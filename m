From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] USB: musb: allow unaligned memory data transfers
Date: Thu, 14 Jan 2010 19:06:16 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E2EB521@dbde02.ent.ti.com>
References: <1263310937-7249-1-git-send-email-vikram.pandita@ti.com>
 <20100114112354.GG19526@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36042 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab0ANNg1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jan 2010 08:36:27 -0500
In-Reply-To: <20100114112354.GG19526@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mankad, Maulik Ojas" <x0082077@ti.com>, "Patra, Nilkesh" <nilkesh.patra@ti.com>

> From: Felipe Balbi wrote:
> >+	/* On MUSB:RTL1.8 and above, DMA has to be word aligned */
> >+	if ((dma_addr % 4) &&
> >+		(musb->hwvers >= MUSB_HWVERS_1800)) {
> 
> is it only inventra dma that suffers from this ? If not, we could move 
> this check before even calling the dma routine.

Yes, it's only the integrated Inventra DMA that behaves like this.

Anyway, I don't think newer versions of the IP are being used by
anyone without the Inventra DMA. The older versions though are
sometimes used with external DMA controllers.

- Anand
