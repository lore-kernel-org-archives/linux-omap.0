From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 3/3] OMAP3 PM: Adding counters for power domain logic
 off and mem off during retention.
Date: Fri, 5 Feb 2010 21:50:11 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E7037A4@dbde02.ent.ti.com>
References: <1265302071-7624-1-git-send-email-thara@ti.com>
 <1265302071-7624-2-git-send-email-thara@ti.com>
 <1265302071-7624-3-git-send-email-thara@ti.com>
 <1265302071-7624-4-git-send-email-thara@ti.com>
 <alpine.DEB.2.00.1002050122410.26033@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49648 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420Ab0BEQUS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 11:20:18 -0500
In-Reply-To: <alpine.DEB.2.00.1002050122410.26033@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>>-----Original Message-----
>>From: Paul Walmsley [mailto:paul@pwsan.com]
>>Sent: Friday, February 05, 2010 1:59 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org
>>Subject: Re: [PATCH 3/3] OMAP3 PM: Adding counters for power domain logic off and mem off during
>>retention.
>>
>>Hi Thara,
>>
>>On Thu, 4 Feb 2010, Thara Gopinath wrote:
>>
>>> This patch adds counters to keep track of whether the powerdomain
>>> logic or software controllable memory banks are turned off when
>>> the power domain enters retention. During power domain retention
>>> if logic gets turned off, the scenario is known as Open Switch Retention.
>>> Also during retention s/w controllable memory banks of a power
>>> domain can be chosen to be kept in retention or off.
>>>
>>> This patch adds one counter per powerdomain to track the power domain
>>> logic state during retention. Number of memory bank state counters
>>> added depends on the number of software controllable memory banks
>>> of the powerdomain. To view these counters do
>>> 	cat ../debug/pm_debug/count
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>
>>I've moved the OSWR counter incrementing code out into its own function,
>>and simplified the conditionals, both per Documentation/CodingStyle.
>>Revised patch attached below.  Could you please check this to confirm that
>>it works as intended?

Hello Paul,

This patch looks fine to me.

Regards
Thara
>>
>>
>>- Paul
>>
>>From 3fe59666447821406068ee7f48aa7f1698e51a72 Mon Sep 17 00:00:00 2001
>>From: Thara Gopinath <thara@ti.com>
>>Date: Thu, 4 Feb 2010 22:17:51 +0530
>>Subject: [PATCH] OMAP3 PM: Adding counters for power domain logic off and mem off during retention.
>>
>>This patch adds counters to keep track of whether the powerdomain
>>logic or software controllable memory banks are turned off when
>>the power domain enters retention. During power domain retention
>>if logic gets turned off, the scenario is known as Open Switch Retention.
>>Also during retention s/w controllable memory banks of a power
>>domain can be chosen to be kept in retention or off.
>>
>>This patch adds one counter per powerdomain to track the power domain
>>logic state during retention. Number of memory bank state counters
>>added depends on the number of software controllable memory banks
>>of the powerdomain. To view these counters do
>>	cat ../debug/pm_debug/count
>>
>>Signed-off-by: Thara Gopinath <thara@ti.com>
>>[paul@pwsan.com: conditional expressions simplified; counter increment
>> code moved to its own function]
>>Signed-off-by: Paul Walmsley <paul@pwsan.com>
>>---
>> arch/arm/mach-omap2/pm-debug.c                |    5 +++++
>> arch/arm/mach-omap2/powerdomain.c             |   25 +++++++++++++++++++++++++
>> arch/arm/plat-omap/include/plat/powerdomain.h |    2 ++
>> 3 files changed, 32 insertions(+), 0 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
>>index 0ce356f..c18f7f2 100644
>>--- a/arch/arm/mach-omap2/pm-debug.c
>>+++ b/arch/arm/mach-omap2/pm-debug.c
>>@@ -385,6 +385,11 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
>> 		seq_printf(s, ",%s:%d", pwrdm_state_names[i],
>> 			pwrdm->state_counter[i]);
>>
>>+	seq_printf(s, ",RET-LOGIC-OFF:%d", pwrdm->ret_logic_off_counter);
>>+	for (i = 0; i < pwrdm->banks; i++)
>>+		seq_printf(s, ",RET-MEMBANK%d-OFF:%d", i + 1,
>>+				pwrdm->ret_mem_off_counter[i]);
>>+
>> 	seq_printf(s, "\n");
>>
>> 	return 0;
>>diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>>index e9eeaa4..9a0fb38 100644
>>--- a/arch/arm/mach-omap2/powerdomain.c
>>+++ b/arch/arm/mach-omap2/powerdomain.c
>>@@ -125,6 +125,10 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>> 	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
>> 		pwrdm->state_counter[i] = 0;
>>
>>+	pwrdm->ret_logic_off_counter = 0;
>>+	for (i = 0; i < pwrdm->banks; i++)
>>+		pwrdm->ret_mem_off_counter[i] = 0;
>>+
>> 	pwrdm_wait_transition(pwrdm);
>> 	pwrdm->state = pwrdm_read_pwrst(pwrdm);
>> 	pwrdm->state_counter[pwrdm->state] = 1;
>>@@ -134,6 +138,25 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>> 	return 0;
>> }
>>
>>+static void _update_logic_membank_counters(struct powerdomain *pwrdm)
>>+{
>>+	int i;
>>+	u8 prev_logic_pwrst, prev_mem_pwrst;
>>+
>>+	prev_logic_pwrst = pwrdm_read_prev_logic_pwrst(pwrdm);
>>+	if ((pwrdm->pwrsts_logic_ret == PWRSTS_OFF_RET) &&
>>+	    (prev_logic_pwrst == PWRDM_POWER_OFF))
>>+		pwrdm->ret_logic_off_counter++;
>>+
>>+	for (i = 0; i < pwrdm->banks; i++) {
>>+		prev_mem_pwrst = pwrdm_read_prev_mem_pwrst(pwrdm, i);
>>+
>>+		if ((pwrdm->pwrsts_mem_ret[i] == PWRSTS_OFF_RET) &&
>>+		    (prev_mem_pwrst == PWRDM_POWER_OFF))
>>+			pwrdm->ret_mem_off_counter[i]++;
>>+	}
>>+}
>>+
>> static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>> {
>>
>>@@ -153,6 +176,8 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>> 		prev = pwrdm_read_prev_pwrst(pwrdm);
>> 		if (pwrdm->state != prev)
>> 			pwrdm->state_counter[prev]++;
>>+		if (prev == PWRDM_POWER_RET)
>>+			_update_logic_membank_counters(pwrdm);
>> 		break;
>> 	default:
>> 		return -EINVAL;
>>diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-
>>omap/include/plat/powerdomain.h
>>index 6657ff2..d82b2c0 100644
>>--- a/arch/arm/plat-omap/include/plat/powerdomain.h
>>+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
>>@@ -100,6 +100,8 @@ struct powerdomain {
>> 	struct list_head node;
>> 	int state;
>> 	unsigned state_counter[PWRDM_MAX_PWRSTS];
>>+	unsigned ret_logic_off_counter;
>>+	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
>>
>> #ifdef CONFIG_PM_DEBUG
>> 	s64 timer;
>>--
>>1.6.6.rc2.5.g49666

