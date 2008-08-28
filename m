From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
Date: Thu, 28 Aug 2008 09:39:52 +0530
Message-ID: <02d601c908c3$ed10dcc0$LocalHost@wipultra1382>
References: <200808271409.m7RE9SgN017140@dbdp31.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54284 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755270AbYH1EKD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 00:10:03 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7S49sWJ010866
	for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 23:10:00 -0500
In-Reply-To: <200808271409.m7RE9SgN017140@dbdp31.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Ramesh Gupta Guntha' <x0023949@ti.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Ramesh Gupta Guntha [mailto:x0023949@ti.com] 
> Sent: Wednesday, August 27, 2008 7:39 PM
> To: 'Rajendra Nayak'; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
> 
> Hi, 
>  
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Rajendra Nayak
> > Sent: Monday, August 11, 2008 6:42 PM
> > To: linux-omap@vger.kernel.org
> > Subject: [PATCH 00/01] CPUFreq: OMAP3 cpufreq driver
> > 
> > Hi,
> > 
> > The patch which follows implements the CPUFreq driver for 
> > OMAP3, tested on 3430sdp.
> > The driver uses API's defined as part of the OMAP-PM layer.
> > 
> > Performance Governor is selected by default in the defconfig.
> > After bootup, to switch to ondemand or any other governor use 
> > the following sysfs interface 
> > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> 
> With the ondemand Governor  I am some seeing issues for DSP 
> Bridge. clk_notifier_register call for iva2_ck is successful 
> but I am seeing below messages on opp change request from IVA.

For bridge do you need a pre notification or post notification?
Besides do you do anything in the notification that could sleep?
The clock notifcation is called with interrupts disabled.

> 
> <3>clock: Could not find fieldval 0 for clock iva2_ck parent 
> dpll2_m2_ck
> clock: Could not find fieldval 0 for clock iva2_ck parent dpll2_m2_ck
> <3>clock: Could not find fieldval 0 for clock iva2_ck parent 
> dpll2_m2_ck
> clock: Could not find fieldval 0 for clock iva2_ck parent dpll2_m2_ck
> 
> Looks like access to memory stalls while opp is changing ( 
> some times I observed MMU Fault messages from IVA while opp 
> is changing). Also some times I observed that after the opp 
> change IVA Power state registers are not accessible( I am 
> getting  BUG# soft lock up while accessing IVA Power state registers).
> 
> Can you please provide your inputs on these issues?
> 
> Is there any way to manually switch opp using sysfs?( useful 
> for debugging)

I am in the process of sending an updated SRF/CPUFreq patches. Meanwhile if you want
to manually switch OPP's I remember Paul posting a patch to actually do that.
Also Paul had initally reported a few stability issues with M2 divider change for CORE dpll on the SDP?
Paul, Any idea if these were fixed or are there still instabilities with VDD2 dvfs.
Below is a snippet from an old mail for reference..


> A few notes:
> 
> - The M2 divider switch does not seem to work consistently on the
>   3430SDP I use to test.  In particular, the switch back to 
> M2=1 results
>   in a hung console.


> 
> regards
> Ramesh Gupta G
> 
> 
> 

