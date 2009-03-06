From: "Premi, Sanjeev" <premi@ti.com>
Subject: Problems in cpuidle
Date: Fri, 6 Mar 2009 23:02:07 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC0EDF9C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46086 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbZCFRcR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2009 12:32:17 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n26HW8bf016876
	for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2009 11:32:14 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n26HW8Y0006148
	for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2009 23:02:08 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

While working with cpuidle, I have come across these problems.
I am also working on the solutions, but would be good to hear
more thoughts.

1) The flag 'enable_dyn_sleep' is honoured only in omap3_idle_bm_check()
   but in the C1 state, omap3_enter_idle() is invoked directly.
   So, the system can transition to deeper idle state(s)

   Same is the case with 'sleep_block'.

   Possible Solutions:
     a)  Call omap3_can_sleep() in omap3_enter_idle().
         This makes omap3_idle_bm_check() redundant; and can be removed.

     b)  Make single entry point for all idle states
         But would be an overkill for C1 state.

     c)  Change omap3_can_sleep() to check for omap_uart_can_sleep()
         and omap3_fclks_active() only.
         Move check for 'enable_dyn_sleep' and 'sleep_block' into
         omap3_enter_idle()

    I believe (c) would be the most optimal.

2) When 'enable_off_mode' is 0, and (mpu_state < PWRDM_POWER_RET)
   the local variables mpu_state and core_state are modified; but
   the usage count for the original state selected by the governor
   are updated.

   Solution:
     Recalculate the idle state and update the dev->last_state
     (for cpuidle driver) to ensure that usage statistics for the
     actual state are entered.

     Only problem is that latency corresponding to original state
     would have been used by the dynamic tick functions.

If things go well, I will be able to submit patches on top of pm branch
by tomorrow...

Best regards,
Sanjeev
