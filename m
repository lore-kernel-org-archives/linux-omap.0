From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] OMAP3 clock: two small fixes
Date: Wed, 07 May 2008 19:19:07 -0600
Message-ID: <20080508011650.15057.8127.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44817 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbYEHB3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 21:29:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Two minor OMAP3 clock framework fixes.  This series:

- puts the sys_clkout2 struct clk into the core_clkdm where it belongs

- removes the omap2_noncore_dpll_set_rate() function pointer from the 
  DPLL3 struct clk (since DPLL3 is the CORE DPLL)


- Paul

---

 arch/arm/mach-omap2/clock34xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


