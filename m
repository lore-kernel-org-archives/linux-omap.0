From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH][RFC] McSPI Slave and DMA,FIFO support
Date: Mon, 18 May 2009 13:11:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03056A123B@dbde02.ent.ti.com>
References: <003d01c9d78a$baef6680$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35205 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756663AbZERHla convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 03:41:30 -0400
In-Reply-To: <003d01c9d78a$baef6680$LocalHost@wipultra793>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "V, Hemanth" <hemanthv@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> >> Index: linux-omap-2.6/arch/arm/mach-omap2/devices.c
> >> ===================================================================
> >> --- linux-omap-2.6.orig/arch/arm/mach-omap2/devices.c 2009-05-14 12:38:50.000000000 +0530
> >> +++ linux-omap-2.6/arch/arm/mach-omap2/devices.c 2009-05-15 16:53:38.000000000 +0530

<snip>

> >>  };
> >>
> >>  static struct resource omap2_mcspi2_resources[] = {
> >> @@ -351,6 +359,14 @@
> >>
> >>  static void omap_init_mcspi(void)
> >>  {
> >> +
> >> + if (cpu_is_omap3430()) {
> >> + omap_cfg_reg(AA3_3430_McSPI2_CLK);
> >> + omap_cfg_reg(Y2_3430_McSPI2_SIMO);
> >> + omap_cfg_reg(Y3_3430_McSPI2_SOMI);
> >> + omap_cfg_reg(Y4_3430_McSPI2_CS0);
> >> + }
> >> +

This will change the mux mode for these pads for all OMAP3 boards,
even if they do not wish to use McSPI2. In particular, Beagleboard
will be affected as it uses HSUSB on Port2 and these pads overlap.

Regards,
Anand
