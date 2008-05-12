From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: OMAP3 DSPBridge review
Date: Mon, 12 May 2008 16:50:22 -0500
Message-ID: <A8E8DDC23969AE4CB38FFF51016C778202AD3D1F@dlee10.ent.ti.com>
References: <5d5443650804160742y71ae769dub7716e75b77a40e5@mail.gmail.com> <EBA93F3E4CB46947A4C5275F6308CF3E026F87F9@dlee15.ent.ti.com> <5d5443650804162254i4cfd5604ve9cbf5afc8acbe37@mail.gmail.com> <5d5443650804162324n2a11c2f2na4c81176aadf143a@mail.gmail.com> <A8E8DDC23969AE4CB38FFF51016C778202A82175@dlee10.ent.ti.com> <5d5443650805100813k40bb7468u13b5bc5d3ee4db89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56709 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbYELVu2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2008 17:50:28 -0400
Content-class: urn:content-classes:message
In-Reply-To: <5d5443650805100813k40bb7468u13b5bc5d3ee4db89@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap@vger.kernel.org, "Gupta, Ramesh" <grgupta@ti.com>, "Pasam, Vijay" <vpasam@ti.com>, "Shah, Bhavin" <bshah@ti.com>

Hi Trilok,
          Thanks for your comments. Please see my following comments.

> > -- We call dma_alloc_coherent API to guarantee the contiguous and
> > uncached memory region allocation for the shared memory region
between
> > MPU and DSP.
> 
> Yes, I do understand this, but I was more inclined towards getting the
> big chunk of this memory at boottime, and managing them through
> mempool APIs. Mempool APIs provides the callback for reserve and
> unreserve. Please check Nokia dspgateway or better
> arch/arm/plat-omap/mmu.c {kmem_reserve/unreserve}.

------ dma_alloc_coherent API is called only once in Bridge during
initialization to allocate memory for IPC purpose, and there are no
dynamic allocations there after from this allocated memory pool. I think
as there is no memory management within this memory pool, I don't see a
reason to move to new API. 


> Meanwhile I hope TI
> provides the GIT tree setup for this dspbridge driver, so that TI
> doesn't have to release their changes in tarball fashion, and other
> open-source developers can also look into the changes which TI is
> doing easily and contribute.

------ We are currently working on the GIT tree and should be available
in the coming months. 

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Trilok Soni [mailto:soni.trilok@gmail.com]
> Sent: Saturday, May 10, 2008 10:14 AM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org
> Subject: Re: OMAP3 DSPBridge review
> 
> Hi Hari,
> 
> On Tue, May 6, 2008 at 4:59 AM, Kanigeri, Hari <h-kanigeri2@ti.com>
wrote:
> > Trilok,
> >
> >       Please see my below responses to your questions.
> >
> >
> >> > There is un-necessary "linux" directory inside mpu_driver source
> >> > codes. e.g src/osal/linux etc. I hope we are writing this code
for
> >> > Linux kernel only. > >
> >
> > -- This will be removed in coming releases.
> >
> >> > src/osal/linux
> >> >  - As the name suggest for directory it is OS Abstraction layer
for
> >> > Linux. I don't see any need for this at all. In Linux kernel, we
> > follow > > approach of directly calling the provided functions and
not
> > to further
> >> > wrap it until necessary.
> >> >
> >
> > -- OSAL is a combination of OS Abstraction and utilities. It is
possible
> > to create a new folder called utilities and move certain modules
there.
> > The other modules do more than just abstracting the OS function
calls.
> > They do certain level of processing before calling kernel functions.
To
> > start off we will start moving out the code that is not OS specific
to a
> > separate folder
> >
> >> > src/osal/kfile.c
> >> > - Don't use KENREL_VERSION comparision check unless very much
> > necessary, > > always try to keep driver in sync in latest kernel
> > version instead.
> >> > - Again there are wrappers for file reading functions provided by
> > kernel.
> >> >- If this functions are only used for doff loader, then moving it
to
> >> >outside kernel space, then we can get away with this functions.
> >> >
> >
> > -- I agree. The check for KERNEL_VERSION will be removed in the
coming
> > releases.
> > We are investigating about moving the doff loader outside the kernel
> > space. I suggest we start a separate discussion for this. And if we
move
> > out of kernel space, then probably we can remove the kfile.c file.
> >
> >> > src/osal/mem.c
> >
> >> > - I see here that you guys are maintaining the pool of memory
> > allocated > > with dma_alloc_coherent, you guys should have used
> > existing mempool apis > > instead, look at dspgw code for example.
> >> >
> >
> > -- We call dma_alloc_coherent API to guarantee the contiguous and
> > uncached memory region allocation for the shared memory region
between
> > MPU and DSP.
> 
> Yes, I do understand this, but I was more inclined towards getting the
> big chunk of this memory at boottime, and managing them through
> mempool APIs. Mempool APIs provides the callback for reserve and
> unreserve. Please check Nokia dspgateway or better
> arch/arm/plat-omap/mmu.c {kmem_reserve/unreserve}.
> 
> As we are on this path, it would be great if TI converts to MMU and
> Mailbox framework we have in OMAP git.
> 
> ...
> >>  >
> > -- The tasklet is scheduled when MPU receives message from DSP.
There is
> > a possibility that while the tasklet is running, the DSP might
interrupt
> > MPU resulting in the scheduling of a new tasklet. So, instead of
waiting
> > till the new tasklet is scheduled to run to process this new
message, we
> > make use of the number of tasklets scheduled counters that are
> > incremented in the ISR to process the new messages. (refer to
> > DPC_DeferredProcedure function in dpc.c)
> 
> I would be able to do more code walkthrough and tests, once I have
> OMAP3 beagle or any other OMAP3 based board. Meanwhile I hope TI
> provides the GIT tree setup for this dspbridge driver, so that TI
> doesn't have to release their changes in tarball fashion, and other
> open-source developers can also look into the changes which TI is
> doing easily and contribute.
> 
> --
> ---Trilok Soni
> http://triloksoni.wordpress.com
