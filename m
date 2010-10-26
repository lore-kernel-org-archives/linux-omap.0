From: ylin@mail.com
Subject: omap-pcm audio playback skips couple frames at first interrupt
Date: Tue, 26 Oct 2010 12:38:12 -0400
Message-ID: <8CD434350DBF097-D68-8BC6@web-mmc-d06.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from imr-da05.mx.aol.com ([205.188.105.147]:37364 "EHLO
	imr-da05.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab0JZQic convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 12:38:32 -0400
Received: from imo-da01.mx.aol.com (imo-da01.mx.aol.com [205.188.169.199])
	by imr-da05.mx.aol.com (8.14.1/8.14.1) with ESMTP id o9QGcUQ4001337
	for <linux-omap@vger.kernel.org>; Tue, 26 Oct 2010 12:38:30 -0400
Received: from ylin@mail.com
	by imo-da01.mx.aol.com  (mail_out_v42.9.) id x.e6d.c74fed2 (43837)
	 for <linux-omap@vger.kernel.org>; Tue, 26 Oct 2010 12:38:25 -0400 (EDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am using 2.6.32 with omap3evm board.
The audio skips a couple of frames at the first interrupt on palyback 
(TWL4030) when I use small period size (10msec).  But the same 
parameters work fine on capture.  With large period/frame size, it 
works fine also.
The skip causes extra delays (30msec at 16kHz) which I tried to 
minimize.  From omap-pcm.c the similar parameters are used to setup DMA 
for both playback and capture, but why only playback does the skip?

The following are logs with xrun_debug=9:

root@omap3evm:~# aplay -f S16_LE -r 16000 -c 2 -d 1 -F 10000 -B 80000 
-R 10000 -T 160000 < /dev/urandom

Oct 26 11:04:11 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0: 
pos=0x280/0xa0/0x500, hwptr=0x0, hw_base=0x0, hw_intr=0x0
Oct 26 11:04:11 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:334: PCM: Lost interrupts? (stream=0, delta=480, 
intr_ptr=160)
Oct 26 11:04:11 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0: 
pos=0x3c0/0xa0/0x500, hwptr=0x320, hw_base=0x0, hw_intr=0x320
Oct 26 11:04:11 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0: 
pos=0x0/0xa0/0x500, hwptr=0x460, hw_base=0x0, hw_intr=0x460
Oct 26 11:04:11 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0: 
pos=0x140/0xa0/0x500, hwptr=0x5a0, hw_base=0x500, hw_intr=0x5a0
Oct 26 11:04:11 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0: 
pos=0x280/0xa0/0x500, hwptr=0x6e0, hw_base=0x500, hw_intr=0x6e0
Oct 26 11:04:11 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0: 
pos=0x3c0/0xa0/0x500, hwptr=0x820, hw_base=0x500, hw_intr=0x820
Oct 26 11:04:11 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0: 
pos=0x0/0xa0/0x500, hwptr=0x960, hw_base=0x500, hw_intr=0x960


root@omap3evm:~# arecord -f S16_LE -r 16000 -c 2 -d 1 -F 10000 -B 80000 
-R 10000 -T 160000 /tmp/test.pcm

Oct 26 11:04:13 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0c:0: 
pos=0x140/0xa0/0x500, hwptr=0xa0, hw_base=0x0, hw_intr=0xa0
Oct 26 11:04:13 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0c:0: 
pos=0x280/0xa0/0x500, hwptr=0x1e0, hw_base=0x0, hw_intr=0x1e0
Oct 26 11:04:13 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0c:0: 
pos=0x3c0/0xa0/0x500, hwptr=0x320, hw_base=0x0, hw_intr=0x320


root@omap3evm:~# aplay -f S16_LE -r 16000 -c 2 -d 1 -F 40000 -B 320000 
-R 40000 -T 640000 < /dev/urandom

Oct 26 11:18:46 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0: 
pos=0x400/0x200/0x1400, hwptr=0x200, hw_base=0x0, hw_intr=0x200
Oct 26 11:18:46 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0: 
pos=0x800/0x200/0x1400, hwptr=0x600, hw_base=0x0, hw_intr=0x600
Oct 26 11:18:46 omap3evm user.debug kernel: ALSA 
sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0: 
pos=0xc00/0x200/0x1400, hwptr=0xa00, hw_base=0x0, hw_intr=0xa00

Best regards,
Ying Lin
