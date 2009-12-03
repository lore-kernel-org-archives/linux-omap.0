From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/9] OMAP powerdomain/PM: use symbolic constants for the max
	number of power states
Date: Thu, 03 Dec 2009 06:45:36 -0700
Message-ID: <20091203134535.16229.31415.stgit@localhost.localdomain>
References: <20091203134321.16229.87539.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48958 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078AbZLCNwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:52:23 -0500
In-Reply-To: <20091203134321.16229.87539.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Replace some bare constants with power states.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c                |    4 ++--
 arch/arm/mach-omap2/powerdomain.c             |    2 +-
 arch/arm/plat-omap/include/plat/powerdomain.h |    6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 8baa30d..860b755 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -326,7 +326,7 @@ int pm_dbg_regset_save(int reg_set)
 	return 0;
 }
 
-static const char pwrdm_state_names[][4] = {
+static const char pwrdm_state_names[][PWRDM_MAX_PWRSTS] = {
 	"OFF",
 	"RET",
 	"INA",
@@ -381,7 +381,7 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 
 	seq_printf(s, "%s (%s)", pwrdm->name,
 			pwrdm_state_names[pwrdm->state]);
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
 		seq_printf(s, ",%s:%d", pwrdm_state_names[i],
 			pwrdm->state_counter[i]);
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 4147267..1dd1a38 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -158,7 +158,7 @@ static __init void _pwrdm_setup(struct powerdomain *pwrdm)
 {
 	int i;
 
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
 		pwrdm->state_counter[i] = 0;
 
 	pwrdm_wait_transition(pwrdm);
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 3d45ee1..5a80ddb 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -28,6 +28,8 @@
 #define PWRDM_POWER_INACTIVE	0x2
 #define PWRDM_POWER_ON		0x3
 
+#define PWRDM_MAX_PWRSTS	4
+
 /* Powerdomain allowable state bitfields */
 #define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) | \
 				 (1 << PWRDM_POWER_ON))
@@ -118,11 +120,11 @@ struct powerdomain {
 	struct list_head node;
 
 	int state;
-	unsigned state_counter[4];
+	unsigned state_counter[PWRDM_MAX_PWRSTS];
 
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
-	s64 state_timer[4];
+	s64 state_timer[PWRDM_MAX_PWRSTS];
 #endif
 };
 


