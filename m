From: Tony Lindgren <tony@atomide.com>
Subject: Re: Strange boot messages on mainline + omap3_defconfig
Date: Mon, 21 Dec 2009 10:37:16 -0800
Message-ID: <20091221183715.GJ11397@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AB9D@dbde02.ent.ti.com>
 <4B2B776D.8000709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51784 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbZLUShU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 13:37:20 -0500
Content-Disposition: inline
In-Reply-To: <4B2B776D.8000709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Romit Dasgupta <romit@ti.com> [091218 04:35]:
> Gadiyar, Anand wrote:
> > I get some "mux: Unknown ball ..." messages booting
> > v2.6.33-rc1 from Linux' tree (built with the omap3_defconfig).
> > 
> > This was on a 3630 SDP.
> > 
> > Won't be looking at this for a while, so just reporting it.
> > 
> > - Anand
> > 
> > 0x588
> > [    0.000000] mux: Unknown ball offset 0x58a
> > [    0.000000] mux: Unknown ball offset 0x58c
> > [    0.000000] mux: Unknown ball offset 0x58e
> > [    0.000000] mux: Unknown ball offset 0x590
> > [    0.000000] mux: Unknown ball offset 0x578
> > [    0.000000] mux: Unknown ball offset 0x57a
> > [    0.000000] mux: Unknown ball offset 0x57c
> > [    0.000000] mux: Unknown ball offset 0x57e
> > [    0.000000] mux: Unknown ball offset 0x580
> > [    0.000000] mux: Unknown ball offset 0x582
> > [    0.000000] mux: Unknown ball offset 0x584
> > [    0.000000] mux: Unknown ball offset 0x586
> > [    0.000000] mux: Unknown ball offset 0x570
> > [    0.000000] mux: Unknown ball offset 0x572
> > [    0.000000] mux: Unknown ball offset 0x40
> > [    0.000000] mux: Unknown ball offset 0x0
> > [    0.000000] mux: Unknown ball offset 0x2
> > 
> > ....
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Try this in you .config
> CONFIG_OMAP_PACKAGE_CBB=y
> CONFIG_OMAP_PACKAGE_CUS=y
> CONFIG_OMAP_PACKAGE_CBP=y

Sounds like the select statement for your the package your
board is using is missing from arch/arm/mach-omap2/Kconfig.

Also looks like we're missing some checks that should be
in place trying to use a non-existing package..

Regards,

Tony
