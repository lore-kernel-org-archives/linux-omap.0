From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: DSPBRIDGE+BRIDGE_DVFS: Crashes on multiple reload
Date: Wed, 11 Mar 2009 21:28:27 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A8F2BC34@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAE596C2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48718 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbZCKP7P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 11:59:15 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAE596C2@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: ext Paul Walmsley <paul@pwsan.com>

Rajendra,
 

> -----Original Message-----
> From: Nayak, Rajendra 
> Sent: Wednesday, March 11, 2009 9:25 PM
> To: Menon, Nishanth; linux-omap@vger.kernel.org
> Cc: ext Paul Walmsley; Gupta, Ramesh
> Subject: RE: DSPBRIDGE+BRIDGE_DVFS: Crashes on multiple reload
> 
> Does the bridge driver call a clk_notifier_unregister on the 
> exit path?

Yes, it is called.

> 
> > CPU: 0    Not tainted  (2.6.28-omap1-00211-gcb75442 #1)
> > PC is at clk_notifier_register+0x68/0x108 LR is at 
> > kmem_cache_alloc+0x7c/0x84
> 
> Taking an objdump of clock.o shows me it probably is crashing 
> some place while trying to traverse through the existing list 
> of registered notifiers. It could very well be that one of 
> these is an old function pointer registered by the previous 
> insmod of the bridge driver.

 
> 
> > -----Original Message-----
> > From: Menon, Nishanth
> > Sent: Wednesday, March 11, 2009 8:21 PM
> > To: linux-omap@vger.kernel.org
> > Cc: ext Paul Walmsley; Nayak, Rajendra; Gupta, Ramesh
> > Subject: DSPBRIDGE+BRIDGE_DVFS: Crashes on multiple reload
> > 
> > Hi Folks,
> > 
> > With the latest linux-omap pm + gitorious bridge changes on 
> SDP3430, 
> > enabling BRIDGE_DVFS and SRF seems to cause an issue with clock 
> > notifier.. I am not entirely of the cause of the issue(don't have a 
> > debugger handy at the moment :( ): The condition is reproducible on 
> > exactly the third insmod of the driver as explained below. 
> Looking for 
> > any advice to fix this issue :(
> > 
> > 
> > Codebase:
> > git clone
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-oma
> > p-2.6.git
> > git checkout -b pm --track origin/pm
> > git fetch git://gitorious.org/lk/mainline.git
> > tidspbridge-pm:tidspbridge-pm
> > git checkout tidspbridge-pm
> > git merge pm
> > 
> > defconfig:
> > essentially omap_3430sdp_defconfig, enable SRF and
> > bridge+bridge_dvfs. (diff b/w defconfig and .config attached).
> > 
> > Bootargs:
> > console=ttyS0,115200n8 noinitrd ip=dhcp root=/dev/nfs rw
> > nfsroot=<myIP>:<myFS>,nolock,wsize=1024,rsize=1024 mem=64M
> > 
> > The error:
> > insmod  ./bridgedriver.ko phys_mempool_base=0x87000000 
> > phys_mempool_size=0x600000 rmmod bridgedriver insmod  
> > ./bridgedriver.ko phys_mempool_base=0x87000000 
> > phys_mempool_size=0x600000 rmmod bridgedriver insmod  
> > ./bridgedriver.ko phys_mempool_base=0x87000000 
> > phys_mempool_size=0x600000
> > 
> > Unable to handle kernel paging request at virtual address 
> 756e696c pgd 
> > = c3e0c000 *pgd=00000000[756e696c]
> > 
> > Internal error: Oops: 5 [#1]
> > Modules linked in:Modules linked in: bridgedriver(+)
> > bridgedriver(+) [last unloaded: bridgedriver] [last unloaded: 
> > bridgedriver]
> > 
> > CPU: 0    Not tainted  (2.6.28-omap1-00211-gcb75442 #1)
> > PC is at clk_notifier_register+0x68/0x108 LR is at 
> > kmem_cache_alloc+0x7c/0x84
> > pc : [<c003f684>]    lr : [<c009f574>]    psr: 00000093
> > sp : c3e05da0  ip : c3e0b3e0  fp : c3e05dbc <snip>
> > 
> > Backtrace: Backtrace:
> > 
> > [<c003f61c>] [<c003f61c>] (clk_notifier_register+0x0/0x108)
> > (clk_notifier_register+0x0/0x108) from [<bf08d394>] from 
> [<bf08d394>] 
> > (bridge_init+0x394/0x3ec [bridgedriver]) (bridge_init+0x394/0x3ec 
> > [bridgedriver])  r7:00000000 r7:00000000 r6:bf08ab88 r6:bf08ab88 
> > r5:1dcd6500 r5:1dcd6500 r4:0ee6b280 r4:0ee6b280
> > 
> > [<bf08d000>] [<bf08d000>] (bridge_init+0x0/0x3ec
> > [bridgedriver]) (bridge_init+0x0/0x3ec [bridgedriver]) from 
> > [<c002d2d4>] from [<c002d2d4>] (do_one_initcall+0x64/0x198)
> > (do_one_initcall+0x64/0x198)
> >  r8:c002df28 r8:c002df28 r7:00000000 r7:00000000 r6:4023a000 
> > r6:4023a000 r5:bf08a520 r5:bf08a520 r4:c03aa340 r4:c03aa340
> > 
> > [<c002d270>] [<c002d270>] (do_one_initcall+0x0/0x198)
> > (do_one_initcall+0x0/0x198) from [<c0078cac>] from [<c0078cac>] 
> > (sys_init_module+0x98/0x188)
> > (sys_init_module+0x98/0x188)
> > [<c0078c14>] [<c0078c14>] (sys_init_module+0x0/0x188)
> > (sys_init_module+0x0/0x188) from [<c002dd80>] from [<c002dd80>] 
> > (ret_fast_syscall+0x0/0x2c)
> > (ret_fast_syscall+0x0/0x2c)
> >  r7:00000080 r7:00000080 r6:00000000 r6:00000000 r5:0000000b 
> > r5:0000000b r4:00000000 r4:00000000
> > 
> > Code: Code: e5943000 e5943000 e1530006 e1530006 0a000005
> > 0a000005 e2424008 e2424008 (e5942008) (e5942008)
> > 
> > <4>---[ end trace c53b9e94a29571d4 ]--- ---[ end trace 
> > c53b9e94a29571d4 ]--- Segmentation fault
> > 
> > 
> > Regards,
> > Nishanth Menon
> > 

Regards
Ramesh Gupta G