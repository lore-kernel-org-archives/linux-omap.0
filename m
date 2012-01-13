From: Antonio Barbalace <antoniob@vt.edu>
Subject: Re: support cpufreq on 3.0.10-rt27
Date: Fri, 13 Jan 2012 10:51:54 -0500
Message-ID: <20120113105154.10163tzefbqlrifu@webmail.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:43040 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab2AMPvz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 10:51:55 -0500
Received: from zidane.cc.vt.edu (zidane.cc.vt.edu [198.82.163.227])
	by lennier.cc.vt.edu (8.13.8/8.13.8) with ESMTP id q0DFptl0015972
	for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 10:51:55 -0500
Received: from imp-b08.cc.vt.edu (imp-b08.cc.vt.edu [127.0.0.1])
	by imp-b08.cc.vt.edu (8.13.8/8.13.8) with ESMTP id q0DFpsqZ013916
	for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 10:51:54 -0500
Received: (from apache@localhost)
	by imp-b08.cc.vt.edu (8.13.8/8.13.8/Submit) id q0DFpsXS013915
	for linux-omap@vger.kernel.org; Fri, 13 Jan 2012 10:51:54 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The discussion I had with Mike follows..
Antonio

> 1.
> In the Linux kernel the available MPU frequencies and voltages are  
> listed in > arch/arm/mach-omap2/opp4xxx_data.c in the struct  
> omap_opp_defq.
> Considering that the MPU can be driven by all the different frequencies that
> someone can generate on the dpll why only 4 frequencies are listed?
> Is it due to the fact that there are only 4 voltage domains availables?
> Can I add other frequency values?
OPP = frequency + voltage

For any given frequency there is a minimum voltage which must be
applied for the IP to operate within spec. Conversely for any given
voltage there is a maximum frequency which an IP can operate at while
staying within spec.

It is true that you can lock the MPU's PLL at many different
frequencies, but we have only validated a small number of
frequency+voltage combinations.  It is advisable to stick with ones
provided in the OPP table so that there are no timing violations or
under-voltage issues.

> 2.
> Cpufreq helps the user switching between different frequencies value.
> Frequency switching can help saving power. Switching frequency lets the core
> running at a different voltage, how can I also switch to the correct voltage
> domain? Voltage scaling is not taken into account in the cpufreq driver?
> Will the SmartReflex technology help me? please can you elaborate more on
> this point, pointing me on the OMAP4 pdf documentation? How can I switch
> frequency and voltage together to save the maximum power?
As a general rule, since you are interested in power management, your
best friend is Chapter 3 of the TRM, "Power, Reset and Clock
Management".  I know that Chapter 4 looks good since it is the MPU,
but Chapter 3 contains everything you need to know about PM.

Kevin's patches will scale voltage as a part of the CPUfreq drivers
.target call.

Also, your terminology is a bit wrong.  Voltage domains are fixed and
cannot be "switched", from one to another.  The MPU is in one voltage
domain, VDD_MPU, which can scale it's voltage up and down through the
VC/VP IP blocks (and communication with the PMIC over I2c).  See
section 3.8, "Voltage Management Function Description".  For a general
overview of changing OPP see section 3.10.4.2, "Changing OPP".

> 3.
> In the document SWPU231K from TI at page 1041 it is written:
> "To maximize performance and SMP scalability, both CPUs must run at the same
> frequency. Do not lower the frequency of one CPU as a power-saving option."
> Is it really possible to run each CPU at a different frequency?
It is not possible.  The ARM cores run at the same frequency always,
as they share a common input clock.

Also you may want to update your TRM which seems old (version K).  You
can always find the latest at:
http://focus.ti.com/general/docs/wtbu/wtbudocumentcenter.tsp?templateId=6123&navigationId=12037

The most recent is version for 4430 is vAA:
http://www.ti.com/pdfs/wtbu/OMAP4430_ES2.x_PUBLIC_TRM_vAA.zip

> 4.
> Is there any entry in sysfs, procfs, debugfs to lookup the OPP table values?
> What about voltage scaling?
Only for the MPU via CPUfreq.  See,
/sys/devices/system/cpu/cpu0/cpufreq/

The values in scaling_available_frequencies are dictated by the OPP table.

> 5.
> From SWPU231K I understand that each CPU is a power domain so I can change
> power state of each CPU independently. Is there a simple way to put one core
> to dormant or power-off mode in Linux?
You can turn off CPU1 (but not CPU0) with,
echo 0 > /sys/devices/system/cpu/cpu1/online

And bring it back up with,
echo 1 > /sys/devices/system/cpu/cpu1/online

This will migrate all work on CPU1 over to CPU0 and take the CPU1
power domain to the lowest power state, OFF mode.

> 6.
> How can I disable other subsytems like M3 and IVA cores? Pheriperals? (I am
> interested in anything that can help me saving power!) Display subsystem?!?!
This is a big problem to solve!  The PM runtime framework can help you
do this is a nice Linux-friendly way.  Direct register writes to the
module mode registers are a hacky way to achieve what you want.

> 7.
> Referring to Kevin's port.. Transition time is not still fixed, i.e. is
> tight to a constant (meaningfull for me) value. Is there an easy way to
> calculate the frequency transition time? What about power state transitions?
Calculating real transition time is hard.  You'll need to break out
some debug signals from the board and monitor voltage and clock
frequencies with a scope to measure the "real thing".  Low power state
transitions can be determined by only monitoring voltage, or PRCM
state via the hardware debug observability signals (chapter 28 of the
TRM).

Regards,
Mike

