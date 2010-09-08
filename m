From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Don't try to send IPI on UP systems with
 CONFIG_SMP
Date: Wed, 8 Sep 2010 12:32:44 -0700
Message-ID: <20100908193244.GU22507@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100906180346.GC20849@atomide.com>
 <20100908030951.GH22507@atomide.com>
 <20100908031214.GI22507@atomide.com>
 <20100908031404.GJ22507@atomide.com>
 <20100908085657.GA29914@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52349 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab0IHTc4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 15:32:56 -0400
Content-Disposition: inline
In-Reply-To: <20100908085657.GA29914@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100908 01:49]:
> On Tue, Sep 07, 2010 at 08:14:05PM -0700, Tony Lindgren wrote:
> > This is not needed on UP. Additionally with will cause issues when
> > booting CONFIG_SMP_ON_UP kernel on earlier ARM cores.
> 
> Doesn't make sense.

Updated below. Basically it's unnecessary to send IPI for one CPU,
and IPI may not be even supported when booting earlier cores
with CONFIG_SMP_ON_UP.
 
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -207,9 +207,7 @@ __setup("reboot=", reboot_setup);
> >  
> >  void machine_shutdown(void)
> >  {
> > -#ifdef CONFIG_SMP
> >  	smp_send_stop();
> > -#endif
> 
> This will cause a link error as smp.c is not built for uniprocessor
> builds.

Right that should have not made it to the patch.
 
> > --- a/arch/arm/kernel/smp.c
> > +++ b/arch/arm/kernel/smp.c
> > @@ -560,12 +560,17 @@ asmlinkage void __exception do_IPI(struct pt_regs *regs)
> >  
> >  void smp_send_reschedule(int cpu)
> >  {
> > -	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
> > +	if (is_smp())
> > +		send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
> 
> There won't be any other CPUs to send an IPI to - and all places which
> call this are protected by a check for cpu == smp_processor_id() - in
> other words, this will never be called for the current CPU.
 
Good point, it's not needed.

> >  void smp_send_stop(void)
> >  {
> >  	cpumask_t mask = cpu_online_map;
> > +
> > +	if (!is_smp())
> > +		return;
> > +
> >  	cpu_clear(smp_processor_id(), mask);
> 
> This results in an empty CPU mask.  It might be better to do instead:
> 
> 	if (!cpus_empty(mask))
> 
> >  	send_ipi_message(&mask, IPI_CPU_STOP);
> >  }

OK, so this patch shrinks to the one change below.

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 7 Sep 2010 18:41:33 -0700
Subject: [PATCH] ARM: Don't send IPI in smp_send_stop if there's only one CPU

No need to send IPI if there's one CPU, especially when booting
systems with CONFIG_SMP_ON_UP that may not even support IPI.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 40dc74f..32e16da 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -567,7 +567,8 @@ void smp_send_stop(void)
 {
 	cpumask_t mask = cpu_online_map;
 	cpu_clear(smp_processor_id(), mask);
-	send_ipi_message(&mask, IPI_CPU_STOP);
+	if (!cpus_empty(mask))
+		send_ipi_message(&mask, IPI_CPU_STOP);
 }
 
 /*
