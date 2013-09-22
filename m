From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 0/5] dma: cppi41: some trivial fixes and support for suspend/resume
Date: Sun, 22 Sep 2013 13:57:43 +0200
Message-ID: <1379851068-18675-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:58093 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879Ab3IVL6E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Sep 2013 07:58:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org, Daniel Mack <zonque@gmail.com>

Here are some patches to teach the cppi41 DMA driver support for
suspend and resume. Patches 1-3 are simply cosmetic things that emerged
during my debugging sessions.

Patch #4 is actually a real bugfix which I would like Sebastian
Andrzej Siewior to have a look at. Quite frankly, the allocation scheme
in this driver and the logic to determine a descriptor's index number
seems quite complicated to me, but that's probably a different story.
Allocating and freeing the exact same pointer more than once is
certainly a bug.

Patch #5 adds support for suspend and resume. As the commit log says,
the code needed to achive this is the result of a trial-and-error
session. This is the minimum that's I'm left with now and which works
for me.

On a different note, I'm also working on patches for the musb core to
make it suspend and resume. Currently, I still have to rmmod/insmod
musb_dsps before/after the resume cycle, but I'm hoping to make
progress here soon.


Thanks,
Daniel

v1 -> v2:
	* Patch #5: depend on CONFIG_PM_SLEEP rather than on
	  CONFIG_PM and use SIMPLE_DEV_PM_OPS
	  (Reported by Sergei Shtylyov)

Daniel Mack (5):
  dma: cppi41: pass around device instead of platform_device
  dma: cppi41: s/deinit_cpii41/deinit_cppi41/
  dma: cppi41: add shortcut to &pdev->dev in cppi41_dma_probe()
  dma: cppi41: only allocate descriptor memory once
  dma: cppi41: add support for suspend and resume

 drivers/dma/cppi41.c | 120 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 45 deletions(-)

-- 
1.8.3.1

