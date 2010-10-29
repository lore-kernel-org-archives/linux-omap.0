From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 03/14] OMAP: Introduce voltage domain information in the hwmod structures
Date: Fri, 29 Oct 2010 21:08:17 +0530
Message-ID: <1288366708-32302-4-git-send-email-thara@ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34603 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932683Ab0J2Pij (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Oct 2010 11:38:39 -0400
In-Reply-To: <1288366708-32302-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch extends the device hwmod structure to contain
info about the voltage domain to which the device belongs to.
This is needed to support a device based DVFS where the
device knows which voltage domain it belongs to.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 7eaa8ed..9567aee 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -34,6 +34,7 @@
 #include <linux/ioport.h>
 #include <linux/mutex.h>
 #include <plat/cpu.h>
+#include <plat/voltage.h>
 
 struct omap_device;
 
@@ -436,6 +437,8 @@ struct omap_hwmod_class {
  * @main_clk: main clock: OMAP clock name
  * @_clk: pointer to the main struct clk (filled in at runtime)
  * @opt_clks: other device clocks that drivers can request (0..*)
+ * @vdd_name: voltage domain name
+ * @voltdm: pointer to voltage domain (filled in at runtime)
  * @masters: ptr to array of OCP ifs that this hwmod can initiate on
  * @slaves: ptr to array of OCP ifs that this hwmod can respond on
  * @dev_attr: arbitrary device attributes that can be passed to the driver
@@ -479,6 +482,8 @@ struct omap_hwmod {
 	const char			*main_clk;
 	struct clk			*_clk;
 	struct omap_hwmod_opt_clk	*opt_clks;
+	char				*vdd_name;
+	struct voltagedomain		*voltdm;
 	struct omap_hwmod_ocp_if	**masters; /* connect to *_IA */
 	struct omap_hwmod_ocp_if	**slaves;  /* connect to *_TA */
 	void				*dev_attr;
-- 
1.7.0.4

