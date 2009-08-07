From: Tony Lindgren <tony@atomide.com>
Subject: Re: N8x0 to mainline patches
Date: Fri, 7 Aug 2009 10:03:20 +0300
Message-ID: <20090807070317.GR2358@atomide.com>
References: <87zlb95dwx.fsf@litku.valot.fi> <20090713060354.GJ6589@nokia.com> <87vdlx5b3y.fsf@litku.valot.fi> <20090713065341.GC16778@nokia.com> <20090806071038.GE7374@atomide.com> <87y6pwnc9t.fsf@litku.valot.fi> <da94abde0908060927s57a5bdcfxac4e46db16913820@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61484 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811AbZHGHD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 03:03:27 -0400
Content-Disposition: inline
In-Reply-To: <da94abde0908060927s57a5bdcfxac4e46db16913820@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Max Filippov <jcmvbkbc@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Kalle Valo <kalle.valo@iki.fi> [090806 19:29]:
> On Thu, Aug 6, 2009 at 7:21 PM, Kalle Valo<kalle.valo@iki.fi> wrote:
> > My plan is this:
> >
> > 1. first finish OMAP_TAG_UART removal patch and send it for review

This would be great.

> > 2. finins and send tusb6010 patch
> >
> > + omap2-add-usb-tusb6010-c

The tusb6010 could be added later on as a fix too if you want to cut
down dependencies.

> > 2. fold these n8x0 board file patches into one and send it for review:
> >
> > + n8x0-add-board-file
> > + n8x0-onenand-support
> > + n8x0-add-spi-support
> > + n8x0-add-usb-support

Yeh one patch for the board file.
 
> This was item 3, of course. And I forget n8x0_defconfig, I'll send
> that as a separate patch.

Yeah it's easier to read the series that way.
 
> Tony, does this look ok to you?

Looks good to me!

Tony

