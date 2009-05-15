From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
	cache line size
Date: Fri, 15 May 2009 20:39:26 +0300
Message-ID: <94a0d4530905151039o4cda70d0o8755b402bdd032e5@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:53957 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbZEORj0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 13:39:26 -0400
Received: by fg-out-1718.google.com with SMTP id d23so175473fga.17
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 10:39:27 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2B073B70@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, May 15, 2009 at 8:32 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
>> Do you know of any client that doing ReseveMemory and Map independently?
>> How much overhead is there in ReserveMemory?
>> What happens if the Map size is different than the ReserveMemory? What
>> happens if the size is bigger?
>
> -- I cannot disclose the name, but it is some major Mobile Company that is following this approach. One big chunk of DSP Virtual address region is grabbed during boot time, and after that all the maps/unmaps are managed from this memory region.

On Linux?

So the DSP VA passed to Map would be v + chunk_size * i?

>> How much overhead is there in ReserveMemory?
> -- The overhead is the ioctls to the Bridge driver and the search that is involved in searching for the DSP virtual address region that meets the size requirement.

Search a DSP virtual memory region from where?

>> What happens if the Map size is different than the ReserveMemory? What
>> happens if the size is bigger?
>
> -- The onus will be on the Client that reserved the memory to make sure that the size to map is within the reserved memory block.

Aha! Yet another place where the kernel is letting user-space screw up
the system.

>> In fact I don't even understand what is DSP VA memory. Is that virtual
>> memory?
> -- Yes, that is the DSP Virtual address.
>
>> What meaning is there on virtual memory that has no physical
>> memory?
>
> -- The mapping to the physical address is done with the DSPProcessor_Map function call.

Yes, but before the Map function the virtual memory has no meaning.

-- 
Felipe Contreras
