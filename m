From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: DSPBRIDGE+BRIDGE_DVFS: Crashes on multiple reload
Date: Wed, 11 Mar 2009 11:55:05 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF4900B9@dlee02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF48FEA4@dlee02.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162037B763A5A@dlee02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0CFF490055@dlee02.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162037B763B7D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40827 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbZCKQzN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 12:55:13 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037B763B7D@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: ext Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

> -----Original Message-----
> From: Woodruff, Richard
> Sent: Wednesday, March 11, 2009 6:40 PM
> To: Menon, Nishanth; linux-omap@vger.kernel.org
> Cc: ext Paul Walmsley; Nayak, Rajendra; Gupta, Ramesh
> Subject: RE: DSPBRIDGE+BRIDGE_DVFS: Crashes on multiple reload
>
> > It does not make sense for clock notifier_registration to oops out.. it
> has'nt
> > come out of init even..
> >
> > This looks like list_del missing in clock_notifier unregistration
> function :(.
> > I have a patch in place.. sending in a few mins
> 
> Yes.  Side issue I pointed out will come up later.  If notifier doesn't
> work there might be a few bugs its useable.

Would this appear as the following crash (after 14-18 iterations now with my clk_notifer_unregister patch):

Unable to handle kernel paging request at virtual address 80200800
pgd = c3eb8000
*pgd=00000000[80200800]
Internal error: Oops: 5 [#1]
Modules linked in:Modules linked in: [last unloaded: bridgedriver] [last unloaded: bridgedriver]

CPU: 0    Not tainted  (2.6.28-omap1-00211-gcb75442-dirty #6)
PC is at vmap_page_range+0xe4/0x1c4
LR is at vmap_page_range+0x160/0x1c4
pc : [<c0096fe8>]    lr : [<c0097064>]    psr: 80000013
<snip>

Backtrace: Backtrace:

[<c0096f04>] [<c0096f04>] (vmap_page_range+0x0/0x1c4) (vmap_page_range+0x0/0x1c4) from [<c00970f0>] from [<c00970f0>] (map_vm_area+0x28/0x40)
(map_vm_area+0x28/0x40)
[<c00970c8>] [<c00970c8>] (map_vm_area+0x0/0x40) (map_vm_area+0x0/0x40) from [<c009720c>] from [<c009720c>] (__vmalloc_area_node+0x104/0x130)
(__vmalloc_area_node+0x104/0x130)
 r5:c39e1460 r5:c39e1460 r4:000003a8 r4:000003a8

[<c0097108>] [<c0097108>] (__vmalloc_area_node+0x0/0x130) (__vmalloc_area_node+0x0/0x130) from [<c00972c8>] from [<c00972c8>] (__vmalloc_node+0x90/0xa8)
(__vmalloc_node+0x90/0xa8)
[<c0097238>] [<c0097238>] (__vmalloc_node+0x0/0xa8) (__vmalloc_node+0x0/0xa8) from [<c009733c>] from [<c009733c>] (vmalloc+0x28/0x34)
(vmalloc+0x28/0x34)
 r7:00000000 r7:00000000 r6:4023a000 r6:4023a000 r5:003a75f0 r5:003a75f0 r4:4023a000 r4:4023a000

[<c0097314>] [<c0097314>] (vmalloc+0x0/0x34) (vmalloc+0x0/0x34) from [<c0077808>] from [<c0077808>] (load_module+0x34/0x1468)
(load_module+0x34/0x1468)
[<c00777d4>] [<c00777d4>] (load_module+0x0/0x1468) (load_module+0x0/0x1468) from [<c0078c90>] from [<c0078c90>] (sys_init_module+0x54/0x188)
(sys_init_module+0x54/0x188)
[<c0078c3c>] [<c0078c3c>] (sys_init_module+0x0/0x188) (sys_init_module+0x0/0x188) from [<c002dd80>] from [<c002dd80>] (ret_fast_syscall+0x0/0x2c)
(ret_fast_syscall+0x0/0x2c)
 r7:00000080 r7:00000080 r6:00000000 r6:00000000 r5:0000000b r5:0000000b r4:00000000 r4:00000000

Code: Code: 0a000024 0a000024 e51b1030 e51b1030 e51b303c e51b303c e0836101 e0836101 (e5952000) (e5952000)


Regards,
Nishanth Menon
