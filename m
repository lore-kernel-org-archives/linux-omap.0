From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/6] OMAP2 PM: link clocks to clockdomains,
	use clkdm/pwrdm code
Date: Tue, 20 May 2008 18:41:07 -0600
Message-ID: <20080521003910.6131.63409.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45898 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933509AbYEUAqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 20:46:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


This series updates OMAP24xx power management to use the recent
clockdomain and powerdomain code that was integrated earlier this
year.  The series:

- associates a clockdomain with each struct clk,

- adds a couple of minor powerdomain/clockdomain interface functions to
  be used by pm.c, 

- converts direct register manipulation for clockdomains and powerdomains
  in pm.c to use the clockdomain/powerdomain interface functions,

- and removes the clockdomain/powerdomain manipulation code from 
  DSPGateway.


This series also adds a missing OMAP24xx clock, ssi_l4_iclk, noticed
while annotating the clock framework.

Tested on an N800 with the serial console enabled, and power
consumption matches current l-o git HEAD during screen on, dim, and off; 
and DSP still works.


Signed-off-by: Paul Walmsley <paul@pwsan.com>

--

size:

   text    data     bss     dec     hex filename
3160390  150488   86308 3397186  33d642 vmlinux.n800.orig
3160642  150488   86308 3397438  33d73e vmlinux.n800.patched

diffstat:

 arch/arm/mach-omap2/clock24xx.h         |  251 +++++++++++++++++++++++++------
 arch/arm/mach-omap2/clockdomain.c       |   16 ++
 arch/arm/mach-omap2/pm24xx.c            |  106 +++++++++----
 arch/arm/mach-omap2/powerdomain.c       |   14 ++
 drivers/dsp/dspgateway/dsp_core.c       |   13 --
 include/asm-arm/arch-omap/clockdomain.h |    5 -
 include/asm-arm/arch-omap/powerdomain.h |    2 
 7 files changed, 308 insertions(+), 99 deletions(-)


