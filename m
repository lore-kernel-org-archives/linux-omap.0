From: Mike Chan <mike@android.com>
Subject: [PATCH] omap: pm: Fix error condition in _pwrdm_deps_lookup when pwrdm not found.
Date: Wed, 12 Aug 2009 11:12:35 -0700
Message-ID: <1250100755-29723-1-git-send-email-mike@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:9183 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbZHLSMm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 14:12:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, Mike Chan <mike@android.com>

Check pwrdm_name instead of the address of a null struct when at the
end of pwrdm_dep array.

Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mike Chan <mike@android.com>
---
 arch/arm/mach-omap2/powerdomain.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 0334609..02c1ef6 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -103,7 +103,7 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
 
 	}
 
-	if (!pd)
+	if (!pd->pwrdm_name)
 		return ERR_PTR(-ENOENT);
 
 	return pd->pwrdm;
-- 
1.5.4.5

