From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SMP: BUG with PREEMPT enabled
Date: Thu, 15 Oct 2009 12:40:32 +0100
Message-ID: <20091015114032.GB14817@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BB254F8D@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BB2555BF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59900 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659AbZJOLlQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Oct 2009 07:41:16 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BB2555BF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 14, 2009 at 04:56:18PM +0530, Shilimkar, Santosh wrote:
> > On the latest ARM kernel(v2.6.32-rc4),I have observed a BUG() dump when

Umm...

> @@ -350,7 +350,7 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
>  	if (tlb_flag(TLB_WB))
>  		dsb();
>  
> -	if (cpu_isset(smp_processor_id(), mm->cpu_vm_mask)) {
> +	if (cpu_isset(get_cpu(), mm->cpu_vm_mask)) {

This isn't 2.6.32-rc4 code - which actually is:

        if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {

so what kernel version are you working with?

The result is this patch won't apply to 2.6.32-rc4.
