From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: [PATCH 2/2] OMAP3: PM: Early exit on invalid parameters
Date: Mon, 27 Apr 2009 19:26:25 +0300
Message-ID: <7ae7ea307c1097671e8637c8d3d43e3e7fefec54.1240849197.git.ext-phil.2.carmody@nokia.com>
References: <>
 <1240849585-14828-1-git-send-email-ext-phil.2.carmody@nokia.com>
 <9ba9fdeeec0cd47fdcff6b689d2196665ea8bcbf.1240849197.git.ext-phil.2.carmody@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32599 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529AbZD0Q0f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 12:26:35 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3RGPmka020784
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2009 11:26:35 -0500
In-Reply-To: <9ba9fdeeec0cd47fdcff6b689d2196665ea8bcbf.1240849197.git.ext-phil.2.carmody@nokia.com>
In-Reply-To: <9ba9fdeeec0cd47fdcff6b689d2196665ea8bcbf.1240849197.git.ext-phil.2.carmody@nokia.com>
References: <9ba9fdeeec0cd47fdcff6b689d2196665ea8bcbf.1240849197.git.ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

Currently no clients call with invalid parameters, but as
these are exported functions there ought to be some protection
against what would cause NULL pointer dereferences.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index ce7d436..741b51e 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -555,6 +555,8 @@ void sr_start_vddautocomap(int srid, u32 target_opp_no)
 		sr = &sr1;
 	else if (srid == SR2)
 		sr = &sr2;
+	else
+		return;
 
 	if (sr->is_sr_reset == 1) {
 		sr_clk_enable(sr);
@@ -583,6 +585,8 @@ int sr_stop_vddautocomap(int srid)
 		sr = &sr1;
 	else if (srid == SR2)
 		sr = &sr2;
+	else
+		return -EINVAL;
 
 	if (sr->is_autocomp_active == 1) {
 		sr_disable(sr);
@@ -609,6 +613,8 @@ void enable_smartreflex(int srid)
 		sr = &sr1;
 	else if (srid == SR2)
 		sr = &sr2;
+	else
+		return;
 
 	if (sr->is_autocomp_active == 1) {
 		if (sr->is_sr_reset == 1) {
@@ -636,6 +642,8 @@ void disable_smartreflex(int srid)
 		sr = &sr1;
 	else if (srid == SR2)
 		sr = &sr2;
+	else
+		return;
 
 	if (sr->is_autocomp_active == 1) {
 		if (sr->is_sr_reset == 0) {
-- 
1.5.4.3

