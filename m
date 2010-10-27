From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [Question] which type of DMA taken by musb of beagle-xM(DM3730)?
Date: Wed, 27 Oct 2010 10:41:43 -0400
Message-ID: <AANLkTi=4K1V2pZQNZOhbkJJ8WCh0X8botpWHOU03p3Hv@mail.gmail.com>
References: <AANLkTi=r08ipWPYfEbpsX-tuG=3evFfVazR198ECjFnn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:48340 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933279Ab0J0OmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Oct 2010 10:42:08 -0400
In-Reply-To: <AANLkTi=r08ipWPYfEbpsX-tuG=3evFfVazR198ECjFnn@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>

On Wed, Oct 27, 2010 at 5:54 AM, Ming Lei <tom.leiming@gmail.com> wrote:
> I want to know which type of DMA is taken by musb of DM3730,
> INVENTRA_DMA, TI_CPPI_DMA or others?

Inventra DMA. An updated version compared to the OMAP34xx/35xx.

- No major change to the programming model
- The simultaneous TX-RX DMA hang bug is gone with this one.

- Anand
