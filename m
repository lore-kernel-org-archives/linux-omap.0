From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [DSPBRIDGE] Staging TODO List
Date: Mon, 4 May 2009 20:48:48 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53040B66B4EA@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53040B56E126@dlee03.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A53040B56E128@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53655 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbZEEBsy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2009 21:48:54 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n451moZC031290
	for <linux-omap@vger.kernel.org>; Mon, 4 May 2009 20:48:55 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n451mnmK013936
	for <linux-omap@vger.kernel.org>; Mon, 4 May 2009 20:48:49 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n451mnPj000369
	for <linux-omap@vger.kernel.org>; Mon, 4 May 2009 20:48:49 -0500 (CDT)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53040B56E128@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi All,

I think I have a more organized list of TODO tasks, which it is being hosted at omapzoom tracker:

https://www.omapzoom.org/gf/project/omapbridge/tracker/

Please comment or feel free to contribute with patches, bug reports or feedback.

Thanks to the people who provided comments for this initial version.

- omar

---

                        DSP Bridge TODO list

Architecture and Design
=======================

Remove custom implementations from Services layer
------------------------------------------------
Bridge driver is composed of many modules which are tightly related, these
modules could be less dependent by getting rid of the "Services" (formerly
know as OSAL - OS Abstraction Layer) layer.

* List Module
  -----------
  (drivers/dsp/bridge/services/list.c)
  The kernel already contains an implementation for double linked list, bridge
  could use that to deprecate its custom implementation.

Previous approach (HK) showed that bridge can replace its list implementation,
by reworking some of its internal structures.

* Mem Module
  ----------
  (drivers/dsp/bridge/services/mem.c)
  Some of bridge calls are direct wrappers plus debugging features (memory leak
  detection).

It seems the functionality is implemented by the kernel, a good feature would
be lost by removing wrappers (memory leak detection), but there is a patch under
review which might help to replace the memory leak feature:
[Kernel memory leak detector] http://thread.gmane.org/gmane.linux.kernel/827196

Seems to be existing mempool APIs to switch from using dma_alloc_coherent,
does this fit the driver needs?

There is a patch (HD) that makes a separate module to register platform
information, this also takes care of reserving a mempool at kernel bootup, are
module parameters still needed for this?

(RMK) MEM_FlushCache() exposes DMA specific cache handling for non-DMA
purposes.  This can only be used with kernel direct-mapped addresses, not
userspace nor some remapped virtual addresses.

* Kfile Module
  ------------
  (drivers/dsp/bridge/services/kfile.c)

Some functions are provided by the kernel, these can be removed once the doff
loader is ported to userspace.

* Dbg Module
  ----------
  (drivers/dsp/bridge/services/dbg.c)
  
Core of the bridge debug tracing, it provides a useful method of runtime
debugging.

Need to explore about the following options:
For code flow debugging, ftrace can be used.
For module level debbuging DYNAMIC_DEBUG(2.6.30), DYNAMIC_PRINTK_DEBUG (<2.6.30)
can be used.

* Dpc Module
  ----------
  (drivers/dsp/bridge/services/dpc.c)
  
Call tasklet functions directly instead.

* Ntfy Module
  -----------
  (drivers/dsp/bridge/services/ntfy.c)

Homebrewed wrappers should be removed.

* Sync Module
  -----------
  (drivers/dsp/bridge/services/sync.c)

Homebrewed wrappers should be removed.

* Reg Module
  ----------
  (drivers/dsp/bridge/services/reg.c)

Homebrewed wrappers should be removed.

* Clk module
  ----------
  (drivers/dsp/bridge/services/clk.c)

Clock module either to be removed or to use other clock interface. This needs
to be further analyzed, bridge wrappers are needed to maintain internal handle
references to the clocks.

Use count of other peripherals should also be taken care of. Maybe more general
framework should take care of this, not specific to clk usecount. This needs more
analysis. [HD]


(RMK) Do NOT Allow invalidation/flushing of _any_ region of memory via ioctl
----------------------------------------------------------------------------
(drivers/dsp/bridge/rmgr/proc.c)
Exposes MEM_FlushCache() via PROC_FlushMemory() and PROC_InvalidateMemory().

(drivers/dsp/bridge/pmgr/wcd.c)
Exposes PROC_FlushMemory() and PROC_InvalidateMemory via
PROCWRAP_FlushMemory() PROCWRAP_InvalidateMemory() respectively, which then
allows them to be called without any argument checking from userspace. 
This allows direct unchecked access to functions which can discard any kernel
data from userspace.  Not only is this a security issue, but has no isolation
from buggy usage.

Why would userspace want to know about kernel addresses?


(RMK) IOCTL numbers not correctly defined
-----------------------------------------
(arch/arm/plat-omap/include/dspbridge/wmdioctl.h)
should be defined using _IO(), _IOR() for those that read arguments,
_IOW() for those which write arguments, and _IORW() for those which read
and write their arguments.


Move doff binary loader to userspace
------------------------------------
Binary doff files should be handled outside the kernel, for this to happen
Kfile module must be decoupled from bridge driver.


Remove bridge custom tracing implementation
-------------------------------------------
Even if it has been proved that it provides a very useful debug mechanism, its
wrappers are not open source aligned, besides there has been an effort to
improve existing debug kernel tools which could provide similar functionality
to replace GT_TRACE.

This can be addressed removing Dbg module from services layer. 


Dyanimc Memory Mapping to be replaced with omap iommu
-----------------------------------------------------
The DMM feature should be replaced with "omap iommu" driver which commonly
supports omap iommu feature. Currently it supports just a mapping of in-kernel
buffers(contiguous/discontiguous), but will be extended to an user buffer soon,
"bitmap_find_free_region" would bring better performance if the number of VMAs
becomes huge.

But before this module can be replaced iommu should:
        - reside in linux-omap tree.
        - provide support for preservation of TLB entries.
        - provide support for notification of MMU faults.

(HK) Basic sanity testing was made in Bridge by replacing the Bridge's MMU
module with the iommu module and the above items need to happen before the
migration to iommu.


Switch to open source Mailbox implementation
--------------------------------------------

********************************************************************************

Maintenance & Code style
========================

- Remove any comment or piece of code that makes reference to other OS.

- Stop using excessive enums (AB).

- Use normal types (AB) (i.e. remove DSP_STATUS and similar)

- Change error codes to return 0 on success and negative value on error,
  DSP_EFAIL and DSP_SOK. (AB)

- The code excessively uses these u32 types. (AB)

- Remove CamelCase and Hungarian notation.
