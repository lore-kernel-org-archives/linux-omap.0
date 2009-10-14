From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: patches rebased on 2.6.32-rc4
Date: Wed, 14 Oct 2009 11:37:13 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB255301@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44434 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361AbZJNGH5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 02:07:57 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,

I am re-sending three patches rebased on the 2.6.32-rc4 mainline for the merge. You have already seen these on linux-omap mailing list. Second patch is spilt because it has two independent fixes.

These patches are boot tested on 
	- OMAP3430 SDP
	- OMAP3 beagle
	- OMAP4430 platform

Santosh Shilimkar (3):
      ARM: OMAP: SDMA: Fix omap_stop_dma() API for channel linking
      ARM: OMAP4: Allow omap_serial_early_init() for OMAP4430 board
      ARM: OMAP4: Fix UART4 platform data

 arch/arm/mach-omap2/board-4430sdp.c |    4 ++--
 arch/arm/mach-omap2/io.c            |    2 ++
 arch/arm/mach-omap2/serial.c        |   10 ----------
 arch/arm/plat-omap/dma.c            |    9 +++++----
 4 files changed, 9 insertions(+), 16 deletions(-)

Please see if they are fine with you.

If it helps you for merge, these patches can also be pulled from:
git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git omap4_upstream

Regards,
Santosh

