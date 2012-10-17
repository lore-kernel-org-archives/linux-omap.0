From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: OMAP2+: Only write the sysconfig on idle when necessary
Date: Wed, 17 Oct 2012 15:12:22 -0500
Message-ID: <1350504742-19995-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59929 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753588Ab2JQUMa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 16:12:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Currently, whenever we idle a device _idle_sysc() is called and writes to the
devices SYSCONFIG register to set the idle mode. A lot devices are using the
smart-idle mode and so the write to the SYSCONFIG register is programming the
same value that is already stored in the register.

Writes to the devices SYSCONFIG register can be slow, for example, writing to
the DMTIMER SYSCONFIG register takes 3 interface clock cycles and 3 functional
clock cycles. If the DMTIMER is using the slow 32kHz functional clock this can
take ~100us.

Furthermore, during boot on an OMAP4430 panda board, I see that there are 100
calls to _idle_sysc(), however, only 3 out of the 100 calls actually write
the SYSCONFIG register with a new value.

Therefore, to avoid unnecessary writes to device SYSCONFIG registers when
idling the device, only write the value if the value has changed. It should be
safe to do this on idle as the context of the register will never be lost while
the device is active.

Verified that suspend, CORE off and retention states are working with this
change on OMAP3430 Beagle board.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b969ab1..962773b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1389,6 +1389,10 @@ static void _idle_sysc(struct omap_hwmod *oh)
 	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
 		_enable_wakeup(oh, &v);
 
+	/* If the cached value is the same as the new value, skip the write */
+	if (oh->_sysc_cache == v)
+		return;
+
 	_write_sysconfig(v, oh);
 }
 
-- 
1.7.9.5

