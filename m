From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/12] Update OMAP2/3 powerdomains, clockdomains
Date: Mon, 08 Sep 2008 10:57:36 -0600
Message-ID: <20080908164444.2540.98619.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49044 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbYIIIUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 04:20:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series updates the in-kernel OMAP2/3 clockdomain and powerdomain
structures:

- Split the placeholder clockdomain "wkup_clkdm" into "cm_clkdm" and
  "prm_clkdm".  This more accurately reflects the hardware.

- Add powerdomains and clockdomains for DPLLs 1 through 5 on OMAP3.

- Associate every clock in OMAP2/3 clock tree with an appropriate
  clockdomain.


Boot-tested on N800, 2430SDP, and 3430SDP.


- Paul

---


size:
   text    data     bss     dec     hex filename
3441310  157936  105728 3704974  38888e vmlinux.3430sdp.orig
3441566  158440  105728 3705734  388b86 vmlinux.3430sdp.patched

diffstat:
 arch/arm/mach-omap2/clock.c                   |    8 +
 arch/arm/mach-omap2/clock24xx.h               |   56 ++++++----
 arch/arm/mach-omap2/clock34xx.h               |  139 ++++++++++++++++++-------
 arch/arm/mach-omap2/clockdomains.h            |   64 +++++++++++-
 arch/arm/mach-omap2/powerdomains.h            |    5 +
 arch/arm/mach-omap2/powerdomains34xx.h        |   31 ++++++
 arch/arm/plat-omap/include/mach/powerdomain.h |    4 -
 7 files changed, 238 insertions(+), 69 deletions(-)

