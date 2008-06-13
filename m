From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: Sharing buffers between ARM-DSP on OMAP3430 over Bridge
Date: Thu, 12 Jun 2008 23:13:22 -0500
Message-ID: <A8E8DDC23969AE4CB38FFF51016C778202D971CB@dlee10.ent.ti.com>
References: <904DEC693BE1AB429622C6F5ABA7E0B802600203@is01ex02.ittiam.com> <036001c8c9f2$53f198f0$11dfa8c0@ent.ti.com> <904DEC693BE1AB429622C6F5ABA7E0B802600207@is01ex02.ittiam.com> <A8E8DDC23969AE4CB38FFF51016C778202D27E91@dlee10.ent.ti.com> <904DEC693BE1AB429622C6F5ABA7E0B802600208@is01ex02.ittiam.com> <A8E8DDC23969AE4CB38FFF51016C778202D2837A@dlee10.ent.ti.com> <904DEC693BE1AB429622C6F5ABA7E0B80260020A@is01ex02.ittiam.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57597 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbYFMEOA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2008 00:14:00 -0400
Content-class: urn:content-classes:message
In-Reply-To: <904DEC693BE1AB429622C6F5ABA7E0B80260020A@is01ex02.ittiam.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Viraj Karandikar <viraj.karandikar@ittiam.com>, "Gupta, Ramesh" <grgupta@ti.com>, linux-omap@vger.kernel.org
Cc: "Ameet U. Kalagi" <ameet.kalagi@ittiam.com>

Viraj,

        I think in order to read the tags you have to be in secure mode,
so this approach might not be possible.    

Thank you,
Best regards,
Hari
 

