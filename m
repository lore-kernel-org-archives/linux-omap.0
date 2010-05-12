From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 4/6] OMAP: hwmod: Temporary disable dependency
Date: Wed, 12 May 2010 17:54:39 +0200
Message-ID: <1273679681-27549-5-git-send-email-b-cousson@ti.com>
References: <1273679681-27549-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48497 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756328Ab0ELPy6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 11:54:58 -0400
In-Reply-To: <1273679681-27549-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

From: Rajendra Nayak <rnayak@ti.com>

Dependency not supported yet, hence comment all dependency handling
code in hwmod.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2fff39f..302f2c8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -908,7 +908,9 @@ static int _enable(struct omap_hwmod *oh)
 
 	/* XXX mux balls */
 
+#if 0
 	_add_initiator_dep(oh, mpu_oh);
+#endif
 	_enable_clocks(oh);
 
 	r = _wait_target_ready(oh);
@@ -949,7 +951,9 @@ static int _idle(struct omap_hwmod *oh)
 
 	if (oh->class->sysc)
 		_sysc_idle(oh);
+#if 0
 	_del_initiator_dep(oh, mpu_oh);
+#endif
 	_disable_clocks(oh);
 
 	oh->_state = _HWMOD_STATE_IDLE;
@@ -1544,7 +1548,10 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 int omap_hwmod_add_initiator_dep(struct omap_hwmod *oh,
 				 struct omap_hwmod *init_oh)
 {
+#if 0
 	return _add_initiator_dep(oh, init_oh);
+#endif
+	return 0;
 }
 
 /*
@@ -1569,7 +1576,10 @@ int omap_hwmod_add_initiator_dep(struct omap_hwmod *oh,
 int omap_hwmod_del_initiator_dep(struct omap_hwmod *oh,
 				 struct omap_hwmod *init_oh)
 {
+#if 0
 	return _del_initiator_dep(oh, init_oh);
+#endif
+	return 0;
 }
 
 /**
-- 
1.6.1.3

