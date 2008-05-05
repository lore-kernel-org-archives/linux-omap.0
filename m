From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: OMAP3 DSPBridge review
Date: Mon, 5 May 2008 18:29:28 -0500
Message-ID: <A8E8DDC23969AE4CB38FFF51016C778202A82175@dlee10.ent.ti.com>
References: <5d5443650804160742y71ae769dub7716e75b77a40e5@mail.gmail.com> <EBA93F3E4CB46947A4C5275F6308CF3E026F87F9@dlee15.ent.ti.com> <5d5443650804162254i4cfd5604ve9cbf5afc8acbe37@mail.gmail.com> <5d5443650804162324n2a11c2f2na4c81176aadf143a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:47233 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbYEEX3g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2008 19:29:36 -0400
Content-class: urn:content-classes:message
In-Reply-To: <5d5443650804162324n2a11c2f2na4c81176aadf143a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap@vger.kernel.org

Trilok,

       Please see my below responses to your questions. 


> > There is un-necessary "linux" directory inside mpu_driver source 
> > codes. e.g src/osal/linux etc. I hope we are writing this code for 
> > Linux kernel only. > >

-- This will be removed in coming releases.

> > src/osal/linux
> >  - As the name suggest for directory it is OS Abstraction layer for 
> > Linux. I don't see any need for this at all. In Linux kernel, we
follow > > approach of directly calling the provided functions and not
to further
> > wrap it until necessary.
> >

-- OSAL is a combination of OS Abstraction and utilities. It is possible
to create a new folder called utilities and move certain modules there.
The other modules do more than just abstracting the OS function calls.
They do certain level of processing before calling kernel functions. To
start off we will start moving out the code that is not OS specific to a
separate folder

> > src/osal/kfile.c
> > - Don't use KENREL_VERSION comparision check unless very much
necessary, > > always try to keep driver in sync in latest kernel
version instead.
> > - Again there are wrappers for file reading functions provided by
kernel.
> >- If this functions are only used for doff loader, then moving it to 
> >outside kernel space, then we can get away with this functions.
> >

-- I agree. The check for KERNEL_VERSION will be removed in the coming
releases. 
We are investigating about moving the doff loader outside the kernel
space. I suggest we start a separate discussion for this. And if we move
out of kernel space, then probably we can remove the kfile.c file.

> > src/osal/mem.c

> > - I see here that you guys are maintaining the pool of memory
allocated > > with dma_alloc_coherent, you guys should have used
existing mempool apis > > instead, look at dspgw code for example. 
> >

-- We call dma_alloc_coherent API to guarantee the contiguous and
uncached memory region allocation for the shared memory region between
MPU and DSP. 

> > src/pmgr/linux/common/dmm.c -
> > Please correct if my undestanding is in-correct for dmm.c - Here you
> >.guys are trying to manage the virtual memory of target (dsp/iva) as 
> > linked list of node, so that reserved memory from ARM can be mapped
to 
> >  DSP and then can be used as shared memory. If we are trying manage 
> > virtual memory in Gigabytes , e.g 2GB for IVA1.0, then doubly linked
> >list may not be optimal for searching the free node, where we can map

> >this buffer.

> > You guys should have used lib/bitmap.c functions for creating
bitmap, 
> >once the bitmap is created use bitmap_find_free_region, which is very

> >fast. For example of this function grep in SH architecture code. 
> >

-- We are currently working on an alternate approach to optimize this
and we will certainly look into your proposal. I will get back to you on
this issue in a separate thread as early as possible.

>  > src/osal/dpc.c - please call tasklet functions directly instead.
>  > src/pmgr/linux/common/dmm.c -
>  > 
-- The tasklet is scheduled when MPU receives message from DSP. There is
a possibility that while the tasklet is running, the DSP might interrupt
MPU resulting in the scheduling of a new tasklet. So, instead of waiting
till the new tasklet is scheduled to run to process this new message, we
make use of the number of tasklets scheduled counters that are
incremented in the ISR to process the new messages. (refer to
DPC_DeferredProcedure function in dpc.c)


