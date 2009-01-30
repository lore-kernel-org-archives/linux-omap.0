From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Beagle PM hangs
Date: Fri, 30 Jan 2009 14:39:43 -0800
Message-ID: <87y6wsh100.fsf@deeprootsystems.com>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com>
	<87zlhbqtrv.fsf@deeprootsystems.com>
	<87skn3qq6x.fsf@deeprootsystems.com>
	<ABB3227E-1B40-47F0-BD79-FE974FDEF4CE@beagleboard.org>
	<13B9B4C6EF24D648824FF11BE89671620376E9A5E5@dlee02.ent.ti.com>
	<212700A7-C5FE-4CAA-BACF-7931D45C02CC@beagleboard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:32124 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbZA3Wjs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 17:39:48 -0500
Received: by rv-out-0506.google.com with SMTP id k40so652918rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 14:39:47 -0800 (PST)
In-Reply-To: <212700A7-C5FE-4CAA-BACF-7931D45C02CC@beagleboard.org> (Koen Kooi's message of "Fri\, 30 Jan 2009 23\:09\:13 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@beagleboard.org>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Koen Kooi <koen@beagleboard.org> writes:

> Op 30 jan 2009, om 23:03 heeft Woodruff, Richard het volgende
> geschreven:
>
>>
>>>> Just a thought, do you still see these problems when using the
>>>> CPUfreq
>>>> performance governor instead of the ondemand governor?
>>>>
>>>> It could be pointing to some bugs in the switching of operating
>>>> points.
>>>
>>> Speaking of operating points, is there a reason why cpufreq only goes
>>> to 550MHz? It's disappointing that omap3 gets marketed with "600MHz",
>>> but that TI won't let it run at that speed with their cpufreq
>>> drivers.
>>
>> Run at that speed on your board if you like.  You can run even
>> faster if you like but at some point you will start to have odd
>> failures.
>>
>> The 600MHz overdrive operating point is such that if you use it all
>> the time your part life may be reduced.  If you use the stock
>> ondemand governor with no kind of policy teak you'll be at that OPP
>> a lot.
>>
>> Percentage operation in overdrive figures into expected life of a
>> given part. For reference code we just make the needed use cases
>> explicitly ask for overdrive.  This way usage is predictable in well
>> defined mobile product.
>>
>> Depending on the chip you buy things are rated differently.  This
>> rating requires part sorting which typically pushes the price up
>> some.  Any step you add into fabrication of high volumes increases
>> cost.
>
> If you look at http://beagleboard.org/hardware it says "600Mhz"
> multiple times, so I'd expect the board to be running at 600MHz if I
> were a customer. If I read the TRM right I can run the cpu at 600MHz
> continuously for a few years, which exceeds the lifespan of most
> mobile products I have owned.
> So my real question is: why limit it in the kernel if all that's
> needed is a costum userspace governer?

In fact, you wouldn't even need a custom governor.

You can just use performance or ondemand, and use CPUfreq policies set
the max available frequency at 550 most of the time, but set the max
to 600 for certain usecases.

Also, dropping the in-kernel restricion is very trivial.  See patch
below.  With that patch applied, just use performance or ondemand
governors and do this:

To avoid governor picking overdrive OPP:

# echo 550000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq  

To allow overdrive:

# echo 600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq  

Kevin

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 2389eb6..e9a75a3 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -698,8 +698,7 @@ void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 	if (!mpu_opps)
 		return;
 
-	/* Avoid registering the 120% Overdrive with CPUFreq */
-	prcm = mpu_opps + MAX_VDD1_OPP - 1;
+	prcm = mpu_opps + MAX_VDD1_OPP;
 	for (; prcm->rate; prcm--) {
 		freq_table[i].index = i;
 		freq_table[i].frequency = prcm->rate / 1000;
