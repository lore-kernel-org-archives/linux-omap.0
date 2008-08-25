From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Mon, 25 Aug 2008 12:19:16 -0700
Message-ID: <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	 <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
	 <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:29534 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbYHYTTS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 15:19:18 -0400
Received: by yx-out-2324.google.com with SMTP id 8so946971yxm.1
        for <linux-omap@vger.kernel.org>; Mon, 25 Aug 2008 12:19:16 -0700 (PDT)
In-Reply-To: <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> For testing I use Debian/testing and alsa-utils and various
> players like mpg321, madplay, etc from there.

I've been using mplayer, madplay, aplay, arecord, speakertest . . .

I'm using a rootfs built with OpenEmbedded, the alsa lib version is 1.0.17

root@overo:~# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.17.

> Can you share the error log and steps when this typically occurs in
> order to see can I reproduce it?

Certainly!

First a few basics -- I can run commands like:

mplayer song.mp3
madplay song.mp3
aplay rawsong

with no problems.

If I run 'mplayer -ao alsa song.mp3' immediately after booting I get a
crash due to a null substream pointer (output below).

However if I run 'mplayer song.mp3' *before* 'mplayer -ao alsa
song.mp3' then the latter command works!

Here's the crash output (alsa debugging is enabled in the kernel):

 overo login: root
login[1632]: root login  on `ttyS2'

root@overo:~# mplayer -ao alsa /Watermelon_Slim-Black_Water.mp3
MPlayer 1.0rc2-4.3.1 (C) 2000-2007 MPlayer Team
CPU: ARM

Playing /Watermelon_Slim-Black_Water.mp3.
Audio file file format detected.
Clip info:
 Title: Black Water
 Artist: Watermelon Slim
 Album: http://music.download.com
 Year: 2007
 Comment: http://music.download.com/
 Track: 1
 Genre: Unknown
==========================================================================
Forced audio codec: mad
Opening audio decoder: [libmad] libmad mpeg audio decoder
AUDIO: 44100 Hz, 2 ch, s16le, 192.0 kbit/13.61% (ratio: 24000->176400)
Selected audio codec: [mad] afm: libmad (libMAD MPEG layer 1-2-3)
==========================================================================
ALSA sound/core/pcm_native.c:2573: BUG? (substream != ((void *)0))
[<c00309c8>] (dump_stack+0x0/0x14) from [<c0259ba0>]
(snd_pcm_playback_ioctl1+0x34/0x474)
[<c0259b6c>] (snd_pcm_playback_ioctl1+0x0/0x474) from [<c025a0d8>]
(snd_pcm_playback_ioctl+0x34/0x38)
 r7:c71bc000 r6:00000005 r5:bea41624 r4:80044100
[<c025a0a4>] (snd_pcm_playback_ioctl+0x0/0x38) from [<c00a5bb8>]
(vfs_ioctl+0x34/0x78)
[<c00a5b84>] (vfs_ioctl+0x0/0x78) from [<c00a5e6c>] (do_vfs_ioctl+0x270/0x280)
 r5:bea41624 r4:c71bc000
[<c00a5bfc>] (do_vfs_ioctl+0x0/0x280) from [<c00a5ebc>] (sys_ioctl+0x40/0x64)
 r7:c71bc000 r6:80044100 r5:bea41624 r4:00000005
[<c00a5e7c>] (sys_ioctl+0x0/0x64) from [<c002cc80>] (ret_fast_syscall+0x0/0x2c)
 r7:00000036 r6:00000400 r5:4001e1cc r4:bea41624
ALSA sound/core/pcm_native.c:2573: BUG? (substream != ((void *)0))
[<c00309c8>] (dump_stack+0x0/0x14) from [<c0259ba0>]
(snd_pcm_playback_ioctl1+0x34/0x474)
[<c0259b6c>] (snd_pcm_playback_ioctl1+0x0/0x474) from [<c025a0d8>]
(snd_pcm_playback_ioctl+0x34/0x38)
 r7:c71bc000 r6:00000005 r5:bea41480 r4:81204101
[<c025a0a4>] (snd_pcm_playback_ioctl+0x0/0x38) from [<c00a5bb8>]
(vfs_ioctl+0x34/0x78)
[<c00a5b84>] (vfs_ioctl+0x0/0x78) from [<c00a5e6c>] (do_vfs_ioctl+0x270/0x280)
 r5:bea41480 r4:c71bc000
[<c00a5bfc>] (do_vfs_ioctl+0x0/0x280) from [<c00a5ebc>] (sys_ioctl+0x40/0x64)
 r7:c71bc000 r6:81204101 r5:bea41480 r4:00000005
[<c00a5e7c>] (sys_ioctl+0x0/0x64) from [<c002cc80>] (ret_fast_syscall+0x0/0x2c)
 r7:00000036 r6:402c0444 r5:007ee3b0 r4:402c0444
[AO_ALSA] alsa-lib: pcm_hw.c:261:(snd_pcm_hw_info)
SNDRV_PCM_IOCTL_INFO failed: No such device or address
[AO_ALSA] alsa-lib:
pcm_direct.c:1100:(snd1_pcm_direct_initialize_poll_fd) unable to info
for slave pcm
[AO_ALSA] alsa-lib: pcm_dmix.c:1085:(snd_pcm_dmix_open) unable to
initialize poll_fd
[AO_ALSA] Playback open error: No such device or address
Could not open/initialize audio device -> no sound.
Audio: no sound
Video: no video


Exiting... (End of file)
root@overo:~# ALSA sound/core/pcm_native.c:2180: BUG? (substream != ((void *)0))
[<c00309c8>] (dump_stack+0x0/0x14) from [<c025694c>] (snd_pcm_release+0x38/0xbc)
[<c0256914>] (snd_pcm_release+0x0/0xbc) from [<c009af68>] (__fput+0xb8/0x170)
 r9:c7164000 r8:c74dd980 r7:c70c7634 r6:c71bc000 r5:c79faab0
r4:00000008
[<c009aeb0>] (__fput+0x0/0x170) from [<c009b2dc>] (fput+0x30/0x34)
[<c009b2ac>] (fput+0x0/0x34) from [<c008746c>] (remove_vma+0x40/0x70)
[<c008742c>] (remove_vma+0x0/0x70) from [<c0087568>] (exit_mmap+0xcc/0xf8)
 r5:c70c7600 r4:c7167898
[<c008749c>] (exit_mmap+0x0/0xf8) from [<c004a624>] (mmput+0x3c/0xc4)
 r6:c791a100 r5:00000000 r4:c70c7600
[<c004a5e8>] (mmput+0x0/0xc4) from [<c004dc8c>] (exit_mm+0x110/0x118)
 r5:c70c7600 r4:00000000
[<c004db7c>] (exit_mm+0x0/0x118) from [<c004f0f0>] (do_exit+0x1f0/0x6e8)
 r7:000000f8 r6:00000000 r5:c791a100 r4:c7164000
[<c004ef00>] (do_exit+0x0/0x6e8) from [<c004f664>] (do_group_exit+0x7c/0xac)
[<c004f5e8>] (do_group_exit+0x0/0xac) from [<c004f6ac>]
(sys_exit_group+0x18/0x1c)
 r5:0008c978 r4:0008c99c
[<c004f694>] (sys_exit_group+0x0/0x1c) from [<c002cc80>]
(ret_fast_syscall+0x0/0x2c)
