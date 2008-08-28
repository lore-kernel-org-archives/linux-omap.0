From: "Ramesh Gupta Guntha" <x0023949@ti.com>
Subject: RE: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
Date: Thu, 28 Aug 2008 10:50:34 +0530
Message-ID: <200808280520.m7S5KcIH022518@dbdp31.itg.ti.com>
References: <02d601c908c3$ed10dcc0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47795 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbYH1FUt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Aug 2008 01:20:49 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7S5KeqS008646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 00:20:48 -0500
In-Reply-To: <02d601c908c3$ed10dcc0$LocalHost@wipultra1382>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Rajendra Nayak' <rnayak@ti.com>, linux-omap@vger.kernel.org

Hi Rajendra,
 

> > > Performance Governor is selected by default in the defconfig.
> > > After bootup, to switch to ondemand or any other governor use the 
> > > following sysfs interface 
> > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> > 
> > With the ondemand Governor  I am some seeing issues for DSP Bridge. 
> > clk_notifier_register call for iva2_ck is successful but I 
> am seeing 
> > below messages on opp change request from IVA.
> 
> For bridge do you need a pre notification or post notification?
> Besides do you do anything in the notification that could sleep?
> The clock notifcation is called with interrupts disabled.

For Bridge we need post notification. We are not doing anything to cause sleep.
We update shared memory with opp information and send interrupt to DSP.


> 
> > 
> > <3>clock: Could not find fieldval 0 for clock iva2_ck parent 
> > dpll2_m2_ck
> > clock: Could not find fieldval 0 for clock iva2_ck parent 
> dpll2_m2_ck
> > <3>clock: Could not find fieldval 0 for clock iva2_ck parent 
> > dpll2_m2_ck
> > clock: Could not find fieldval 0 for clock iva2_ck parent 
> dpll2_m2_ck
> > 
> > Looks like access to memory stalls while opp is changing ( 
> some times 
> > I observed MMU Fault messages from IVA while opp is changing). Also 
> > some times I observed that after the opp change IVA Power state 
> > registers are not accessible( I am getting  BUG# soft lock up while 
> > accessing IVA Power state registers).
> > 
> > Can you please provide your inputs on these issues?
> > 
> > Is there any way to manually switch opp using sysfs?( useful for 
> > debugging)
> 
> I am in the process of sending an updated SRF/CPUFreq 
> patches. Meanwhile if you want to manually switch OPP's I 
> remember Paul posting a patch to actually do that.
> Also Paul had initally reported a few stability issues with 
> M2 divider change for CORE dpll on the SDP?

Thank you,
I am using the userspace governor to  set the cpu frequency manually, thanks to Romit and Anand.
I will try finding the Paul patch.

Thanks
Ramesh Gupta G

