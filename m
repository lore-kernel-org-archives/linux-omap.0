From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v3.11-rc4: OMAP1/Amstrad Delta (E3) crash
Date: Fri, 9 Aug 2013 00:11:15 +0300
Message-ID: <20130808211114.GF15014@blackmetal.musicnaut.iki.fi>
References: <20130806232609.GB15014@blackmetal.musicnaut.iki.fi>
 <20130808110108.GK23053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:41557 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966575Ab3HHVLZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Aug 2013 17:11:25 -0400
Content-Disposition: inline
In-Reply-To: <20130808110108.GK23053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Thu, Aug 08, 2013 at 12:01:08PM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 07, 2013 at 02:26:09AM +0300, Aaro Koskinen wrote:
> > [    0.258589] [ffff1224] *pgd=00000000, *pte=11fff0cb000001f1, *ppte=11fff00a00000000
> 
> BTW, your oops dump is interesting for another reason - the above.
> You seem to have 64-bit page table entries above.

Yes, this is worrying...

> Now, this is totally legal C:
> 
> 	unsigned int val = 0x12345678;
> 
> 	printk("%08llx\n", (long long)val);
> 
> and it should produce "12345678" but I'm willing to bet with your compiler
> it produces "12345678xxxxxxxx" where xxxxxxxx is just what happens to be
> sitting in some register.  IOW, I think you have a compiler bug here.  Can
> you investigate what's going on with this yourself please?

I made a quick check and added that to the fault handler, and yes,
the result is crap:

+unsigned int test_bar = 0x12345678;
 void show_pte(struct mm_struct *mm, unsigned long addr)
 {
        pgd_t *pgd;
 
+       printk(KERN_INFO "%d\n", 0);
+       printk(KERN_INFO "%llx\n", (long long)test_bar);
+       printk(KERN_INFO "%d %llx\n", 1, (long long)test_bar);
[...]
[    0.261788] 0
[    0.263849] 1234567800000000
[    0.267201] 1 0

However, addings similar prints to early boot produces correct results:

+unsigned int test_foo = 0x12345678;
 void __init smp_setup_processor_id(void)
[...]
        printk(KERN_INFO "Booting Linux on physical CPU 0x%x\n", mpidr);
+       printk(KERN_INFO "%llx\n", (long long)test_foo);
+       printk(KERN_INFO "%d %llx\n", 1, (long long)test_foo);
[...]
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] 12345678
[    0.000000] 1 12345678

So I'm pretty confused. Anyway, I'll continue investigating this next week...

A.
