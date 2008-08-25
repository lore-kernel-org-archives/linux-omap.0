From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Mon, 25 Aug 2008 16:34:40 -0700
Message-ID: <5e088bd90808251634m69a9d865n89defa575fea097f@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	 <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
	 <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
	 <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
	 <20080825213510.GC14939@frodo>
	 <5e088bd90808251450p25bca40bpf810f135ddf91a73@mail.gmail.com>
	 <20080825215258.GF14939@frodo>
	 <5e088bd90808251530n1fb59656p6e994f944add7109@mail.gmail.com>
	 <20080825224003.GH14939@frodo> <20080825225450.GI14939@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:55321 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbYHYXem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 19:34:42 -0400
Received: by yx-out-2324.google.com with SMTP id 8so994240yxm.1
        for <linux-omap@vger.kernel.org>; Mon, 25 Aug 2008 16:34:41 -0700 (PDT)
In-Reply-To: <20080825225450.GI14939@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> can you also apply this other patch:
>
> diff --git a/sound/core/pcm.c b/sound/core/pcm.c

That patch didn't seem to have an effect, pretty much the same crash:

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
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c7128000
[00000000] *pgd=871c9031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in: ipv6 rtl8187 eeprom_93cx6
CPU: 0    Not tainted  (2.6.27-rc3-omap1 #1)
PC is at snd_pcm_info+0xc/0xe0
LR is at snd_pcm_info_user+0x38/0x94
pc : [<c0256330>]    lr : [<c025643c>]    psr: a0000013
sp : c71ddd98  ip : c71dddb8  fp : c71dddb4
r10: 00000001  r9 : c71dc000  r8 : c002ce04
r7 : 00000000  r6 : 00000000  r5 : c7077600  r4 : bee1d480
r3 : 00000001  r2 : 40044145  r1 : c7077600  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 87128018  DAC: 00000015
Process mplayer (pid: 1720, stack limit = 0xc71dc2e8)
Stack: (0xc71ddd98 to 0xc71de000)
dd80:                                                       bee1d480 c7077600
dda0: 00000000 00000000 c71dddd4 c71dddb8 c025643c c0256330 bee1d480 bee1d480
ddc0: 00000005 00000000 c71ddefc c71dddd8 c0257530 c0256410 84e030ff c051b060
dde0: c71dde3c c71dddf0 c008373c c007e2f0 c005059c c7129018 00000001 00000000
de00: 00000001 0000001f 406d5000 c051b060 c0171ed0 00000001 00000000 c71dc000
de20: c71d2160 406d5000 00000354 c7128000 c71dde94 c71dde40 c0084280 c00833b8
de40: 0000001f 00000001 00000000 c051afe0 c71dde74 00000001 c7123300 c007dc38
de60: 84e030ff c051b060 c71dde94 c71dde78 c0083d8c c007e470 00000000 00000003
de80: 0000001f c71d2160 c71ddedc c71dde98 c008474c c0083cb0 00000000 00000000
dea0: c7123300 c7866520 00000003 00000022 c0151c6c 00000020 c71dc000 406b6000
dec0: 406b6000 c7123300 080020fb 406d6000 c71ddf0c 81204101 bee1d480 00000005
dee0: 00000000 c002ce04 c71dc000 00000001 c71ddf2c c71ddf00 c0258b48 c0257388
df00: c71ddf54 c71ddf10 c00868dc c0085b78 81204101 bee1d480 00000005 c71d3d80
df20: c71ddf3c c71ddf30 c0258c64 c0258758 c71ddf54 c71ddf40 c00a5bb8 c0258c3c
df40: c71d3d80 bee1d480 c71ddf7c c71ddf58 c00a5e6c c00a5b90 406b6000 00000096
df60: 00000005 bee1d480 81204101 c71d3d80 c71ddfa4 c71ddf80 c00a5ebc c00a5c08
df80: c0086b54 00000000 402c0444 007ee3b0 402c0444 00000036 00000000 c71ddfa8
dfa0: c002cc80 c00a5e88 402c0444 007ee3b0 00000005 81204101 bee1d480 007fbf10
dfc0: 402c0444 007ee3b0 402c0444 00000036 bee1d480 00000016 00000001 bee1d65c
dfe0: 007ee3b0 bee1d458 4025a3d8 404c099c 20000010 00000005 00000000 00000000
Backtrace:
[<c0256324>] (snd_pcm_info+0x0/0xe0) from [<c025643c>]
(snd_pcm_info_user+0x38/0x94)
 r7:00000000 r6:00000000 r5:c7077600 r4:bee1d480
[<c0256404>] (snd_pcm_info_user+0x0/0x94) from [<c0257530>]
(snd_pcm_common_ioctl1+0x1b4/0xf9c)
 r7:00000000 r6:00000005 r5:bee1d480 r4:bee1d480
[<c025737c>] (snd_pcm_common_ioctl1+0x0/0xf9c) from [<c0258b48>]
(snd_pcm_playback_ioctl1+0x3fc/0x420)
[<c025874c>] (snd_pcm_playback_ioctl1+0x0/0x420) from [<c0258c64>]
(snd_pcm_playback_ioctl+0x34/0x38)
 r7:c71d3d80 r6:00000005 r5:bee1d480 r4:81204101
[<c0258c30>] (snd_pcm_playback_ioctl+0x0/0x38) from [<c00a5bb8>]
(vfs_ioctl+0x34/0x78)
[<c00a5b84>] (vfs_ioctl+0x0/0x78) from [<c00a5e6c>] (do_vfs_ioctl+0x270/0x280)
 r5:bee1d480 r4:c71d3d80
[<c00a5bfc>] (do_vfs_ioctl+0x0/0x280) from [<c00a5ebc>] (sys_ioctl+0x40/0x64)
 r7:c71d3d80 r6:81204101 r5:bee1d480 r4:00000005
[<c00a5e7c>] (sys_ioctl+0x0/0x64) from [<c002cc80>] (ret_fast_syscall+0x0/0x2c)
 r7:00000036 r6:402c0444 r5:007ee3b0 r4:402c0444
Code: e89da830 e1a0c00d e92dd8f0 e24cb004 (e5904000)
---[ end trace 7a94571fa90e8e6c ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 17 [#2]
Modules linked in: ipv6 rtl8187 eeprom_93cx6
CPU: 0    Tainted: G      D    (2.6.27-rc3-omap1 #1)
PC is at snd_pcm_release+0x20/0x88
LR is at __fput+0xb8/0x170
pc : [<c02558ec>]    lr : [<c009af68>]    psr: a0000013
sp : c71ddb60  ip : c71ddb88  fp : c71ddb84
r10: c79d8200  r9 : c71ddd50  r8 : c71d3d80
r7 : c70372a8  r6 : c71d3d80  r5 : c70da3d0  r4 : 00000000
r3 : c02558cc  r2 : 00000000  r1 : c71d3d80  r0 : ffffffff
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 87180018  DAC: 00000015
Process mplayer (pid: 1720, stack limit = 0xc71dc2e8)
Stack: (0xc71ddb60 to 0xc71de000)
db60: 00000008 c70da3d0 c71d3d80 c7bf1788 c74dea80 c71ddd50 c71ddbb4 c71ddb88
db80: c009af68 c02558d8 00000000 c71dc000 c71d3d80 00000000 c7bf1780 c7bf1788
dba0: 00000000 00000008 c71ddbc4 c71ddbb8 c009b2dc c009aebc c71ddbe4 c71ddbc8
dbc0: c009804c c009b2b8 c7bf1780 00000001 00000014 c7bf1788 c71ddc0c c71ddbe8
dbe0: c004de48 c0097fe4 c71dc000 c7866520 0000000b c0256330 00000001 c71ddd50
dc00: c71ddc1c c71ddc10 c004dec4 c004ddd0 c71ddc34 c71ddc20 c004f10c c004dea8
dc20: c004c458 c004c270 c71ddc44 c71ddc38 c0030864 c004ef0c c71ddc64 c71ddc48
dc40: c0031cf0 c00305cc 00010000 c71dff78 c7866520 c7123334 c71ddca4 c71ddc68
dc60: c0031f08 c0031c90 00000000 c0435cdc 00000000 00000017 c71ddcac c0426850
dc80: 00000017 c71ddd50 00000000 c002ce04 60000113 00000001 c71ddd4c c71ddca8
dca0: c002c1e8 c0031d0c c007b008 c007986c 00000044 c0436498 00000000 00000000
dcc0: c04364a4 00000000 00000002 00000001 00000000 c71dc000 c0435cdc c0435cdc
dce0: c044a3d0 c043649c 001200d2 c0436498 00000000 c7866520 001200d2 00000000
dd00: c71ddd6c c71ddd10 c051b064 c051b060 c70a7634 0000001f 00000000 c70a7528
dd20: 001200d2 00000000 c71ddd54 c71ddd38 ffffffff c71ddd84 00000000 00000000
dd40: c71dddb4 c71ddd50 c002c7ec c002c1b8 00000000 c7077600 40044145 00000001
dd60: bee1d480 c7077600 00000000 00000000 c002ce04 c71dc000 00000001 c71dddb4
dd80: c71dddb8 c71ddd98 c025643c c0256330 a0000013 ffffffff bee1d480 c7077600
dda0: 00000000 00000000 c71dddd4 c71dddb8 c025643c c0256330 bee1d480 bee1d480
ddc0: 00000005 00000000 c71ddefc c71dddd8 c0257530 c0256410 84e030ff c051b060
dde0: c71dde3c c71dddf0 c008373c c007e2f0 c005059c c7129018 00000001 00000000
de00: 00000001 0000001f 406d5000 c051b060 c0171ed0 00000001 00000000 c71dc000
de20: c71d2160 406d5000 00000354 c7128000 c71dde94 c71dde40 c0084280 c00833b8
de40: 0000001f 00000001 00000000 c051afe0 c71dde74 00000001 c7123300 c007dc38
de60: 84e030ff c051b060 c71dde94 c71dde78 c0083d8c c007e470 00000000 00000003
de80: 0000001f c71d2160 c71ddedc c71dde98 c008474c c0083cb0 00000000 00000000
dea0: c7123300 c7866520 00000003 00000022 c0151c6c 00000020 c71dc000 406b6000
dec0: 406b6000 c7123300 080020fb 406d6000 c71ddf0c 81204101 bee1d480 00000005
dee0: 00000000 c002ce04 c71dc000 00000001 c71ddf2c c71ddf00 c0258b48 c0257388
df00: c71ddf54 c71ddf10 c00868dc c0085b78 81204101 bee1d480 00000005 c71d3d80
df20: c71ddf3c c71ddf30 c0258c64 c0258758 c71ddf54 c71ddf40 c00a5bb8 c0258c3c
df40: c71d3d80 bee1d480 c71ddf7c c71ddf58 c00a5e6c c00a5b90 406b6000 00000096
df60: 00000005 bee1d480 81204101 c71d3d80 c71ddfa4 c71ddf80 c00a5ebc c00a5c08
df80: c0086b54 00000000 402c0444 007ee3b0 402c0444 00000036 00000000 c71ddfa8
dfa0: c002cc80 c00a5e88 402c0444 007ee3b0 00000005 81204101 bee1d480 007fbf10
dfc0: 402c0444 007ee3b0 402c0444 00000036 bee1d480 00000016 00000001 bee1d65c
dfe0: 007ee3b0 bee1d458 4025a3d8 404c099c 20000010 00000005 00000000 00000000
Backtrace:
[<c02558cc>] (snd_pcm_release+0x0/0x88) from [<c009af68>] (__fput+0xb8/0x170)
 r9:c71ddd50 r8:c74dea80 r7:c7bf1788 r6:c71d3d80 r5:c70da3d0
r4:00000008
[<c009aeb0>] (__fput+0x0/0x170) from [<c009b2dc>] (fput+0x30/0x34)
[<c009b2ac>] (fput+0x0/0x34) from [<c009804c>] (filp_close+0x74/0x80)
[<c0097fd8>] (filp_close+0x0/0x80) from [<c004de48>]
(put_files_struct+0x84/0xd8)
 r7:c7bf1788 r6:00000014 r5:00000001 r4:c7bf1780
[<c004ddc4>] (put_files_struct+0x0/0xd8) from [<c004dec4>]
(exit_files+0x28/0x2c)
 r9:c71ddd50 r8:00000001 r7:c0256330 r6:0000000b r5:c7866520
r4:c71dc000
[<c004de9c>] (exit_files+0x0/0x2c) from [<c004f10c>] (do_exit+0x20c/0x6e8)
[<c004ef00>] (do_exit+0x0/0x6e8) from [<c0030864>] (die+0x2a4/0x300)
[<c00305c0>] (die+0x0/0x300) from [<c0031cf0>] (__do_kernel_fault+0x6c/0x7c)
[<c0031c84>] (__do_kernel_fault+0x0/0x7c) from [<c0031f08>]
(do_page_fault+0x208/0x224)
 r7:c7123334 r6:c7866520 r5:c71dff78 r4:00010000
[<c0031d00>] (do_page_fault+0x0/0x224) from [<c002c1e8>]
(do_DataAbort+0x3c/0x9c)
[<c002c1ac>] (do_DataAbort+0x0/0x9c) from [<c002c7ec>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc71ddd50 to 0xc71ddd98)
dd40:                                     00000000 c7077600 40044145 00000001
dd60: bee1d480 c7077600 00000000 00000000 c002ce04 c71dc000 00000001 c71dddb4
dd80: c71dddb8 c71ddd98 c025643c c0256330 a0000013 ffffffff
 r7:00000000 r6:00000000 r5:c71ddd84 r4:ffffffff
[<c0256324>] (snd_pcm_info+0x0/0xe0) from [<c025643c>]
(snd_pcm_info_user+0x38/0x94)
 r7:00000000 r6:00000000 r5:c7077600 r4:bee1d480
[<c0256404>] (snd_pcm_info_user+0x0/0x94) from [<c0257530>]
(snd_pcm_common_ioctl1+0x1b4/0xf9c)
 r7:00000000 r6:00000005 r5:bee1d480 r4:bee1d480
[<c025737c>] (snd_pcm_common_ioctl1+0x0/0xf9c) from [<c0258b48>]
(snd_pcm_playback_ioctl1+0x3fc/0x420)
[<c025874c>] (snd_pcm_playback_ioctl1+0x0/0x420) from [<c0258c64>]
(snd_pcm_playback_ioctl+0x34/0x38)
 r7:c71d3d80 r6:00000005 r5:bee1d480 r4:81204101
[<c0258c30>] (snd_pcm_playback_ioctl+0x0/0x38) from [<c00a5bb8>]
(vfs_ioctl+0x34/0x78)
[<c00a5b84>] (vfs_ioctl+0x0/0x78) from [<c00a5e6c>] (do_vfs_ioctl+0x270/0x280)
 r5:bee1d480 r4:c71d3d80
[<c00a5bfc>] (do_vfs_ioctl+0x0/0x280) from [<c00a5ebc>] (sys_ioctl+0x40/0x64)
 r7:c71d3d80 r6:81204101 r5:bee1d480 r4:00000005
[<c00a5e7c>] (sys_ioctl+0x0/0x64) from [<c002cc80>] (ret_fast_syscall+0x0/0x2c)
 r7:00000036 r6:402c0444 r5:007ee3b0 r4:402c0444
Code: e3a02000 e3e00000 e5974000 e1a08001 (e5945000)
---[ end trace 7a94571fa90e8e6c ]---
Fixing recursive fault but reboot is needed!
