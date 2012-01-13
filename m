From: Antonio Barbalace <antoniob@vt.edu>
Subject: RE: support cpufreq on 3.0.10-rt27
Date: Fri, 13 Jan 2012 11:35:15 -0500
Message-ID: <20120113113515.60614nxwa1vxbxvn@webmail.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:50633 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab2AMQfU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 11:35:20 -0500
Received: from steiner.cc.vt.edu (steiner.cc.vt.edu [198.82.163.51])
	by lennier.cc.vt.edu (8.13.8/8.13.8) with ESMTP id q0DGVsDB005034
	for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 11:35:19 -0500
Received: from imp-b08.cc.vt.edu (imp-b08.cc.vt.edu [127.0.0.1])
	by imp-b08.cc.vt.edu (8.13.8/8.13.8) with ESMTP id q0DGZFKC014706
	for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 11:35:15 -0500
Received: (from apache@localhost)
	by imp-b08.cc.vt.edu (8.13.8/8.13.8/Submit) id q0DGZFuv014705
	for linux-omap@vger.kernel.org; Fri, 13 Jan 2012 11:35:15 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I have some more questions inline..

Note that the previous patches I have submitted so far are not tight  
to freq table values (any freq values can be selected).

> > 1.
> > In the Linux kernel the available MPU frequencies and voltages are  
>  > listed in > arch/arm/mach-omap2/opp4xxx_data.c in the struct  >  
> omap_opp_defq.
> > Considering that the MPU can be driven by all the different  
> frequencies that
> > someone can generate on the dpll why only 4 frequencies are listed?
> > Is it due to the fact that there are only 4 voltage domains availables?
> > Can I add other frequency values?
> OPP = frequency + voltage
>
> For any given frequency there is a minimum voltage which must be
> applied for the IP to operate within spec. Conversely for any given
> voltage there is a maximum frequency which an IP can operate at while
> staying within spec.
>
> It is true that you can lock the MPU's PLL at many different
> frequencies, but we have only validated a small number of
> frequency+voltage combinations.  It is advisable to stick with ones
> provided in the OPP table so that there are no timing violations or
> under-voltage issues.
Will the smartreflex driver select the best voltage for me at any  
time? How can I verify that the smartreflex is actually running? Is  
there a device driver in the Linux source tree?

> > 2.
> > Cpufreq helps the user switching between different frequencies value.
> > Frequency switching can help saving power. Switching frequency  
> lets the core
> > running at a different voltage, how can I also switch to the  
> correct voltage
> > domain? Voltage scaling is not taken into account in the cpufreq driver?
> > Will the SmartReflex technology help me? please can you elaborate more on
> > this point, pointing me on the OMAP4 pdf documentation? How can I switch
> > frequency and voltage together to save the maximum power?
> As a general rule, since you are interested in power management, your
> best friend is Chapter 3 of the TRM, "Power, Reset and Clock
> Management".  I know that Chapter 4 looks good since it is the MPU,
> but Chapter 3 contains everything you need to know about PM.
>
> Kevin's patches will scale voltage as a part of the CPUfreq drivers
> .target call.
I went through Kevin's patches but I cannot see any voltage scaling in  
cpufreq related stuff, can you please point me out on the exact code?
Function trace on which I have went through:

drivers/cpufreq/cpufreq.c: __cpufreq_driver_target
drivers/cpufreq/omap-cpufreq.c: omap_target
arch/arm/plat-omap/clock.c: clk_set_rate
arch/arm/mach-omap2/clock.c: omap2_clk_set_rate
arch/arm/mach-omap2/dpll3xxx.c: omap3_noncore_dpll_set_rate

> > 5.
> > From SWPU231K I understand that each CPU is a power domain so I can change
> > power state of each CPU independently. Is there a simple way to  
> put one core
> > to dormant or power-off mode in Linux?
> You can turn off CPU1 (but not CPU0) with,
> echo 0 > /sys/devices/system/cpu/cpu1/online
>
> And bring it back up with,
> echo 1 > /sys/devices/system/cpu/cpu1/online
>
> This will migrate all work on CPU1 over to CPU0 and take the CPU1
> power domain to the lowest power state, OFF mode.
Wow! This work very well! Measuring power on my PandaBoard when  
switching off CPU1 I do not see any power difference! Why?

Thanks,
Antonio

