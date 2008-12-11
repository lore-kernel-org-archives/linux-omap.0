From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3 NOT FOR MERGING] ehci-omap clock rewrite test patches
Date: Thu, 11 Dec 2008 14:22:33 -0700
Message-ID: <20081211212030.22860.49518.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51039 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717AbYLKVZM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 16:25:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This series - not for merging - is for those who are trying to get
ehci-omap.c working on their hardware.

The series programs the clocks through the clock framework, rather
than writing registers directly.  It also adds some debugging and
drops some unnecessary register writes.

Unfortunately, there is no hardware here for me to test these on, so
these patches have only been compile-tested.  Note also that patch 2
should be implemented differently before any final merge; it is written
this way for testing purposes only.


- Paul

---

Paul Walmsley (3):
      OMAP3 clock: Add debugging in omap3_noncore_dpll_enable()
      OMAP3 EHCI: use clock framework to program DPLL5, DPLL5_M2_CLK
      OMAP3 EHCI: drop unnecessary debug writes, per Vikram Pandita


 arch/arm/mach-omap2/clock34xx.c |    4 ++
 drivers/usb/host/ehci-omap.c    |   73 +++++++++++++++++++--------------------
 2 files changed, 40 insertions(+), 37 deletions(-)


