From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc7-omap] twl4030-regulator: list more VAUX4 voltages
Date: Tue, 10 Mar 2009 11:51:15 -0800
Message-ID: <200903101251.15700.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:30868 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754480AbZCJTvT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Mar 2009 15:51:19 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@sirena.org.uk>, OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

The VAUX4 voltage table scrolls onto a second page in many versions
of the TWL4030 family manuals.  This doesn't mean we should ignore
those values!  Some boards use the (fully supported) 2.8V setting.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Please apply to both the regulator-next and OMAP trees.

 drivers/regulator/twl4030-regulator.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -229,6 +229,8 @@ static const u16 VAUX3_VSEL_table[] = {
 static const u16 VAUX4_VSEL_table[] = {
 	700, 1000, 1200, UNSUP(1300),
 	1500, 1800, UNSUP(1850), 2500,
+	UNSUP(2600), 2800, UNSUP(2850), UNSUP(3000),
+	UNSUP(3150), UNSUP(3150), UNSUP(3150), UNSUP(3150),
 };
 static const u16 VMMC1_VSEL_table[] = {
 	1850, 2850, 3000, 3150,
