From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/3] musb: Remvoing twl4030 dependency for OMAP3EVM MUSB
Date: Fri, 28 Nov 2008 09:25:26 -0800
Message-ID: <200811280925.26736.david-b@pacbell.net>
References: <1227850104-16166-1-git-send-email-mani.pillai@ti.com> <200811272302.43295.david-b@pacbell.net> <19F8576C6E063C45BE387C64729E739403E904EBCD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:43602 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752295AbYK1RZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 12:25:28 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E904EBCD@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Pillai, Manikandan" <mani.pillai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 27 November 2008, Gupta, Ajay Kumar wrote:

> > This is obviously wrong.  One does set_transceiver(),
> > the other does get_transceiver() ...
> 
> For OMAP3EVM we don't need twl4030 support for musb and thus
> otg_set_transceiver() which was done 
> in twl4030-usb.c, is now done here itself for OMAP3EVM.

Which is obviously wrong.  Some other code should have
called otg_set_transceiver() ... *NEVER* the musb driver,
except with silicon that integrates an OTG transceiver
(like DaVinci and Blackfin).

Yes, the MUSB driver hasn't fully sorted this out yet;
it started with DaVinci EVMs, and only later started
to support discrete transceivers.  Patches are in the
works to fix that, I'm not sure of their status.

That's an example of why you must not discard your basic
intuition when updating drivers ... like noticing that
since two branches of an #if do entirely different things,
at least one branch must accordingly be wrong.


> Whereas for SDP and Beagle twol4030-usb would be enabled and
> thus otg_set_transceiver() would 
> have been done in twl4030-usb.c file itself.
> 
> > 
> > It seems that some boards need some kind of basic
> > OTG transceiver stub.  The newish drivers/usb/otg
> > directory is the place to keep such stuff.

So the answer for you is obviously to have something
other than the musb driver hold your otg_transceiver
driver.  Like ... an isp1504.c I2C driver, which will
eventually move to drivers/usb/otg and which calls
the otg_set_transceiver() utility.

Board-specific logic would presumably involve just
declaring the i2c board info for the isp1504 chip.

- Dave