> -----Original Message-----
> From: Viraj Karandikar [mailto:viraj.karandikar@ittiam.com] 
> Sent: Tuesday, June 10, 2008 11:33 PM
> To: Kanigeri, Hari; Gupta, Ramesh; linux-omap@vger.kernel.org
> Cc: Ameet U. Kalagi
> Subject: RE: Sharing buffers between ARM-DSP on OMAP3430 over Bridge
> 
> Hari,
> Yes, performance of other applications will be impacted if we 
> flush entire cache.
> Can we do something like, scan through cache entries and 
> flush entries belonging to the buffer requested for flush?
> This can be done only while flushing huge buffers, so that 
> flushing small buffers will not be affected.
> I am not sure how exactly cache operations are done in linux. 
> But I think this could be done.
> 
> 
> Regards,
> Viraj
> 
> 
> -----Original Message-----
> From: Kanigeri, Hari [mailto:h-kanigeri2@ti.com]
> Sent: Wednesday, June 11, 2008 12:38 AM
> To: Viraj Karandikar; Gupta, Ramesh; linux-omap@vger.kernel.org
> Subject: RE: Sharing buffers between ARM-DSP on OMAP3430 over Bridge
> 
> Hi Viraj,
> 
> > I took these changes and built new bridgedriver.ko.
> > I could see 50% reduction in time taken to queue a buffer 
> of size of 
> > 3MB. (old time: 28 ms, new time: 13 ms).
>  
> -------- Nice to hear the optimization worked for you.
> 
> > But actually the L2 cache is only 256Kb. So a small part of 
> the buffer 
> > might be in cache (< 256Kb).
> > This will add unnecessary overhead for huge (my buffer size is 3MB) 
> > buffers.
> > Is there any way so that I can flush full cache to avoid overhead?
> 
> -------- I did benchmark the flush part and the number I got 
> is very close to what you observed. We are looking into the 
> issue of reducing the flush time. I will inform once I find 
> any improvements to this.
> As far as your question regarding flushing the entire cache, 
> I am not sure if this is the best approach as this will have 
> an impact on the performance of other applications running in 
> the system.
> 
> Thank you,
> Best regards,
> Hari
> 
> > -----Original Message-----
> > From: Viraj Karandikar [mailto:viraj.karandikar@ittiam.com]
> > Sent: Tuesday, June 10, 2008 10:51 AM
> > To: Kanigeri, Hari; Gupta, Ramesh; linux-omap@vger.kernel.org
> > Subject: RE: Sharing buffers between ARM-DSP on OMAP3430 over Bridge
> > 
> > Thanks Hari,
> > I took these changes and built new bridgedriver.ko.
> > I could see 50% reduction in time taken to queue a buffer 
> of size of 
> > 3MB. (old time: 28 ms, new time: 13 ms).
> > 
> > If I reserve and map a buffer only once and use the mapped 
> address for 
> > future (avoiding map/unmap every time) I get better numbers (9 ms).
> > So only thing which I am doing is flushing the buffer for 
> consistency 
> > since this buffer is input to codec on DSP.
> > 
> > But 9ms only for flushing seems very high.
> > I am not 100% sure, but it seems like the kernel flush code is
> scanning
> > through all the virtual addresses of the buffer and flush if any of 
> > those are cached.
> > But actually the L2 cache is only 256Kb. So a small part of 
> the buffer 
> > might be in cache (< 256Kb).
> > This will add unnecessary overhead for huge (my buffer size is 3MB) 
> > buffers.
> > Is there any way so that I can flush full cache to avoid overhead?
> > 
> > 
> > Regards,
> > Viraj
> > 
> > 
> > 
> > 
> > 
> > -----Original Message-----
> > From: Kanigeri, Hari [mailto:h-kanigeri2@ti.com]
> > Sent: Monday, June 09, 2008 10:51 PM
> > To: Viraj Karandikar; Gupta, Ramesh; linux-omap@vger.kernel.org
> > Subject: RE: Sharing buffers between ARM-DSP on OMAP3430 over Bridge
> > 
> > Hi Viraj,
> > 
> >         You can use the attached file to get the DMM optimimzation
> that
> > Ramesh is referring to.
> > 
> > The location of this file is mpu_driver\src\wmd\omap\3430
> > 
> > 
> > Thank you,
> > Best regards,
> > Hari
> > 
> > 
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org 
> > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Viraj 
> > > Karandikar
> > > Sent: Monday, June 09, 2008 10:18 AM
> > > To: Gupta, Ramesh; linux-omap@vger.kernel.org
> > > Subject: RE: Sharing buffers between ARM-DSP on OMAP3430 
> over Bridge
> > >
> > > Thanks Ramesh.
> > > I was reserving and mapping buffers "every time". This was not 
> > > required.
> > > I modified the code to reserve and map a buffer only once and use
> the
> > > mapped address for future.
> > > This modification reduced the overhead.
> > >
> > > I have one more doubt.
> > > Does DSP use virtual-to-physical mapping for all the addresses it 
> > > accesses (including DSP's local buffers)?
> > > Or it uses this mapping only to access shared buffers?
> > > Wont it be a big overhead if DSP accesses all the 
> memories through 
> > > virtual-to-physical mapping?
> > >
> > > Regards,
> > > Viraj
> > >
> > >
> > >
> > > -----Original Message-----
> > > From: Ramesh Gupta G [mailto:x0023949@ti.com]
> > > Sent: Monday, June 09, 2008 11:03 AM
> > > To: Viraj Karandikar; linux-omap-open-source@linux.omap.com
> > > Subject: Re: Sharing buffers between ARM-DSP on OMAP3430 
> over Bridge
> > >
> > > Hi Vijay,
> > >
> > > ----- Original Message -----
> > > From: "Viraj Karandikar" <viraj.karandikar@ittiam.com>
> > > To: <linux-omap-open-source@linux.omap.com>
> > > Sent: Saturday, June 07, 2008 3:45 PM
> > > Subject: Sharing buffers between ARM-DSP on OMAP3430 over Bridge
> > >
> > >
> > > >Hi all,
> > >
> > > >I am working on omap3430 using bridge. I am using Dynamically
> Mapped
> > > >Memory (DMM) method for sharing buffers.
> > >
> > > >For sending buffers to DSP I am doing calls to
> > > >DSPProcessor_ReserveMemory() and DSPProcessor_Map(). For these
> calls
> > > are
> > > >taking around 18ms (for 3-4MB buffers) which is not
> > > acceptable for the
> > > >application. I am not able to understand why it is taking so
> > > much time?
> > >
> > > Which version of bridge you are using?
> > > We have optimized the code for DSPProcessor_Map(), You can see 
> > > significant change in the numbers with the latest code.
> > >
> > >
> > > >My understanding of DMM method is ->
> > >
> > >
> > > >- Use malloc() to allocate a buffer on ARM.
> > >
> > > >- Reserve required chunk of memory from DMM pool (using
> > > >DSPProcessor_ReserveMemory() )
> > >
> > > >- Translate this memory to ARM virtual address space in
> > > >DSPProcessor_Map() function.
> > >
> > > Actually DSPProcessor_Map() maps ARM physical addresses to DSP
> Virtual
> > > addresses.
> > >
> > > >- Send the reserved memory address to DSP.
> > >
> > >
> > >
> > > >Is this correct? I am confused about how exactly this happens.
> > >
> > > You are correct except above point about DSPProcessor_Map().
> > >
> > > >Also Ihave a doubt if the reserved memory address is from
> > > DSP physical
> > > address
> > > >space? Or is it from ARM virtual address space for DSP
> > > physical address
> > > >space?
> > >
> > > Reserved Memory is from DSP Virtual Address.
> > >
> > > >Is DMM method does copy from malloc'ed address to 
> reserved address 
> > > >in any way?
> > >
> > > Do you mean copying the contents? No copying is involved. Only
> mapping
> > > of
> > > addresses is performed.
> > >
> > >
> > > >It will be helpful if anybody put some light on this.
> > >
> > > Please let me know if you see any issues.
> > >
> > >
> > >
> > > >Regards,
> > >
> > > >Viraj
> > >
> > >
> > > Thanks & Regards
> > > Ramesh Gupta G
> > >
> > >
> **********************************************************************
> > > This email and any files transmitted with it are confidential and 
> > > intended solely for the use of the individual or entity 
> to whom they 
> > > are addressed. If you have received this email in error please
> notify
> > > helpdesk@ittiam.com.
> > >
> **********************************************************************
> > >
> > > _______________________________________________
> > > Linux-omap-open-source mailing list
> > > Linux-omap-open-source@linux.omap.com
> > > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe 
> > > linux-omap" in the body of a message to majordomo@vger.kernel.org 
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> 
