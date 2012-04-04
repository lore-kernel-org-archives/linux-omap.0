From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: omap: hwmod: Restore sysc after a reset
Date: Wed, 4 Apr 2012 09:41:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204040939300.8000@utopia.booyaka.com>
References: <1331646928-31119-1-git-send-email-rnayak@ti.com> <1331646928-31119-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48576 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274Ab2DDPlC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 11:41:02 -0400
In-Reply-To: <1331646928-31119-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

On Tue, 13 Mar 2012, Rajendra Nayak wrote:

> After a softreset, make sure the sysc settings are correctly
> restored.
> 
> Reported-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

Thanks, this patch has been modified a bit to consolidate the SYSCONFIG 
reload after _reset() into the _reset() function itself.  This should 
hopefully avoid future mistakes and avoid some code duplication.  Modified 
patch follows, queued for 3.4-rc.


- Paul


From: Rajendra Nayak <rnayak@ti.com>
Date: Tue, 13 Mar 2012 22:55:23 +0530
Subject: [PATCH] ARM: OMAP2+: hwmod: Restore sysc after a reset

After a softreset, make sure the sysc settings are correctly
restored.

Reported-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
[paul@pwsan.com: combined post-reset SYSCONFIG reload code into the
 _reset() function to avoid duplication and future mistakes]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5a68010..d32c1ce 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1477,6 +1477,11 @@ static int _reset(struct omap_hwmod *oh)
 
 	ret = (oh->class->reset) ? oh->class->reset(oh) : _ocp_softreset(oh);
 
+	if (oh->class->sysc) {
+		_update_sysc_cache(oh);
+		_enable_sysc(oh);
+	}
+
 	return ret;
 }
 
@@ -1786,20 +1791,9 @@ static int _setup(struct omap_hwmod *oh, void *data)
 		return 0;
 	}
 
-	if (!(oh->flags & HWMOD_INIT_NO_RESET)) {
+	if (!(oh->flags & HWMOD_INIT_NO_RESET))
 		_reset(oh);
 
-		/*
-		 * OCP_SYSCONFIG bits need to be reprogrammed after a softreset.
-		 * The _enable() function should be split to
-		 * avoid the rewrite of the OCP_SYSCONFIG register.
-		 */
-		if (oh->class->sysc) {
-			_update_sysc_cache(oh);
-			_enable_sysc(oh);
-		}
-	}
-
 	postsetup_state = oh->_postsetup_state;
 	if (postsetup_state == _HWMOD_STATE_UNKNOWN)
 		postsetup_state = _HWMOD_STATE_ENABLED;
-- 
1.7.9.5

