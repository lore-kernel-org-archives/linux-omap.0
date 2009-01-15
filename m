From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: v2.6.28-omap1 tagged, some bugs remain
Date: Thu, 15 Jan 2009 06:53:51 -0800
Message-ID: <5e088bd90901150653m5588663kaf3ddb78b7c951f4@mail.gmail.com>
References: <20090112145051.GL9373@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:39295 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbZAOOxz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 09:53:55 -0500
Received: by bwz14 with SMTP id 14so3490925bwz.13
        for <linux-omap@vger.kernel.org>; Thu, 15 Jan 2009 06:53:53 -0800 (PST)
In-Reply-To: <20090112145051.GL9373@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, Jan 12, 2009 at 6:50 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> I've just tagged v2.6.28-omap1, and looks like we might want to also
> do v2.6.28-omap2 as there are few annoying bugs remaining:
>
> - According to Jarkko Nikula, ASoC does not currently work because of
>  some recent clock changes.

Just to verify -- does this issue manifest as a segmentation fault?

Here's what I am seeing on Overo with the current top of tree:

root@overo:~# mplayer /these.mp3
MPlayer dev-SVN-r27659-4.3.1 (C) 2000-2008 MPlayer Team
CPU: ARM

Playing /these.mp3.
Audio only file format detected.
Clip info:
 Title:
 Artist:
 Album:
 Year:
 Comment:
 Genre: Other