Thank you,
Best regards,
Hari


-----Original Message-----
From: Trilok Soni [mailto:soni.trilok@gmail.com] 
Sent: Thursday, April 17, 2008 1:25 AM
To: Pasam, Vijay
Cc: Kanigeri, Hari; linux-omap@vger.kernel.org
Subject: Re: OMAP3 DSPBridge review

Hi Vijay,

On Thu, Apr 17, 2008 at 11:24 AM, Trilok Soni <soni.trilok@gmail.com>
wrote:
> Hi Vijay,
>
>
>
>  On Thu, Apr 17, 2008 at 8:15 AM, Pasam, Vijay <vpasam@ti.com> wrote:
>  > Hi Trilok:
>  >
>  >
>  >
>  >  >
>  >  > I was just going this dspbridge code, and I was surprised to
>  >  > find layers for un-necessary things, where we could have
>  >  > simply called the linux kernel provided function. Here goes the
list:
>  >  >
>  >  > 1. There is un-necessary "linux" directory inside mpu_driver
>  >  > source codes. e.g src/osal/linux etc. I hope we are writing
>  >  > this code for Linux kernel only.
>  >  > 2. src/osal/linux
>  >  >   - As the name suggest for directory it is OS Abstraction
>  >  > layer for Linux. I don't see any need for this at all. In
>  >  > Linux kernel, we follow approach of directly calling the
>  >  > provided functions and not to further wrap it until necessary.
>  >  >
>  >  > src/osal/list.c
>  >  >
>  >  > - This whole file tries implement doubly linked list code, I
>  >  > am sure you can get away this with list.h itself. I don't see
>  >  > any need of further wrapping it.
>  >  >
>  >  > src/osal/kfile.c
>  >  >
>  >  > - Don't use KENREL_VERSION comparision check unless very much
>  >  > necessary, always try to keep driver in sync in latest kernel
>  >  > version instead.
>  >  > - Again there are wrappers for file reading functions
>  >  > provided by kernel.
>  >  > - If this functions are only used for doff loader, then
>  >  > moving it to outside kernel space, then we can get away with
>  >  > this functions.
>  >  >
>  >  > src/osal/mem.c
>  >  >
>  >  > - I see here that you guys are maintaining the pool of memory
>  >  > allocated with dma_alloc_coherent, you guys should have used
>  >  > existing mempool apis instead, look at dspgw code for example.
>  >  >
>  >  > src/osal/isr.c
>  >  >
>  >  > - Not required, please call request_irq/free_irq directly
>  >  > please. I also see lots of #ifdef LINUX and #ifndef LINUX,
>  >  > does TI also target to build this code for WinCE and Symbian
>  >  > like OS. If yes, I don't see how we are going to maintain
>  >  > this along with community.
>  >  >
>  >  > src/osal/dpc.c - please call tasklet functions directly instead.
>  >  >
>  >  > src/pmgr/linux/common/dmm.c -
>  >
>  >  One of the goals of bridge is easier portability to other RTOS.
You are
>  >  right about the additional layer to call into Linux OS. This was
>  >  intended to port this to other OS'es easily.
>  >
>
>  TI has to decide, what path they have to follow now onwards for
>  bridge, I see no need of OSAL layer, when we are targeting this as
>  Linux kernel driver.
>
>  It would be tough to get contributions as this code at first sight
>  looks harder to understand. Let's have some ideas on how we can clean
>  this code gradually without breaking API compatibility and IPC layer.
>  Common MMU and Mailbox framework written in Nokia dspgw should also
be
>  utilized in this.
>

Forgot to mention that "documents" folder contains documents in MS$
.doc format. Please publish them in .pdf instead. Later the steps can
be converted to dspbridge-wiki pages.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
