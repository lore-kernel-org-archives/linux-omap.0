From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] OMAP: hwmod: API to handle autoidle mode
Date: Thu, 10 Mar 2011 02:24:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100216360.15132@utopia.booyaka.com>
References: <1296477288-26253-1-git-send-email-kishon@ti.com> <1296477288-26253-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47348 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab1CJJYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 04:24:16 -0500
In-Reply-To: <1296477288-26253-2-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com

On Mon, 31 Jan 2011, Kishon Vijay Abraham I wrote:

> Create a new API that forms a wrapper to _set_module_autoidle()
> to modify the AUTOIDLE bit.
> 
> This API is intended to be used by drivers that requires direct
> manipulation of the AUTOIDLE bits in SYSCONFIG register.
> McBSP driver requires autoidle bit to be enabled/disabled while
> using sidetone feature.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

I've made some changes to this patch.

I don't think this bit is slave-specific.  For example 34xx TRM Rev. ZH 
Table 15-155 "DISPC_SYSCONFIG" refers to both the L3 and L4 interface 
clock gating strategy.  So I've renamed the function to 
omap_hwmod_set_ocp_autoidle().

Also I think the only valid hwmod state that this function could be called 
in is ENABLED, so I've restricted its use to that state.  Please advise if 
this is not correct.

I've also cleaned up a few minor issues with the code and comments.  I'm 
not entirely sure this function the best approach going forward, but it 
should do for now.

Updated patch below, queued for 2.6.39,


- Paul


From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Mon, 31 Jan 2011 12:34:47 +0000
Subject: [PATCH] OMAP2+: hwmod: add API to handle autoidle mode

Create a new API that forms a wrapper to _set_module_autoidle()
to modify the AUTOIDLE bit.

This API is intended to be used by drivers that requires direct
manipulation of the AUTOIDLE bits in SYSCONFIG register.
McBSP driver requires autoidle bit to be enabled/disabled while
using sidetone feature.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
[paul@pwsan.com: restrict the hwmod states that the autoidle bit can be changed
 in; changed function name; dropped "int" from "unsigned int long"]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   36 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 816aeb9..a68a2cf 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1288,6 +1288,42 @@ static int _idle(struct omap_hwmod *oh)
 }
 
 /**
+ * omap_hwmod_set_ocp_autoidle - set the hwmod's OCP autoidle bit
+ * @oh: struct omap_hwmod *
+ * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
+ *
+ * Sets the IP block's OCP autoidle bit in hardware, and updates our
+ * local copy. Intended to be used by drivers that require
+ * direct manipulation of the AUTOIDLE bits.
+ * Returns -EINVAL if @oh is null or is not in the ENABLED state, or passes
+ * along the return value from _set_module_autoidle().
+ *
+ * Any users of this function should be scrutinized carefully.
+ */
+int omap_hwmod_set_ocp_autoidle(struct omap_hwmod *oh, u8 autoidle)
+{
+	u32 v;
+	int retval = 0;
+	unsigned long flags;
+
+	if (!oh || oh->_state != _HWMOD_STATE_ENABLED)
+		return -EINVAL;
+
+	spin_lock_irqsave(&oh->_lock, flags);
+
+	v = oh->_sysc_cache;
+
+	retval = _set_module_autoidle(oh, autoidle, &v);
+
+	if (!retval)
+		_write_sysconfig(v, oh);
+
+	spin_unlock_irqrestore(&oh->_lock, flags);
+
+	return retval;
+}
+
+/**
  * _shutdown - shutdown an omap_hwmod
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index bba2343..98f7f61 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -555,6 +555,7 @@ int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
 
 int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
+int omap_hwmod_set_ocp_autoidle(struct omap_hwmod *oh, u8 autoidle);
 
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
-- 
1.7.2.3

