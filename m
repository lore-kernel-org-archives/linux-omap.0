From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 6/8] soc: ti: omap_prm: add data for am33xx
Date: Tue, 20 Aug 2019 13:48:31 -0500
Message-ID: <ebb6e240-1252-5a4f-39a2-403ee699d8aa@ti.com>
References: <1565164139-21886-1-git-send-email-t-kristo@ti.com>
 <1565164139-21886-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565164139-21886-7-git-send-email-t-kristo@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org
Cc: tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tero,

On 8/7/19 2:48 AM, Tero Kristo wrote:
> Add PRM instance data for AM33xx SoC. Includes some basic register
> definitions and reset data for now.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/soc/ti/omap_prm.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
> index 9b8d5945..fadfc7f 100644
> --- a/drivers/soc/ti/omap_prm.c
> +++ b/drivers/soc/ti/omap_prm.c
> @@ -73,8 +73,25 @@ struct omap_prm_data omap4_prm_data[] = {
>  	{ },
>  };
>  
> +struct omap_rst_map am3_wkup_rst_map[] = {
> +	{ .rst = 3, .st = 5 },
> +	{ .rst = -1 },
> +};
> +
> +struct omap_prm_data am3_prm_data[] = {
> +	{ .name = "per", .base = 0x44e00c00, .pwstctrl = 0xc, .pwstst = 0x8, .flags = OMAP_PRM_NO_RSTST },
> +	{ .name = "wkup", .base = 0x44e00d00, .pwstctrl = 0x4, .pwstst = 0x8, .rstst = 0xc, .rstmap = am3_wkup_rst_map },
> +	{ .name = "mpu", .base = 0x44e00e00, .pwstst = 0x4 },

Has a rstst but no rstctrl, but your registration logic takes care of
this. Somewhat confusing, when you just look at the data. Should you
limit the check to only rstctrl and OMAP_PRM_NO_RSTST?

> +	{ .name = "device", .base = 0x44e00f00, .rstctl = 0x0, .rstst = 0x8 },

No pwrstctrl and pwrstst registers, so same comment as on OMAP4 data.

> +	{ .name = "rtc", .base = 0x44e01000, .pwstst = 0x4 },
> +	{ .name = "gfx", .base = 0x44e01100, .pwstst = 0x10, .rstctl = 0x4, .rstst = 0x14 },
> +	{ .name = "cefuse", .base = 0x44e01200, .pwstst = 0x4 },

I am not sure if it is better to explicitly list the registers at 0
offset rather than using the implied value of 0, since there are some
registers that do not exist on some PRM instances which are also not
defined.

regards
Suman

> +	{ },
> +};
> +
>  static const struct of_device_id omap_prm_id_table[] = {
>  	{ .compatible = "ti,omap4-prm-inst", .data = omap4_prm_data },
> +	{ .compatible = "ti,am3-prm-inst", .data = am3_prm_data },
>  	{ },
>  };
>  
> 
