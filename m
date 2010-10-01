From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not finish
Date: Fri, 1 Oct 2010 04:23:26 -0500
Message-ID: <4CA5A88E.1080908@ti.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com> <1285915146-18511-3-git-send-email-peter.ujfalusi@nokia.com> <4CA59188.5020904@ti.com> <201010011151.52547.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44534 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab0JAJXf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 05:23:35 -0400
In-Reply-To: <201010011151.52547.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Peter Ujfalusi had written, on 10/01/2010 03:51 AM, the following:
> On Friday 01 October 2010 10:45:12 ext Nishanth Menon wrote:
> ...
>>> -	l &= ~OMAP_DMA_CCR_EN;
>>> -	dma_write(l, CCR(lch));
>>> +	/* OMAP3 Errata: sDMA FIFO draining does not finish */
>> would be informative to give the iXYZ id as well for some of these
>> erratas might scale across processors.
> 
> In TI's site I was only able to find this public ERRATA:
> OMAP3530/25/15/03 Applications Processor Silicon Errata-Revs 3.1, 3.0, 2.1,&2.0 
> (Rev. E)
> In that document it is under: Advisory 3.1.1.192, but no iXYZ is associated with 
> it. However I have another ERRATA document, which has the iXYZ associated with 
> this advisory, but the first page tells that it is confidential, and under NDA 
> restriction. I'm not really sure, if I should refere to that number...
> But if you have the iXYZ number, which I can use, than I'm more than happy to 
> add that.

I do. It is i541.

> 
>>> +	if (cpu_is_omap34xx() && (l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
>> does it make sense to use an dma_errata variable and populate it?
> 
> Hmmm, the errata handling via dma_errata shall be done separately IMHO,
> since if we do that, than we need to revisit other parts of the code as well, 
> and replace the existing errata handling.
> 
> But yes, it would make the code much more readable, and we can easily track, 
> which errata has been already addressed.
> 
I suppose that is fair..

-- 
Regards,
Nishanth Menon