==========================================================================
Forced audio codec: mad
Opening audio decoder: [libmad] libmad mpeg audio decoder
AUDIOAlignment trap: not handling instruction e193cf9f at [<c00f9374>]
Unhandled fault: alignment exception (0x001) at 0xc04853da
Internal error: : 1 [#1]
Modules linked in: libertas_sdio libertas rt73usb ipv6 ftdi_sio
rt2x00usb rtl8187 eeprom_93cx6 rt2x00lib usbserial
CPU: 0    Not tainted  (2.6.28-omap1 #1)
PC is at omap2_clkdm_clk_enable+0x30/0x7c
LR is at omap2_clk_enable+0x3c/0xb0
pc : [<c00f9378>]    lr : [<c00f73dc>]    psr: a0000093
sp : cdcb9c90  ip : cdcb9ca8  fp : cdcb9ca4
r10: cddc4340  r9 : c05107cc  r8 : c0510bf0
r7 : cf9f1cc0  r6 : c05107f0  r5 : 80000013  r4 : c04853ca
r3 : c04853da  r2 : c00f73a0  r1 : 00000000  r0 : c04853ca
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 8ecc8018  DAC: 00000015
Process mplayer (pid: 3377, stack limit = 0xcdcb82e8)
Stack: (0xcdcb9c90 to 0xcdcba000)
9c80:                                     c04e75d4 80000013 cdcb9cbc cdcb9ca8
9ca0: c00f73dc c00f9354 c04e75d4 80000013 cdcb9cdc cdcb9cc0 c00fc36c c00f73ac
9cc0: cf840bc0 cecc1400 c05107f0 cf9f1cc0 cdcb9cfc cdcb9ce0 c0101128 c00fc338
9ce0: c0510690 cecc1400 c0510690 cecc1400 cdcb9d0c cdcb9d00 c032c128 c01010c4
9d00: cdcb9d44 cdcb9d10 c03282bc c032c100 0000000b c0510b88 c0306ce8 00000000
9d20: cdcb9ddc cec9e8c0 cec0f000 cdcb9d80 00000000 cddc4340 cdcb9d64 cdcb9d48
9d40: c03091ec c0328278 cdcb9d80 cf9f1cc0 cdcb9d80 cdcb9da8 cdcb9e0c cdcb9d68
9d60: c031a064 c0309190 cdcb9d8c cece3c90 00000001 cdcb8000 0000000e 00000003
9d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9da0: 00000000 00000000 616c706d 00726579 00000000 00000000 cf9f4700 c04f6a28
9dc0: cdcb9dec cdcb9dd0 00000000 cdc3a140 c0108c24 cec0f138 cec0f138 cf87c3e0
9de0: cdcb9dfc c040f8d8 00000003 00000003 cddc4340 cece3c90 cdcb8000 cf44d818
9e00: cdcb9e34 cdcb9e10 c02fc090 c0319e28 00000000 cf87c3e0 cece3c90 00000000
9e20: cddc4340 cdcb8000 cdcb9e64 cdcb9e38 c0160634 c02fbf98 c01678e0 00000003
9e40: cf80a220 cddc4340 cece3c90 c0160500 00000000 cf80ad20 cdcb9e8c cdcb9e68
9e60: c015bf58 c016050c cddc4340 cdcb9ed8 ffffff9c 00000004 cef11000 00020802
9e80: cdcb9eac cdcb9e90 c015c0a8 c015be2c 00000000 cdcb9ed8 ffffff9c 00000000
9ea0: cdcb9f64 cdcb9eb0 c0168ae0 c015c07c 00020802 c069be60 cdcb9f04 00000000
9ec0: 00020801 00000000 00000022 00027000 00000000 cecc8000 cf80ad20 cf44d818
9ee0: c0149128 c0148164 0000001f 00000101 00000001 00000000 cdcb9fac 00000000
9f00: cef69980 c00f3d44 cecc8000 cdcb9f20 c0126150 ffffffff cf8a0be0 00020802
9f20: 00000000 cddc4340 00000000 cdcb8000 cdcb9f64 cdcb9f40 c0170450 00020801
9f40: 00000000 ffffff9c 00000004 cef11000 cdcb8000 0075ab0c cdcb9f94 cdcb9f68
9f60: c015bd38 c016876c 0000ac44 00a5b030 cdcb9f9c 00000000 00000801 005e05ec
9f80: 00000005 c00eefc4 cdcb9fa4 cdcb9f98 c015be00 c015bce8 00000000 cdcb9fa8
9fa0: c00eee40 c015bde8 00000000 00000801 005e05ec 00020801 00000000 000021d4
9fc0: 00000000 00000801 005e05ec 00000005 0075ab08 bef40aa4 0075ab0c 00000002
9fe0: 0075966c bef409e0 00027268 400ddf78 60000010 005e05ec 00000000 00000000
Backtrace:
[<c00f9348>] (omap2_clkdm_clk_enable+0x0/0x7c) from [<c00f73dc>]
(omap2_clk_enable+0x3c/0xb0)
 r5:80000013 r4:c04e75d4
[<c00f73a0>] (omap2_clk_enable+0x0/0xb0) from [<c00fc36c>]
(clk_enable+0x40/0x80)
 r5:80000013 r4:c04e75d4
[<c00fc32c>] (clk_enable+0x0/0x80) from [<c0101128>]
(omap_mcbsp_request+0x70/0x1c0)
 r7:cf9f1cc0 r6:c05107f0 r5:cecc1400 r4:cf840bc0
[<c01010b8>] (omap_mcbsp_request+0x0/0x1c0) from [<c032c128>]
(omap_mcbsp_dai_startup+0x34/0x38)
 r5:cecc1400 r4:c0510690
[<c032c0f4>] (omap_mcbsp_dai_startup+0x0/0x38) from [<c03282bc>]
(soc_pcm_open+0x50/0x34c)
[<c032826c>] (soc_pcm_open+0x0/0x34c) from [<c03091ec>]
(snd_pcm_open_substream+0x68/0xcc)
[<c0309184>] (snd_pcm_open_substream+0x0/0xcc) from [<c031a064>]
(snd_pcm_oss_open+0x248/0x444)
 r5:cdcb9da8 r4:cdcb9d80
[<c0319e1c>] (snd_pcm_oss_open+0x0/0x444) from [<c02fc090>]
(soundcore_open+0x104/0x18c)
[<c02fbf8c>] (soundcore_open+0x0/0x18c) from [<c0160634>]
(chrdev_open+0x134/0x154)
 r9:cdcb8000 r8:cddc4340 r7:00000000 r6:cece3c90 r5:cf87c3e0
r4:00000000
[<c0160500>] (chrdev_open+0x0/0x154) from [<c015bf58>]
(__dentry_open+0x138/0x250)
 r8:cf80ad20 r7:00000000 r6:c0160500 r5:cece3c90 r4:cddc4340
[<c015be20>] (__dentry_open+0x0/0x250) from [<c015c0a8>]
(nameidata_to_filp+0x38/0x50)
[<c015c070>] (nameidata_to_filp+0x0/0x50) from [<c0168ae0>]
(do_filp_open+0x380/0x700)
 r4:00000000
[<c0168760>] (do_filp_open+0x0/0x700) from [<c015bd38>] (do_sys_open+0x5c/0xec)
[<c015bcdc>] (do_sys_open+0x0/0xec) from [<c015be00>] (sys_open+0x24/0x28)
 r8:c00eefc4 r7:00000005 r6:005e05ec r5:00000801 r4:00000000
[<c015bddc>] (sys_open+0x0/0x28) from [<c00eee40>] (ret_fast_syscall+0x0/0x2c)
Code: 03e00015 089da830 e2843010 e193cf9f (e28cc001)
: 44100 Hz, 2 ch, s16le, 192.0 k---[ end trace 71f57f514e7970ae ]---
bit/13.61% (ratio: 24000->176400)
Selected audio codec: [mad] afm: libmad (libMAD MPEG layer 1-2-3)
==========================================================================
Segmentation fault
@overo:/home/root#

> - MMC seems to be broken for omap1, Ladislav Michl  might have a patch
>  coming up for that.
>
> - I2C is broken for 2430 according to Kainan Cha.
>
> Also looks like source.mvista.com is down, so please use the kernel.org
> tree.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
