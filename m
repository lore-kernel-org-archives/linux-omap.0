From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap5.dtsi: add DSS RFBI node
Date: Mon, 8 Sep 2014 17:14:06 -0700
Message-ID: <20140909001406.GB10785@atomide.com>
References: <1409812112-19194-1-git-send-email-tomi.valkeinen@ti.com>
 <54086CD0.7000203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47814 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753533AbaIIAOL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 20:14:11 -0400
Content-Disposition: inline
In-Reply-To: <54086CD0.7000203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nishanth Menon <nm@ti.com> [140904 06:45]:
> $subject: ARM: dts: OMAP5: Add DSS RFBI node
> 
> On 09/04/2014 01:28 AM, Tomi Valkeinen wrote:
> > The RFBI node for OMAP DSS was left out when adding the rest of the DSS
> > nodes, because it was not clear how to set up the clocks for the RFBI.
> > 
> > However, it seems that if there is a HWMOD for a device, we also need a
> > DT node for it. Otherwise, at boot, we get:
> > 
> > WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2542 _init+0x464/0x4e0()
> > omap_hwmod: dss_rfbi: doesn't have mpu register target base
> > 
> > Now that v3.17-rc3 contains a fix
> > (8fd46439e1f5a7f86d76a08733459b74debd9468) for the L3 ICLK required by
> > the RFBI, let's add the RFBI node to get rid of the warning.
> The usual style is to use the following style:
> Commit 8fd46439e1f5 ("ARM: dts: omap54xx-clocks: Fix the l3 and l4
> clock rates")

Applying into omap-for-v3.18/dt with the above part of the
changelog updated.

Regards,

Tony 
 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >  arch/arm/boot/dts/omap5.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> > index fc8df1739f39..1e6ff61a7f12 100644
> > --- a/arch/arm/boot/dts/omap5.dtsi
> > +++ b/arch/arm/boot/dts/omap5.dtsi
> > @@ -945,6 +945,15 @@
> >  				clock-names = "fck";
> >  			};
> >  
> > +			rfbi: encoder@58002000  {
> > +				compatible = "ti,omap5-rfbi";
> > +				reg = <0x58002000 0x100>;
> > +				status = "disabled";
> > +				ti,hwmods = "dss_rfbi";
> > +				clocks = <&dss_dss_clk>, <&l3_iclk_div>;
> > +				clock-names = "fck", "ick";
> > +			};
> > +
> >  			dsi1: encoder@58004000 {
> >  				compatible = "ti,omap5-dsi";
> >  				reg = <0x58004000 0x200>,
> > 
> 
> before-omap5-evm: http://paste.ubuntu.org.cn/1477659
> 
> after-omap5-evm:  http://paste.ubuntu.org.cn/1477658
> 
> So, yep, no more warning.
> 
> 
> -- 
> Regards,
> Nishanth Menon
