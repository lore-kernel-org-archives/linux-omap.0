From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 5/8] i2c: move twl4030-usb to platform_device
Date: Sat, 27 Sep 2008 11:01:20 +0300
Message-ID: <20080927080120.GA10218@frodo>
References: <1222422061-3940-1-git-send-email-felipe.balbi@nokia.com> <1222422061-3940-2-git-send-email-felipe.balbi@nokia.com> <1222422061-3940-3-git-send-email-felipe.balbi@nokia.com> <1222422061-3940-4-git-send-email-felipe.balbi@nokia.com> <1222422061-3940-5-git-send-email-felipe.balbi@nokia.com> <1222422061-3940-6-git-send-email-felipe.balbi@nokia.com> <5e088bd90809262013w1e300ce3g257a3ad8fa7b065d@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56809 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbYI0IBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Sep 2008 04:01:31 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809262013w1e300ce3g257a3ad8fa7b065d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Fri, Sep 26, 2008 at 08:13:27PM -0700, Steve Sakoman wrote:
> On Fri, Sep 26, 2008 at 2:40 AM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> > use new style twl4030-core to register a platform_device
> > for twl4030-usb.
> >
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  arch/arm/mach-omap2/board-2430sdp.c     |    6 +
> >  arch/arm/mach-omap2/board-3430sdp.c     |    5 +
> >  arch/arm/mach-omap2/board-ldp.c         |    7 +
> >  arch/arm/mach-omap2/board-omap2evm.c    |    5 +
> >  arch/arm/mach-omap2/board-omap3beagle.c |    7 +
> >  arch/arm/mach-omap2/board-omap3evm.c    |    6 +-
> 
> board-overo.c should have the same changes made.
> 
> Should I submit a separate patch or can you incorporate in the the
> next revision?

I can incorporate, no big deal. Only woring on them on monday though.

> 
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
