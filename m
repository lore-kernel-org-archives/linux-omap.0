From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFT/PATCH 05/10] cbus: retu: move to threaded IRQ and GENIRQ
Date: Tue, 4 Jan 2011 11:14:00 -0800
Message-ID: <20110104191359.GH7771@atomide.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
 <1294040988-21191-6-git-send-email-balbi@ti.com>
 <20110104014002.GV7771@atomide.com>
 <20110104065229.GB2367@legolas.emea.dhcp.ti.com>
 <20110104074615.GC2656@legolas.emea.dhcp.ti.com>
 <20110104074756.GD2656@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44594 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab1ADTOC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 14:14:02 -0500
Content-Disposition: inline
In-Reply-To: <20110104074756.GD2656@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110103 23:47]:
> On Tue, Jan 04, 2011 at 09:46:15AM +0200, Felipe Balbi wrote:
> >@@ -593,6 +594,14 @@ static struct twl4030_platform_data sdp3430_twldata = {
> >       .vpll2          = &sdp3430_vpll2,
> >};
> >+static void __init sdp3430_twl_init(void)
> >+{
> >+       int             irq_base = omap_irq_get_base();
> >+
> >+       sdp3430_twldata.irq_base = irq_base;
> >+       sdp3430_twldata.irq_end = irq_base + TWL4030_BASE_NR_IRQS;
> >+}
> >+
> >static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
> >       {
> >               I2C_BOARD_INFO("twl4030", 0x48),
> 
> this hunk should be:
> 
> @@ -593,6 +594,16 @@ static struct twl4030_platform_data sdp3430_twldata = {
>         .vpll2          = &sdp3430_vpll2,
>  };
> +static void __init sdp3430_twl_init(void)
> +{
> +       int             irq_base = omap_irq_get_base();
> +
> +       sdp3430_twldata.irq_base = irq_base;
> +       sdp3430_twldata.irq_end = irq_base + TWL4030_BASE_NR_IRQS;
> +
> +       omap_irq_add(TWL4030_BASE_NR_IRQS);
> +}
> +
>  static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
>         {
>                 I2C_BOARD_INFO("twl4030", 0x48),
> 
> otherwise it won't work for other irq_chips

I think there's been some patches related to this to get rid
of NR_IRQS? Might be worth taking a look at those first as it's
a generic solution.

Regards,

Tony
