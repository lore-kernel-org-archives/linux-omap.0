From: Kim Kyuwon <chammoru@gmail.com>
Subject: PM: 4 Problems in OMAP3430 DVFS (SmartReflex, Cpufreq)
Date: Thu, 23 Apr 2009 14:00:06 +0900
Message-ID: <4d34a0a70904222200oc699378k56367cf3b378b5d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:15165 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbZDWFAV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 01:00:21 -0400
Received: by wf-out-1314.google.com with SMTP id 26so298746wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 22:00:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, OMAP <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, =?EUC-KR?B?uc66tMij?= <bhmin@samsung.com>, Tony Lindgren <tony@atomide.com>

Hi Kevin, Rajendra, and other OMAP experts,

Lately I'm digging up OMAP3430-DVFS and I found 4 problems on top of PM=
 branch.

1. Setting CPUFreq Governor to 'ondemand' turns off display system.
I think the following codes in set_opp() of rescource34xx.c makes this =
problem.

		/*
		 * For VDD1 OPP3 and above, make sure the interconnect
		 * is at 100Mhz or above.
		 * throughput in KiB/s for 100 Mhz =3D 100 * 1000 * 4.
		 */
		if (target_level >=3D 3)
			resource_request("vdd2_opp", &vdd2_dev, 400000);
		else
			resource_release("vdd2_opp", &vdd2_dev);

I'm not sure this is the root cause. However, if I remove the above
sentences, display system doesn't turn off.

2. [Trivial] Setting CPUFreq Governor to 'ondemand' makes warning
message as below.

    SR1: VDD autocomp is not active
    SR2: VDD autocomp is not active

These warning messages are removed, if I set sr_vdd1_autocomp and
sr_vdd2_autocomp to 1. However, is these warning messages really
needed?

3. OP(Operating Point) transition time is set to 10seconds in
cpu-omap.c as follows:

	/* FIXME: what's the actual transition time? */
	policy->cpuinfo.transition_latency =3D 10 * 1000 * 1000;

The default sampling rate of CPUFreq is set to transition_latency, so
it becomes 10 seconds! It's really too long for DVFS. I measured
transition latency by myself using oscilloscope and it's about 150 ~
200m seconds. I think TI engineers may know more accurate figure. I
wish we could update transition latency as soon as possible.

4. Current PM code didn't enable the maximum clock (i.e. CPU: 600Mhz)
according to the comment as below:

	/* Avoid registering the 120% Overdrive with CPUFreq */
	prcm =3D mpu_opps + MAX_VDD1_OPP - 1;

But in some cases, we should use 600Mhz for multimedia application.
And, even thought we enable the maximum clock, CPU frequency seldom
goes into maximum clock. I think we don't have to avoid registering
the max OPP.

In OMAP PM, there are a lot of part that only experts in TI or people
with experience can handle. So I'm afraid to send new patch or fix
previous PM codes.
I hope we can discuss above issues a lot!

Thank you.
Kyuwon (=B1=D4=BF=F8)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
