From: "Subbrathnam, Swaminathan" <swami.iyer@ti.com>
Subject: RE: Patch [2/2] DaVinci CPPI TX DMA tasklet
Date: Fri, 22 Aug 2008 07:01:26 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870229F52485@dbde02.ent.ti.com>
References: <1219327122-28334-1-git-send-email-swami.iyer@ti.com>,<48AD8526.8080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43718 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbYHVBfp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 21:35:45 -0400
In-Reply-To: <48AD8526.8080206@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

Hi Dmitry,

Comments inlined.

swami


________________________________________
From: Dmitry Krivoschekov [dmitry.krivoschekov@gmail.com]
Sent: Thursday, August 21, 2008 8:39 PM
To: Subbrathnam, Swaminathan
Cc: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org; felipe.balbi@nokia.com
Subject: Re: Patch [2/2] DaVinci CPPI TX DMA tasklet

Hi Swami,

Swaminathan S wrote:
>     Signed-off-by: Swaminathan S <swami.iyer@ti.com>
>
>     This patch implements a tasklet to poll for TX Endpoint FIFO
>     empty status before completing a transfer.  This is required
>     in the context of DaVinci CPPI DMA Tx transfers.  CPPI
>     DMA engine generates completion interrupt before the data
>     actually moves out of TX FIFO

I guess the DMA interrupt is generated after the data have been moved
from a s/w buffer to TX FIFO.

<Swami> Yes.  This being an external DMA (unlike Mentor DMA) that was
the designed behavior.

> and the driver needs to save the
>     Data toggle after ensuring that the FIFO is empty.

why don't rely on an endpoint interrupt which is generated after a USB
transaction is complete?

<Swami> When in DMA mode (mode 1) Endpoint interrupt does not get
generated (only DMA completion interrupt) and hence cannot rely on that.

Thanks,
Dmitry