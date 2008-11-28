From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/3] musb: Remvoing twl4030 dependency for OMAP3EVM MUSB
Date: Fri, 28 Nov 2008 10:37:47 -0800
Message-ID: <200811281037.48654.david-b@pacbell.net>
References: <1227850104-16166-1-git-send-email-mani.pillai@ti.com> <200811280925.26736.david-b@pacbell.net> <20081128175902.GD6525@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:29911 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752570AbYK1Sh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 13:37:56 -0500
In-Reply-To: <20081128175902.GD6525@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "Pillai, Manikandan" <mani.pillai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 28 November 2008, Felipe Balbi wrote:
> On Fri, Nov 28, 2008 at 09:25:26AM -0800, David Brownell wrote:
> > So the answer for you is obviously to have something
> > other than the musb driver hold your otg_transceiver
> > driver.  Like ... an isp1504.c I2C driver, which will
> > eventually move to drivers/usb/otg and which calls
> > the otg_set_transceiver() utility.
> 
> There's one problem here. If this is similar to isp1704, it doesn't have
> a control interface. 

It does have an I2C interface; I looked before making
that particular comment ...

Whether it's hooked up on that board is a different
issue.  I didn't look at how for example it arranges
to supply VBUS power when running in A-Default mode.

- Dave
