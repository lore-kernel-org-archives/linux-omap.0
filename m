From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/13] [PATCH] OMAP: powerdomain: Fix overflow when doing
	powerdomain deps lookups.
Date: Sat, 15 Aug 2009 14:18:43 +0300
Message-ID: <20090815111840.7384.20607.stgit@localhost.localdomain>
References: <20090815111704.7384.31564.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32946 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbZHOL0N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 07:26:13 -0400
In-Reply-To: <20090815111704.7384.31564.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org
Cc: Mike Chan <mike@android.com>

At the end of the list pd is a pointer to a NULL struct, so checking
if the address == NULL doesn't help here. In fact the original code
will just keep running past the struct to read who knows what in
memory.

This case manifests itself when from clkdms_setup() when enabling auto
idle for a clock domain and the clockdomain usecount is greater than
0. When _clkdm_add_autodeps() tries to add the a dependency that does
not exist in the powerdomain->wkdep_srcs array the for loop will run
past the wkdep_srcs array.

Currently in linux-omap you won't hit this because the not found case
is never executed, unless you start modifying powerdomains and their
wakeup/sleep deps.

Signed-off-by: Mike Chan <mike@android.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 983f1cb..66206b6 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -83,7 +83,7 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
 	if (!pwrdm || !deps || !omap_chip_is(pwrdm->omap_chip))
 		return ERR_PTR(-EINVAL);
 
-	for (pd = deps; pd; pd++) {
+	for (pd = deps; pd->pwrdm_name; pd++) {
 
 		if (!omap_chip_is(pd->omap_chip))
 			continue;
@@ -96,7 +96,7 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
 
 	}
 
-	if (!pd)
+	if (!pd->pwrdm_name)
 		return ERR_PTR(-ENOENT);
 
 	return pd->pwrdm;


