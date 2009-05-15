From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
 	cache line size
Date: Fri, 15 May 2009 09:54:19 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2B07395C@dlee03.ent.ti.com>
References: <1242017713-25795-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <1242017713-25795-2-git-send-email-Hiroshi.DOYU@nokia.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AF66245@dlee03.ent.ti.com>
	 <20090511.184705.116375196.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905110931i3b81b991x9b7686c5bda25ff8@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AF668B1@dlee03.ent.ti.com>
 <94a0d4530905121422q5ff8cdb2m900bccb031f1eb9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33030 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541AbZEOOya convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 10:54:30 -0400
In-Reply-To: <94a0d4530905121422q5ff8cdb2m900bccb031f1eb9b@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> >>While we are at it, this new mapping could do
> >> PROC_ReserveMemory at the same time so that the user-space application
> >> doesn't get a chance to modify the pa.
> >>
> > -- What does PROC_ReserveMemory has to do with pa ?
> 
> Sorry, I don't know what kind of address PROC_ReserveMemory returns
> (va?), but I don't see any point in having PROC_ReserveMemory and
> PROC_Map as separate ioctls
>

-- The purpose of PROC_ReserveMemory is for the Bridge clients to grab DSP VA memory one time and use the PROC_MapMemory to map the address within this
reserved memory. So, in a way with proper usage of PROC_ReserveMemory, it should be called only one time and subsequent Map/Unmaps from a client should happen within this memory region. By following this, you can eliminate the overhead of calling redundant reserve/unreserve calls that go into the driver.

Thank you,
Best regards,
Hari
