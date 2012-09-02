From: Christian Hoffmann <chrmhoffmann@gmail.com>
Subject: mbox: possible deadlock
Date: Sun, 2 Sep 2012 16:51:10 +0200
Message-ID: <CAAk9F98P6oXSLOOPcKzHe0gX_8c4cdvCpfm+3=R5wjREsSJ8DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46145 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab2IBOvM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Sep 2012 10:51:12 -0400
Received: by lbbgj3 with SMTP id gj3so2064515lbb.19
        for <linux-omap@vger.kernel.org>; Sun, 02 Sep 2012 07:51:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Trying to find a hanging reason for a custom omap4430 board (aka nook
tablet), I stumled over a possible circular locking problem on
startup:
...
<4>[   12.078216]
<4>[   12.078247] =======================================================
<4>[   12.087341] [ INFO: possible circular locking dependency detected ]
<4>[   12.094329] 3.0.31+ #2
<4>[   12.097290] -------------------------------------------------------
<4>[   12.104278] kworker/0:1/58 is trying to acquire lock:
<4>[   12.110168]  ((&mq->work)){+.+.+.}, at: [<c00d2fb0>]
wait_on_work+0x0/0x1cc
<4>[   12.118621]
<4>[   12.118621] but task is already holding lock:
<4>[   12.125549]  (mbox_configured_lock){+.+.+.}, at: [<c009ddd4>]
omap_mbox_put+0x34/0x100
<4>[   12.135009]
<4>[   12.135040] which lock already depends on the new lock.
...
<4>[   12.504486] Chain exists of:
<4>[   12.504486]   (&mq->work) --> &rproc->lock --> mbox_configured_lock
<4>[   12.515899]
<4>[   12.518127]  Possible unsafe locking scenario:
<4>[   12.518127]
<4>[   12.524963]        CPU0                    CPU1
<4>[   12.530242]        ----                    ----
<4>[   12.535369]   lock(mbox_configured_lock);
<4>[   12.540344]                                lock(&rproc->lock);
<4>[   12.547485]                                lock(mbox_configured_lock);
<4>[   12.555389]   lock((&mq->work));
<4>[   12.559539]
<4>[   12.559539]  *** DEADLOCK ***
<4>[   12.559539]
<4>[   12.566589] 3 locks held by kworker/0:1/58:
<4>[   12.571502]  #0:  (pm){.+.+..}, at: [<c00d34b8>]
process_one_work+0x124/0x590
<4>[   12.580322]  #1:  ((&dev->power.work)){+.+...}, at: [<c00d34b8>]
process_one_work+0x124/0x590
<4>[   12.590850]  #2:  (mbox_configured_lock){+.+.+.}, at:
[<c009ddd4>] omap_mbox_put+0x34/0x100
<4>[   12.601165]

Full dmesg can be found here:
https://dl.dropbox.com/u/21820416/mbox-deadlock.dmesg
For the record: Kernel source is very close to p-android-3.0. It can
be found here:
https://github.com/Kuzma30/kernel3NookTablet/tree/jellybean

Used config: cyanogenmod_acclaim_defconfig.

Kind regards,
Chris
