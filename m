From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] ARM:OMAP2: an issue about curr_pwrst, u8 is never < 0
Date: Thu, 14 Mar 2013 12:21:28 +0800
Message-ID: <51415048.6000607@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:6981 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab3CNEVz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 00:21:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org


  if pwrdm_read_pwrst returns negative number, curr_pwrst can not notice it.
  since really need check curr_pwrst whether is negative,
    need let the check valid in _pwrdm_save_clkdm_state_and_activate.
    and also better to check the return value of pwrdm_read_pwrst, firstly.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-omap2/powerdomain.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 43ac20c..876d067 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -233,7 +233,7 @@ static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
 {
 	u8 sleep_switch;
 
-	if (curr_pwrst < 0) {
+	if ((char)curr_pwrst < 0) {
 		WARN_ON(1);
 		sleep_switch = ERROR_SWITCH;
 	} else if (curr_pwrst < PWRDM_POWER_ON) {
@@ -1106,7 +1106,10 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
 
 	pwrdm_lock(pwrdm);
 
-	curr_pwrst = pwrdm_read_pwrst(pwrdm);
+	ret = pwrdm_read_pwrst(pwrdm);
+	if (ret < 0)
+		goto osps_out;
+	curr_pwrst = (u8)(unsigned int)ret;
 	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
 	if (curr_pwrst == pwrst && next_pwrst == pwrst)
 		goto osps_out;
-- 
1.7.7.6
