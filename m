From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 4/5] ARM: OMAP2+: Add pdata quirk for sys_clkout2 for
 omap3 DBB056
Date: Wed, 22 Jan 2014 13:33:21 -0600
Message-ID: <52E01D01.2010709@ti.com>
References: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com> <1390417460-3134-5-git-send-email-chf.fritz@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56044 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbaAVTeN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jan 2014 14:34:13 -0500
In-Reply-To: <1390417460-3134-5-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, bcousson@baylibre.com, "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <zonque@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 01/22/2014 01:04 PM, Christoph Fritz wrote:
> Full device tree support for clock control is not yet accomplished. Until
> then, configure the 24Mhz of sys_clkout2 to feed an USB-Hub here.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  arch/arm/mach-omap2/pdata-quirks.c |   37 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index a58590f..9ef7ca8 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -171,6 +171,43 @@ static void __init am3517_evm_legacy_init(void)
>  }
>  static void __init omap3_dbb056_legacy_init(void)
>  {
> +	struct clk *clkout2;
> +	struct clk *cm96fck;
> +
> +	/* Reparent clkout2 to 96M_FCK */
> +	pr_info("a83x-quirk: Late Reparent clkout2 to 96M_FCK\n");
what'd be a83x?

> +	clkout2 = clk_get(NULL, "clkout2_src_ck");
> +	if(clkout2 < 0) {
> +		pr_err("a83x-quirk: couldn't get clkout2_src_ck\n");
> +		return;
> +	}
> +	cm96fck = clk_get(NULL, "cm_96m_fck");
> +	if(cm96fck < 0) {
> +		pr_err("a83x-quirk: couldn't get cm_96m_fck\n");
> +		return;
> +	}
> +	if(clk_set_parent(clkout2, cm96fck) < 0) {
> +		pr_err("a83x-quirk: couldn't reparent clkout2_src_ck\n");
> +		return;
> +	}
yep - we have bunch of similar code in drivers/clk/ti -> but we'd need
a generic property to handle this.
> +
> +	/* Set clkout2 to 24MHz for internal usb hub*/
> +	pr_info("a83x-quirk: Set clkout2 to 24MHz for internal usb hub\n");
> +	clkout2 = clk_get(NULL, "sys_clkout2");
> +	if(clkout2 < 0) {
> +		pr_err("a83x-quirk: couldn't get sys_clkout2\n");
> +		return;
> +	}
> +	if(clk_set_rate(clkout2, 24000000) < 0) {
same here.
> +		printk(KERN_ERR "board-omap3evm: couldn't set sys_clkout2 rate\n");
"board-omap3evm:" copy paste?
any reason why not pr_err?

> +		return;
> +	}
> +	if(clk_prepare_enable(clkout2) < 0) {
> +		pr_err("a83x-quirk: couldn't enable sys_clkout2\n");
> +		return;
> +	}
> +
> +	/* Initialize display */
>  	omap3_dbb056_display_init_of();
>  }
>  #endif /* CONFIG_ARCH_OMAP3 */
> 

looking at the coding style, I assume we'd missed running
checkpatch.pl --strict?

ERROR: space required before the open parenthesis '('
#44: FILE: arch/arm/mach-omap2/pdata-quirks.c:180:
+	if(clkout2 < 0) {

ERROR: space required before the open parenthesis '('
#49: FILE: arch/arm/mach-omap2/pdata-quirks.c:185:
+	if(cm96fck < 0) {

ERROR: space required before the open parenthesis '('
#53: FILE: arch/arm/mach-omap2/pdata-quirks.c:189:
+	if(clk_set_parent(clkout2, cm96fck) < 0) {

ERROR: space required before the open parenthesis '('
#61: FILE: arch/arm/mach-omap2/pdata-quirks.c:197:
+	if(clkout2 < 0) {

ERROR: space required before the open parenthesis '('
#65: FILE: arch/arm/mach-omap2/pdata-quirks.c:201:
+	if(clk_set_rate(clkout2, 24000000) < 0) {

WARNING: Prefer netdev_err(netdev, ... then dev_err(dev, ... then
pr_err(...  to printk(KERN_ERR ...
#66: FILE: arch/arm/mach-omap2/pdata-quirks.c:202:
+		printk(KERN_ERR "board-omap3evm: couldn't set sys_clkout2 rate\n");

ERROR: space required before the open parenthesis '('
#69: FILE: arch/arm/mach-omap2/pdata-quirks.c:205:
+	if(clk_prepare_enable(clkout2) < 0) {

total: 6 errors, 1 warnings, 0 checks, 43 lines checked

 has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.

you might want to run something like aiaiai[1] or
kernel_patch_verify[2] or patman... etc.. to help you clean up for
minimum needs.

[1] https://lwn.net/Articles/488992/
[2] https://github.com/nmenon/kernel_patch_verify

-- 
Regards,
Nishanth Menon
