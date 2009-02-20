From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: USB on OMAP3530
Date: Fri, 20 Feb 2009 14:56:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA904548@dbde02.ent.ti.com>
References: <E1LaALp-0003gl-KO@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60732 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbZBTJ00 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 04:26:26 -0500
In-Reply-To: <E1LaALp-0003gl-KO@amazonia.comcast.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "rick@efn.org" <rick@efn.org>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rick
> Bronson
> Sent: Thursday, February 19, 2009 8:28 PM
> To: Gadiyar, Anand
> Cc: linux-omap@vger.kernel.org
> Subject: Re: USB on OMAP3530
> 
> 
>   Thanks very much for the help.
> 
> > so Rick, you need to load a gadget driver for musb to work, g_ether or
> > g_zero are the simplest ones.
> 
>   But don't I already have the g_zero enabled via:
> 
> CONFIG_USB_GADGET_MUSB_HDRC=y
> 
>   But lets assume that, for the time being, I'm only interested in USB
> Host.
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

I am using OMAP35x EVM which has ISP1504 and it works directly. Use omap3_evm_defconfig
which has all the required default config for MUSB. Just make sure to insert the gadget
module after boot OR use built-in gadget driver.

Regards,
Ajay
> 
>   Rick
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

