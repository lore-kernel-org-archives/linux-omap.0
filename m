From: David Brownell <david-b@pacbell.net>
Subject: Re: DSP/IOMMU needs 128-byte alignment from user-space buffers?
Date: Sun, 21 Dec 2008 19:48:11 -0800
Message-ID: <200812211948.11460.david-b@pacbell.net>
References: <94a0d4530812170526x51aa7959r52c7583661c5a9da@mail.gmail.com> <200812211819.47692.david-b@pacbell.net> <94a0d4530812211915g78f1e74ei11af4b9c1202befb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:37234 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752122AbYLVDsN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Dec 2008 22:48:13 -0500
In-Reply-To: <94a0d4530812211915g78f1e74ei11af4b9c1202befb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On Sunday 21 December 2008, Felipe Contreras wrote:
> On Mon, Dec 22, 2008 at 4:19 AM, David Brownell wrote:
> > In short:  it's the same kind of cache line sharing issue
> > that any other DMA-using software needs to be aware of,
> > ...
> 
> Do you know of any software doing some kind of processing that sends
> the data back? My guess is that there isn't a lot of software doing
> that.

I wouldn't know about such hardware, but I'd be shocked to
learn that TI's products are the first to offload image
processing tasks to hardware.  Workstations have done such
stuff for at least 25 years now, which is enough time to
have tried a LOT of hardware variations.  Surely at least
one non-TI variation wrote data back, in those years...

I'm just saying this is really a bog-standard issue.

Maybe it's a surprise in this context for some reason;
current Open Source tools might easily have made unwise
x86-oriented assumptions, like caches being DMA-coherent.
Tools moving for the first time to new platforms tend to
uncover a lot of portability glitches.  They get fixed.

- Dave
