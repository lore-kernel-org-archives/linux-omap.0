From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/3] dma: cppi41: more suspend/resume patches
Date: Wed, 2 Oct 2013 12:20:33 +0200
Message-ID: <20131002102033.GB16680@linutronix.de>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41738 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3JBKUf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 06:20:35 -0400
Content-Disposition: inline
In-Reply-To: <1380634271-27588-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

* Daniel Mack | 2013-10-01 15:31:08 [+0200]:

>Patch #3, however, gives me headaches. I can't fully explain what's
>going on, but I can tell for sure that if fixes a problem that I stared
>on for many hours.
>
>The problem is that on resume, the musb core will detect that some of
>the suspended USB devices' endpoints are stalled. Which is something
>that is unrelated to the dma driver, it just seems to be an expected
>condition. That, however, makes the musb core call
>cppi41_dma_channel_abort() -> cppi41_tear_down_chan(), which is
>an otherwise untravelled code path. When that function is called for
>a channel which has all of td_queued, td_seen and td_desc_seen set
>to FALSE, I'm always getting a warning like this:
>
>[   17.105981] ------------[ cut here ]------------
>[   17.110861] WARNING: CPU: 0 PID: 122 at drivers/dma/cppi41.c:644 cppi41_dma_control+0x378/0x3f8 [cppi41]()

This is 
    WARN_ON(!cdd->chan_busy[desc_num]);

at the end of cppi41_stop_chan() right? So you get the warning because
you tried to stop a channel which was not busy. But then you should not
be called at all because cppi41_dma_channel_abort() shouldn't call dma
driver on idle channels. So it should complete at some point.

>Note that the line numbers don't match the current code in mainline due
>to some debugging code, but it should be clear where the warning comes
>from.
>
>With patch #3 applied, I made this problem go away, and I can suspend
>resume with all musb related drivers active just fine. The only issue
>I have is that I don't fully understand the reason, as it seems to me
>that my patch just changes the timing, and we're actually seeing a
>race condition here.
>
>Sebastian, can you give a comment on this? I'll post the musb patches
>that are necessary as well now, and I'd appreciate more testers here.

How does your suspend & resume thingy work? Is it completly shutdown
i.e. powered off? According to you earlier patches I would assume so. In
that case the request is not enqueued and there is nothing to be removed
from the engine, right?
With the change you somehow get an interrupt that cleans up that slot.
If you trigger TD bits for a random channel you get atleast the teardown
descriptor. But then you don't complain about the WARN_ON() about
missing / wrong desc_phys.
In general this works like this:
- descriptor is busy / in progress.
  The TEAR-DOWN bits have to be set a few times. The hw returns the
  teardown descriptor and the descriptor that has been enqueued
- descriptor is queued but not busy / in use
  Setting the TEAR-DOWN bit once seems to be enough. The hw returns
  _only_ the teardown descriptor. The transfer descriptor remains pushed
  onto the queue like it has been never consumed. A pop cleans it up,
  the complete queue is empty. (Warning: reading the queue counter leads
  to a pop! So checking if the queue counter increments after pushing
  something to it is a bad idea).

The whole thing has been tested by manipulating the USB storage driver
to enqueue more / less data then required by the protocol leading to a
stall followed by an abort of the transfer. Let me re-do your suspend
with the patches you made so far to check what is going on and if the
"normal" transfer cancel is still working.

>Many thanks,
>Daniel

Sebastian
