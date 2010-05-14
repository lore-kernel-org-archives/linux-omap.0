From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 4/5] musb: use system DMA for unaligned buffers on RTL
 >= 1.8
Date: Fri, 14 May 2010 17:09:37 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E40561A@dbde02.ent.ti.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-3-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-4-git-send-email-ajay.gupta@ti.com>
 <20100512175433.GC3285@gandalf>
 <19F8576C6E063C45BE387C64729E7394044E405169@dbde02.ent.ti.com>
 <20100514110648.GA3947@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53525 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab0ENLjp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 07:39:45 -0400
In-Reply-To: <20100514110648.GA3947@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Friday, May 14, 2010 4:37 PM
> To: Gupta, Ajay Kumar
> Cc: me@felipebalbi.com; linux-usb@vger.kernel.org; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH 4/5] musb: use system DMA for unaligned buffers on RTL
> >= 1.8
> 
> On Thu, May 13, 2010 at 06:13:00AM +0200, ext Gupta, Ajay Kumar wrote:
> >How about this 'memcpy', this would affect both cpu loading
> >and performance. That's why using system dma would be a better
> >approach.
> 
> but that's not portable.
> Even if you come up with nice wrappers for
> system dma usage (which is already ugly, more exported functions) you
> might end up on a board where system dma has same alignment constraints
> as mentor dma.

It can't be an OMAP3 based board but yes, future platform could have
such limitations but they should not restrict other platforms
to use system dma which can handle unaligned buffers.

> Either fall back to pio or use a bounce buffer. That'll
> work always.

Agreed but performance we should allow system dma approach also.

> 
> Besides, the only offending gadget driver we have is g_ether and that's
> already 'fixed' by the alignment patch to g_ether.

No, it's not fixed. It had two issues,
1. 	Cache coherency as we observed iperf failing and after using
	Cache_flush_all() things started working.
2. 	High cpu loading of 100% and bit rate of only 30Mbits/sec due
	To memmove and cache_flush..

-Ajay
> Any other gadget
> driver causing that, should be fixed too...
> 
> --
> balbi
> 
> DefectiveByDesign.org
