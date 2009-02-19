From: Rick Bronson <rick@efn.org>
Subject: Re: USB on OMAP3530
Date: Thu, 19 Feb 2009 06:58:09 -0800
Message-ID: <E1LaALp-0003gl-KO@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from efn.org ([206.192.230.249]:37118 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbZBSO6J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Feb 2009 09:58:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


  Thanks very much for the help.

> so Rick, you need to load a gadget driver for musb to work, g_ether or
> g_zero are the simplest ones.

  But don't I already have the g_zero enabled via:

CONFIG_USB_GADGET_MUSB_HDRC=y

  But lets assume that, for the time being, I'm only interested in USB
Host.

  I had combed the mailing list looking for ISP1505 support and
happened across this:

> There's one problem here. If this is similar to isp1704, it doesn't have
> a control interface. And the only way to talk to the transceiver is via
> ULPI. I have patches that add musb_ulpi_read/write functions using the
> musb ulpi wrapper.

  The ISP1704 is very similar to the ISP1505, neither one has a
control interface (like I2C), only straight ULPI.  Does this mean that
there is no "out of the box" support for straight ULPI in 2.6.29?  If
so, what would I need to do to support it?

  Rick
