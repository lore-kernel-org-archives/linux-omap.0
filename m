From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/3] OMAP4: Enable L2 cache
Date: Fri, 29 Jan 2010 17:00:30 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C09C67F9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52110 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754549Ab0A2La7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 06:30:59 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Tony,

Here is the rebased series against 2.6.33-rc5 which adds L2 cache support 
on OMAP4430. I have dropped the l2 errata patch from earlier post [1] in
this series since it will go through Russell's patch system. The link
for patches is [2]

The following changes since commit 92dcffb916d309aa01778bf8963a6932e4014d07:
  Linus Torvalds (1):
        Linux 2.6.33-rc5

Santosh Shilimkar (3):
      OMAP4: Add L2 Cache support
      OMAP4: Clean the secondary_data from L2
      OMAP4: Enable L2 Cache

 arch/arm/configs/omap_4430sdp_defconfig    |    2 +
 arch/arm/mach-omap2/board-4430sdp.c        |   33 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-smp.c             |    2 +
 arch/arm/mm/Kconfig                        |    2 +-
 arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
 5 files changed, 39 insertions(+), 1 deletions(-)

Regards,
Santosh

[1]	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg20553.html
[2]	http://www.spinics.net/lists/arm-kernel/msg81122.html


