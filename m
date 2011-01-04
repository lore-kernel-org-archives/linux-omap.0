From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Tue, 04 Jan 2011 16:06:39 +0300
Message-ID: <4D231B5F.7030607@mvista.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>	<4D21F3F2.6090302@mvista.com>	<20110103163447.GB2911@n2100.arm.linux.org.uk>	<19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>	<4D220246.5020303@mvista.com>	<19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com> <20110103204416.GA2240@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40437 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab1ADNHr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 08:07:47 -0500
Received: by eye27 with SMTP id 27so6285113eye.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 05:07:46 -0800 (PST)
In-Reply-To: <20110103204416.GA2240@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello.

On 03-01-2011 23:44, Felipe Balbi wrote:

>>> > Moreover, even Felipe also seems to move other musb
>>> > DMAs (Inventra, CPPI3.0, TUSB) to drivers/dma.

>>> Frankly speaking, I doubt that drivers/dma/ will have place for the
>>> purely MUSB specific DMA engines such as the named ones (there's no TUSB
>>> DMA BTW it uses OMAP DMA).

>> I think we will get more clarity once we start on this activity.

> I agree, but I personally don't see that many limiting factors.
> dmaengine is just a generic API for doing DMA transfers. If it's not
> enough for us currently, we extend it.

    Putting MUSB DMA enignes into drivers/dma/ is the same as taking *any* 
chip capable of bus-mastering DMA, "separating" its bus mastering related code 
from its driver and putting this code into drivers/dma/. This doesn't make 
sense, in my opinion. drivers/dma/ is for the dedicated DMA controllers (which 
can *optionally* serve the slave devices).

WBR, Sergei
