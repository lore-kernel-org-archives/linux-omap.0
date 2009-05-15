From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
 	cache line size
Date: Fri, 15 May 2009 15:32:25 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2B073D8F@dlee03.ent.ti.com>
References: <1242017713-25795-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <1242017713-25795-2-git-send-email-Hiroshi.DOYU@nokia.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AF66245@dlee03.ent.ti.com>
	 <20090511.184705.116375196.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905110931i3b81b991x9b7686c5bda25ff8@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AF668B1@dlee03.ent.ti.com>
	 <94a0d4530905121422q5ff8cdb2m900bccb031f1eb9b@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2B07395C@dlee03.ent.ti.com>
	 <94a0d4530905150959x64920e8fud52961cfadd84d6b@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2B073B70@dlee03.ent.ti.com>
 <94a0d4530905151039o4cda70d0o8755b402bdd032e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45259 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbZEOUcg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 16:32:36 -0400
In-Reply-To: <94a0d4530905151039o4cda70d0o8755b402bdd032e5@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Felipe,

> > -- I cannot disclose the name, but it is some major Mobile Company that
> is following this approach. One big chunk of DSP Virtual address region is
> grabbed during boot time, and after that all the maps/unmaps are managed
> from this memory region.
> 
> On Linux?

-- Yes.

> So the DSP VA passed to Map would be v + chunk_size * i?

-- Yes. 

> 
> Search a DSP virtual memory region from where?

-- Bridge internally does the management of this virtual memory pool. It might get fragmented over time, so based on the size that is requested it will loop through the pool to find the requested continguous DSP VA region.

> > -- The onus will be on the Client that reserved the memory to make sure
> that the size to map is within the reserved memory block.
> 
> Aha! Yet another place where the kernel is letting user-space screw up
> the system.

-- :) :). It is a choice between either
	a. Provide too much configurable options to the Users that they can optimize according to their needs and requirements.
	b. Don't provide any configurable options to Users and acting like a Black box. 
With option a. at the benefit of getting configurable option the Users can also use the configurable options to screw up the System :). Examples of (a) are TI's MMU and Mailbox modules and (b) is the IOMMU module and Mailbox module in LO tree. 
But any ways, coming to Map question, if the User provide size to map greater than reserved memory, the map function fails as this was never reserved. Or it might screw up other Client's reserved memory as this Map request might fall in the other reserved memory region.

> > -- The mapping to the physical address is done with the DSPProcessor_Map
> function call.
> 
> Yes, but before the Map function the virtual memory has no meaning.
>
-- Isn't to similar to ARM's virtual memory that doesn't has any meaning until the Physical memory is assigned to it ?


Thank you,
Best regards,
Hari
