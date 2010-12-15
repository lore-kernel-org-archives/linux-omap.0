From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 2/6] OMAP2+: hwmod: Mark functions used only during initialization with __init
Date: Wed, 15 Dec 2010 15:49:23 +0100
Message-ID: <1292424567-25794-3-git-send-email-b-cousson@ti.com>
References: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42950 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420Ab0LOOvw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 09:51:52 -0500
In-Reply-To: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>

_register, _find_mpu_port_index and _find_mpu_rt_base are static APIs
that will be used only during the omap_hwmod initialization phase.
There is no need to keep them for runtime.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 298fc3b..1a0dd56 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -673,7 +673,7 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
  * Returns the array index of the OCP slave port that the MPU
  * addresses the device on, or -EINVAL upon error or not found.
  */
-static int _find_mpu_port_index(struct omap_hwmod *oh)
+static int __init _find_mpu_port_index(struct omap_hwmod *oh)
 {
 	int i;
 	int found = 0;
@@ -707,7 +707,7 @@ static int _find_mpu_port_index(struct omap_hwmod *oh)
  * Return the virtual address of the base of the register target of
  * device @oh, or NULL on error.
  */
-static void __iomem *_find_mpu_rt_base(struct omap_hwmod *oh, u8 index)
+static void __iomem * __init _find_mpu_rt_base(struct omap_hwmod *oh, u8 index)
 {
 	struct omap_hwmod_ocp_if *os;
 	struct omap_hwmod_addr_space *mem;
@@ -1435,7 +1435,7 @@ static int _setup(struct omap_hwmod *oh, void *data)
  * that the copy process would be relatively complex due to the large number
  * of substructures.
  */
-static int _register(struct omap_hwmod *oh)
+static int __init _register(struct omap_hwmod *oh)
 {
 	int ret, ms_id;
 
@@ -1587,7 +1587,7 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
  * listed in @ohs that are valid for this chip.  Returns -EINVAL if
  * omap_hwmod_init() has already been called or 0 otherwise.
  */
-int omap_hwmod_init(struct omap_hwmod **ohs)
+int __init omap_hwmod_init(struct omap_hwmod **ohs)
 {
 	struct omap_hwmod *oh;
 	int r;
-- 
1.7.0.4

