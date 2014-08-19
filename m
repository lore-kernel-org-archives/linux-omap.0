From: Tony Lindgren <tony@atomide.com>
Subject: Re: Questions about enabling dps(dynamic power switching) and SLM
Date: Tue, 19 Aug 2014 08:01:11 -0700
Message-ID: <20140819150110.GG9239@atomide.com>
References: <BLU185-W2233E35F6629F6D4F137D6ECEB0@phx.gbl>
 <20140814140943.GB9239@atomide.com>
 <BLU185-W41F1B3F381C31F1C3B8266ECD40@phx.gbl>
 <BLU185-W16CBCC06A88D78F300AE9AECD40@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55587 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbaHSPBP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2014 11:01:15 -0400
Content-Disposition: inline
In-Reply-To: <BLU185-W16CBCC06A88D78F300AE9AECD40@phx.gbl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Deepa Raj <draj187@hotmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Deepa Raj <draj187@hotmail.com> [140818 10:32]:
> Hi Tony,
> 
> I have few more questions on OMAP3:
> 
> 1) As you know there are power scripts in drivers/mfd folder for PMIC chip (Triton2). Is this mandatory to use these scripts like there are P1,P2,P3 areas are there in PMIC.

Not mandatory, but you need to configure the scripts if you want
the PMIC to trigger changes during deeper idle states based on
sys_clkreq and sys_off_mode pins.
 
> 2) My understanding was when regulator_enable and disable are called from device drivers, voltage regulators are powered on/off, is it correct, if yes, why do we need to use power scripts?

We still need to configure scripts as when the system hits retention
or off mode during idle, the regulator framework can't do anything.

For most part we want to configure PMIC to shut down vpll1, vdd1
and vdd2 during off-idle while keeping everything else controlled
by the regulator framework. Optionally also the oscillator can be
cut off and regen.

FYI, there's a bug in omap3_idle_rconfig that I'll provide a patch
for today. Most of it should use TWL4030_RESCONFIG_UNDEF instead
of DEV_GRP_NULL.
 
> 3) Suppose HiFreq clk source (Oscillator), since there are no suspend/resume hooks from PMIC. Do we mandatory to use these scripts during suspend to RAM or we can directly power off oscillators or is there any hardware mechanism also, when all voltage regulators are disabled, HiFreq oscillator will be cut off.

That must be done withe the scripts as nothing else can run
without the oscillator :)
 
> 4) Do power scripts are mandatory for all OMAP platforms?

Not mandatory, but needed for many battery operated devices to
save power.

Regards,

Tony
