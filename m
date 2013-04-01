From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM:OMAP2: an issue about curr_pwrst, u8 is never < 0
Date: Mon, 1 Apr 2013 10:25:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304011024090.28273@utopia.booyaka.com>
References: <51415048.6000607@asianux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39204 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457Ab3DAKZa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 06:25:30 -0400
In-Reply-To: <51415048.6000607@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

Hi,

On Thu, 14 Mar 2013, Chen Gang wrote:

> 
>   if pwrdm_read_pwrst returns negative number, curr_pwrst can not notice it.
>   since really need check curr_pwrst whether is negative,
>     need let the check valid in _pwrdm_save_clkdm_state_and_activate.
>     and also better to check the return value of pwrdm_read_pwrst, firstly.
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

thanks for reporting this and sending a suggested fix.  The following 
patch is what I've queued here, which should deal with the root cause 
without the casts.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 31 Mar 2013 20:22:22 -0600
Subject: [PATCH] ARM: OMAP2+: powerdomain: avoid testing whether an unsigned
 char is less than 0

_pwrdm_save_clkdm_state_and_activate() tried to test one of its
unsigned arguments to determine whether it was less than zero.  Fix by
moving the error test to the caller.

Reported-by: Chen Gang <gang.chen@asianux.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 8e61d80..89cad4a 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -52,7 +52,6 @@ enum {
 #define ALREADYACTIVE_SWITCH		0
 #define FORCEWAKEUP_SWITCH		1
 #define LOWPOWERSTATE_SWITCH		2
-#define ERROR_SWITCH			3
 
 /* pwrdm_list contains all registered struct powerdomains */
 static LIST_HEAD(pwrdm_list);
@@ -233,10 +232,7 @@ static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
 {
 	u8 sleep_switch;
 
-	if (curr_pwrst < 0) {
-		WARN_ON(1);
-		sleep_switch = ERROR_SWITCH;
-	} else if (curr_pwrst < PWRDM_POWER_ON) {
+	if (curr_pwrst < PWRDM_POWER_ON) {
 		if (curr_pwrst > pwrst &&
 		    pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
 		    arch_pwrdm->pwrdm_set_lowpwrstchange) {
@@ -1091,7 +1087,8 @@ int pwrdm_post_transition(struct powerdomain *pwrdm)
  */
 int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
 {
-	u8 curr_pwrst, next_pwrst, sleep_switch;
+	u8 next_pwrst, sleep_switch;
+	int curr_pwrst;
 	int ret = 0;
 	bool hwsup = false;
 
@@ -1107,16 +1104,17 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
 	pwrdm_lock(pwrdm);
 
 	curr_pwrst = pwrdm_read_pwrst(pwrdm);
+	if (curr_pwrst < 0) {
+		ret = -EINVAL;
+		goto osps_out;
+	}
+
 	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
 	if (curr_pwrst == pwrst && next_pwrst == pwrst)
 		goto osps_out;
 
 	sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, curr_pwrst,
 							    pwrst, &hwsup);
-	if (sleep_switch == ERROR_SWITCH) {
-		ret = -EINVAL;
-		goto osps_out;
-	}
 
 	ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
 	if (ret)
-- 
1.7.10.4

