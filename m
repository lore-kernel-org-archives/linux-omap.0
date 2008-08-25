From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Mon, 25 Aug 2008 15:30:13 -0700
Message-ID: <5e088bd90808251530n1fb59656p6e994f944add7109@mail.gmail.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com>
	 <5e088bd90808211451y2ebc4522mb511a9cda7dcdd68@mail.gmail.com>
	 <20080822105757.1c2d0c5c.jarkko.nikula@nokia.com>
	 <5e088bd90808251219t4e0f6562x5837afe727de126@mail.gmail.com>
	 <20080825213510.GC14939@frodo>
	 <5e088bd90808251450p25bca40bpf810f135ddf91a73@mail.gmail.com>
	 <20080825215258.GF14939@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:37883 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbYHYWaP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 18:30:15 -0400
Received: by py-out-1112.google.com with SMTP id p76so1191106pyb.10
        for <linux-omap@vger.kernel.org>; Mon, 25 Aug 2008 15:30:14 -0700 (PDT)
In-Reply-To: <20080825215258.GF14939@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Hmm, so the crash is actually somewhere else. Could you disable debug
> and get the NULL pointer dereference at the right point ?

The output is below.  The crash seems to occur at the substream
pointer dereference in the second line of snd_pcm_info (in
pcm_native.c):

	struct snd_pcm *pcm = substream->pcm;


