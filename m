From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Mon, 06 Jun 2011 15:25:48 -0700
Message-ID: <87zkluwqab.fsf@ti.com>
References: <Pine.LNX.4.44L0.1106021010360.1913-100000@iolanthe.rowland.org>
	<87lixkyxa8.fsf@ti.com> <201106062029.36389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:60669 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751912Ab1FFWZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 18:25:52 -0400
Received: by mail-px0-f182.google.com with SMTP id 20so3545242pxi.27
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 15:25:51 -0700 (PDT)
In-Reply-To: <201106062029.36389.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Mon, 6 Jun 2011 20:29:36 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[..]

> While it is tempting to try to get away with only two PM callbacks per
> driver instead of four (or even more), it generally is not doable, simply
> because driver callbacks are not executed directly by the core.
>
> The only way to address the problem of code duplication between .suspend()
> and .runtime_suspend() callbacks (and analogously for resume) I see at the
> moment is to make those callbacks execute common routines.

Makes sense if the "common routines" are in the driver.  The problem
arises when the common routines are not actually in the driver, but are
instead at the subsystem (or in this case, device power domain) level.

Considering the OMAP I2C driver, it doesn't have (or need) runtime PM
callbacks.  It does runtime PM get/put per-xfer, and has no context to
save/restore, so it needs no runtime PM callbacks, or no special PM code
other than runtime PM get/put calls.  The device power domain level code
is managing the device clocks, power states, etc..

So what the system suspend needs to do is something like:

1. block any new xfers from starting
2. wait for any outstanding xfers
3. if device is already runtime suspended
    - nothing to do
4. trigger idle transition (at device power domain level)

If runtime PM has not been disabled from userspace, it should always end
at step 3, since the last xfer will always trigger a runtime suspend.

However, if runtime PM has been disabled from
userspace/pm_runtime_forbid(), we need some way to do step 4.  It's this
last 'trigger' step that I'm trying to figure out how a clean way of
implementing, particularily for drivers with no runtime PM callbacks.

Unless I'm missing something else, if runtime PM was not prevented via
userspace/pm_runtime_forbid(), we would not need this last 'trigger'
step.  That's why a solution where any pending runtime PM transitions
would be allowed during system PM is the ideal solution (to me.)  It
avoids having to call runtime PM methods from system PM all together.

The current OMAP I2C driver in mainline does this extra "trigger" step
by directly calling the subsystem (bus) callbacks. (It's also missing
the first two steps, which is a known bug and will be fixed once I
figure out the rest of this problem.)

However, now that we have device power domains, I was planning to extend
that to call device power domain callbacks first if they exist.  Since
that was starting to duplicate callback precedence assumptions in the
runtime PM core, I was thinking about ways to avoid that by simply using
runtime PM directly, that's what got me to start this thread in the
first place.

So, I see 2 ways forward

1. Having some per-device option/flag that would allow pending runtime
   PM transitions to happen during system PM, thus removing the need
   for step 4 above.

2. Decide the "right" way to trigger device power domain (or subsytem)
   transitions from the driver.   Directly calling the subsystem
   callbacks from the driver?   Any other options?

I have a rather strong preference for the first one, but am realizing
that I may be in the minority.  So what is the recommended solution for
2?

Kevin

P.S.  I'm glad you got to discuss this with Paul & Magnus at LinuxCon
Japan.  I wish I could've been there too.  Hope your return trip went
well and your internet is back working soon.
