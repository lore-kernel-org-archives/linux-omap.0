From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC] dspbridge: staging todo list
Date: Sun, 26 Apr 2009 20:36:43 +0300 (EEST)
Message-ID: <20090426.203643.35024594.Hiroshi.DOYU@nokia.com>
References: <983c694e0904260907o2e10da56xffeade20f1b3ff7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48454 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbZDZRhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2009 13:37:04 -0400
In-Reply-To: <983c694e0904260907o2e10da56xffeade20f1b3ff7c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: or.rmz1@gmail.com
Cc: linux-omap@vger.kernel.org, menon.nishanth@gmail.com, h-kanigeri2@ti.com, felipe.contreras@gmail.com, ameya.palande@nokia.com, dedekind@yandex.ru, grgupta@ti.com

Hi Omar,

From: ext omar ramirez <or.rmz1@gmail.com>
Subject: [RFC] dspbridge: staging todo list
Date: Sun, 26 Apr 2009 18:07:18 +0200

> Hi,
> 
> This is my personal TODO list, I gathered this from the comments
> received from the list, mainly from Trilok Soni (TS), Hiroshi Doyu
> (HD), Felipe Contreras (FC), Artem Biyutskiy (AB).
> 
> Let me know your thoughts or if you have something else to add.

It may be better to discuss separately "architecture change" and just
"coding style fix".

>From architecture perspective, this driver is composed of several
functional modules which are tightly related each other unfortunately,
and it size seems to be too big. So I think that these modules can be
lesser dependent by getting rid of its kind of "OSAL" layer at first,
and some of functional features can be pushed out to userland like a
binary loader, page locking mechanism and etc. Also some modules can
be shared more generally by differenct DSPs/Coprocessors(C55x, IVA1/2)
and differenct OMAP generations(OMAP1, 2, 3) like "iommu" and
"mailbox". Ideally pushing out some modules into userland would bring
more robustness and the advantage of the unix programming like a
process and a filesystem. Then the code size can be more smaller and
lesser module dependency, easy to maintain.


> - Remove the layers for unnecesary things (TS)
>   - drivers/dsp/bridge/services/list.c
>   This whole file tries implement doubly linked list code, I am sure you can
>   get away this with list.h itself. I don't see any need of further wrapping it.
> 
>   - drivers/dsp/bridge/services/kfile.c
>   Again there are wrappers for file reading functions provided by kernel.
>   If this functions are only used for doff loader, then moving it to outside
>   kernel space, then we can get away with this functions.
> 
>   - drivers/dsp/bridge/services/mem.c
>   I see here that you guys are maintaining the pool of memory allocated with
>   dma_alloc_coherent, you guys should have used existing mempool apis instead,
>   look at dspgw code for example.
> 
>   - drivers/dsp/bridge/services/dpc.c
>   call tasklet functions directly instead.

IIRC, this "services" directory used to be named as "OSAL", "OS
Abstruction Layer" to support differenct OSes at the same time in the
past. Most of the features under this directory should be direcly
replaced with the normal linux kernel APIs, instead of using
homebrewed wrappers around that APIs like "notifier",
"synchronization" and ISR family. Also the concept of Windows-like
"registory" may not be necessary at all here. So I think that this
directly itself should be removed eventually.


>   - drivers/dsp/bridge/services/dmm.c
>   Please correct if my undestanding is in-correct for dmm.c - Here you
>   guys are trying to manage the virtual memory of target (dsp/iva) as
>   linked list of node, so that reserved memory from ARM can be mapped to
>   DSP and then can be used as shared memory. If we are trying manage
>   virtual memory in Gigabytes , e.g 2GB for IVA1.0, then doubly linked
>   list may not be optimal for searching the free node, where we can map
>   this buffer.
> 
>   You guys should have used lib/bitmap.c functions for creating bitmap,
>   once the bitmap is created use bitmap_find_free_region, which is very
>   fast. For example of this function grep in SH architecture code.

This DMM feature should be replaced with "omap iommu" driver which
commonly supports omap iommu feature. Currently it supports just a
mapping of in-kernel buffers(contiguous/discontiguous), but will be
extened to an user buffer soon. Anyway, "bitmap_find_free_region"
would bring better performance if the number of VMAs becomes huge.


>   - Remove any comment or piece of code that makes reference to other OS.
> 
> - Use mempool_* kernel API interfaces instead of having module parameter
> phys_mempool* to reserve big amount of memory (HD)
>
> - Clock module either to be removed or to use other clock interface(FC, HD)
> 
> - Remove bridge debug system (GT_Trace) and keep only the meaningful pr_*
>   calls (AB), probably need to maintain this as a separate patch if
> needed. (OR)

This tracing feature can be implemented with "debugfs" and "ftrace" can
be used as is and also can be an good example to implement
newly. Please refer to "Documentation/ftrace.txt".

"DYNAMIC_PRINTK_DEBUG" can be used for easier debugging if this
dspbridge can be well divided into multiple kernel modules from
functional perspective.

Both debugging feature can be used for their appropriate cases where
GT_Trace is supporting integrally.

> 
> - Stop using excessive enums (AB).
> 
> - Use normal types (AB) (i.e. remove DSP_STATUS and similar)
> 
> - Change error codes to return 0 on success and negative value on error,
>   DSP_EFAIL and DSP_SOK. (AB)
> 
> - The code excessively uses these u32 types. (AB)
> 
> - Remove CamelCase and Hungarian notation.

I think that the above all work won't be so small and keeping items
discussed above as "TODO list" with other dspbridge patches would be
quite beneficial too;-)

If you clean up this list a bit more, it would be feasible to keep
this in gitorious l-o bridge patches.


> 
> ---
> omar ramirez
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
