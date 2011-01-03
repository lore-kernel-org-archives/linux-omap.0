From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Mon, 3 Jan 2011 22:44:17 +0200
Message-ID: <20110103204416.GA2240@legolas.emea.dhcp.ti.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
 <4D21F3F2.6090302@mvista.com>
 <20110103163447.GB2911@n2100.arm.linux.org.uk>
 <19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
 <4D220246.5020303@mvista.com>
 <19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45517 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751155Ab1ACUoW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 15:44:22 -0500
Received: by ewy23 with SMTP id 23so6093411ewy.11
        for <linux-omap@vger.kernel.org>; Mon, 03 Jan 2011 12:44:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>

Hi,

On Mon, Jan 03, 2011 at 10:45:35PM +0530, Gupta, Ajay Kumar wrote:
>> > Moreover, even Felipe also seems to move other musb
>> > DMAs (Inventra, CPPI3.0, TUSB) to drivers/dma.
>>
>>     Frankly speaking, I doubt that drivers/dma/ will have place for the
>> purely MUSB specific DMA engines such as the named ones (there's no TUSB
>> DMA BTW it uses OMAP DMA).
>I think we will get more clarity once we start on this activity.

I agree, but I personally don't see that many limiting factors.
dmaengine is just a generic API for doing DMA transfers. If it's not
enough for us currently, we extend it.

-- 
balbi
