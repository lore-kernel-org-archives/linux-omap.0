From: Dave Young <dyoung@redhat.com>
Subject: Re: bbb kexec bug: Unhandled fault external abort on non-linefetch
 (0x1028) at 0xfa1ac140
Date: Sat, 2 Jan 2016 15:02:31 +0800
Message-ID: <20160102070231.GA23855@dhcp-128-65.nay.redhat.com>
References: <20151227073840.GC23608@dhcp-128-65.nay.redhat.com>
 <20151228071809.GA20621@dhcp-128-65.nay.redhat.com>
 <568127FE.3010001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <568127FE.3010001@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap@vger.kernel.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi, Grygorii

Thanks fot your reply.

On 12/28/15 at 02:15pm, Grygorii Strashko wrote:
> On 12/28/2015 09:18 AM, Dave Young wrote:
> > On 12/27/15 at 03:38pm, Dave Young wrote:
> >> Here is what I get when I test kdump on Beagle bone black:
> >>
> >> Added a printk line at the begin of function omap_gpio_rmw:
> >> printk("########## %lx, %x, %x\n", base, reg, mask);
> >>
> >> Any hints how to fix it? I tried call the machine_kexec_mask_interrupts
> >> at runtime kernel also panics so it may not limit to kdump case.
> >>
> >> [   66.340168] ########## fa1ac000, 140, 1
> >> [   66.344456] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa1ac140
> >> [   66.352142] pgd = dd9f0000
> 
> [...]
> 
> >> [   66.727278] [<c01f2276>] (omap_set_gpio_triggering) from [<c01f2551>] (omap_gpio_mask_irq+0x29/0x34)
> 
> Usually such back-trace means that you are trying to access HW
> which is disabled (powered off) already. Or this HW IP has never been enabled.

It is possible, but how to detect such disabled gpio in this for_each_irq_desc
loop? I tried below, it works for me but I'm not sure if it is a right fix.

---
 arch/arm/kernel/machine_kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux.orig/arch/arm/kernel/machine_kexec.c
+++ linux/arch/arm/kernel/machine_kexec.c
@@ -106,7 +106,7 @@ static void machine_kexec_mask_interrupt
 		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
 			chip->irq_eoi(&desc->irq_data);
 
-		if (chip->irq_mask)
+		if ((chip->irq_mask) && !irqd_irq_masked(&desc->irq_data))
 			chip->irq_mask(&desc->irq_data);
 
 		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))

> 
> >> [   66.736457] [<c01f2551>] (omap_gpio_mask_irq) from [<c0012f35>] (machine_crash_shutdown+0xb9/0x104)
> >> [   66.745551] [<c0012f35>] (machine_crash_shutdown) from [<c00803fd>] (crash_kexec+0x35/0x68)
> >> [   66.753942] [<c00803fd>] (crash_kexec) from [<c0010f51>] (die+0x1b9/0x390)
> >> [   66.760859] [<c0010f51>] (die) from [<c001bc23>] (__do_kernel_fault.part.0+0x4f/0x1cc)
> >> [   66.768824] [<c001bc23>] (__do_kernel_fault.part.0) from [<c0412e11>] (do_page_fault+0x155/0x29c)
> >> [   66.777740] [<c0412e11>] (do_page_fault) from [<c00091ff>] (do_DataAbort+0x2f/0x88)
> >> [   66.785432] [<c00091ff>] (do_DataAbort) from [<c041247b>] (__dabt_svc+0x3b/0x80)
> >> [   66.792858] Exception stack(0xddc39e58 to 0xddc39ea0)
> >> [   66.797929] 9e40:                                                       00000063 df93647c
> >> [   66.806144] 9e60: 1f26a000 00000000 00000001 00000063 00000007 c0702e3c 00000000 ddc38000
> >> [   66.814359] 9e80: 00000000 7f70d614 00000030 ddc39ea8 c021e54b c021e54c 600e0033 ffffffff
> >> [   66.822575] [<c041247b>] (__dabt_svc) from [<c021e54c>] (sysrq_handle_crash+0x18/0x1c)
> >> [   66.830530] [<c021e54c>] (sysrq_handle_crash) from [<c021e8b5>] (__handle_sysrq+0x79/0x10c)
> >> [   66.838919] [<c021e8b5>] (__handle_sysrq) from [<c021ec79>] (write_sysrq_trigger+0x45/0x50)
> >> [   66.847310] [<c021ec79>] (write_sysrq_trigger) from [<c010695f>] (proc_reg_write+0x43/0x68)
> >> [   66.855700] [<c010695f>] (proc_reg_write) from [<c00ca6a3>] (__vfs_write+0xf/0x8c)
> >> [   66.863304] [<c00ca6a3>] (__vfs_write) from [<c00cacd7>] (vfs_write+0x5f/0x128)
> >> [   66.870646] [<c00cacd7>] (vfs_write) from [<c00cb313>] (SyS_write+0x2b/0x68)
> >> [   66.877729] [<c00cb313>] (SyS_write) from [<c000ddc1>] (ret_fast_syscall+0x1/0x4c)
> >> [   66.885332] Code: 443c 4643 f6a9 f9a1 (6823) 0732
> >> [   66.890145] ---[ end trace 5a39094ece4dc200 ]---
> >> [   66.894782] Kernel panic - not syncing: Fatal exception
> >> [   66.900033] ---[ end Kernel panic - not syncing: Fatal exception
> >>
> 
> 
> -- 
> regards,
> -grygorii

Thanks
Dave
