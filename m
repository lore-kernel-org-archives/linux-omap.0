From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv11 1/8] ARM: OMAP2+: hwmod: Add API to enable IO ring
 wakeup.
Date: Tue, 13 Dec 2011 14:04:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112131354380.12046@utopia.booyaka.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com> <1323713733-13115-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34646 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab1LMVEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 16:04:10 -0500
In-Reply-To: <1323713733-13115-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Govindraj" <govindraj.raja@ti.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Mon, 12 Dec 2011, Tero Kristo wrote:

> From: R, Govindraj <govindraj.raja@ti.com>
> 
> Add API to enable IO pad wakeup capability based on mux dynamic pad and
> wake_up enable flag available from hwmod_mux initialization.
> 
> Use the wakeup_enable flag and enable wakeup capability
> for the given pads. Wakeup capability will be enabled/disabled
> during hwmod idle transition based on whether wakeup_flag is
> set or cleared.
> 
> Map the enable/disable pad wakeup API's to hwmod_wakeup_enable/disable.
> 
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

A few changes have been made to this patch:

- The documentation has been improved

- omap_hwmod_{enable,disable}_ioring_wakeup() have been removed, since 
  they are not called outside the omap_hwmod code and were missing 
  function prototypes in omap_hwmod.h

- The omap_hwmod_set_ioring_wakeup() function has been modified to
  not return anything, and indentation depth has been reduced

I still don't think this patch is 100% correct.  For example, if 
omap_hwmod_enable_wakeup() or omap_hwmod_disable_wakeup() is called on an 
idle hwmod, shouldn't the caller expect the SCM PADCONF registers to be 
updated immediately?  The current code merely changes the dynamic mux 
data.  If there is some rationale for not updating the hardware registers 
at this point, I'd like to know what it is.

Modified patch is below; please let me know if you have any comments.
I may modify it again to synchronize the hardware with the in-memory 
settings immediately.


- Paul

From: Govindraj R <govindraj.raja@ti.com>
Date: Tue, 13 Dec 2011 13:50:23 -0700
Subject: [PATCH] ARM: OMAP2+: hwmod: Add API to enable IO ring wakeup

Add API to enable IO pad wakeup capability based on mux dynamic pad and
wake_up enable flag available from hwmod_mux initialization.

Use the wakeup_enable flag and enable wakeup capability
for the given pads. Wakeup capability will be enabled/disabled
during hwmod idle transition based on whether wakeup_flag is
set or cleared.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
XXX Tero's sign-off?
[paul@pwsan.com: rearranged code to limit indentation, cleaned up
 documentation, removed unused non-static functions]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   39 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 207a2ff..ec19841 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -381,6 +381,43 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
 }
 
 /**
+ * _set_ioring_wakeup - enable/disable IO pad wakeup flag for dynamic muxing
+ * @oh: struct omap_hwmod *
+ * @set_wake: bool value indicating to set (true) or clear (false) wakeup enable
+ *
+ * Set or clear the I/O pad wakeup flag in the dynamic mux entries for
+ * the hwmod @oh.  This function does not change anything in the
+ * hardware.  Rather, the @oh->mux->pads_dynamic array is changed, and
+ * these settings are later written to the SCM PADCTRL registers when
+ * the hwmod is enabled or idled.  No return value.
+ *
+ * XXX Shouldn't the dynamic pad changes affect hwmod shutdown as
+ * well?
+ * XXX Shouldn't this function update the hardware SCM PADCONF registers if
+ * anything has changed?
+ */
+static void _set_ioring_wakeup(struct omap_hwmod *oh, bool set_wake)
+{
+	struct omap_device_pad *pad;
+	int j;
+
+	if (!oh->mux || !oh->mux->enabled)
+		return;
+
+	for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
+		pad = oh->mux->pads_dynamic[j];
+
+		if (!(pad->flags & OMAP_DEVICE_PAD_WAKEUP))
+			continue;
+
+		if (set_wake)
+			pad->idle |= OMAP_WAKEUP_EN;
+		else
+			pad->idle &= ~OMAP_WAKEUP_EN;
+	}
+}
+
+/**
  * _enable_wakeup: set OCP_SYSCONFIG.ENAWAKEUP bit in the hardware
  * @oh: struct omap_hwmod *
  *
@@ -2416,6 +2453,7 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	_enable_wakeup(oh, &v);
 	_write_sysconfig(v, oh);
+	_set_ioring_wakeup(oh, true);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
@@ -2446,6 +2484,7 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 	v = oh->_sysc_cache;
 	_disable_wakeup(oh, &v);
 	_write_sysconfig(v, oh);
+	_set_ioring_wakeup(oh, false);
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return 0;
-- 
1.7.7.3

