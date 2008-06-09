From: "Viraj Karandikar" <viraj.karandikar@ittiam.com>
Subject: RE: Sharing buffers between ARM-DSP on OMAP3430 over Bridge
Date: Mon, 9 Jun 2008 20:48:12 +0530
Message-ID: <904DEC693BE1AB429622C6F5ABA7E0B802600207@is01ex02.ittiam.com>
References: <904DEC693BE1AB429622C6F5ABA7E0B802600203@is01ex02.ittiam.com> <036001c8c9f2$53f198f0$11dfa8c0@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from Ittiam.com ([125.16.143.82]:27726 "EHLO is01ms02.ittiam.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752062AbYFIPct convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 11:32:49 -0400
Content-class: urn:content-classes:message
In-Reply-To: <036001c8c9f2$53f198f0$11dfa8c0@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ramesh Gupta G <x0023949@ti.com>, linux-omap@vger.kernel.org

Thanks Ramesh.
I was reserving and mapping buffers "every time". This was not required.
I modified the code to reserve and map a buffer only once and use the
mapped address for future.
This modification reduced the overhead.

I have one more doubt.
Does DSP use virtual-to-physical mapping for all the addresses it
accesses (including DSP's local buffers)?
Or it uses this mapping only to access shared buffers?
Wont it be a big overhead if DSP accesses all the memories through
virtual-to-physical mapping?

Regards,
Viraj



-----Original Message-----
From: Ramesh Gupta G [mailto:x0023949@ti.com] 
Sent: Monday, June 09, 2008 11:03 AM
To: Viraj Karandikar; linux-omap-open-source@linux.omap.com
Subject: Re: Sharing buffers between ARM-DSP on OMAP3430 over Bridge

Hi Vijay,

----- Original Message ----- 
From: "Viraj Karandikar" <viraj.karandikar@ittiam.com>
To: <linux-omap-open-source@linux.omap.com>
Sent: Saturday, June 07, 2008 3:45 PM
Subject: Sharing buffers between ARM-DSP on OMAP3430 over Bridge


>Hi all,

>I am working on omap3430 using bridge. I am using Dynamically Mapped
>Memory (DMM) method for sharing buffers.

>For sending buffers to DSP I am doing calls to
>DSPProcessor_ReserveMemory() and DSPProcessor_Map(). For these calls
are
>taking around 18ms (for 3-4MB buffers) which is not acceptable for the
>application. I am not able to understand why it is taking so much time?

Which version of bridge you are using?
We have optimized the code for DSPProcessor_Map(), You can see
significant
change in the
numbers with the latest code.


>My understanding of DMM method is ->


>- Use malloc() to allocate a buffer on ARM.

>- Reserve required chunk of memory from DMM pool (using
>DSPProcessor_ReserveMemory() )

>- Translate this memory to ARM virtual address space in
>DSPProcessor_Map() function.

Actually DSPProcessor_Map() maps ARM physical addresses to DSP Virtual
addresses.

>- Send the reserved memory address to DSP.



>Is this correct? I am confused about how exactly this happens.

You are correct except above point about DSPProcessor_Map().

>Also Ihave a doubt if the reserved memory address is from DSP physical
address
>space? Or is it from ARM virtual address space for DSP physical address
>space?

Reserved Memory is from DSP Virtual Address.

>Is DMM method does copy from malloc'ed address to reserved
>address in any way?

Do you mean copying the contents? No copying is involved. Only mapping
of
addresses is performed.


>It will be helpful if anybody put some light on this.

Please let me know if you see any issues.



>Regards,

>Viraj


Thanks & Regards
Ramesh Gupta G

**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
helpdesk@ittiam.com.
**********************************************************************
