From: Joachim Eastwood <manabian@gmail.com>
Subject: omap4 and cpufreq
Date: Wed, 1 Jan 2014 23:37:16 +0100
Message-ID: <CAGhQ9Vzx-WyCHUurK-2vxS0i_T3SCGGnhq3FfKGhGzbMCeYAqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:59894 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686AbaAAWhR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jan 2014 17:37:17 -0500
Received: by mail-ve0-f175.google.com with SMTP id jx11so6899340veb.6
        for <linux-omap@vger.kernel.org>; Wed, 01 Jan 2014 14:37:17 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am bringing up a OMAP4460 board on dt and I saw the following messages
in the kernel log from "cpufreq-cpu0".
[ 2.373352] cpufreq_cpu0: failed to get cpu0 regulator: -19
[ 2.379302] cpufreq_cpu0: failed to get cpu0 clock: -2
[ 2.384704] cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -2

Failure to get the clock is because OMAP4 seems to be lacking a "cpu0" entry
in cclock44xx_data.c. Adding "CLK("cpu0", NULL, &dpll_mpu_ck)," to
"omap44xx_clks" seems to do the trick. This is what OMAP3 has anyways. Think
this failure was caused by commit 60c5fc86d which switched from
"omap-cpufreq" to "cpufreq-cpu0" driver on dt boot.

As far as I can see it makes cpufreq work again. I at least get the
cpufreq nodes in sysfs and can play around with them.

Should I submit a patch for cclock44xx_data.c adding "cpu0"?

Next up is the regulator. Since my board is a 4460 and it seems that
tps63261 support for 4460 never made it to mainline I guess I am out of
luck here?

But for all 4430 boards in mainline I guess it would be nice to add:
&twl {
    vdd1: regulator-vdd1 {
        compatible = "ti,twl6030-vdd1";
        regulator-min-microvolt = <1000000>;
        regulator-max-microvolt = <1400000>;
    };
};
cpus {
    cpu@0 {
        cpu0-supply = <&vdd1>;
    };
};

I assume this would work but I don't have a 4430 board to test it on.
Unsure about voltage range, but at least 1.0 to 1.4V covers the operation
points for cpu in omap443xx.dtsi.

regards
Joachim Eastwood
