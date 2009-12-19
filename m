From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] arm: Fix typo in cacheflush.h and remove unnecessary
	comments
Date: Fri, 18 Dec 2009 19:46:44 -0800
Message-ID: <20091219034644.26198.28856.stgit@localhost>
References: <20091219034151.26198.26570.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55843 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251AbZLSDqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 22:46:46 -0500
In-Reply-To: <20091219034151.26198.26570.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

While dealing with the kexec fixes, I noticed these.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/cacheflush.h |    2 +-
 arch/arm/mm/proc-v6.S             |    2 --
 arch/arm/mm/proc-v7.S             |    2 --
 3 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 730aefc..e9fb1d3 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -154,7 +154,7 @@
  *	Please note that the implementation of these, and the required
  *	effects are cache-type (VIVT/VIPT/PIPT) specific.
  *
- *	flush_cache_kern_all()
+ *	flush_cache_all()
  *
  *		Unconditionally clean and invalidate the entire cache.
  *
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 395cc90..7a5337e 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -59,8 +59,6 @@ ENTRY(cpu_v6_proc_fin)
  *	to what would be the reset vector.
  *
  *	- loc   - location to jump to for soft reset
- *
- *	It is assumed that:
  */
 	.align	5
 ENTRY(cpu_v6_reset)
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index d2a8074..7aaf88a 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -63,8 +63,6 @@ ENDPROC(cpu_v7_proc_fin)
  *	to what would be the reset vector.
  *
  *	- loc   - location to jump to for soft reset
- *
- *	It is assumed that:
  */
 	.align	5
 ENTRY(cpu_v7_reset)

