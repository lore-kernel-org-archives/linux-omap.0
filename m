From: Mike Chan <mike@android.com>
Subject: [PATCH] omap: pm: Fix overflow when doing powerdomain deps lookups.
Date: Mon, 10 Aug 2009 19:00:52 -0700
Message-ID: <1249956052-21893-1-git-send-email-mike@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:28558 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbZHKCA6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 22:00:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Mike Chan <mike@android.com>

Signed-off-by: Mike Chan <mike@android.com>
---
 arch/arm/mach-omap2/powerdomain.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 0334609..6077629 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -90,7 +90,7 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
 	if (!pwrdm || !deps || !omap_chip_is(pwrdm->omap_chip))
 		return ERR_PTR(-EINVAL);
 
-	for (pd = deps; pd; pd++) {
+	for (pd = deps; pd->pwrdm_name; pd++) {
 
 		if (!omap_chip_is(pd->omap_chip))
 			continue;
-- 
1.5.4.5

