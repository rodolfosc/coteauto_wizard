class OrcamentosController < ApplicationController
  before_action :set_orcamento, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :edit, :show, :destroy]

  # GET /orcamentos
  # GET /orcamentos.json
  def index

    @orcamentos = Orcamento.all
  end

  # GET /orcamentos/1
  # GET /orcamentos/1.json
  def show

  end

  def finish
   @orcamento = Orcamento.find(params[:_id])  
  end

  # GET /orcamentos/new
  def new
    @orcamento = Orcamento.new
  end

  # GET /orcamentos/1/edit
  def edit

  end

  # POST /orcamentos
  # POST /orcamentos.json
  def create
    @orcamento = Orcamento.new(orcamento_params)

    respond_to do |format|
      if @orcamento.save
        format.html { redirect_to steps_path(@orcamento, :_id => @orcamento._id) }
        format.json { render :show, status: :created, location: @orcamento }
      else
        format.html { render :new }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orcamentos/1
  # PATCH/PUT /orcamentos/1.json
  def update
    respond_to do |format|
      if @orcamento.update(orcamento_params)
         if(self.vei_tipo == 'Carros' && self.vei_nacionalidade == 'Nacional' && self.vei_modelo_ano.scan(/\d*/) <= 1997 )
          format.html { redirect_to root_path , notice: 'Deu erro.'
          format.html { redirect_to(old_car?  steps_path(@orcamento, :_id => @orcamento._id) , notice: 'oBRIGADO.' }
          format.json { render :show, status: :ok, location: @orcamento }
        end
      else
        format.html { render :edit }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end

    end
  end

  # DELETE /orcamentos/1
  # DELETE /orcamentos/1.json
  def destroy
    @orcamento.destroy
    respond_to do |format|
      format.html { redirect_to orcamentos_url, notice: 'Orcamento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orcamento
      @orcamento = Orcamento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orcamento_params
    params.require(:orcamento).permit(:data_pgto,:seguro_plan, :seguro_preco_default, :seguro_preco_silver, :seguro_preco_pro,:current_step, :cli_name, :cli_email, :cli_tel, :cli_cpf, :cli_pais, :cli_trab, :cli_salario, :cli_sexo, :cli_cep, :cli_end, :cli_end_number, :cli_end_compl, :cli_end_cidade, :cli_end_bairro, :vei_tipo, :vei_marca, :vei_veiculo, :vei_modelo_ano, :vei_preco, :vei_tipo_uso, :vei_placa,:seguro_preco,:seguro_preco_final, :seg_car_reboque_300, :seg_car_reboque_500 , :seg_car_terceiros_50k , :seg_car_vidros , :seg_car_reserva_7d , :seg_car_reserva14, :vei_nacionalidade)
    end 

    def old_car?(orcamento)
      if(self.vei_tipo == 'Carros' && self.vei_nacionalidade == 'Nacional' && self.vei_modelo_ano..scan(/\d*/) <= 1997 )
           p 'Seu carro não esta coberto por nossa equipe. Obrigado!'
      end
    end
end
