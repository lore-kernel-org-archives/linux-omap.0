From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH v5 2/3] OMAP3: DMA: Errata i541: sDMA FIFO draining does
 not finish
Date: Thu, 11 Nov 2010 09:17:18 +0200
Message-ID: <4CDB987E.2020806@nokia.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com> <1286261141-1039-3-git-send-email-peter.ujfalusi@nokia.com> <4CDAA3AA.7070003@nokia.com> <alpine.DEB.2.00.1011101628410.28301@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55174 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757694Ab0KKHRt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 02:17:49 -0500
In-Reply-To: <alpine.DEB.2.00.1011101628410.28301@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Ujfalusi Peter (Nokia-MS/Tampere)" <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>

On 11/11/10 01:30, ext Paul Walmsley wrote:
> Hello Adrian,
>
> On Wed, 10 Nov 2010, Adrian Hunter wrote:
>
>> On 05/10/10 09:45, Peter Ujfalusi wrote:
>>
>>> +	if (cpu_is_omap34xx()&&   (l&   OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
>>> +		int i = 0;
>>> +		u32 sys_cf;
>>> +
>>> +		/* Configure No-Standby */
>>> +		l = dma_read(OCP_SYSCONFIG);
>>> +		sys_cf = l;
>>> +		l&= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
>>> +		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
>>> +		dma_write(l , OCP_SYSCONFIG);
>>
>> Are accesses of OCP_SYSCONFIG synchronised?
>
> Do you mean, with respect to later reads and writes from the SDMA device?
> If so, then yes, later reads and writes to the SDMA are guaranteed to
> complete in order.  But perhaps I am misunderstanding what you mean?

I just meant it looks racy e.g.  two threads call omap_dma_stop() (or
another function that changes OCP_SYSCONFIG) at the same time
