From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/3] musb: Remvoing twl4030 dependency for OMAP3EVM MUSB
Date: Fri, 28 Nov 2008 21:43:34 +0200
Message-ID: <20081128194334.GF6525@frodo>
References: <1227850104-16166-1-git-send-email-mani.pillai@ti.com> <200811280925.26736.david-b@pacbell.net> <20081128175902.GD6525@frodo> <200811281037.48654.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41837 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755395AbYK1Tno (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 14:43:44 -0500
Content-Disposition: inline
In-Reply-To: <200811281037.48654.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "Pillai, Manikandan" <mani.pillai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 28, 2008 at 10:37:47AM -0800, David Brownell wrote:
> On Friday 28 November 2008, Felipe Balbi wrote:
> > On Fri, Nov 28, 2008 at 09:25:26AM -0800, David Brownell wrote:
> > > So the answer for you is obviously to have something
> > > other than the musb driver hold your otg_transceiver
> > > driver.  Like ... an isp1504.c I2C driver, which will
> > > eventually move to drivers/usb/otg and which calls
> > > the otg_set_transceiver() utility.
> > 
> > There's one problem here. If this is similar to isp1704, it doesn't have
> > a control interface. 
> 
> It does have an I2C interface; I looked before making
> that particular comment ...

so it's better than isp1704. It's horrible only been able to talk to the
device via ulpi.

-- 
balbi
