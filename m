From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: OMAP2+: OPP: Fix to ensure check of right oppdef after bad one
Date: Fri, 18 May 2012 12:26:19 -0500
Message-ID: <1337361979-19052-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:59682 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674Ab2ERR00 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 13:26:26 -0400
Received: by obhx4 with SMTP id x4so4890267obh.20
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 10:26:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Steve Sakoman <steve@sakoman.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Commit 9fa2df6b90786301b175e264f5fa9846aba81a65
(ARM: OMAP2+: OPP: allow OPP enumeration to continue if device is not present)
makes the logic:
for (i = 0; i < opp_def_size; i++) {
	<snip>
	if (!oh || !oh->od) {
		<snip>
		continue;
	}
<snip>
opp_def++;
}

In short, the moment we hit a "Bad OPP", we end up looping the list
comparing against the bad opp definition pointer for the rest of the
iteration count. Instead, increment opp_def in the for loop itself
and allow continue to be used in code without much thought so that
we check the next set of OPP definition pointers :)

Cc: Kevin Hilman <khilman@ti.com>
Cc: Steve Sakoman <steve@sakoman.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---

 arch/arm/mach-omap2/opp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index de6d464..d8f6dbf 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -53,7 +53,7 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 	omap_table_init = 1;
 
 	/* Lets now register with OPP library */
-	for (i = 0; i < opp_def_size; i++) {
+	for (i = 0; i < opp_def_size; i++, opp_def++) {
 		struct omap_hwmod *oh;
 		struct device *dev;
 
@@ -86,7 +86,6 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 					__func__, opp_def->freq,
 					opp_def->hwmod_name, i, r);
 		}
-		opp_def++;
 	}
 
 	return 0;
-- 
1.7.9.5

