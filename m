From: epsi@gmx.de
Subject: RE: Memory performance / Cache problem
Date: Mon, 12 Oct 2009 10:38:06 +0200
Message-ID: <20091012083806.323990@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52316 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754610AbZJLIiz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Oct 2009 04:38:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Linux version 2.6.31 (star@localhost) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #1 Mon Oct 12 08:30:58 CEST 2009
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 EVM
Memory policy: ECC disabled, Data cache writeback
OMAP3430 ES2.1
SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512                                                                                               

I see, you get the message about L2 Cache, which I don't have
Do you know how to enable this?
Shoudn't the kernel configure all this things - not rely on bootloader?
I am using the U-Boot 2008.10 (TIs PSP)
The old 22 kernel is independet from the uboot in this issue.

Thanks
Steffen
-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.5 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/atbrowser
