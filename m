From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v3.11-rc4: OMAP1/Amstrad Delta (E3) crash
Date: Fri, 9 Aug 2013 01:28:54 +0300
Message-ID: <20130808222854.GG15014@blackmetal.musicnaut.iki.fi>
References: <20130806232609.GB15014@blackmetal.musicnaut.iki.fi>
 <20130808110108.GK23053@n2100.arm.linux.org.uk>
 <20130808211114.GF15014@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:42824 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966749Ab3HHW3D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Aug 2013 18:29:03 -0400
Content-Disposition: inline
In-Reply-To: <20130808211114.GF15014@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Aug 09, 2013 at 12:11:15AM +0300, Aaro Koskinen wrote:
> On Thu, Aug 08, 2013 at 12:01:08PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Aug 07, 2013 at 02:26:09AM +0300, Aaro Koskinen wrote:
> > > [    0.258589] [ffff1224] *pgd=00000000, *pte=11fff0cb000001f1, *ppte=11fff00a00000000
> > 
> > BTW, your oops dump is interesting for another reason - the above.
> > You seem to have 64-bit page table entries above.
> 
> Yes, this is worrying...
> 
> > Now, this is totally legal C:
> > 
> > 	unsigned int val = 0x12345678;
> > 
> > 	printk("%08llx\n", (long long)val);
> > 
> > and it should produce "12345678" but I'm willing to bet with your compiler
> > it produces "12345678xxxxxxxx" where xxxxxxxx is just what happens to be
> > sitting in some register.  IOW, I think you have a compiler bug here.  Can
> > you investigate what's going on with this yourself please?
> 
> I made a quick check and added that to the fault handler, and yes,
> the result is crap:
> 
> +unsigned int test_bar = 0x12345678;
>  void show_pte(struct mm_struct *mm, unsigned long addr)
>  {
>         pgd_t *pgd;
>  
> +       printk(KERN_INFO "%d\n", 0);
> +       printk(KERN_INFO "%llx\n", (long long)test_bar);
> +       printk(KERN_INFO "%d %llx\n", 1, (long long)test_bar);
> [...]
> [    0.261788] 0
> [    0.263849] 1234567800000000
> [    0.267201] 1 0

Still one more thing. Once I apply the FIQ patch and initiate a crash
from userspace, results are as expected:

# echo c > /proc/sysrq-trigger
[   75.547504] SysRq : Trigger a crash
[   75.562891] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   75.594259] 0
[   75.607326] 12345678
[   75.620607] 1 12345678
[   75.633818] pgd = c10f0000
[   75.647114] [00000000] *pgd=1195d831, *pte=00000000, *ppte=00000000

A.
