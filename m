From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 12/16] OMAP2+: UART: Allow UART parameters to be
	configured from board file.
Date: Tue, 11 Oct 2011 11:53:31 -0700
Message-ID: <878vor2wd0.fsf@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-3-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317380561-661-3-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:32:37 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Deepak K <deepak.k@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: Deepak K <deepak.k@ti.com>
>
> The following UART parameters are defined within the UART driver:
>
> 1). Whether the UART uses DMA (dma_enabled), by default set to 0
> 2). The size of dma buffer (set to 4096 bytes)
> 3). The time after which the dma should stop if no more data is received.
> 4). The auto suspend delay that will be passed for pm_runtime_autosuspend
>     where uart will be disabled after timeout
>
> Different UARTs may be used for different purpose such as the console,
> for interfacing bluetooth chip, for interfacing to a modem chip, etc.
> Therefore, it is necessary to be able to customize the above settings
> for a given board on a per UART basis.
>
> This change allows these parameters to be configured from the board file
> and allows the parameters to be configured for each UART independently.
>
> If a board does not define its own custom parameters for the UARTs, then
> use the default parameters in the structure "omap_serial_default_info".
> The default parameters are defined to be the same as the current settings
> in the UART driver to avoid breaking the UART for any cuurnelty supported
> boards. By default, make all boards use the default UART parameters.
>
> Signed-off-by: Deepak K <deepak.k@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

A couple minor comments below...

> ---
> This patch is derived and reworked from a custom 2.6.35 kernel
> Available here:
> http://git.omapzoom.org/?p=kernel/omap.git;
> a=commitdiff;h=584ef316542f77312be7ba96a0f3013c8f64852b;
> hp=7233a76cb362c0fc603f773274159adff91d3513
>
>  arch/arm/mach-omap2/board-n8x0.c              |    6 +-
>  arch/arm/mach-omap2/serial.c                  |   56 ++++++++++++++++++++----
>  arch/arm/plat-omap/include/plat/omap-serial.h |    7 ++-
>  arch/arm/plat-omap/include/plat/serial.h      |    5 ++-
>  drivers/tty/serial/omap-serial.c              |    8 +--
>  5 files changed, 61 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
> index e11f0c5..3408726 100644
> --- a/arch/arm/mach-omap2/board-n8x0.c
> +++ b/arch/arm/mach-omap2/board-n8x0.c
> @@ -656,15 +656,15 @@ static inline void board_serial_init(void)
>  	bdata.pads_cnt = 0;
>  
>  	bdata.id = 0;
> -	omap_serial_init_port(&bdata);
> +	omap_serial_init_port(&bdata, NULL);
>  
>  	bdata.id = 1;
> -	omap_serial_init_port(&bdata);
> +	omap_serial_init_port(&bdata, NULL);
>  
>  	bdata.id = 2;
>  	bdata.pads = serial2_pads;
>  	bdata.pads_cnt = ARRAY_SIZE(serial2_pads);
> -	omap_serial_init_port(&bdata);
> +	omap_serial_init_port(&bdata, NULL);
>  }
>  
>  #else
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 0731575..78f7051 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -43,17 +43,29 @@
>  #include "mux.h"
>  
>  /*
> - * NOTE: By default the serial timeout is disabled as it causes lost characters
> - * over the serial ports. This means that the UART clocks will stay on until
> - * disabled via sysfs. This also causes that any deeper omap sleep states are
> - * blocked. 
> + * NOTE: By default the serial auto_suspend timeout is disabled as it causes
> + * lost characters over the serial ports. This means that the UART clocks will
> + * stay on until power/autosuspend_delay is set for the uart from sysfs.
> + * This also causes that any deeper omap sleep states are blocked.
>   */
> -#define DEFAULT_TIMEOUT 0
> +#define DEFAULT_AUTOSUSPEND_DELAY	-1
>  
>  #define MAX_UART_HWMOD_NAME_LEN		16
>  
>  static u8 num_uarts;
>  
> +#define DEFAULT_RXDMA_TIMEOUT		1	/* RX DMA polling rate (us) */
> +#define DEFAULT_RXDMA_BUFSIZE		4096	/* RX DMA buffer size */
> +
> +static struct omap_uart_port_info omap_serial_default_info[] = {

This could be __initdata

> +	{
> +		.dma_enabled	= 0,

This field is a bool, use 'false' instead of 0.

> +		.dma_rx_buf_size = DEFAULT_RXDMA_BUFSIZE,
> +		.dma_rx_timeout = DEFAULT_RXDMA_TIMEOUT,
> +		.autosuspend_timeout = DEFAULT_AUTOSUSPEND_DELAY,
> +	},
> +};
> +
>  static int uart_idle_hwmod(struct omap_device *od)
>  {
>  	omap_hwmod_idle(od->hwmods[0]);
> @@ -298,6 +310,7 @@ core_initcall(omap_serial_early_init);
>  /**
>   * omap_serial_init_port() - initialize single serial port
>   * @bdata: port specific board data pointer
> + * @info: platform specific data pointer
>   *
>   * This function initialies serial driver for given port only.
>   * Platforms can call this function instead of omap_serial_init()
> @@ -306,7 +319,8 @@ core_initcall(omap_serial_early_init);
>   * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
>   * use only one of the two.
>   */
> -void __init omap_serial_init_port(struct omap_board_data *bdata)
> +void __init omap_serial_init_port(struct omap_board_data *bdata,
> +			struct omap_uart_port_info *info)

alignment.  2nd argument should align with 1st

>  {
>  	struct omap_hwmod *oh;
>  	struct platform_device *pdev;
> @@ -325,6 +339,9 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
>  	if (!oh)
>  		return;
>  
> +	if (info == NULL)

if (!info)

there's another one of these elsewhere in the patch too.

[...]

Kevin
