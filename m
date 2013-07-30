From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 09/21] ARM: OMAP: devkit8000: use new display drivers
Date: Tue, 30 Jul 2013 11:18:45 +0530
Message-ID: <51F753BD.5040509@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
 <1374822504-28949-10-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374822504-28949-10-git-send-email-tomi.valkeinen@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, weber@corscience.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Friday 26 July 2013 12:38 PM, Tomi Valkeinen wrote:
> Use new display drivers for devkit8000 board.
>
> The new OMAP display drivers were merged for 3.11, and we can now change
> the board files to use the new ones and phase out the old ones.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm/mach-omap2/board-devkit8000.c | 96 +++++++++++++++++++++++-----------
>   1 file changed, 65 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
> index f1d91ba..cdc4fb9 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -112,50 +112,81 @@ static struct regulator_consumer_supply devkit8000_vio_supply[] = {
>   	REGULATOR_SUPPLY("vcc", "spi2.0"),
>   };
>
> -static struct panel_generic_dpi_data lcd_panel = {
> -	.name			= "innolux_at070tn83",
> -	/* gpios filled in code */
> +static const struct display_timing devkit8000_lcd_videomode = {
> +	.pixelclock	= { 0, 40000000, 0 },

This is unrelated to the work being done here, but noticed that the 
pixel clock for this panel seems to be too high for the given timings. 
It puts the refresh rate around 90 Hz, which is odd.

Archit
