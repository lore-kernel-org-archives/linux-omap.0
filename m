From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: v3.16-rc1 & default cachepolicy
Date: Thu, 19 Jun 2014 23:36:55 +0300
Message-ID: <20140619203655.GE558@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:56605 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433AbaFSUhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jun 2014 16:37:04 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

When booting v3.16-rc1 on OMAP1, I noticed strange slowness.
E.g. initramfs unpack takes several minutes. This was caused by default
cachepolicy getting changed from writethrough -> uncached for some reason:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.16.0-rc1-e3-los_880e+ (aaro@cooljazz) (gcc version 4.9.0 (GCC) ) #1 PREEMPT Thu Jun 19 22:51:42 EEST 2014
[    0.000000] CPU: ARM925T [54029252] revision 2 (ARMv4T), cr=0000317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Amstrad E3 (Delta)
[    0.000000] Ignoring memory below PHYS_OFFSET: 0x02000000-0x10000000
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache uncached
[...]
[    4.602732] Unpacking initramfs...
[  425.125093] Freeing initrd memory: 3532K (c1c00000 - c1f73000)

It seems this is caused by commit:

commit ca8f0b0a545f55b3dc6877cda24d609a8979c951
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Tue May 27 20:34:28 2014 +0100

    ARM: ensure C page table setup code follows assembly code

I can workaround this with "cachepolicy=writethrough" parameter.

A.
