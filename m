From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: SMP: BUG with PREEMPT enabled
Date: Thu, 15 Oct 2009 18:55:13 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB37D10B@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BB254F8D@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BB2555BF@dbde02.ent.ti.com>
	<20091015114032.GB14817@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091015114032.GB14817@n2100.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

The patch submitted to patch-system I based it on 2.6.32-rc4

Have you tried that patch ?

The one attached was in email was based on 2.6.31

Regards,
Santosh

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Thursday, October 15, 2009 5:11 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: SMP: BUG with PREEMPT enabled
> 
> On Wed, Oct 14, 2009 at 04:56:18PM +0530, Shilimkar, Santosh wrote:
> > > On the latest ARM kernel(v2.6.32-rc4),I have observed a BUG() dump
> when
> 
> Umm...
> 
> > @@ -350,7 +350,7 @@ static inline void local_flush_tlb_mm(struct
> mm_struct *mm)
> >  	if (tlb_flag(TLB_WB))
> >  		dsb();
> >
> > -	if (cpu_isset(smp_processor_id(), mm->cpu_vm_mask)) {
> > +	if (cpu_isset(get_cpu(), mm->cpu_vm_mask)) {
> 
> This isn't 2.6.32-rc4 code - which actually is:
> 
>         if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
> 
> so what kernel version are you working with?
> 
> The result is this patch won't apply to 2.6.32-rc4.
