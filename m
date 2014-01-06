From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: omap4 and cpufreq
Date: Mon, 6 Jan 2014 22:51:13 +0100
Message-ID: <CAGhQ9Vy1mja7-F0a4v9gBQ5naPmRoxNv6GZgjqZ30dhVfD7q8w@mail.gmail.com>
References: <CAGhQ9Vzx-WyCHUurK-2vxS0i_T3SCGGnhq3FfKGhGzbMCeYAqA@mail.gmail.com>
	<52CAD9C2.2020307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:44228 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbaAFVvO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jan 2014 16:51:14 -0500
Received: by mail-vb0-f48.google.com with SMTP id q12so1200423vbe.21
        for <linux-omap@vger.kernel.org>; Mon, 06 Jan 2014 13:51:13 -0800 (PST)
In-Reply-To: <52CAD9C2.2020307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org

On 6 January 2014 17:28, Nishanth Menon <nm@ti.com> wrote:
> On 01/01/2014 04:37 PM, Joachim Eastwood wrote:
>> Hi,
>>
>> I am bringing up a OMAP4460 board on dt and I saw the following messages
>> in the kernel log from "cpufreq-cpu0".
>> [ 2.373352] cpufreq_cpu0: failed to get cpu0 regulator: -19
>> [ 2.379302] cpufreq_cpu0: failed to get cpu0 clock: -2
>> [ 2.384704] cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -2
>>
>> Failure to get the clock is because OMAP4 seems to be lacking a "cpu0" entry
>> in cclock44xx_data.c. Adding "CLK("cpu0", NULL, &dpll_mpu_ck)," to
>> "omap44xx_clks" seems to do the trick. This is what OMAP3 has anyways. Think
>> this failure was caused by commit 60c5fc86d which switched from
>> "omap-cpufreq" to "cpufreq-cpu0" driver on dt boot.
>
> This is part of the transition to device tree based clock nodes. See:
> https://bugzilla.kernel.org/show_bug.cgi?id=58541
>
> for details.
>>
>> As far as I can see it makes cpufreq work again. I at least get the
>> cpufreq nodes in sysfs and can play around with them.
>>
>> Should I submit a patch for cclock44xx_data.c adding "cpu0"?
> No. cclock44xx_data is on the way to be dead.
>
>>
>> Next up is the regulator. Since my board is a 4460 and it seems that
>> tps63261 support for 4460 never made it to mainline I guess I am out of
>> luck here?
>>
>> But for all 4430 boards in mainline I guess it would be nice to add:
>> &twl {
>>     vdd1: regulator-vdd1 {
>>         compatible = "ti,twl6030-vdd1";
>>         regulator-min-microvolt = <1000000>;
>>         regulator-max-microvolt = <1400000>;
>>     };
>> };
>> cpus {
>>     cpu@0 {
>>         cpu0-supply = <&vdd1>;
>>     };
>> };
>>
>> I assume this would work but I don't have a 4430 board to test it on.
>> Unsure about voltage range, but at least 1.0 to 1.4V covers the operation
>> points for cpu in omap443xx.dtsi.
> This will not work. 6030 does not allow voltage to be set over i2c1,
> needs voltage controller/processor to work.

Well, it allows the LDO regulators to be changed over i2c, but I guess
the SMPS regulators are different.



Anyways, thanks for the information and bugzilla link with links to
the patch postings on the mailing list.


regards
Joachim Eastwood
