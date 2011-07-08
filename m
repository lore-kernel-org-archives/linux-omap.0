From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 00/11] Tahvo cleanups and Retu optimization
Date: Sat,  9 Jul 2011 01:52:28 +0300
Message-ID: <1310165559-31037-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:35435 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752099Ab1GHWwp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 18:52:45 -0400
Received: by mail-bw0-f47.google.com with SMTP id 20so2484507bwf.20
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 15:52:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

a few more CBUS patches. I started cleaning
up tahvo and also found two possible optimizations
on Retu which are based on patches from Thomas
Gleixner and Sebastian Siewior - on other pieces
of code, of course :-p

These patches were compile tested only. It would
be very nice if someone could actually measure
IRQ latency on Retu to see if managed to spend
considerably less time looping on the IDR register.

Anyway, following are the patches.

Felipe Balbi (11):
  cbus: tahvo: convert spinlock into mutex
  cbus: tahvo: move to __devinit/__devexit sections
  cbus: tahvo: a switch looks better
  cbus: tahvo: don't go over 80 columns
  cbus: tahvo: drop the tasklet
  cbus: retu: set IRQF_ONESHOT flag
  cbus: tahvo: git it a context structure
  cbus: tahvo: pass tahvo to IRQ handler
  cbus: tahvo: introduce __tahvo_(read/write)_reg
  cbus: tahvo: drop some unneded defines
  cbus: retu: IRQ demux optimization

 drivers/cbus/retu.c  |   18 ++--
 drivers/cbus/tahvo.c |  256 +++++++++++++++++++++++++++-----------------------
 2 files changed, 150 insertions(+), 124 deletions(-)

-- 
1.7.6

