From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
Date: Fri, 13 Apr 2012 05:22:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204130521110.25832@utopia.booyaka.com>
References: <1331659524-7635-1-git-send-email-rnayak@ti.com> <1331659524-7635-3-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204101803020.20894@utopia.booyaka.com> <4F8565C7.4080506@ti.com> <alpine.DEB.2.00.1204111251100.29473@utopia.booyaka.com>
 <4F87F147.3040002@ti.com> <alpine.DEB.2.00.1204130443530.25832@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50484 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab2DMLWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 07:22:13 -0400
In-Reply-To: <alpine.DEB.2.00.1204130443530.25832@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anand Gadiyar <gadiyar@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

Hi Rajendra

here's what I've queued for v3.4-rc; please let me know if you have any 
comments.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 13 Apr 2012 05:08:43 -0600
Subject: [PATCH] ARM: OMAP2+: hwmod: Revert "ARM: OMAP2+: hwmod: Make
 omap_hwmod_softreset wait for reset status"

This reverts commit f9a2f9c3fa76eec55928e8e06f3094c8f01df7cb.  This
commit caused a regression in the I2C hwmod reset on OMAP2/3/4,
logging messages similar to these during boot:

[    0.200378] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
[    0.222076] omap_hwmod: i2c2: softreset failed (waited 10000 usec)

While the original patch was intended to fix some reset-related timing
issues, it's believed that these problems were actually fixed by
commit 2800852a079504f35f88e44faf5c9c96318c0cca ("ARM: OMAP2+: hwmod:
Restore sysc after a reset"):

    http://marc.info/?l=linux-arm-kernel&m=133410322617245&w=2

Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 45f1d9c..7144ae6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1906,10 +1906,20 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
  */
 int omap_hwmod_softreset(struct omap_hwmod *oh)
 {
-	if (!oh)
+	u32 v;
+	int ret;
+
+	if (!oh || !(oh->_sysc_cache))
 		return -EINVAL;
 
-	return _ocp_softreset(oh);
+	v = oh->_sysc_cache;
+	ret = _set_softreset(oh, &v);
+	if (ret)
+		goto error;
+	_write_sysconfig(v, oh);
+
+error:
+	return ret;
 }
 
 /**
-- 
1.7.10

