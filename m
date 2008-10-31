From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] 34xx spurious interrupts unravelling
Date: Fri, 31 Oct 2008 12:21:09 -0700
Message-ID: <1225480873-30835-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59040 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbYJaTVR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 15:21:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Hi all,

So it's now starting to look like we need to ensure write posting in
interrupt handlers for 34xx instead of marking the IO areas as strongly
ordered.

The first patch in the series reverts marking the IO areas as strongly
ordered.

The second debug patch also prints out the previous interrupt before
the spurious interrupt, which should help identify the interrupt
handler that needs a read back of some register.

So if you see errors like this with dspbridge:

FIXME: spurious irq 95: 0xffffffdf previous irq 26
FIXME: spurious irq 95: 0xffffffdf previous irq 26
FIXME: spurious irq 95: 0xffffffdf previous irq 26
...

You'll know that the interrupt handler for irq 26 needs a read back
of some register in the interrupt handler. Most likely you need to
read back the interrupt ack register right after writing to it in
the handler, see a later patch in this series for dspbridge.

If you get errors like this during boot:

FIXME: spurious irq 95: 0xffffffdf previous irq 25       
FIXME: spurious irq 95: 0xffffffdf previous irq 25       
FIXME: spurious irq 95: 0xffffffdf previous irq 37
...

Most likely we need to do a read back when initializing some devices
like dispc and gptimer. I don't have patches for these yet..

The other patches fix few interrupt handlers that I'm aware of needing
this, like i2c-omap and dspbridge. The dspbridge patch only applies
if you have it installed.

I'd appreciate if people who have been working on this issue would
torture test this series and provide feedback!

Cheers,

Tony
