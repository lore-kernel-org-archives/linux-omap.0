From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] ARM: OMAP: DSP Gateway 3.3.1
Date: Fri, 15 Sep 2006 00:37:40 -0700 (PDT)
Message-ID: <20060915073740.66435.qmail@web37906.mail.mud.yahoo.com>
References: <7AF192DA69C59243838FF62851F64F5502DD1E31@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7AF192DA69C59243838FF62851F64F5502DD1E31@toebe101.NOE.Nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Toshihiro.Kobayashi@nokia.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Toshihiro.Kobayashi@nokia.com wrote:

> Hi,
> 
> Here's the patch that updates DSP Gateway driver to 3.3.1,
> that supports omap2 DSP.
> It also contains generic mailbox interface
> considering IVA use on 2420, but this patch
> itself doesn't contain any IVA driver.
> 
> Regarding omap2, this code is tested
> only on our 2420 custom board,
> so feedbacks from testing on other chips /
> boards will be greatly appreciated.
> 
> I'd aplogize for the bzip-ed attachement, since
> it's too large to send as a plain text.
> 

First cut review:

+#ifdef CONFIG_ARCH_OMAP24XX
+       if (cpu_is_omap24xx()) {
+               dspmem_base = DSP_MEM_24XX_VIRT;
+               dspmem_size = DSP_MEM_24XX_SIZE;
...

Are you thinking of getting above information and irqs to arch specific
resources? devices.c?

+#if defined(CONFIG_ARCH_OMAP1)
 EXPORT_SYMBOL(dsp_ck_handle);
 EXPORT_SYMBOL(api_ck_handle);
+#elif defined(CONFIG_ARCH_OMAP2)
+EXPORT_SYMBOL(dsp_fck_handle);
+EXPORT_SYMBOL(dsp_ick_handle);
+#endif

After looking this and lots of #ifdefers dsp_common.c doesn't 
look common ;-). There should be some way to separate them in arch-*
specific files.

More-or-less getting into the shape like mcbsp.c.
...

dsp_ctl.c

device_create_file(&dsp_device.dev, &dev_attr_ifver);
device_create_file(&dsp_device.dev, &dev_attr_cpustat);

error checking for these files...and same for other places?

+#define SZ_4KB 0x1000
+#define SZ_64KB  0x10000
+#define SZ_1MB 0x100000
+#define SZ_16MB  0x1000000

I think we utilizes sizes.h #defines instead.

+#ifdef CONFIG_ARCH_OMAP2
+       exmap_setup_iomap_page(OMAP24XX_PRCM_BASE,     0x7000, n++);
+#ifdef CONFIG_ARCH_OMAP2420
+       exmap_setup_iomap_page(OMAP2420_GPT5_BASE,     0xe000, n++);
+       exmap_setup_iomap_page(OMAP2420_GPT6_BASE,     0xe800, n++);
+       exmap_setup_iomap_page(OMAP2420_GPT7_BASE,     0xf000, n++);
+       exmap_setup_iomap_page(OMAP2420_GPT8_BASE,     0xf800, n++);

As above registers are not mapped to DSP in OMAP2 case, we are mapping
it manually to DSP MMU (and same applies for IVA). 

How do you decide 0x7000 as offset for that mapping? 

Also, for each entry you map into the DSP MMU, the code also exmaps
the same entry to ARM MMU (DSP shadow space area - 16MB). Then each
process on arm side gets (4GB - 16MB) virt. space ?

We can't scale this idea for IVA (2GB virt. space), also, IVA MMU
sees these virtual memory from 0x0000 0000 - 0x7fff ffff and IVA
MPU as L3 space (0x8000 0000 - 0xffff: ffff), so address passed
from ARM side always needs to be subtracted from 0x8000 0000 to
get the address seen by IVA MMU.

+        */
+       ret = request_irq(INT_DSP_MMU, dsp_mmu_interrupt, SA_INTERRUPT,
"dsp",
+                         &devid_mmu);

No SA_* flags please. Replace it once you rebase it to latest git tree.


+       /* correspinding file struct isn't found in the list ???  */
                ^^^
Spelling mistake.

Mailbox framework - I think this still contains lots of #ifdefers,
instead those changes can be moved to arch-omap[1/2]/mailbox.c
implementation, and in-turn they will register with common
plat-omap/mailbox.c framework.

class devices are used at several places, but it is going to removed
in 2.6.20 kernel.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
