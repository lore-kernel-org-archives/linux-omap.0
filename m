From: Sergey Lapin <slapinid@gmail.com>
Subject: McBSP troubles
Date: Sat, 21 Nov 2009 18:54:41 +0300
Message-ID: <48239d390911210754q5ef62784p4168a4e2a7324db0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:43025 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbZKUPyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Nov 2009 10:54:36 -0500
Received: by ey-out-2122.google.com with SMTP id 4so674669eyf.19
        for <linux-omap@vger.kernel.org>; Sat, 21 Nov 2009 07:54:41 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, all!

I have problems making any sound with current linux-omap master.
Driver below worked ok with 2.6.28-omap1, and debugging output of
mcbsp driver is the following:
gnome5:~# aplay -c 2 -f S16_LE /dev/urandom
[ 4593.480072] !!!omap_mcbsp_dai_startup()
[ 4593.484283] !!!omap2_mcbsp_request()
[ 4593.488159] disabling LINE_OUT
[ 4593.491302] disabling DMIC
[ 4593.494018] Disabling ASSYM pin
Playing raw data '/dev/urandom' : Signed 16 bit Little Endian, Rate
8000 Hz, Stereo
[ 4593.522064] !!!omap_mcbsp_dai_set_dai_fmt()
[ 4593.615905] !!!omap_mcbsp_dai_hw_params()
[ 4593.620086] omap-mcbsp omap-mcbsp.2: Configuring McBSP2  phys_base:
0x49022000
[ 4593.678375] gnome5_jack_event
[ 4593.726623] !!!omap_mcbsp_set_threshold()
[ 4593.730651] !!!omap_mcbsp_dai_trigger()
[ 4593.735015] omap-mcbsp omap-mcbsp.2: **** McBSP2 regs ****
[ 4593.740539] omap-mcbsp omap-mcbsp.2: DRR2:  0xd907da5a
[ 4593.745697] omap-mcbsp omap-mcbsp.2: DRR1:  0x0000
[ 4593.750518] omap-mcbsp omap-mcbsp.2: DXR2:  0x0000
[ 4593.755340] omap-mcbsp omap-mcbsp.2: DXR1:  0x0000
[ 4593.760162] omap-mcbsp omap-mcbsp.2: SPCR2: 0x02f5
[ 4593.764984] omap-mcbsp omap-mcbsp.2: SPCR1: 0x0030
[ 4593.769805] omap-mcbsp omap-mcbsp.2: RCR2:  0x8041
[ 4593.774627] omap-mcbsp omap-mcbsp.2: RCR1:  0x0040
[ 4593.779449] omap-mcbsp omap-mcbsp.2: XCR2:  0x8041
[ 4593.784271] omap-mcbsp omap-mcbsp.2: XCR1:  0x0040
[ 4593.789093] omap-mcbsp omap-mcbsp.2: SRGR2: 0x001f
[ 4593.793884] omap-mcbsp omap-mcbsp.2: SRGR1: 0x0f00
[ 4593.798706] omap-mcbsp omap-mcbsp.2: PCR0:  0x000f
[ 4593.803527] omap-mcbsp omap-mcbsp.2: ***********************
[ 4603.811187] ALSA sound/core/pcm_lib.c:1708: playback write error
(DMA or IRQ trouble?)
[ 4614.818878] ALSA sound/core/pcm_lib.c:1708: playback write error
(DMA or IRQ trouble?)
aplay: pcm_write:1442: write error:

And no sound at all. Codec is supplied properly with clock, and
programmed normally, so
I think that's McBSP trouble, but I might be wrong. I use tlv320aic32 as codec.

I use slightly modified sound/soc/omap/n810.c with clock names changed
for OMAP3.
Clock is supplied properly.
