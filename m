From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Bridge issue #3! dma_alloc_coherent causing crash - pm branch
Date: Thu, 12 Mar 2009 17:34:44 -0700
Message-ID: <874oxy2rbv.fsf@deeprootsystems.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF51E360@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:49033 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbZCMAev (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 20:34:51 -0400
Received: by gxk7 with SMTP id 7so569919gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 17:34:49 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF51E360@dlee02.ent.ti.com> (Nishanth Menon's message of "Thu\, 12 Mar 2009 19\:23\:49 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org

"Menon, Nishanth" <nm@ti.com> writes:

> Hi Folks,
>
> I seem to be having (mis?)fortune of hitting every single roadblock on the way..
> After applying patches for list_del and the ioremap, I am attempting to loadup bridge in another (and hopefully the last possible way):
>
> insmod ./bridgedriver.ko shm_size=0x400000 phys_mempool_base=0 base_img=/lib/dsp/baseimage.dof
>
> to do this I need a large enough dma_alloc_coherent pool. So, I changed CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=10 from 2 to get myself enough space for the driver to do dma_alloc_coherent.
>
> Over some 20-30 iterations, I hit the following crash! I added trace printks to every single dma_alloc_coherent and frees in the bridge driver, and the alloc and frees match - so no obvious leaks or pointer corruptions..
>
> So, I wrote (yet another) dummy driver which allocates and frees the memory in the same order as the bridge does. The dummy driver functions correctly and does not crash after few 100s of iterations even!
>
> Now, interestingly at the start of every new iterations, the dummy driver gets the same virtual-physical address pair, but in the case of the bridge driver, the addresses change. I suspect that is a symptom of the problem though I do not know the reason why..

Just to clarify... your dummy driver works fine, but the bridge driver
crashes?

Sounds like a memory leak in the bridge driver to me.  I suggest you
enable memory leak debugging.  In Kconfig

   Kernel Hacking -->  Kernel debugging

Enable 'Debug slab memory allocations' and its child 'Memory leak
debugging'.  

Or, you could switch to the SLUB allocator which has some more flexible
debug options which can be controlled at boot-time from the cmdline.

While you are in the Kernel debugging menu, make sure you enable
'Verbose BUG()' and 'Verbose kernel errors'.  This will ensure that
any memory leaks will be dumped with some extra debug output.
    
Kevin

> Insights are most welcome..
>
> Details:
>
> Codebase:
> l-o pm branch + gitorious 
> + ioremap patch= http://marc.info/?l=linux-omap&m=123689459826837&w=2 (should be in pm branch soon)
> + autoload patch = http://marc.info/?l=linux-omap&m=123687157321175&w=2
> + list-del patch = http://marc.info/?l=linux-omap&m=123686780114707&w=2  (should be in pm branch soon)


> Bootargs:
> console=ttyS0,115200n8 noinitrd ip=dhcp root=/dev/nfs rw nfsroot=128.247.75.1:/home/fs/sdp3430,nolock,wsize=1024,rsize=1024 mem=64M
> (not that 64M matters in this case)
>
> Error:
> <4>insmod: page allocation failure. order:10, mode:0xd0
> insmod: page allocation failure. order:10, mode:0xd0
> [<c0031e20>] [<c0031e20>] (dump_stack+0x0/0x14) (dump_stack+0x0/0x14) from [<c0084318>] from [<c0084318>] (__alloc_pages_internal+0x384/0x39c)
> (__alloc_pages_internal+0x384/0x39c)
> [<c0083f94>] [<c0083f94>] (__alloc_pages_internal+0x0/0x39c) (__alloc_pages_internal+0x0/0x39c) from [<c00337e4>] from [<c00337e4>] (__dma_alloc+0x170/0x3c4)
> (__dma_alloc+0x170/0x3c4)
> [<c0033674>] [<c0033674>] (__dma_alloc+0x0/0x3c4) (__dma_alloc+0x0/0x3c4) from [<c0033ac4>] from [<c0033ac4>] (dma_alloc_coherent+0x58/0x64)
> (dma_alloc_coherent+0x58/0x64)
> [<c0033a6c>] [<c0033a6c>] (dma_alloc_coherent+0x0/0x64) (dma_alloc_coherent+0x0/0x64) from [<bf0f6224>] from [<bf0f6224>] (MEM_AllocPhysMem+0xc4/0xe4 [bridgedriver])
> (MEM_AllocPhysMem+0xc4/0xe4 [bridgedriver])
>  r7:c1bfdc5c r7:c1bfdc5c r6:48306a00 r6:48306a00 r5:c48aa000 r5:c48aa000 r4:bf11fe60 r4:bf11fe60
> [<bf0f6160>] [<bf0f6160>] (MEM_AllocPhysMem+0x0/0xe4 [bridgedriver]) (MEM_AllocPhysMem+0x0/0xe4 [bridgedriver]) from [<bf1072fc>] from [<bf1072fc>] (DRV_RequestResources+0x2c0/0)
> (DRV_RequestResources+0x2c0/0x370 [bridgedriver])
>  r7:48307000 r7:48307000 r6:48306a00 r6:48306a00 r5:c48aa000 r5:c48aa000 r4:00008000 r4:00008000
>
> [<bf10703c>] [<bf10703c>] (DRV_RequestResources+0x0/0x370 [bridgedriver]) (DRV_RequestResources+0x0/0x370 [bridgedriver]) from [<bf10daa0>] from [<bf10daa0>] (DSP_Init+0x68/0xf0)
> (DSP_Init+0x68/0xf0 [bridgedriver])
> [<bf10da38>] [<bf10da38>] (DSP_Init+0x0/0xf0 [bridgedriver]) (DSP_Init+0x0/0xf0 [bridgedriver]) from [<bf12338c>] from [<bf12338c>] (bridge_init+0x38c/0x3f4 [bridgedriver])
> (bridge_init+0x38c/0x3f4 [bridgedriver])
>  r6:bf11f750 r6:bf11f750 r5:1dcd6500 r5:1dcd6500 r4:bf120068 r4:bf120068
>
> [<bf123000>] [<bf123000>] (bridge_init+0x0/0x3f4 [bridgedriver]) (bridge_init+0x0/0x3f4 [bridgedriver]) from [<c002d2d4>] from [<c002d2d4>] (do_one_initcall+0x64/0x198)
> (do_one_initcall+0x64/0x198)
>  r8:c002df28 r8:c002df28 r7:00000000 r7:00000000 r6:4023a000 r6:4023a000 r5:bf11fa00 r5:bf11fa00 r4:c03aa340 r4:c03aa340
>
> [<c002d270>] [<c002d270>] (do_one_initcall+0x0/0x198) (do_one_initcall+0x0/0x198) from [<c0078cb4>] from [<c0078cb4>] (sys_init_module+0x98/0x188)
> (sys_init_module+0x98/0x188)
> [<c0078c1c>] [<c0078c1c>] (sys_init_module+0x0/0x188) (sys_init_module+0x0/0x188) from [<c002dd80>] from [<c002dd80>] (ret_fast_syscall+0x0/0x2c)
> (ret_fast_syscall+0x0/0x2c)
>  r7:00000080 r7:00000080 r6:00000000 r6:00000000 r5:0000000b r5:0000000b r4:00000000 r4:00000000
>
> Mem-info:
> Mem-info:
> Normal per-cpu:
> Normal per-cpu:
> CPU    0: hi:   18, btch:   3 usd:   2
> CPU    0: hi:   18, btch:   3 usd:   2
> Active_anon:0 active_file:0 inactive_anon:201
>  inactive_file:25 unevictable:0 dirty:0 writeback:0 unstable:0
>  free:14210 slab:468 mapped:0 pagetables:31 bounce:0
> Active_anon:0 active_file:0 inactive_anon:201
>  inactive_file:25 unevictable:0 dirty:0 writeback:0 unstable:0
>  free:14210 slab:468 mapped:0 pagetables:31 bounce:0
> Normal free:56840kB min:1016kB low:1268kB high:1524kB active_anon:0kB inactive_anon:804kB active_file:0kB inactive_file:100kB unevictable:0kB present:65024kB pages_scanned:0 allo
> Normal free:56840kB min:1016kB low:1268kB high:1524kB active_anon:0kB inactive_anon:804kB active_file:0kB inactive_file:100kB unevictable:0kB present:65024kB pages_scanned:0 allo
> lowmem_reserve[]:lowmem_reserve[]: 0 0 0 0
>
> Normal: Normal: 144*4kB 144*4kB 141*8kB 141*8kB 96*16kB 96*16kB 73*32kB 73*32kB 39*64kB 39*64kB 11*128kB 11*128kB 15*256kB 15*256kB 11*512kB 11*512kB 15*1024kB 15*1024kB 11*2048B
> = 56840kB
> 25 total pagecache pages
> 25 total pagecache pages
> 0 pages in swap cache
> 0 pages in swap cache
> Swap cache stats: add 0, delete 0, find 0/0
> Swap cache stats: add 0, delete 0, find 0/0
> Free swap  = 0kB
> Free swap  = 0kB
> Total swap = 0kB
> Total swap = 0kB
> 16384 pages of RAM
> 16384 pages of RAM
> 14301 free pages
> 14301 free pages
> 1112 reserved pages
> 1112 reserved pages
> 468 slab pages
> 468 slab pages
> 26 pages shared
> 26 pages shared
> 0 pages swap cached
> 0 pages swap cached
>
>
> Dummy driver:
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/slab.h>
> #include <linux/mm.h>
> #include <linux/dma-mapping.h>
>
> struct mem_s {
>         void *vir;
>         u32 phy;
>         u32 size;
> };
>
> static struct mem_s b[] = {
>         {0, 0, 4194304},
>         {0, 0, 4096},
>         {0, 0, 71680},
> };
>
> static int try;
> module_param(try, int, 0);
> MODULE_PARM_DESC(try, "try=3");
> static int rev;
> module_param(rev, int, 0);
> MODULE_PARM_DESC(rev, "rev=0");
>
> static int __init dummy_init(void)
> {
>         int i;
>         if (!try)
>                 try = (sizeof(b) / sizeof(struct mem_s));
>         if (try > (sizeof(b) / sizeof(struct mem_s))) {
>                 printk(KERN_ERR "Give me proper try value\n");
>                 return -EINVAL;
>         }
>         for (i = 0; i < try; i++) {
>                 b[i].vir =
>                     dma_alloc_coherent(NULL, b[i].size, &b[i].phy, GFP_KERNEL);
>                 printk(KERN_INFO
>                        "alloc[%d] - virt=0x%08X phy=0x%08X size=0x%08X\n", i,
>                        (u32) (b[i].vir), b[i].phy, b[i].size);
>                 if (b[i].vir == NULL) {
>                         printk(KERN_ERR "Allocation failed idx=%d\n", i);
>                         /* Free up all the prev allocs */
>                         i--;
>                         while (i >= 0) {
>                                 dma_free_coherent(NULL, b[i].size, b[i].vir,
>                                                   b[i].phy);
>                                 i--;
>                         }
>                         return -ENOMEM;
>
>                 }
>         }
>         return 0;
> }
> module_init(dummy_init);
>
> static void __exit dummy_exit(void)
> {
>         int i;
>         if (rev) {
>                 for (i = try - 1; i > -1; i--) {
>                         printk(KERN_INFO
>                                "free[%d] - virt=0x%08x phy=0x%08x size=0x%08x\n",
>                                i, (u32) b[i].vir, b[i].phy, b[i].size);
>                         dma_free_coherent(NULL, b[i].size, b[i].vir, b[i].phy);
>                 }
>         } else {
>                 for (i = 0; i < try; i++) {
>                         printk(KERN_INFO
>                                "free[%d] - virt=0x%08x phy=0x%08x size=0x%08x\n",
>                                i, (u32) b[i].vir, b[i].phy, b[i].size);
>                         dma_free_coherent(NULL, b[i].size, b[i].vir, b[i].phy);
>                 }
>         }
> }
> module_exit(dummy_exit);
>
> MODULE_LICENSE("GPL");
>
> #!/bin/bash
> slee()
> {
>         echo "Sleep "
> #sleep 5
> }
> try=1
> r=0
> while [ $try -lt 4 ]; do
>         i=0
>         while [ $i -lt 100 ]; do
>                 echo "insmod $i try=$try rev=$r"
>                 insmod  ./dummy.ko try=$try
>                 if [ $? -ne 0 ]; then
>                         echo "QUIT IN INSMOD $i"
>                         exit 1;
>                 fi
>                 slee
>                 echo "rmmod $i"
>                 rmmod dummy
>                 if [ $? -ne 0 ]; then
>                         echo "QUIT IN RMMOD $i"
>                         exit 1;
>                 fi
>                 i=`expr $i + 1`
>                 slee
>                 if [ $r -eq 0 ]; then
>                         r=1
>                 else
>                         r=0
>                 fi
>         done
>         try=$(( $try + 1 ))
> done
>
>
> Now comparing the physical addresses allocated: 
> Dummy Driver:
> Insmod:
> alloc[0] - virt=0xFF427000 phy=0x83C00000 size=0x00400000
> alloc[1] - virt=0xFF827000 phy=0x83A45000 size=0x00001000
> alloc[2] - virt=0xFF828000 phy=0x83A60000 size=0x00011800
> rmmod:
> free[0] - virt=0xff427000 phy=0x83c00000 size=0x00400000
> free[1] - virt=0xff827000 phy=0x83a45000 size=0x00001000
> free[2] - virt=0xff828000 phy=0x83a60000 size=0x00011800
> [All iterations have the same output]
>
> Vs bridgedriver:(prints are generated by modifying drivers/dsp/bridge/services/mem.c
>
> <iteration 0>
> insmod
> DMA_ALLOC_COH:MEM_AllocPhysMem369:virt=ff427000,phy=83c00000,size=4194304 1
> DMA_ALLOC_COH:MEM_AllocPhysMem369:virt=ff827000,phy=83b4a000,size=4096 1
> DMA_ALLOC_COH:MEM_AllocPhysMem369:virt=ff828000,phy=83360000,size=71680 1
> rmmod
> DMA_ALLOC_FREE:MEM_FreePhysMem578:virt=ff828000,phy=83360000,size=71680
> DMA_ALLOC_FREE:MEM_FreePhysMem578:virt=ff827000,phy=83b4a000,size=4096
> DMA_ALLOC_FREE:MEM_FreePhysMem578:virt=ff427000,phy=83c00000,size=4194304
>
> <iteration 1>
> insmod
> DMA_ALLOC_COH:MEM_AllocPhysMem369:virt=ff427000,phy=82400000,size=4194304 1
> DMA_ALLOC_COH:MEM_AllocPhysMem369:virt=ff827000,phy=83bf9000,size=4096 1
> DMA_ALLOC_COH:MEM_AllocPhysMem369:virt=ff828000,phy=83320000,size=71680 1
> rmmmod
> DMA_ALLOC_FREE:MEM_FreePhysMem578:virt=ff828000,phy=83320000,size=71680
> DMA_ALLOC_FREE:MEM_FreePhysMem578:virt=ff827000,phy=83bf9000,size=4096
> DMA_ALLOC_FREE:MEM_FreePhysMem578:virt=ff427000,phy=82400000,size=4194304
>
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
