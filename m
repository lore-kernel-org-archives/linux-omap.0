From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: dma_declare_coherent_memory fails for RAM allocated memory
Date: Sun, 29 May 2016 17:56:02 +0300
Message-ID: <574B0302.3010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, brian.starkey@arm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

When trying to declare and use DT reserved memory region on ARM (OMAP3), 
dma_declare_coherent_memory() fails in memremap(). This is from today's 
master:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/memremap.c:111 memremap+0x118/0x194
memremap attempted on ram 0x8f800000 size: 0x700000
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.6.0+ #15
Hardware name: Nokia RX-51 board
[<c010bc30>] (unwind_backtrace) from [<c0109f70>] (show_stack+0x10/0x14)
[<c0109f70>] (show_stack) from [<c0126d80>] (__warn+0xcc/0xf8)
[<c0126d80>] (__warn) from [<c0126e40>] (warn_slowpath_fmt+0x34/0x44)
[<c0126e40>] (warn_slowpath_fmt) from [<c019c8d4>] (memremap+0x118/0x194)
[<c019c8d4>] (memremap) from [<c03b88fc>] 
(dma_init_coherent_memory+0x48/0x104)
[<c03b88fc>] (dma_init_coherent_memory) from [<c03b89e4>] 
(dma_declare_coherent_memory+0x2c/0x68)
[<c03b89e4>] (dma_declare_coherent_memory) from [<c0115c0c>] 
(rmem_omapfb_device_init+0x34/0x64)
[<c0115c0c>] (rmem_omapfb_device_init) from [<c045b0f8>] 
(of_reserved_mem_device_init+0x94/0xd8)
[<c045b0f8>] (of_reserved_mem_device_init) from [<c080aaf8>] 
(omapdss_init_of+0xe4/0x154)
[<c080aaf8>] (omapdss_init_of) from [<c08033f4>] 
(customize_machine+0x20/0x44)
[<c08033f4>] (customize_machine) from [<c01016b8>] 
(do_one_initcall+0xac/0x158)
[<c01016b8>] (do_one_initcall) from [<c0800d64>] 
(kernel_init_freeable+0xf8/0x1c8)
[<c0800d64>] (kernel_init_freeable) from [<c05519dc>] 
(kernel_init+0x8/0x110)
[<c05519dc>] (kernel_init) from [<c0107258>] (ret_from_fork+0x14/0x3c)
---[ end trace 73a8c076df72166b ]---
omapfb: dma_declare_coherent_memory failed


The failing code looks like:
.
.
.
static int rmem_omapfb_device_init(struct reserved_mem *rmem, struct 
device *dev)
{
	int dma;

	if (rmem->priv)
		return 0;

	dma = dma_declare_coherent_memory(&omap_fb_device.dev, rmem->base,
					  rmem->base, rmem->size,
					  DMA_MEMORY_MAP |
					  DMA_MEMORY_EXCLUSIVE);
	if (!(dma & DMA_MEMORY_MAP)) {
			pr_err("omapfb: dma_declare_coherent_memory failed\n");
			return -ENOMEM;
	}
	else
		rmem->priv = omap_fb_device.dev.dma_mem;

	return 0;
}

static void rmem_omapfb_device_release(struct reserved_mem *rmem,
				       struct device *dev)
{
	dma_release_declared_memory(&omap_fb_device.dev);
}

static const struct reserved_mem_ops rmem_omapfb_ops = {
	.device_init    = rmem_omapfb_device_init,
	.device_release = rmem_omapfb_device_release,
};

static int __init rmem_omapfb_setup(struct reserved_mem *rmem)
{
	rmem->ops = &rmem_omapfb_ops;
	pr_info("omapfb: reserved %d bytes at %pa\n", rmem->size, &rmem->base);

	return 0;
}

RESERVEDMEM_OF_DECLARE(dss, "ti,omapfb-memsize", rmem_omapfb_setup);


It turns out that dma_init_coherent_memory calls memremap with 
MEMREMAP_WC flag, which is disallowed for RAM IIUC.

I quickly hacked some code to fix the issue, but as memremap API is 
relatively new(esp to me), I wonder if this is the correct way to go:

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index bdf28f7..04b1687 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -5,6 +5,7 @@
  #include <linux/io.h>
  #include <linux/slab.h>
  #include <linux/kernel.h>
+#include <linux/memblock.h>
  #include <linux/module.h>
  #include <linux/dma-mapping.h>

@@ -32,8 +33,12 @@ static bool dma_init_coherent_memory(
         if (!size)
                 goto out;

-       if (flags & DMA_MEMORY_MAP)
-               mem_base = memremap(phys_addr, size, MEMREMAP_WC);
+       if (flags & DMA_MEMORY_MAP) {
+               unsigned long map_type = memblock_is_map_memory(phys_addr) ?
+                                                MEMREMAP_WB : MEMREMAP_WC;
+
+               mem_base = memremap(phys_addr, size, map_type);
+       }
         else
                 mem_base = ioremap(phys_addr, size);
         if (!mem_base)

Does the above code looks sane? How to fix the problem if not?

Thanks,
Ivo
