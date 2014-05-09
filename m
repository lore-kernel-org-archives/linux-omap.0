From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Fri, 9 May 2014 08:55:04 -0700
Message-ID: <20140509155504.GE17814@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com>
 <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com>
 <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com>
 <536C8293.4070506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45229 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009AbaEIPzK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 11:55:10 -0400
Content-Disposition: inline
In-Reply-To: <536C8293.4070506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140509 00:24]:
> On 09/05/14 02:33, Tony Lindgren wrote:
> > +Example when connected to a omap2+ based device:
> > +
> > +	lcd0: display {
> > +		compatible = "sharp,ls037v7dw01";
> > +		power-supply = <&lcd_3v3>;
> > +		enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
> > +		reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
> > +		mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
> > +			      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
> > +			      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
> > +
> > +		panel-timing {
> > +			clock-frequency = <19200000>;
> > +			hback-porch = <28>;
> > +			hactive = <480>;
> > +			hfront-porch = <1>;
> > +			hsync-len = <2>;
> > +			vback-porch = <1>;
> > +			vactive = <640>;
> > +			vfront-porch = <1>;
> > +			vsync-len = <1>;
> > +			hsync-active = <0>;
> > +			vsync-active = <0>;
> > +			de-active = <1>;
> > +			pixelclk-active = <1>;
> > +		};
> 
> I don't think we should define panel-timing here. We know it's
> sharp,ls037v7dw01, so the driver knows the video timings. Also, if we
> would extend the driver to support both resolution modes, it needs to
> support two different timings, so the above doesn't work in that case
> either.

OK. It seems we can have at least two different timings for this panel,
the VGA timing above and the QVGA timings that LDP uses that are listed
in the .dts changes.
 
> Although if the MO gpio is not controlled by the driver, we should tell
> the driver whether that gpio is high or low.

What do you have in mind for telling that? We should also tell the
orientation of the panel:

EVM	VGA	omapfb.rotate=3
LDP	QVGA	omapfb.rotate=0

Do you have something in mind for that?
 
> At the moment our display drivers are OMAP specific, and for that reason
> we should prefix the compatible strings with "omapdss,". For example,
> drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c:
> 
> 	{ .compatible = "omapdss,panel-dsi-cm", },
> 
> But we should still have the right compatible string in the .dts, so we
> convert the compatible name in arch/arm/mach-omap2/display.c, with
> 'dss_compat_conv_list' array, to which this panel's name should be added.

Oh so what do you want to have in the .dts file then?

Regards,

Tony 