The log:

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
pgd = c7108000
[00000000] *pgd=87077031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in: ipv6 rtl8187 eeprom_93cx6
CPU: 0    Not tainted  (2.6.27-rc3-omap1 #1)
PC is at snd_pcm_info+0xc/0xe0
LR is at snd_pcm_info_user+0x38/0x94
pc : [<c0256344>]    lr : [<c0256450>]    psr: a0000013
sp : c716bd98  ip : c716bdb8  fp : c716bdb4
r10: 00000001  r9 : c716a000  r8 : c002ce04
r7 : 00000000  r6 : 00000000  r5 : c70ed600  r4 : beaff480
r3 : 00000001  r2 : 40044145  r1 : c70ed600  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 87108018  DAC: 00000015
Process mplayer (pid: 1757, stack limit = 0xc716a2e8)
Stack: (0xc716bd98 to 0xc716c000)
bd80:                                                       beaff480 c70ed600
bda0: 00000000 00000000 c716bdd4 c716bdb8 c0256450 c0256344 beaff480 beaff480
bdc0: 00000005 00000000 c716befc c716bdd8 c0257544 c0256424 84cda0ff c0518b40
bde0: c716be3c c716bdf0 c008373c c007e2f0 c716be14 c7109018 00000001 00000000
be00: 00000001 0000001f 406d5000 c0518b40 c00636b4 00000001 00000000 c716a000
be20: c7bc56e0 406d5000 00000354 c7108000 c716be94 c716be40 c0084280 c00833b8
be40: 0000001f 00000001 00000000 c0518ac0 c716be74 00000001 c7163600 c007dc38
be60: 84cda0ff c0518b40 c716be94 c716be78 c0083d8c c007e470 00000000 00000003
be80: 0000001f c7bc56e0 c716bedc c716be98 c008474c c0083cb0 00000000 00000000
bea0: c7163600 c7864420 00000003 00000022 c0151c6c 00000020 c716a000 406b6000
bec0: 406b6000 c7163600 080020fb 406d6000 c716bf0c 81204101 beaff480 00000005
bee0: 00000000 c002ce04 c716a000 00000001 c716bf2c c716bf00 c0258b5c c025739c
bf00: c716bf54 c716bf10 c00868dc c0085b78 81204101 beaff480 00000005 c70b7080
bf20: c716bf3c c716bf30 c0258c78 c025876c c716bf54 c716bf40 c00a5bb8 c0258c50
bf40: c70b7080 beaff480 c716bf7c c716bf58 c00a5e6c c00a5b90 406b6000 00000096
bf60: 00000005 beaff480 81204101 c70b7080 c716bfa4 c716bf80 c00a5ebc c00a5c08
bf80: c0086b54 00000000 402c0444 007ee3b0 402c0444 00000036 00000000 c716bfa8
bfa0: c002cc80 c00a5e88 402c0444 007ee3b0 00000005 81204101 beaff480 007fbf10
bfc0: 402c0444 007ee3b0 402c0444 00000036 beaff480 00000016 00000001 beaff65c
bfe0: 007ee3b0 beaff458 4025a3d8 404c099c 20000010 00000005 00000000 00000000
Backtrace:
[<c0256338>] (snd_pcm_info+0x0/0xe0) from [<c0256450>]
(snd_pcm_info_user+0x38/0x94)
 r7:00000000 r6:00000000 r5:c70ed600 r4:beaff480
[<c0256418>] (snd_pcm_info_user+0x0/0x94) from [<c0257544>]
(snd_pcm_common_ioctl1+0x1b4/0xf9c)
 r7:00000000 r6:00000005 r5:beaff480 r4:beaff480
[<c0257390>] (snd_pcm_common_ioctl1+0x0/0xf9c) from [<c0258b5c>]
(snd_pcm_playback_ioctl1+0x3fc/0x420)
[<c0258760>] (snd_pcm_playback_ioctl1+0x0/0x420) from [<c0258c78>]
(snd_pcm_playback_ioctl+0x34/0x38)
 r7:c70b7080 r6:00000005 r5:beaff480 r4:81204101
[<c0258c44>] (snd_pcm_playback_ioctl+0x0/0x38) from [<c00a5bb8>]
(vfs_ioctl+0x34/0x78)
[<c00a5b84>] (vfs_ioctl+0x0/0x78) from [<c00a5e6c>] (do_vfs_ioctl+0x270/0x280)
 r5:beaff480 r4:c70b7080
[<c00a5bfc>] (do_vfs_ioctl+0x0/0x280) from [<c00a5ebc>] (sys_ioctl+0x40/0x64)
 r7:c70b7080 r6:81204101 r5:beaff480 r4:00000005
[<c00a5e7c>] (sys_ioctl+0x0/0x64) from [<c002cc80>] (ret_fast_syscall+0x0/0x2c)
 r7:00000036 r6:402c0444 r5:007ee3b0 r4:402c0444
Code: e89da830 e1a0c00d e92dd8f0 e24cb004 (e5904000)
---[ end trace 85720182f0be6892 ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 17 [#2]
Modules linked in: ipv6 rtl8187 eeprom_93cx6
CPU: 0    Tainted: G      D    (2.6.27-rc3-omap1 #1)
PC is at snd_pcm_release+0x20/0x88
LR is at __fput+0xb8/0x170
pc : [<c0255900>]    lr : [<c009af68>]    psr: a0000013
sp : c716bb60  ip : c716bb88  fp : c716bb84
r10: c7854000  r9 : c716bd50  r8 : c70b7080
r7 : c70c72a8  r6 : c70b7080  r5 : c79f6ab0  r4 : 00000000
r3 : c02558e0  r2 : 00000000  r1 : c70b7080  r0 : ffffffff
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 871c8018  DAC: 00000015
Process mplayer (pid: 1757, stack limit = 0xc716a2e8)
Stack: (0xc716bb60 to 0xc716c000)
bb60: 00000008 c79f6ab0 c70b7080 c7887608 c74d9780 c716bd50 c716bbb4 c716bb88
bb80: c009af68 c02558ec 00000000 c716a000 c70b7080 00000000 c7887600 c7887608
bba0: 00000000 00000008 c716bbc4 c716bbb8 c009b2dc c009aebc c716bbe4 c716bbc8
bbc0: c009804c c009b2b8 c7887600 00000001 00000014 c7887608 c716bc0c c716bbe8
bbe0: c004de48 c0097fe4 c716a000 c7864420 0000000b c0256344 00000001 c716bd50
bc00: c716bc1c c716bc10 c004dec4 c004ddd0 c716bc34 c716bc20 c004f10c c004dea8
bc20: c004c458 c004c270 c716bc44 c716bc38 c0030864 c004ef0c c716bc64 c716bc48
bc40: c0031cf0 c00305cc 00010000 c71c5420 c7864420 c7163634 c716bca4 c716bc68
bc60: c0031f08 c0031c90 00000000 c0435cdc 00000000 00000017 c716bcac c0426850
bc80: 00000017 c716bd50 00000000 c002ce04 60000113 00000001 c716bd4c c716bca8
bca0: c002c1e8 c0031d0c c007b008 c007986c 00000044 c0436498 00000000 00000000
bcc0: c04364a4 00000000 00000002 00000001 00000000 c716a000 c0435cdc c0435cdc
bce0: c0051174 c043649c 001200d2 c0436498 00000000 c7864420 001200d2 00000000
bd00: c716bd6c c716bd10 c0518b44 c0518b40 c7162ecc 0000001f 00000000 c7162dc0
bd20: 001200d2 00000000 c716bd54 c716bd38 ffffffff c716bd84 00000000 00000000
bd40: c716bdb4 c716bd50 c002c7ec c002c1b8 00000000 c70ed600 40044145 00000001
bd60: beaff480 c70ed600 00000000 00000000 c002ce04 c716a000 00000001 c716bdb4
bd80: c716bdb8 c716bd98 c0256450 c0256344 a0000013 ffffffff beaff480 c70ed600
bda0: 00000000 00000000 c716bdd4 c716bdb8 c0256450 c0256344 beaff480 beaff480
bdc0: 00000005 00000000 c716befc c716bdd8 c0257544 c0256424 84cda0ff c0518b40
bde0: c716be3c c716bdf0 c008373c c007e2f0 c716be14 c7109018 00000001 00000000
be00: 00000001 0000001f 406d5000 c0518b40 c00636b4 00000001 00000000 c716a000
be20: c7bc56e0 406d5000 00000354 c7108000 c716be94 c716be40 c0084280 c00833b8
be40: 0000001f 00000001 00000000 c0518ac0 c716be74 00000001 c7163600 c007dc38
be60: 84cda0ff c0518b40 c716be94 c716be78 c0083d8c c007e470 00000000 00000003
be80: 0000001f c7bc56e0 c716bedc c716be98 c008474c c0083cb0 00000000 00000000
bea0: c7163600 c7864420 00000003 00000022 c0151c6c 00000020 c716a000 406b6000
bec0: 406b6000 c7163600 080020fb 406d6000 c716bf0c 81204101 beaff480 00000005
bee0: 00000000 c002ce04 c716a000 00000001 c716bf2c c716bf00 c0258b5c c025739c
bf00: c716bf54 c716bf10 c00868dc c0085b78 81204101 beaff480 00000005 c70b7080
bf20: c716bf3c c716bf30 c0258c78 c025876c c716bf54 c716bf40 c00a5bb8 c0258c50
bf40: c70b7080 beaff480 c716bf7c c716bf58 c00a5e6c c00a5b90 406b6000 00000096
bf60: 00000005 beaff480 81204101 c70b7080 c716bfa4 c716bf80 c00a5ebc c00a5c08
bf80: c0086b54 00000000 402c0444 007ee3b0 402c0444 00000036 00000000 c716bfa8
bfa0: c002cc80 c00a5e88 402c0444 007ee3b0 00000005 81204101 beaff480 007fbf10
bfc0: 402c0444 007ee3b0 402c0444 00000036 beaff480 00000016 00000001 beaff65c
bfe0: 007ee3b0 beaff458 4025a3d8 404c099c 20000010 00000005 00000000 00000000
Backtrace:
[<c02558e0>] (snd_pcm_release+0x0/0x88) from [<c009af68>] (__fput+0xb8/0x170)
 r9:c716bd50 r8:c74d9780 r7:c7887608 r6:c70b7080 r5:c79f6ab0
r4:00000008
[<c009aeb0>] (__fput+0x0/0x170) from [<c009b2dc>] (fput+0x30/0x34)
[<c009b2ac>] (fput+0x0/0x34) from [<c009804c>] (filp_close+0x74/0x80)
[<c0097fd8>] (filp_close+0x0/0x80) from [<c004de48>]
(put_files_struct+0x84/0xd8)
 r7:c7887608 r6:00000014 r5:00000001 r4:c7887600
[<c004ddc4>] (put_files_struct+0x0/0xd8) from [<c004dec4>]
(exit_files+0x28/0x2c)
 r9:c716bd50 r8:00000001 r7:c0256344 r6:0000000b r5:c7864420
r4:c716a000
[<c004de9c>] (exit_files+0x0/0x2c) from [<c004f10c>] (do_exit+0x20c/0x6e8)
[<c004ef00>] (do_exit+0x0/0x6e8) from [<c0030864>] (die+0x2a4/0x300)
[<c00305c0>] (die+0x0/0x300) from [<c0031cf0>] (__do_kernel_fault+0x6c/0x7c)
[<c0031c84>] (__do_kernel_fault+0x0/0x7c) from [<c0031f08>]
(do_page_fault+0x208/0x224)
 r7:c7163634 r6:c7864420 r5:c71c5420 r4:00010000
[<c0031d00>] (do_page_fault+0x0/0x224) from [<c002c1e8>]
(do_DataAbort+0x3c/0x9c)
[<c002c1ac>] (do_DataAbort+0x0/0x9c) from [<c002c7ec>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc716bd50 to 0xc716bd98)
bd40:                                     00000000 c70ed600 40044145 00000001
bd60: beaff480 c70ed600 00000000 00000000 c002ce04 c716a000 00000001 c716bdb4
bd80: c716bdb8 c716bd98 c0256450 c0256344 a0000013 ffffffff
 r7:00000000 r6:00000000 r5:c716bd84 r4:ffffffff
[<c0256338>] (snd_pcm_info+0x0/0xe0) from [<c0256450>]
(snd_pcm_info_user+0x38/0x94)
 r7:00000000 r6:00000000 r5:c70ed600 r4:beaff480
[<c0256418>] (snd_pcm_info_user+0x0/0x94) from [<c0257544>]
(snd_pcm_common_ioctl1+0x1b4/0xf9c)
 r7:00000000 r6:00000005 r5:beaff480 r4:beaff480
[<c0257390>] (snd_pcm_common_ioctl1+0x0/0xf9c) from [<c0258b5c>]
(snd_pcm_playback_ioctl1+0x3fc/0x420)
[<c0258760>] (snd_pcm_playback_ioctl1+0x0/0x420) from [<c0258c78>]
(snd_pcm_playback_ioctl+0x34/0x38)
 r7:c70b7080 r6:00000005 r5:beaff480 r4:81204101
[<c0258c44>] (snd_pcm_playback_ioctl+0x0/0x38) from [<c00a5bb8>]
(vfs_ioctl+0x34/0x78)
[<c00a5b84>] (vfs_ioctl+0x0/0x78) from [<c00a5e6c>] (do_vfs_ioctl+0x270/0x280)
 r5:beaff480 r4:c70b7080
[<c00a5bfc>] (do_vfs_ioctl+0x0/0x280) from [<c00a5ebc>] (sys_ioctl+0x40/0x64)
 r7:c70b7080 r6:81204101 r5:beaff480 r4:00000005
[<c00a5e7c>] (sys_ioctl+0x0/0x64) from [<c002cc80>] (ret_fast_syscall+0x0/0x2c)
 r7:00000036 r6:402c0444 r5:007ee3b0 r4:402c0444
Code: e3a02000 e3e00000 e5974000 e1a08001 (e5945000)
---[ end trace 85720182f0be6892 ]---
Fixing recursive fault but reboot is needed!
