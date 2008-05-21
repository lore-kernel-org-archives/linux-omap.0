From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/6] powerdomain: add pwrdm_get_mem_bank_count()
Date: Tue, 20 May 2008 18:41:33 -0600
Message-ID: <20080521004128.6131.98309.stgit@localhost.localdomain>
References: <20080521003910.6131.63409.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45901 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933512AbYEUAqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 20:46:04 -0400
In-Reply-To: <20080521003910.6131.63409.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add a function pwrdm_get_mem_bank_count() to the powerdomain code to
return the number of memory banks contained inside an OMAP
powerdomain.  This will be used by the PM code to configure the memory
bank retention state.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/powerdomain.c       |   14 ++++++++++++++
 include/asm-arm/arch-omap/powerdomain.h |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 94b16d0..3a8dae0 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -588,6 +588,20 @@ int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 					(1 << pwrdm2->dep_bit));
 }
 
+/**
+ * pwrdm_get_mem_bank_count - get number of memory banks in this powerdomain
+ * @pwrdm: struct powerdomain *
+ *
+ * Return the number of controllable memory banks in powerdomain pwrdm,
+ * starting with 1.  Returns -EINVAL if the powerdomain pointer is null.
+ */
+int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
+{
+	if (!pwrdm)
+		return -EINVAL;
+
+	return pwrdm->banks;
+}
 
 /**
  * pwrdm_set_next_pwrst - set next powerdomain power state
diff --git a/include/asm-arm/arch-omap/powerdomain.h b/include/asm-arm/arch-omap/powerdomain.h
index 40a054d..39b7df6 100644
--- a/include/asm-arm/arch-omap/powerdomain.h
+++ b/include/asm-arm/arch-omap/powerdomain.h
@@ -134,6 +134,8 @@ int pwrdm_add_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
 int pwrdm_del_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
 int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
 
+int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
+
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_pwrst(struct powerdomain *pwrdm);


