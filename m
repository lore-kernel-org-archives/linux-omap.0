From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Mon, 3 Jan 2011 22:31:56 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
	<4D21F3F2.6090302@mvista.com> <20110103163447.GB2911@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41354 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab1ACRCP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 12:02:15 -0500
In-Reply-To: <20110103163447.GB2911@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sergei Shtylyov <sshtylyov@mvista.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>

Hi,
> >> Add support for Texas Instuments Communication Port Programming
> Interface 4.1
> >> (CPPI 4.1) used on OMAP-L1x/DA8xx and AM35x.
> >
> >> At this moment, only the DMA controller and queue manager are supported.
> >> Support for the buffer manager is lacking but these chips don't have it
> anyway.
> >
> >> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
> >> Signed-off-by: Sekhar Nori<nsekhar@ti.com>
> >
> >    Russell, you have recently discarded this patch from your patch
> > system. Can we know the reason?
> 
> It was recently discussed with TI, and various people raised concerns
> about it.  I don't remember the exact details, and I wish they'd raise
> them with the patch author directly.  It may have been that it's
> inventing its own API rather than using something like the DMA engine
> API.
> 
> Adding linux-omap to try to get a response there.

Sergei,
This issue was discussed recently at TI and proposal was to place it to
drivers/dma folder. Moreover, even Felipe also seems to move other musb
DMAs (Inventra, CPPI3.0, TUSB) to drivers/dma.

Regards,
Ajay
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source@linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
