From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: USB on OMAP3530
Date: Thu, 19 Feb 2009 20:37:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02F565649D@dbde02.ent.ti.com>
References: <E1LaALp-0003gl-KO@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42106 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbZBSPHv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 10:07:51 -0500
In-Reply-To: <E1LaALp-0003gl-KO@amazonia.comcast.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "rick@efn.org" <rick@efn.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>   Thanks very much for the help.
> 
> > so Rick, you need to load a gadget driver for musb to work, g_ether or
> > g_zero are the simplest ones.
> 
>   But don't I already have the g_zero enabled via:
> 
> CONFIG_USB_GADGET_MUSB_HDRC=y
> 
>   But lets assume that, for the time being, I'm only interested in USB Host.
> 
>   I had combed the mailing list looking for ISP1505 support and
> happened across this:
> 
> > There's one problem here. If this is similar to isp1704, it doesn't have
> > a control interface. And the only way to talk to the transceiver is via
> > ULPI. I have patches that add musb_ulpi_read/write functions using the
> > musb ulpi wrapper.
> 
>   The ISP1704 is very similar to the ISP1505, neither one has a
> control interface (like I2C), only straight ULPI.  Does this mean that
> there is no "out of the box" support for straight ULPI in 2.6.29?  If
> so, what would I need to do to support it?
> 
>   Rick
> 
> 

The ISP1505 is supposed to be pretty-much plug and play. MUSB should
in theory work directly - no configuration required.

The OMAP3 EVM boards also run a similar configuration. Maybe someone
with that board can tell you if MUSB in the current kernel works out
of the box.

Looking closer at your config options, you have CONFIG_USB_MUSB_OTG
which means you need a gadget driver loaded before you can use MUSB.
But, you also have CONFIG_USB_ETH=y, which means your gadget driver
is also built-in. So you won't need to insmod the module.

