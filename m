From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: DSP/IOMMU needs 128-byte alignment from user-space buffers?
Date: Mon, 22 Dec 2008 05:15:47 +0200
Message-ID: <94a0d4530812211915g78f1e74ei11af4b9c1202befb@mail.gmail.com>
References: <94a0d4530812170526x51aa7959r52c7583661c5a9da@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E1A0CFAAB@dlee03.ent.ti.com>
	 <200812211819.47692.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:17809 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbYLVDPt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Dec 2008 22:15:49 -0500
Received: by fg-out-1718.google.com with SMTP id 19so714488fgg.17
        for <linux-omap@vger.kernel.org>; Sun, 21 Dec 2008 19:15:47 -0800 (PST)
In-Reply-To: <200812211819.47692.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On Mon, Dec 22, 2008 at 4:19 AM, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 17 December 2008, Kanigeri, Hari wrote:
>> When the DSP processes data, the DSP cache controller
>> loads 128-Byte chunks (lines) from SDRAM and writes the
>> data back in 128-Byte chunks.
>
> In short:  it's the same kind of cache line sharing issue
> that any other DMA-using software needs to be aware of,
> except that (a) the lines are 128 bytes vs whatever ARM
> uses, and (b) the other bus master is a CPU instead of
> something relatively dumb.
>
> Any software that runs on non-x86 hardware will likely
> have had to deal with such issues already, since most
> hardware other than x86 relies on software to prevent
> cache coherency goofs:  no bus snooping, MOESI, etc.

Do you know of any software doing some kind of processing that sends
the data back? My guess is that there isn't a lot of software doing
that.

I think existing software would need to be updated to render video
output efficiently (allocate Xv buffers properly aligned).

-- 
Felipe Contreras
