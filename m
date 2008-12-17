From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: DSP/IOMMU needs 128-byte alignment from user-space buffers?
Date: Wed, 17 Dec 2008 23:20:42 +0200
Message-ID: <94a0d4530812171320i5d081bedn3c4b6b75875a51c0@mail.gmail.com>
References: <94a0d4530812170526x51aa7959r52c7583661c5a9da@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E1A0CFAAB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:20879 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYLQVUo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2008 16:20:44 -0500
Received: by fg-out-1718.google.com with SMTP id 19so50833fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 17 Dec 2008 13:20:42 -0800 (PST)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E1A0CFAAB@dlee03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On Wed, Dec 17, 2008 at 10:37 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Hi Felipe,
>
>> I received information from TI saying that user-space buffers
>> need to be 128-byte aligned for the DSP to work properly.
>>
>> Is this true or is it some kind of limitation on their MMU
>> code that might be solved by Hiroshi's iommu?
>>
>> This impacts quite drastically user-space applications like
>> GStreamer since a memory copy would be required to achieve
>> that 128-byte alignment.
>>
>> They also claim that adding 128-byte padding at the beginning
>> and at the end achieves the same purpose.
>
> This is to address the memory corruption that might arise when using DMM (Dynamic memory mapping) feature.
> When the DSP processes data, the DSP cache controller loads 128-Byte chunks (lines) from SDRAM and writes the data back in 128-Byte chunks. If a DMM buffer does not start and end on a 128-Byte boundary, the data preceding the start address from the 128-Byte boundary to the Start Address and the data at addresses trailing the end address from the End Address to the next 128-Byte boundary will be loaded and written back as well. If the DMM buffer was allocated on the heap of a process running on the ARM, the preceding and trailing data, if modified by the ARM (or other non-DSP entity) during DSP processing, will be overwritten by the DSP cache controller, when the 128-Byte chunks are written back to SDRAM. This can lead to heap corruption.

Thanks for the explanation. So it doesn't have anything to do with
IOMMU; it's the software running on the DSP that has this limitation.

> I think if you request the buffer from OMX component, this issue will be taken as there is an additional 256 bytes padding.

Yes, but in that case a memcpy would be unavoidable in many cases,
like trying to render the result of video decoding on Xv. If the Xv
buffer is unaligned; a dedicated DMM would need to be allocated, and
then the data coming from DSP would need to be copied to the Xv
buffer. That has a huge performance penalty.

So if I'm understanding correctly there's no problem with unaligned
DMM buffers if the DSP software is just reading; the problem is when
writing data back to ARM.

-- 
Felipe Contreras
