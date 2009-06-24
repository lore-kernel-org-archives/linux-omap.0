From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH v2] OMAP3: PM: reset USB OTG module on boot
Date: Wed, 24 Jun 2009 23:41:46 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305398D53@dbde02.ent.ti.com>
References: <1245857533-2419-1-git-send-email-khilman@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F546233D@dbde02.ent.ti.com>,<87tz251ph2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52661 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754163AbZFXSOU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 14:14:20 -0400
In-Reply-To: <87tz251ph2.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

<snip>
> >
> >>
> >> static void __init usb_musb_pm_init(void)
> >> {
> >>-     /* Ensure force-idle mode for OTG controller */
> >>-     if (cpu_is_omap34xx())
> >>-             omap_writel(0, OTG_SYSCONFIG);
> >>+     struct clk *iclk;
> >>+     void __iomem *otg_base;
> >>+
> >>+     if (!cpu_is_omap34xx())
> >>+             return;
> >
> > Why is this sys-config reset done only for omap34xx()
> > This should be valid for any old 24xx() as well as new 44xx() omaps
> 

Minor correction - it's valid only for any old 243x() only. 242x did not
have this controller, IIRC.


> You're correct.  Good catch.
> 
> The force-idle "fix" that this is replacing was only being done on
> 34xx due to the smart-idle errata.  However, this reset should be
> done even without any errata.
> 
> Thanks for review,  will respin.
> 
> Kevin
> 
