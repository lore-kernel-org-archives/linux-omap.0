From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] arm: Flush TLB entries in setup_mm_for_reboot()
Date: Fri, 18 Dec 2009 19:46:19 -0800
Message-ID: <20091219034619.26198.58992.stgit@localhost>
References: <20091219034151.26198.26570.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55570 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbZLSDqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 22:46:20 -0500
In-Reply-To: <20091219034151.26198.26570.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

We need to do that if we tinker with the MMU entries.

This fixes the occasional bug with kexec where the new
fails to uncompress with "crc error". Most likely at
least kexec on v6 and v7 need this fix.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mm/mmu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 8c7fbd1..a2802ea 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1068,4 +1068,7 @@ void setup_mm_for_reboot(char mode)
 		pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
 		flush_pmd_entry(pmd);
 	}
+
+	local_flush_tlb_all();
+	flush_cache_all();
 }

