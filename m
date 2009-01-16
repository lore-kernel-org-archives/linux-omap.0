From: Krishna Kishore <krishna.kishore@sasken.com>
Subject: RE: DSP/IOMMU needs 128-byte alignment from user-space buffers?
Date: Fri, 16 Jan 2009 20:23:26 +0530
Message-ID: <F9F1042FDECC134ABFBF4EC5EBEC88DAB35A2E@EXGZ02.sasken.com>
References: <94a0d4530812170526x51aa7959r52c7583661c5a9da@mail.gmail.com> <8F7AF80515AF0D4D93307E594F3CB40E1A0CFAAB@dlee03.ent.ti.com> <94a0d4530812171320i5d081bedn3c4b6b75875a51c0@mail.gmail.com> <8F7AF80515AF0D4D93307E594F3CB40E1A136121@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-blr1.sasken.com ([203.200.200.72]:30421 "EHLO
	mta-blr1.sasken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785AbZAPOxs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 09:53:48 -0500
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hi Hari,

   Is this document ready? Can you please send this for information?

Regards,
Kishore. 

-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kanigeri, Hari
Sent: Thursday, December 18, 2008 7:01 PM
To: Felipe Contreras
Cc: linux-omap@vger.kernel.org; Hiroshi DOYU
Subject: RE: DSP/IOMMU needs 128-byte alignment from user-space buffers?

Hi Felipe,

> So if I'm understanding correctly there's no problem with unaligned 
> DMM buffers if the DSP software is just reading; the problem is when 
> writing data back to ARM.

--- That is my understanding too. For read only buffer there shouldn't
be an issue with data corruption.

I heard that some folks at TI are working on documenting this cache
alignement issues to share with you. Please hold on.

Thank you,
Best regards,
Hari
 

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Wednesday, December 17, 2008 3:21 PM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; Hiroshi DOYU
> Subject: Re: DSP/IOMMU needs 128-byte alignment from user-space 
> buffers?
> 
> On Wed, Dec 17, 2008 at 10:37 PM, Kanigeri, Hari <h-kanigeri2@ti.com> 
> wrote:
> > Hi Felipe,
> >
> >> I received information from TI saying that user-space
> buffers need to
> >> be 128-byte aligned for the DSP to work properly.
> >>
> >> Is this true or is it some kind of limitation on their MMU
> code that
> >> might be solved by Hiroshi's iommu?
> >>
> >> This impacts quite drastically user-space applications
> like GStreamer
> >> since a memory copy would be required to achieve that 128-byte 
> >> alignment.
> >>
> >> They also claim that adding 128-byte padding at the
> beginning and at
> >> the end achieves the same purpose.
> >
> > This is to address the memory corruption that might arise
> when using DMM (Dynamic memory mapping) feature.
> > When the DSP processes data, the DSP cache controller loads
> 128-Byte chunks (lines) from SDRAM and writes the data back in 
> 128-Byte chunks. If a DMM buffer does not start and end on a 128-Byte 
> boundary, the data preceding the start address from the 128-Byte 
> boundary to the Start Address and the data at addresses trailing the 
> end address from the End Address to the next 128-Byte boundary will be

> loaded and written back as well. If the DMM buffer was allocated on 
> the heap of a process running on the ARM, the preceding and trailing 
> data, if modified by the ARM (or other non-DSP entity) during DSP 
> processing, will be overwritten by the DSP cache controller, when the 
> 128-Byte chunks are written back to SDRAM. This can lead to heap 
> corruption.
> 
> Thanks for the explanation. So it doesn't have anything to do with 
> IOMMU; it's the software running on the DSP that has this limitation.
> 
> > I think if you request the buffer from OMX component, this
> issue will be taken as there is an additional 256 bytes padding.
> 
> Yes, but in that case a memcpy would be unavoidable in many cases, 
> like trying to render the result of video decoding on Xv. If the Xv 
> buffer is unaligned; a dedicated DMM would need to be allocated, and 
> then the data coming from DSP would need to be copied to the Xv 
> buffer. That has a huge performance penalty.
> 
> So if I'm understanding correctly there's no problem with unaligned 
> DMM buffers if the DSP software is just reading; the problem is when 
> writing data back to ARM.
> 
> --
> Felipe Contreras
> 
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org More majordomo info
at  http://vger.kernel.org/majordomo-info.html
SASKEN BUSINESS DISCLAIMER
-------------------------
This message may contain confidential, proprietary or legally privileged information. In 
case you are not the original intended Recipient of the message, you must not, directly or 
indirectly, use, Disclose, distribute, print, or copy any part of this message and you are 
requested to delete it and inform the sender. Any views expressed in this message are 
those of the individual sender unless otherwise stated. Nothing contained in this message 
shall be construed as an offer or acceptance of any offer by Sasken Communication 
Technologies Limited ("Sasken") unless sent with that express intent and with due 
authority of Sasken. Sasken has taken enough precautions to prevent the spread of 
viruses. However the company accepts no liability for any damage caused by any virus 
transmitted by this email

