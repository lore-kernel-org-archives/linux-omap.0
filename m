From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP2/3/4: omap_hwmod: fix reset bug
Date: Tue,  7 Jul 2009 17:17:37 -0700
Message-ID: <1247012257-19407-3-git-send-email-khilman@deeprootsystems.com>
References: <1247012257-19407-1-git-send-email-khilman@deeprootsystems.com>
 <1247012257-19407-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f181.google.com ([209.85.216.181]:39434 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757943AbZGHARp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 20:17:45 -0400
Received: by mail-px0-f181.google.com with SMTP id 11so19465pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 07 Jul 2009 17:17:44 -0700 (PDT)
In-Reply-To: <1247012257-19407-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org

The _reset() hook should early when _soft_reset() fails, not it if
succeeds.  Currently, it aborts when _soft_reset() succeeds, resulting
in not waiting for RESETDONE.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b103797..76b6845 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -746,7 +746,7 @@ static int _reset(struct omap_hwmod *oh)
 
 	v = oh->_sysc_cache;
 	r = _set_softreset(oh, &v);
-	if (!r)
+	if (r)
 		return r;
 	_write_sysconfig(v, oh);
 
-- 
1.6.3.3

