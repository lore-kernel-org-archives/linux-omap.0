From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v3] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 9 Oct 2013 15:14:58 -0500
Message-ID: <5255B942.5000601@ti.com>
References: <1380639886-9526-1-git-send-email-zonque@gmail.com> <5254DB86.4000104@ti.com>,<5254E60F.80009@ti.com> <F774F8C9-0A8F-4B27-8607-874FB0901A78@ti.com> <5254F54D.7060709@ti.com> <52550809.2000407@gmail.com> <52556467.7010400@ti.com>
Reply-To: <joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45281 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458Ab3JIUPd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 16:15:33 -0400
In-Reply-To: <52556467.7010400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Gururaja Hebbar <gururaja.hebbar@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "neumann@teufel.de" <neumann@teufel.de>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "vinod.koul@intel.com" <vinod.koul@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "Balbi, Felipe" <balbi@ti.com>

On 10/09/2013 09:12 AM, Joel Fernandes wrote:
> On 10/09/2013 02:38 AM, Daniel Mack wrote:
[..]
>> (And the 'v3' in the subject is really my bad, sorry - I only sent one
>> version of this patch ever).
>>
>> I can respin the patch on top of the proper driver once all the edma
>> bits have eventually been moved to drivers/dma. Is anyone continuing
>> Matt Porter's work on this?
> 
> The work is waiting on conversion of the davinci-pcm ASoC driver to DMA Engine,
> which once done can make exposing the private EDMA API in arch/arm/common/edma.c
> obsolete and we can take it to drivers/dma. Some more work to be done in edma in
> unifying the probe etc.

Forgot to mention, since ASoC DMAengine conversion is not going to happen any
time soon considering the amount of work involved, I suggest you respin this
patch on the common/edma code itself. That way we can keep suspend/resume
working on these platforms that use EDMA till the actual conversion takes place.

I suggest though to recreate the state based on existing datastructures instead
of allocating/saving additional memory.

Hope you're also in agreement with my comments on your original patch on what
needs to / need not be saved.

thanks,

-Joel



