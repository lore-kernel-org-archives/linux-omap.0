From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/9] OMAP clockdomain/powerdomain: optimize out sleepdep code
	on OMAP24xx
Date: Thu, 03 Dec 2009 06:45:35 -0700
Message-ID: <20091203134533.16229.90970.stgit@localhost.localdomain>
References: <20091203134321.16229.87539.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48956 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091AbZLCNwW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:52:22 -0500
In-Reply-To: <20091203134321.16229.87539.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

OMAP24xx chips don't support software-configurable sleep dependencies.
Test early for this so the compiler can redact the entire function body
on OMAP24xx.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 9708f12..4147267 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -571,10 +571,10 @@ int pwrdm_add_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 {
 	struct powerdomain *p;
 
-	if (!pwrdm1)
+	if (!cpu_is_omap34xx())
 		return -EINVAL;
 
-	if (!cpu_is_omap34xx())
+	if (!pwrdm1)
 		return -EINVAL;
 
 	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);
@@ -610,10 +610,10 @@ int pwrdm_del_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 {
 	struct powerdomain *p;
 
-	if (!pwrdm1)
+	if (!cpu_is_omap34xx())
 		return -EINVAL;
 
-	if (!cpu_is_omap34xx())
+	if (!pwrdm1)
 		return -EINVAL;
 
 	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);
@@ -653,10 +653,10 @@ int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 {
 	struct powerdomain *p;
 
-	if (!pwrdm1)
+	if (!cpu_is_omap34xx())
 		return -EINVAL;
 
-	if (!cpu_is_omap34xx())
+	if (!pwrdm1)
 		return -EINVAL;
 
 	p = _pwrdm_deps_lookup(pwrdm2, pwrdm1->sleepdep_srcs);


