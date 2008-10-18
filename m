From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/4] bq27x00 updates
Date: Sun, 19 Oct 2008 01:23:43 +0300
Message-ID: <20081018222338.GT31842@frodo>
References: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com> <20081018211643.GA1272@oksana.dev.rtsoft.ru>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43244 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbYJRWYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 18:24:00 -0400
Content-Disposition: inline
In-Reply-To: <20081018211643.GA1272@oksana.dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>

On Sun, Oct 19, 2008 at 01:16:43AM +0400, Anton Vorontsov wrote:
> On Sat, Oct 18, 2008 at 12:00:44AM +0300, Felipe Balbi wrote:
> > The previous driver for bq27x00 batteries was a real
> > ifdef mess. The following patches separate common code
> > and create separate drivers for bq27200 and bq27000.
> 
> FYI (if you don't know already): Rodolfo Giometti already
> cleaned up bq27200 part of that driver and submitted it few
> months ago.

Didn't know that. Good to know by the way. In any case I think Copyright
Texas Instruments should be kept as is and not like Rodolfo wrote:

"Based on a previous work by Copyright (C) 2008 Texas Instruments, Inc."

since he's not really writing new driver from scratch but only cleaning
up an existing one that still sits in linux-omap tree.

In any case, that's what you get when you don't push your drivers upstream,
right ?? :-p

Hopefully TI will start pushing their code upstream and this kind of
issue will vanish.

> http://lkml.org/lkml/2008/6/18/154
> 
> It will appear in the 2.6.28 kernel. For now it lives here:
> 
> http://git.infradead.org/battery-2.6.git?a=commitdiff;h=b996ad0e9fb15ca4acc60bcd0380912117a45d13
> 
> So I'd be happy if you could just rework it to support
> bq27000 (w1) interface as well.

Sure, but I'll only take a look at that after it falls into mainline.
And btw, I don't have access to bq27000, only bq27200, so don't know if
I'm gonna be the best person to put down that code since I can only
build test.

> > The code looks much cleaner, but we had to keep a global
> > static pointer to hold the i2c_client (bq27200) or the
> > w1 device (bq27000).
> 
> Yeah, this is not great...

What I was trying to do, actually, is to provide a generic structure for
bq27200 and bq27000 and another device specific which would hold the
bus-related hooks (basically a pointer to i2c_client or a pointer to
the w1 dev).

Turned out that would be way too complicated for such a simple driver.

> Can you consider this idea
> http://kerneltrap.org/mailarchive/linux-kernel/2008/6/23/2198444
> ?
> 
> It shows only i2c part, but the idea should be clear:
> there should be w1 and i2c drivers, both would create bq27x00
> platform devices, then the platform driver would not depend on
> any hw interface.

That looks good, but please don't add new stuff to drivers/i2c/chips.
That directory is schedule to vanish asap. Also, I think bq27x00.h
should not site in include/linux since it's not really related to the
kernel as a whole.

Sure you need the access method, but that structure is initialized by
bq27200.c or bq27000.c; better would be to move bq27200.c into
drivers/power and make bq27x00.h sit inside drivers/power as well.

Also, this line is wrong:

+	di->bus = platform_get_drvdata(pdev);

di->bus will get initialized by di again. The correct would be:

di->bus = pdev->dev.platform_data;

another point is that I suppose that goto idr_try_again should have a
max_tries hook to prevent that code from looping unconditionally if we
can't get new IDR (for some reason).

-- 
balbi
