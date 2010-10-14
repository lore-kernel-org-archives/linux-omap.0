From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] omap2plus: wdt: Fix boot warn when CONFIG_PM_RUNTIME=n
Date: Thu, 14 Oct 2010 12:52:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010141250490.21196@utopia.booyaka.com>
References: <1286798556-22749-1-git-send-email-charu@ti.com> <4CB40B07.8080301@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CFC553C@dbde02.ent.ti.com> <4CB45E0E.6080104@ti.com> <87mxqj1d2v.fsf@deeprootsystems.com> <EAF47CD23C76F840A9E7FCE10091EFAB030D09A22D@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1010141234190.21196@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35508 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab0JNSwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 14:52:21 -0400
In-Reply-To: <alpine.DEB.2.00.1010141234190.21196@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 14 Oct 2010, Paul Walmsley wrote:

> Enclosed below is a work-in-progress patch to illustrate the proposal.
> It clearly needs some more work and should be split into at least two
> patches, but it might help clarify what I am proposing.

Here's one important missing piece of the patch that I wanted to 
illustrate...


- Paul

>From de3b800f9a6db027846f68de3aa4202eb713b391 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 14 Oct 2010 12:48:00 -0600
Subject: [RFC PATCH] OMAP2+ hwmod: illustrate pre-shutdown hook 
implementation

---
 arch/arm/mach-omap2/omap_hwmod.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 618e135..92dd369 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1261,6 +1261,9 @@ int _omap_hwmod_idle(struct omap_hwmod *oh)
  */
 static int _shutdown(struct omap_hwmod *oh)
 {
+	int ret;
+	u8 prev_state;
+
 	if (oh->_state != _HWMOD_STATE_IDLE &&
 	    oh->_state != _HWMOD_STATE_ENABLED) {
 		WARN(1, "omap_hwmod: %s: disabled state can only be entered "
@@ -1270,6 +1273,18 @@ static int _shutdown(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: disabling\n", oh->name);
 
+	if (oh->class->pre_shutdown) {
+		prev_state = oh->_state;
+		if (oh->_state == _HWMOD_STATE_IDLE)
+			_omap_hwmod_enable(oh);
+		ret = oh->class->pre_shutdown(oh);
+		if (ret) {
+			if (prev_state == _HWMOD_STATE_IDLE)
+				_omap_hwmod_idle(oh);
+			return ret;
+		}
+	}
+
 	if (oh->class->sysc)
 		_shutdown_sysc(oh);
 
-- 
1.7.1

