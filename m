From: Nishanth Menon <nm@ti.com>
Subject: Re: omap4 and cpufreq
Date: Mon, 6 Jan 2014 10:28:50 -0600
Message-ID: <52CAD9C2.2020307@ti.com>
References: <CAGhQ9Vzx-WyCHUurK-2vxS0i_T3SCGGnhq3FfKGhGzbMCeYAqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49542 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbaAFQ2w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jan 2014 11:28:52 -0500
In-Reply-To: <CAGhQ9Vzx-WyCHUurK-2vxS0i_T3SCGGnhq3FfKGhGzbMCeYAqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>, linux-omap@vger.kernel.org

On 01/01/2014 04:37 PM, Joachim Eastwood wrote:
> Hi,
> 
> I am bringing up a OMAP4460 board on dt and I saw the following messages
> in the kernel log from "cpufreq-cpu0".
> [ 2.373352] cpufreq_cpu0: failed to get cpu0 regulator: -19
> [ 2.379302] cpufreq_cpu0: failed to get cpu0 clock: -2
> [ 2.384704] cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -2
> 
> Failure to get the clock is because OMAP4 seems to be lacking a "cpu0" entry
> in cclock44xx_data.c. Adding "CLK("cpu0", NULL, &dpll_mpu_ck)," to
> "omap44xx_clks" seems to do the trick. This is what OMAP3 has anyways. Think
> this failure was caused by commit 60c5fc86d which switched from
> "omap-cpufreq" to "cpufreq-cpu0" driver on dt boot.

This is part of the transition to device tree based clock nodes. See:
https://bugzilla.kernel.org/show_bug.cgi?id=58541

for details.
> 
> As far as I can see it makes cpufreq work again. I at least get the
> cpufreq nodes in sysfs and can play around with them.
> 
> Should I submit a patch for cclock44xx_data.c adding "cpu0"?
No. cclock44xx_data is on the way to be dead.

> 
> Next up is the regulator. Since my board is a 4460 and it seems that
> tps63261 support for 4460 never made it to mainline I guess I am out of
> luck here?
> 
> But for all 4430 boards in mainline I guess it would be nice to add:
> &twl {
>     vdd1: regulator-vdd1 {
>         compatible = "ti,twl6030-vdd1";
>         regulator-min-microvolt = <1000000>;
>         regulator-max-microvolt = <1400000>;
>     };
> };
> cpus {
>     cpu@0 {
>         cpu0-supply = <&vdd1>;
>     };
> };
> 
> I assume this would work but I don't have a 4430 board to test it on.
> Unsure about voltage range, but at least 1.0 to 1.4V covers the operation
> points for cpu in omap443xx.dtsi.
This will not work. 6030 does not allow voltage to be set over i2c1,
needs voltage controller/processor to work.





-- 
Regards,
Nishanth Menon
