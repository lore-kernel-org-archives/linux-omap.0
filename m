From: "Pasam, Vijay" <vpasam@ti.com>
Subject: RE: Sharing buffers between ARM-DSP on OMAP3430 over Bridge
Date: Mon, 9 Jun 2008 11:09:33 -0500
Message-ID: <EBA93F3E4CB46947A4C5275F6308CF3E02C88AC4@dlee15.ent.ti.com>
References: <904DEC693BE1AB429622C6F5ABA7E0B802600207@is01ex02.ittiam.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:47786 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbYFIQJp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 12:09:45 -0400
Content-class: urn:content-classes:message
In-reply-to: <904DEC693BE1AB429622C6F5ABA7E0B802600207@is01ex02.ittiam.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Viraj Karandikar <viraj.karandikar@ittiam.com>, "Gupta, Ramesh" <grgupta@ti.com>, linux-omap@vger.kernel.org

> Does DSP use virtual-to-physical mapping for all the 
> addresses it accesses (including DSP's local buffers)?
> Or it uses this mapping only to access shared buffers?
> Wont it be a big overhead if DSP accesses all the memories 
> through virtual-to-physical mapping?

DSP has to access all the external memory buffers through DSP MMU.

Best Regards
Vijay
 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Viraj 
> Karandikar
> Sent: Monday, June 09, 2008 10:18 AM
> To: Gupta, Ramesh; linux-omap@vger.kernel.org
> Subject: RE: Sharing buffers between ARM-DSP on OMAP3430 over Bridge
> Viraj,


> Thanks Ramesh.
> I was reserving and mapping buffers "every time". This was 
> not required.
> I modified the code to reserve and map a buffer only once and 
> use the mapped address for future.
> This modification reduced the overhead.
> 
> I have one more doubt.
> Does DSP use virtual-to-physical mapping for all the 
> addresses it accesses (including DSP's local buffers)?
> Or it uses this mapping only to access shared buffers?
> Wont it be a big overhead if DSP accesses all the memories 
> through virtual-to-physical mapping?
> 
> Regards,
> Viraj
> 
> 
> 
> -----Original Message-----
> From: Ramesh Gupta G [mailto:x0023949@ti.com]
> Sent: Monday, June 09, 2008 11:03 AM
> To: Viraj Karandikar; linux-omap-open-source@linux.omap.com
> Subject: Re: Sharing buffers between ARM-DSP on OMAP3430 over Bridge
> 
> Hi Vijay,
> 
> ----- Original Message -----
> From: "Viraj Karandikar" <viraj.karandikar@ittiam.com>
> To: <linux-omap-open-source@linux.omap.com>
> Sent: Saturday, June 07, 2008 3:45 PM
> Subject: Sharing buffers between ARM-DSP on OMAP3430 over Bridge
> 
> 
> >Hi all,
> 
> >I am working on omap3430 using bridge. I am using Dynamically Mapped
> >Memory (DMM) method for sharing buffers.
> 
> >For sending buffers to DSP I am doing calls to
> >DSPProcessor_ReserveMemory() and DSPProcessor_Map(). For these calls
> are
> >taking around 18ms (for 3-4MB buffers) which is not 
> acceptable for the
> >application. I am not able to understand why it is taking so 
> much time?
> 
> Which version of bridge you are using?
> We have optimized the code for DSPProcessor_Map(), You can see
> significant
> change in the
> numbers with the latest code.
> 
> 
> >My understanding of DMM method is ->
> 
> 
> >- Use malloc() to allocate a buffer on ARM.
> 
> >- Reserve required chunk of memory from DMM pool (using
> >DSPProcessor_ReserveMemory() )
> 
> >- Translate this memory to ARM virtual address space in
> >DSPProcessor_Map() function.
> 
> Actually DSPProcessor_Map() maps ARM physical addresses to DSP Virtual
> addresses.
> 
> >- Send the reserved memory address to DSP.
> 
> 
> 
> >Is this correct? I am confused about how exactly this happens.
> 
> You are correct except above point about DSPProcessor_Map().
> 
> >Also Ihave a doubt if the reserved memory address is from 
> DSP physical
> address
> >space? Or is it from ARM virtual address space for DSP 
> physical address
> >space?
> 
> Reserved Memory is from DSP Virtual Address.
> 
> >Is DMM method does copy from malloc'ed address to reserved
> >address in any way?
> 
> Do you mean copying the contents? No copying is involved. Only mapping
> of
> addresses is performed.
> 
> 
> >It will be helpful if anybody put some light on this.
> 
> Please let me know if you see any issues.
> 
> 
> 
> >Regards,
> 
> >Viraj
> 
> 
> Thanks & Regards
> Ramesh Gupta G
> 
> **********************************************************************
> This email and any files transmitted with it are confidential and
> intended solely for the use of the individual or entity to whom they
> are addressed. If you have received this email in error please notify
> helpdesk@ittiam.com.
> **********************************************************************
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
