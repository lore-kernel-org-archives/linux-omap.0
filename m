From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: DSP/IOMMU needs 128-byte alignment from user-space buffers?
Date: Wed, 17 Dec 2008 14:37:01 -0600
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E1A0CFAAB@dlee03.ent.ti.com>
References: <94a0d4530812170526x51aa7959r52c7583661c5a9da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41975 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYLQUhO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2008 15:37:14 -0500
In-Reply-To: <94a0d4530812170526x51aa7959r52c7583661c5a9da@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hi Felipe,

> I received information from TI saying that user-space buffers 
> need to be 128-byte aligned for the DSP to work properly.
> 
> Is this true or is it some kind of limitation on their MMU 
> code that might be solved by Hiroshi's iommu?
> 
> This impacts quite drastically user-space applications like 
> GStreamer since a memory copy would be required to achieve 
> that 128-byte alignment.
> 
> They also claim that adding 128-byte padding at the beginning 
> and at the end achieves the same purpose.

This is to address the memory corruption that might arise when using DMM (Dynamic memory mapping) feature.
When the DSP processes data, the DSP cache controller loads 128-Byte chunks (lines) from SDRAM and writes the data back in 128-Byte chunks. If a DMM buffer does not start and end on a 128-Byte boundary, the data preceding the start address from the 128-Byte boundary to the Start Address and the data at addresses trailing the end address from the End Address to the next 128-Byte boundary will be loaded and written back as well. If the DMM buffer was allocated on the heap of a process running on the ARM, the preceding and trailing data, if modified by the ARM (or other non-DSP entity) during DSP processing, will be overwritten by the DSP cache controller, when the 128-Byte chunks are written back to SDRAM. This can lead to heap corruption.
I think if you request the buffer from OMX component, this issue will be taken as there is an additional 256 bytes padding.

Thank you,
Best regards,
Hari
 