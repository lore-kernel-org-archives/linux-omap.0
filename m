From: Paolo Pisati <p.pisati@gmail.com>
Subject: beaglebone black: is mem=... broken?
Date: Sun, 18 Jan 2015 15:34:48 +0100
Message-ID: <20150118143448.GA4023@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:51605 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbbAROew (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Jan 2015 09:34:52 -0500
Received: by mail-wg0-f47.google.com with SMTP id z12so2106132wgg.6
        for <linux-omap@vger.kernel.org>; Sun, 18 Jan 2015 06:34:51 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: linux-omap <linux-omap@vger.kernel.org>

Boot hangs when passing mem=256M to a 3.16 kernel (but i was able to reproduce
it with multi_v7_defconfig on a 3.19rcX kernel too):

80e6d694: 00240000 00000000 65746e49 6c616e72    ..$.....Internal
80e6d6a4: 72726520 203a726f 73706f4f 2035203a     error: Oops: 5 
80e6d6b4: 5d31235b 504d5320 4d524120 00000000    [#1] SMP ARM....
80e6d6c4: 00000000 00120000 00000000 75646f4d    ............Modu
80e6d6d4: 2073656c 6b6e696c 69206465 00003a6e    les linked in:..
80e6d6e4: 00000000 00000000 00000000 00000000    ................
80e6d6f4: 00000000 00000000 00000000 6f432030    ............0 Co
80e6d704: 203a6d6d 70617773 20726570 20746f4e    mm: swapper Not 
80e6d714: 6e696174 20646574 36312e33 322d302e    tainted 3.16.0-2
80e6d724: 65672d38 6972656e 33232063 62552d38    8-generic #38-Ub
80e6d734: 75746e75 00000000 00000000 002d0000    untu..........-.
80e6d744: 00000000 6b736174 3063203a 61313964    ....task: c0d91a
80e6d754: 74203832 63203a69 34386430 20303030    28 ti: c0d84000 
80e6d764: 6b736174 3a69742e 64306320 30303438    task.ti: c0d8400
80e6d774: 00000030 00000000 00000000 00220000    0.............".
80e6d784: 00000000 69204350 74612073 74646620    ....PC is at fdt
80e6d794: 6568635f 685f6b63 65646165 78302b72    _check_header+0x
80e6d7a4: 78302f30 00003437 00000000 00000000    0/0x74..........
80e6d7b4: 00000000 00000000 00000000 74612073    ............s at
80e6d7c4: 755f5f20 616c666e 6e657474 7665645f     __unflatten_dev
80e6d7d4: 5f656369 65657274 3778302b 78302f38    ice_tree+0x78/0x
80e6d7e4: 00306132 00000000 00000000 00000000    2a0.............
80e6d7f4: 00000000 00000000 00000000 65323930    ............092e
80e6d804: 3e383064 2020205d 20726c20 3c5b203a    d08>]    lr : [<
80e6d814: 64373063 34303335 20205d3e 73702020    c07d5304>]    ps
80e6d824: 36203a72 30303030 0a333931 3a207073    r: 60000193.sp :
80e6d834: 64306320 33663538 69202030 203a2070     c0d85f30  ip : 
80e6d844: 31663038 37616638 70662020 63203a20    80f18fa7  fp : c
80e6d854: 33666530 00343661 00000000 00000000    0ef3a64.........
80e6d864: 00000000 00000000 00000000 00000000    ................
80e6d874: 00000000 00000000 00000000 36623063    ............c0b6
80e6d884: 30393730 38722020 63203a20 61326430    0790  r8 : c0d2a
80e6d894: 00383435 00000000 00000000 00000000    548.............
80e6d8a4: 00000000 00000000 00000000 00000000    ................
80e6d8b4: 00000000 00000000 00000000 30303035    ............5000
80e6d8c4: 35722020 63203a20 33366530 20306330      r5 : c0e630c0 
80e6d8d4: 20347220 3063203a 30333665 00003063     r4 : c0e630c0..
80e6d8e4: 00000000 00000000 00000000 00000000    ................
80e6d8f4: 00000000 00000000 00000000 72202030    ............0  r
80e6d904: 203a2032 30303030 30303030 31722020    2 : 00000000  r1
80e6d914: 63203a20 30316630 20633231 20307220     : c0f1012c  r0 
80e6d924: 6663203a 30356666 00003030 00000000    : cfff5000......
80e6d934: 00000000 00000000 00000000 67616c46    ............Flag
80e6d944: 6e203a73 2076435a 51524920 666f2073    s: nZCv  IRQs of
80e6d954: 46202066 20735149 20206e6f 65646f4d    f  FIQs on  Mode
80e6d964: 43565320 2032335f 41534920 4d524120     SVC_32  ISA ARM
80e6d974: 65532020 6e656d67 656b2074 6c656e72      Segment kernel

Another thing that i noticed was that we actually pass 256M as the physical
memory, while the beaglebone black has 512M - is the dt live patched by the
bootloader before being passed to the kernel?

dtc -I dtb ./arch/arm/boot/dts/am335x-boneblack.dtb
...
        memory {
                device_type = "memory";
                reg = <0x80000000 0x10000000>;
        };
...
-- 
bye,
p.
