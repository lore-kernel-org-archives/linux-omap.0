From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: Re: [RFC PATCH v2 0/6] ARM: OMAP3+: Introduce ABB driver
Date: Tue, 16 Apr 2013 15:40:44 +0300
Message-ID: <516D46CC.3080705@ti.com>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com> <87sj2rbguv.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46530 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010Ab3DPMkr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Apr 2013 08:40:47 -0400
In-Reply-To: <87sj2rbguv.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>

Hi Kevin,

On 04/16/2013 12:53 AM, Kevin Hilman wrote:
> Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:
>
>> From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>
>>
>> Following patch series introduces the Adaptive Body-Bias
>> LDO driver, which handles LDOs voltage during OPP change routine.
>> Current implementation is based on patch series from
>> Mike Turquette:
>>
>> http://marc.info/?l=linux-omap&m=134931341818379&w=2
>>
>> ABB transition is a part of OPP changing sequence.
>> ABB can operate in the following modes:
>> - Bypass mode: Activated when ABB is not required
>> - FBB mode: Fast Body Bias mode, used on fast OPPs
> Fast?  I thought the 'F' was for Forward?
You are right. Should be 'Forward' here.

>> - RBB mode: Reverse Body Bias mode, used on slow OPPs
>>
>> In current implementation ABB is converted to regulator.
>> Standalone OPP table is used to store ABB mode, it is defined
>> in device tree for each ABB regulator. It has the following format:
>>
>> operating-points = <
>> 	       /* uV   ABB (0 - Bypass, 1 - FBB, 2 - RBB) */
>> 	       880000		0
>> 	       1060000		1
>> 	       1250000		1
>> 	       1260000		1
>>> ;
>> ABB regulator is linked to regulator chain
> In addition to Mike's comments (which I completely agree with), it would
> be very helfpul to see how this is actually used.  e.g, how the
> regulators are chained together, how the proper ordering is managed,
> etc. etc.

We would like to handle voltage scaling in the following way:

cpufreq_cpu0
clk_set_rate(cpu0)
     |
     |-->set_voltage(ABB regulator) /* all ABB related stuff will be 
handled here */
                 |
                 |-->set_voltage(smps123 regulator) /* actual voltage 
scaling */


This simple model will be extended to handle AVS as a part of the chain.
smps123 regulator may be changed to VP/VC regulator.

Following example is from integration branch, which already has smps123 
regulator.
It demonstrates an example of linkage to chain. ABB regulator is linked 
with smps123 and cpu0 inside device tree.
cpu0 calls set_voltage() function for ABB, and then ABB calls 
set_voltage() function for smps123 to do actual voltage scaling.

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index bb5ee70..c8cbbee 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -36,7 +36,7 @@
         cpus {
                 cpu@0 {
                         compatible = "arm,cortex-a15";
-                       cpu0-supply = <&smps123_reg>;
+                       cpu0-supply = <&abb_mpu>;
                         operating-points = <
                                 /* kHz    uV */
                                 /* Only for Nominal Samples */
@@ -94,6 +94,7 @@
                 reg = <0x4ae07cdc 0x8>,
                       <0x4ae06014 0x4>;
                 ti,tranxdone_status_mask = <0x80>;
+               avs-supply = <&smps123_reg>;
                 operating-points = <
                         /* uV   ABB */
                         880000  0

This RFC patch series is verified together with:
https://patchwork.kernel.org/patch/2445091/

Kevin, what do you think about this model in general? Does it fit to 
regulator framework?

Thank you.

Regards,
Andrii

