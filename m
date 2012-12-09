From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/12] ARM: OMAP2+: powerdomain: remove some redundant
 checks; add some notes
Date: Sun, 09 Dec 2012 13:03:24 -0700
Message-ID: <20121209200322.3196.6345.stgit@dusk.lan>
References: <20121209200108.3196.12452.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40197 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab2LIUFH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 15:05:07 -0500
In-Reply-To: <20121209200108.3196.12452.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com?>

Remove some redundant tests in static functions, and add some comments
to some code that should have future attention.

Signed-off-by: Paul Walmsley <paul@pwsan.com?>
---
 arch/arm/mach-omap2/powerdomain.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 658f4ed..62e2f75 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -95,7 +95,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	int i;
 	struct voltagedomain *voltdm;
 
-	if (!pwrdm || !pwrdm->name)
+	if (!pwrdm->name)
 		return -EINVAL;
 
 	if (cpu_is_omap44xx() &&
@@ -528,9 +528,6 @@ static int _pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 {
 	int ret = -EINVAL;
 
-	if (!pwrdm)
-		return -EINVAL;
-
 	if (pwrdm->banks < (bank + 1))
 		return -EEXIST;
 
@@ -566,9 +563,6 @@ static int _pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 {
 	int ret = -EINVAL;
 
-	if (!pwrdm)
-		return -EINVAL;
-
 	if (pwrdm->banks < (bank + 1))
 		return -EEXIST;
 
@@ -635,6 +629,11 @@ static void _pwrdm_state_switch(struct powerdomain *pwrdm)
 
 static int _pwrdm_pre_transition_cb(struct powerdomain *pwrdm, void *unused)
 {
+	/*
+	 * XXX It should be possible to avoid the clear_all_prev_pwrst
+	 * call for powerdomains if we are programming them to stay on,
+	 * for example.
+	 */
 	pwrdm_clear_all_prev_pwrst(pwrdm);
 	_pwrdm_state_switch(pwrdm);
 	return 0;
@@ -1000,6 +999,11 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 		return ret;
 
 	/*
+	 * XXX Is there some way for us to skip powerdomains that
+	 * don't have a prev pwrst register?
+	 */
+
+	/*
 	 * XXX should get the powerdomain's current state here;
 	 * warn & fail if it is not ON.
 	 */


