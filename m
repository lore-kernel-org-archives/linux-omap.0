From: Jay Chokshi <jchokshi@codeaurora.org>
Subject: How feasible is to implement {voltage/power/clock}domain concepts of OMAP?
Date: Tue, 18 Oct 2011 16:11:42 -0700
Message-ID: <A73B5629-5B40-4A63-B355-73B7B945D121@codeaurora.org>
References: <9C696456696C1A41BEC8A26F1E2C7F3805FC136B@nasanexd01c.na.qualcomm.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:27360 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab1JRXLn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Oct 2011 19:11:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: khugans@codeaurora.org, bryanh@codeaurora.org, linux-omap@vger.kernel.org

Greetings Kevin/Paul,

We have been working to understand omap powerdomain concepts. We used a couple of use cases (i.e. cpuidle, cpufreq etc.) to see how omap handles them. We saw that the leaf functions in such use cases interact with defined powerdomain/clockdomain that talks with hardware directly (pwrdm->prcm_offs  / clkdm1->prcm_partition, clkdm->clkdm_offs).

For example, in for omap2/3 archs, the powerdomain are declared in powerdomains3xxx_data.c 

/* As powerdomains are added or removed above, this list must also be changed */
static struct powerdomain *powerdomains_omap3xxx[] __initdata = {

        &wkup_omap2_pwrdm,
        &gfx_omap2_pwrdm,
        &iva2_pwrdm,
        &mpu_3xxx_pwrdm,
        &neon_pwrdm,
        &core_3xxx_pre_es3_1_pwrdm,
....
};

The same goes for both voltagedomains and clockdomains.


In the cpuidle scenario, in omap3_enter_idle function,
1. it sets next power state for the particular power domain using pwrdm_set_next_pwrst
2. it sets clock state for the particular clock domain using  pwrdm_for_each_clkdm


With that being said, would you please help us understand following,

1. 
It seems that all three concepts, voltagedomains, powerdomains, and clockdomains, are tightly coupled with the OMAP hardware. Were these concepts derived exclusive keeping omap hardware in perspective? Or How would you say that any OEM can implement such concepts, or would it make sense?

2. 
As shown in following diagram, each voltagedomain contains one or many powerdomains, each powerdomain contains one or many clockdomains, and each clockdomain, in turn, would correspond to one or many clocks.

                              |-cldm1     |-clock1
vltdm1 --|-pwrdm1----|-clkdm2---|-clock2
             |                |-cldm_n   |-clock_n
             |-pwrdm2
             |
             |-pwrdm_n

The question is how would describe a situation in which same needs to be sourced for multiple powerdomains? or is it so that you make sure such relation does happen while chip is being laid out?
 
3. 
What is the meaning of following two terms (taken from powerdomain.h),
 * @prcm_offs: the address offset from CM_BASE/PRM_BASE
 * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prcm_offs

4.
This might be a stupid question, but I'll ask anyway. :)
How do you define MPU? How different it is from CPU?
How do you differentiate between MPU and core? 

5. 
Currently we are working on linaro-pm branch of linux-pm tree. Would you advise us use rather another branch for this work, if any?


Thanks,
Jay
-------------------------
Love All, Serve All
-------------------------


















