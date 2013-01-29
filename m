From: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Subject: Re: [PATCH v1 1/5] ARM: cache-l2x0: add 'smc' identifier
Date: Tue, 29 Jan 2013 17:08:53 +0530
Message-ID: <20130129113853.GA22145@bnru10>
References: <20130129101328.GA11878@bnru10>
 <20130129113325.GG2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:49307 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753067Ab3A2LjY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Jan 2013 06:39:24 -0500
Content-Disposition: inline
In-Reply-To: <20130129113325.GG2637@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "avorontsov@mvista.com" <avorontsov@mvista.com>, "gregory.clement@free-electrons.com" <gregory.clement@free-electrons.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "rubini@unipv.it" <rubini@unipv.it>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "horms@verge.net.au" <horms@verge.net.au>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, Shiraz HASHIM <shiraz.hashim@st.com>

On Tue, Jan 29, 2013 at 12:33:25 +0100, Russell King - ARM Linux wrote:
> On Tue, Jan 29, 2013 at 03:43:31PM +0530, srinidhi kasagar wrote:
> > Add 'smc' (Secure Monitor Call) identifier to differentiates
> > the platforms which implements this.
> 
> This patch makes no sense.
> 
> So, if setting 'smc' in the DT description is supposed to mean that
> the platform has a secure monitor then...
> 
> > +	is_smc = of_property_read_bool(np, "smc");
> > +
> > +	if (is_smc) {
> > +		/* set the debug interface */
> > +		outer_cache.set_debug = pl310_set_debug;
> > +	}
> 
> Now, let's look at what pl310_set_debug() does:
> 
> static void pl310_set_debug(unsigned long val)
> {
>         writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
> }
> 
> Can you explain where the secure monitor call is there please, because
> I can't see one.  In fact, this is the function used when there _isn't_
> a secure monitor.  So this patch just seems totally wrong to me.

Today, one and only platform is omap. Please check below snapshot: 

--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -51,6 +51,7 @@
 		reg = <0x48242000 0x1000>;
 		cache-unified;
 		cache-level = <2>;
+		smc;
 	};

[...]

--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -214,7 +214,7 @@ static int __init omap_l2_cache_init(void)
 	if (of_have_populated_dt())
 		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
 	else
-		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
+		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK, true);


regards/srinidhi
