From: "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>
Subject: RE: [PATCH 1/2] ARM: McBSP: Fix request for irq in OMAP4
Date: Wed, 5 May 2010 19:58:17 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B910F888E@dlee01.ent.ti.com>
References: <1273016270-31452-1-git-send-email-jorge.candelaria@ti.com>
	<1273016270-31452-2-git-send-email-jorge.candelaria@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F8C6E56@dbde02.ent.ti.com>
 <20100505133903.cde41896.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58197 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab0EFA6U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 20:58:20 -0400
In-Reply-To: <20100505133903.cde41896.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jarkko Nikula wrote:
> On Wed, 5 May 2010 08:32:13 +0530
> "G, Manjunath Kondaiah" <manjugk@ti.com> wrote:
> 
>>> -		init_completion(&mcbsp->rx_irq_completion);
>>> -		err = request_irq(mcbsp->rx_irq,
>>> omap_mcbsp_rx_irq_handler,
>>> +		if (!cpu_is_omap44xx) {
>>> +			init_completion(&mcbsp->rx_irq_completion);
>>> +			err = request_irq(mcbsp->rx_irq,
>>> +					omap_mcbsp_rx_irq_handler,
>>>  					0, "McBSP", (void *)mcbsp);
>> 
>> How about using request_threaded_irq?
>> Refer to: http://lwn.net/Articles/302043/
>> 
> Threaded irq conversion would be better to handle as a separate patch
> as it does different thing than this patch.

I will redo this patch without threaded irq for now, and will do the
conversion in a later patch then.