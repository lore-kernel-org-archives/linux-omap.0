From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Tue, 26 Aug 2008 10:18:56 -0700
Message-ID: <5e088bd90808261018h1e04cbd4o20e88669031eda4d@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	 <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
	 <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
	 <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
	 <20080826161938.4fc7e990.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:56558 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085AbYHZRS6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 13:18:58 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1192629yxm.1
        for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 10:18:57 -0700 (PDT)
In-Reply-To: <20080826161938.4fc7e990.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>, Felipe Balbi <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Sounds indeed strange. Can you track is the pcm_file->substream getting
> zeroed somewhere after it is set in snd_pcm_open_file? Like printing
> both address of pcm_file and pcm_file->substream.

I added a bunch of tracking to the ioctl handling in pcm_native.c to
see where the substream pointer goes null.

It appears that substream is valid through the SNDRV_PCM_IOCTL_START
ioctl call, and then goes null for SNDRV_PCM_IOCTL_PVERSION and
SNDRV_PCM_IOCTL_INFO where it finally crashes.

I don't believe that it is the SNDRV_PCM_IOCTL_START that writes a
null in substream, so it is likely something in alsa-lib :-(

It isn't confidence inspiring to see comments like /* AB: FIXME!!!
This is definitely nonsense */ in snd_pcm_info (the function where it
finally crashes)

Steve


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

snd_pcm_open_file 2102 substream c7bdb900
success: snd_pcm_open 2168 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_INFO:snd_pcm_common_ioctl1 2517 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_INFO:snd_pcm_common_ioctl1 2517 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_PVERSION:snd_pcm_common_ioctl1 2514 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_TSTAMP:snd_pcm_common_ioctl1 2520 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_SYNC_PTR:snd_pcm_common_ioctl1 2571 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_HW_REFINE:snd_pcm_common_ioctl1 2526 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_HW_REFINE:snd_pcm_common_ioctl1 2526 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_HW_REFINE:snd_pcm_common_ioctl1 2526 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_HW_REFINE:snd_pcm_common_ioctl1 2526 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_HW_REFINE:snd_pcm_common_ioctl1 2526 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_HW_REFINE:snd_pcm_common_ioctl1 2526 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_HW_REFINE:snd_pcm_common_ioctl1 2526 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_HW_REFINE:snd_pcm_common_ioctl1 2526 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_HW_REFINE:snd_pcm_common_ioctl1 2526 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_HW_PARAMS:snd_pcm_common_ioctl1 2529 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_SYNC_PTR:snd_pcm_common_ioctl1 2571 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_SW_PARAMS:snd_pcm_common_ioctl1 2535 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_CHANNEL_INFO:snd_pcm_common_ioctl1 2541 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_CHANNEL_INFO:snd_pcm_common_ioctl1 2541 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_PREPARE:snd_pcm_common_ioctl1 2544 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_SYNC_PTR:snd_pcm_common_ioctl1 2571 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_SW_PARAMS:snd_pcm_common_ioctl1 2535 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_SYNC_PTR:snd_pcm_common_ioctl1 2571 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream c7bdb900
SNDRV_PCM_IOCTL_START:snd_pcm_common_ioctl1 2550 substream c7bdb900
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream 00000000
SNDRV_PCM_IOCTL_PVERSION:snd_pcm_common_ioctl1 2514 substream 00000000
OTHER (passing to snd_pcm_common_ioctl1):snd_pcm_playback_ioctl1 2682
substream 00000000
SNDRV_PCM_IOCTL_INFO:snd_pcm_common_ioctl1 2517 substream 00000000
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c6db8000
[00000000] *pgd=86d5e031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in: ipv6 rtl8187 eeprom_93cx6
CPU: 0    Not tainted  (2.6.27-rc3-omap1 #1)
PC is at snd_pcm_info+0xc/0xe0
LR is at snd_pcm_info_user+0x38/0x94
pc : [<c0256414>]    lr : [<c0256520>]    psr: a0000013
sp : c6ccdd98  ip : c6ccddb8  fp : c6ccddb4
r10: 00000001  r9 : c6ccc000  r8 : c002ce04
r7 : 00000000  r6 : 00000000  r5 : c7b85c00  r4 : bef36480
r3 : 00000001  r2 : 00000000  r1 : c7b85c00  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 86db8018  DAC: 00000015
Process mplayer (pid: 1719, stack limit = 0xc6ccc2e8)
Stack: (0xc6ccdd98 to 0xc6cce000)
dd80:                                                       bef36480 c7b85c00
dda0: 00000000 00000000 c6ccddd4 c6ccddb8 c0256520 c0256414 81204101 bef36480
ddc0: c6cca080 00000000 c6ccdefc c6ccddd8 c025783c c02564f4 00000025 c0430a98
dde0: c6ccde0c c6ccddf0 c002c04c c0051114 ffffffff d8200000 00000000 c6cca080
de00: c6ccded4 c6ccde10 c002c830 c002c00c c042e39c 000051cf 00000000 30000013
de20: c045252c bef36480 00000000 c6cca080 c03f8448 c0452588 00000000 c6ccded4
de40: c6ccde30 c6ccde58 c004cd4c c004d278 60000013 ffffffff c6c37480 00000006
de60: 30000013 0000005c c6ccde94 c6ccde78 c0083d8c c007e470 00000000 00000003
de80: 0000001f c6d79160 c6ccdedc c6ccde98 c008474c c0083cb0 00000000 00000000
dea0: c6c37480 c791a520 00000003 81204101 bef36480 00000000 c6cca080 c002ce04
dec0: c6ccc000 00000001 c6ccdeec c6ccded8 c004d2d0 81204101 bef36480 00000000
dee0: c6cca080 c002ce04 c6ccc000 00000001 c6ccdf2c c6ccdf00 c0258fe0 c025766c
df00: c6ccdf54 c6ccdf10 c00868dc c0085b78 81204101 bef36480 00000005 c6cca080
df20: c6ccdf3c c6ccdf30 c0259108 c0258b84 c6ccdf54 c6ccdf40 c00a5bb8 c02590e0
df40: c6cca080 bef36480 c6ccdf7c c6ccdf58 c00a5e6c c00a5b90 406b6000 00000096
df60: 00000005 bef36480 81204101 c6cca080 c6ccdfa4 c6ccdf80 c00a5ebc c00a5c08
df80: c0086b54 00000000 402c0444 007ee3b0 402c0444 00000036 00000000 c6ccdfa8
dfa0: c002cc80 c00a5e88 402c0444 007ee3b0 00000005 81204101 bef36480 007fbf10
dfc0: 402c0444 007ee3b0 402c0444 00000036 bef36480 00000016 00000001 bef3665c
dfe0: 007ee3b0 bef36458 4025a3d8 404c099c 20000010 00000005 00000000 00000000
Backtrace:
[<c0256408>] (snd_pcm_info+0x0/0xe0) from [<c0256520>]
(snd_pcm_info_user+0x38/0x94)
 r7:00000000 r6:00000000 r5:c7b85c00 r4:bef36480
[<c02564e8>] (snd_pcm_info_user+0x0/0x94) from [<c025783c>]
(snd_pcm_common_ioctl1+0x1dc/0x10e4)
 r7:00000000 r6:c6cca080 r5:bef36480 r4:81204101
[<c0257660>] (snd_pcm_common_ioctl1+0x0/0x10e4) from [<c0258fe0>]
(snd_pcm_playback_ioctl1+0x468/0x498)
[<c0258b78>] (snd_pcm_playback_ioctl1+0x0/0x498) from [<c0259108>]
(snd_pcm_playback_ioctl+0x34/0x38)
 r7:c6cca080 r6:00000005 r5:bef36480 r4:81204101
[<c02590d4>] (snd_pcm_playback_ioctl+0x0/0x38) from [<c00a5bb8>]
(vfs_ioctl+0x34/0x78)
[<c00a5b84>] (vfs_ioctl+0x0/0x78) from [<c00a5e6c>] (do_vfs_ioctl+0x270/0x280)
 r5:bef36480 r4:c6cca080
[<c00a5bfc>] (do_vfs_ioctl+0x0/0x280) from [<c00a5ebc>] (sys_ioctl+0x40/0x64)
 r7:c6cca080 r6:81204101 r5:bef36480 r4:00000005
[<c00a5e7c>] (sys_ioctl+0x0/0x64) from [<c002cc80>] (ret_fast_syscall+0x0/0x2c)
 r7:00000036 r6:402c0444 r5:007ee3b0 r4:402c0444
Code: e89da830 e1a0c00d e92dd8f0 e24cb004 (e5904000)
---[ end trace 720db3cd45410745 ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 17 [#2]
Modules linked in: ipv6 rtl8187 eeprom_93cx6
CPU: 0    Tainted: G      D    (2.6.27-rc3-omap1 #1)
PC is at snd_pcm_release+0x20/0x88
LR is at __fput+0xb8/0x170
pc : [<c025590c>]    lr : [<c009af68>]    psr: a0000013
sp : c6ccdb60  ip : c6ccdb88  fp : c6ccdb84
r10: c79d8200  r9 : c6ccdd50  r8 : c6cca080
r7 : c6d9e2a8  r6 : c6cca080  r5 : c6c41ab0  r4 : 00000000
r3 : c02558ec  r2 : 00000000  r1 : c6cca080  r0 : ffffffff
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 86dbc018  DAC: 00000015
Process mplayer (pid: 1719, stack limit = 0xc6ccc2e8)
Stack: (0xc6ccdb60 to 0xc6cce000)
db60: 00000008 c6c41ab0 c6cca080 c7887788 c74eb980 c6ccdd50 c6ccdbb4 c6ccdb88
db80: c009af68 c02558f8 00000000 c6ccc000 c6cca080 00000000 c7887780 c7887788
dba0: 00000000 00000008 c6ccdbc4 c6ccdbb8 c009b2dc c009aebc c6ccdbe4 c6ccdbc8
dbc0: c009804c c009b2b8 c7887780 00000001 00000014 c7887788 c6ccdc0c c6ccdbe8
dbe0: c004de48 c0097fe4 c6ccc000 c791a520 0000000b c0256414 00000001 c6ccdd50
dc00: c6ccdc1c c6ccdc10 c004dec4 c004ddd0 c6ccdc34 c6ccdc20 c004f10c c004dea8
dc20: c004c458 c004c270 c6ccdc44 c6ccdc38 c0030864 c004ef0c c6ccdc64 c6ccdc48
dc40: c0031cf0 c00305cc 00010000 c6ca9b58 c791a520 c6c374b4 c6ccdca4 c6ccdc68
dc60: c0031f08 c0031c90 00000001 c0456944 0000000a 00000017 00000000 c0426850
dc80: 00000017 c6ccdd50 00000000 c002ce04 60000113 00000001 c6ccdd4c c6ccdca8
dca0: c002c1e8 c0031d0c c0051174 c00448d0 00000025 c0430a98 c6ccdce4 c6ccdcc8
dcc0: c002c04c c0051114 ffffffff d8200000 00000000 00000000 c6ccddac c6ccdce8
dce0: c002c830 c002c00c c042e39c 00005215 00000000 60000013 c045252c bef36480
dd00: 00000000 00000000 c03f7fe3 c0452572 00000000 c6ccddac c6ccdd08 c6ccdd30
dd20: c004cd4c c004d278 60000013 ffffffff ffffffff c6ccdd84 00000000 00000000
dd40: c6ccddb4 c6ccdd50 c002c7ec c002c1b8 00000000 c7b85c00 00000000 00000001
dd60: bef36480 c7b85c00 00000000 00000000 c002ce04 c6ccc000 00000001 c6ccddb4
dd80: c6ccddb8 c6ccdd98 c0256520 c0256414 a0000013 ffffffff bef36480 c7b85c00
dda0: 00000000 00000000 c6ccddd4 c6ccddb8 c0256520 c0256414 81204101 bef36480
ddc0: c6cca080 00000000 c6ccdefc c6ccddd8 c025783c c02564f4 00000025 c0430a98
dde0: c6ccde0c c6ccddf0 c002c04c c0051114 ffffffff d8200000 00000000 c6cca080
de00: c6ccded4 c6ccde10 c002c830 c002c00c c042e39c 000051cf 00000000 30000013
de20: c045252c bef36480 00000000 c6cca080 c03f8448 c0452588 00000000 c6ccded4
de40: c6ccde30 c6ccde58 c004cd4c c004d278 60000013 ffffffff c6c37480 00000006
de60: 30000013 0000005c c6ccde94 c6ccde78 c0083d8c c007e470 00000000 00000003
de80: 0000001f c6d79160 c6ccdedc c6ccde98 c008474c c0083cb0 00000000 00000000
dea0: c6c37480 c791a520 00000003 81204101 bef36480 00000000 c6cca080 c002ce04
dec0: c6ccc000 00000001 c6ccdeec c6ccded8 c004d2d0 81204101 bef36480 00000000
dee0: c6cca080 c002ce04 c6ccc000 00000001 c6ccdf2c c6ccdf00 c0258fe0 c025766c
df00: c6ccdf54 c6ccdf10 c00868dc c0085b78 81204101 bef36480 00000005 c6cca080
df20: c6ccdf3c c6ccdf30 c0259108 c0258b84 c6ccdf54 c6ccdf40 c00a5bb8 c02590e0
df40: c6cca080 bef36480 c6ccdf7c c6ccdf58 c00a5e6c c00a5b90 406b6000 00000096
df60: 00000005 bef36480 81204101 c6cca080 c6ccdfa4 c6ccdf80 c00a5ebc c00a5c08
df80: c0086b54 00000000 402c0444 007ee3b0 402c0444 00000036 00000000 c6ccdfa8
dfa0: c002cc80 c00a5e88 402c0444 007ee3b0 00000005 81204101 bef36480 007fbf10
dfc0: 402c0444 007ee3b0 402c0444 00000036 bef36480 00000016 00000001 bef3665c
dfe0: 007ee3b0 bef36458 4025a3d8 404c099c 20000010 00000005 00000000 00000000
Backtrace:
[<c02558ec>] (snd_pcm_release+0x0/0x88) from [<c009af68>] (__fput+0xb8/0x170)
 r9:c6ccdd50 r8:c74eb980 r7:c7887788 r6:c6cca080 r5:c6c41ab0
r4:00000008
[<c009aeb0>] (__fput+0x0/0x170) from [<c009b2dc>] (fput+0x30/0x34)
[<c009b2ac>] (fput+0x0/0x34) from [<c009804c>] (filp_close+0x74/0x80)
[<c0097fd8>] (filp_close+0x0/0x80) from [<c004de48>]
(put_files_struct+0x84/0xd8)
 r7:c7887788 r6:00000014 r5:00000001 r4:c7887780
[<c004ddc4>] (put_files_struct+0x0/0xd8) from [<c004dec4>]
(exit_files+0x28/0x2c)
 r9:c6ccdd50 r8:00000001 r7:c0256414 r6:0000000b r5:c791a520
r4:c6ccc000
[<c004de9c>] (exit_files+0x0/0x2c) from [<c004f10c>] (do_exit+0x20c/0x6e8)
[<c004ef00>] (do_exit+0x0/0x6e8) from [<c0030864>] (die+0x2a4/0x300)
[<c00305c0>] (die+0x0/0x300) from [<c0031cf0>] (__do_kernel_fault+0x6c/0x7c)
[<c0031c84>] (__do_kernel_fault+0x0/0x7c) from [<c0031f08>]
(do_page_fault+0x208/0x224)
 r7:c6c374b4 r6:c791a520 r5:c6ca9b58 r4:00010000
[<c0031d00>] (do_page_fault+0x0/0x224) from [<c002c1e8>]
(do_DataAbort+0x3c/0x9c)
[<c002c1ac>] (do_DataAbort+0x0/0x9c) from [<c002c7ec>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc6ccdd50 to 0xc6ccdd98)
dd40:                                     00000000 c7b85c00 00000000 00000001
dd60: bef36480 c7b85c00 00000000 00000000 c002ce04 c6ccc000 00000001 c6ccddb4
dd80: c6ccddb8 c6ccdd98 c0256520 c0256414 a0000013 ffffffff
 r7:00000000 r6:00000000 r5:c6ccdd84 r4:ffffffff
[<c0256408>] (snd_pcm_info+0x0/0xe0) from [<c0256520>]
(snd_pcm_info_user+0x38/0x94)
 r7:00000000 r6:00000000 r5:c7b85c00 r4:bef36480
[<c02564e8>] (snd_pcm_info_user+0x0/0x94) from [<c025783c>]
(snd_pcm_common_ioctl1+0x1dc/0x10e4)
 r7:00000000 r6:c6cca080 r5:bef36480 r4:81204101
[<c0257660>] (snd_pcm_common_ioctl1+0x0/0x10e4) from [<c0258fe0>]
(snd_pcm_playback_ioctl1+0x468/0x498)
[<c0258b78>] (snd_pcm_playback_ioctl1+0x0/0x498) from [<c0259108>]
(snd_pcm_playback_ioctl+0x34/0x38)
 r7:c6cca080 r6:00000005 r5:bef36480 r4:81204101
[<c02590d4>] (snd_pcm_playback_ioctl+0x0/0x38) from [<c00a5bb8>]
(vfs_ioctl+0x34/0x78)
[<c00a5b84>] (vfs_ioctl+0x0/0x78) from [<c00a5e6c>] (do_vfs_ioctl+0x270/0x280)
 r5:bef36480 r4:c6cca080
[<c00a5bfc>] (do_vfs_ioctl+0x0/0x280) from [<c00a5ebc>] (sys_ioctl+0x40/0x64)
 r7:c6cca080 r6:81204101 r5:bef36480 r4:00000005
[<c00a5e7c>] (sys_ioctl+0x0/0x64) from [<c002cc80>] (ret_fast_syscall+0x0/0x2c)
 r7:00000036 r6:402c0444 r5:007ee3b0 r4:402c0444
Code: e3a02000 e3e00000 e5974000 e1a08001 (e5945000)
---[ end trace 720db3cd45410745 ]---
Fixing recursive fault but reboot is needed!
