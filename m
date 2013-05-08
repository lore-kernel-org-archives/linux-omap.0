From: Jason Cooper <jason@lakedaemon.net>
Subject: [RFC PATCH 0/3] ARM: omap3: add Seagate Wireless Plus board
Date: Wed,  8 May 2013 19:23:31 +0000
Message-ID: <cover.1368038129.git.jason@lakedaemon.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65505 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab3EHTX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 15:23:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>

All,

This is a work in progress.  All mistakes are mine.  Seriously.  I've never
touched omap before.  It should be obvious.

History:

The Wireless Plus is a portable, 1TB HD with an ~ 4 hour battery, and a wifi
hotspot.  It's only external connection is the SATA port (GoFlex connector).

The Wireless Plus is the successor to the GoFlex Wireless.  Full source can be
found here [1] (GoFlex Wireless).  These appear to be exactly the same at the
hardware level.  The primary difference is drive capacity, and the Wireless
Plus exposes uart1 to an unpopulated header in the corner of the board, so I
chose to develop on it. :-)

Technical:

Both boards are using an AM3703 SoC and the tps6507x power regulator/battery
charger.  Both are using the Hynix h8kds0un0mer-4em RAM module.

Status:

The following patches are a work-in-progress and are based against v3.9.  It
basically boots (to rootfs panic) with patches 1 and 2.  The gpmc patch oops
out.  I've included it in the hopes that someone can laugh at me and maybe give
me a pointer.  I need it to work in order to add the child node for the nand,
and then the child nodes for the partitions.

Tony has been helping me out offline with this, and he suggested trying the
gpmc against Linus' ToT.  Which locks up before it even has a chance to get
going.  So this series is against v3.9.

The current state of the dts file has been to silence warnings/errors.  I
disabled a bunch of unused devices, and added the pinctrl nodes in order to
remove the pins not found kind of errors.  As for their correctness, I haven't
been able to test yet.

I've done a liberal amount of copying from the provided sources for u-boot and
the kernel.  If you're motivated, grepping those sources for 'satellite|vavni'
locates most of the changes made by Seagate.

Current Problem:

There are several gaps in my understanding of how far along TI's conversion to
DT is.  Should I be doing a separate board file for initializing the legacy
items?  I was hoping to do it all with DT.

Obviously, I don't expect anybody to run out and buy one of these, take it
apart, and try to boot this code.  But if the omap guys could take a look at
this and give me a few pointers, I'd appreciate it.  I'm kind of spinning my
wheels at the moment.

Primarily, I'd like to get nand and usb working, so that I can read/write,
mount a rootfs and do better testing.

thx,

Jason.

[1] http://www.seagate.com/support/downloads/item/satellite-gpl-fw-master-dl/

Jason Cooper (3):
  ARM: omap3: Seagate Wireless Plus board
  ARM: omap3: Seagate Wireless Plus DT entry
  ARM: omap3: wireless plus gpmc wip

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/omap3-wireless_plus.dts          | 331 +++++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c                |  26 ++
 arch/arm/mach-omap2/sdram-hynix-h8kds0un0mer-4em.h |  30 ++
 4 files changed, 388 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-wireless_plus.dts
 create mode 100644 arch/arm/mach-omap2/sdram-hynix-h8kds0un0mer-4em.h

-- 
1.8.2.1

