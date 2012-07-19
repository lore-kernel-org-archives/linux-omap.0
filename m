From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: am3517: geting MMC working
Date: Thu, 19 Jul 2012 12:37:18 +0530
Message-ID: <CAMQu2gx83tx66kQtF9v_v6yaw-L6v8QMc9u3bokX68ZhzC0tiA@mail.gmail.com>
References: <5007A838.3040309@visionsystems.de> <CAMQu2gyGH2r1vqEx5DCiv8xr=Lp+p1_5nvrtQe9RdpnfecSoag@mail.gmail.com>
 <5007AF7C.1010902@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:44462 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752087Ab2GSHHj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 03:07:39 -0400
Received: by qcmt36 with SMTP id t36so1317458qcm.15
        for <linux-omap@vger.kernel.org>; Thu, 19 Jul 2012 00:07:38 -0700 (PDT)
In-Reply-To: <5007AF7C.1010902@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegor_sub1@visionsystems.de
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mark A. Greer" <mgreer@animalcreek.com>, "Porter, Matt" <mporter@ti.com>

On Thu, Jul 19, 2012 at 12:25 PM, Yegor Yefremov
<yegor_sub1@visionsystems.de> wrote:
> Am 19.07.2012 08:34, schrieb Shilimkar, Santosh:
>> On Thu, Jul 19, 2012 at 11:54 AM, Yegor Yefremov
>> <yegor_sub1@visionsystems.de> wrote:
>>> What patches do I need to get MMC working with linux-omap master?
>>>
>>> omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
>>> omap-dma-engine omap-dma-engine: allocating channel for 62
>>> omap-dma-engine omap-dma-engine: allocating channel for 61
>>> omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
>>> omap-dma-engine omap-dma-engine: allocating channel for 48
>>> omap-dma-engine omap-dma-engine: allocating channel for 47
>>>
>>> I searched for this issue and saw some patches for common clock framework
>>> that were scheduled for 3.6, but I'm not sure it's enough or weather they
>>> are already incorporated in linux-omap.
>>>
>> I guess you need [1] to get around the issue.
>>
>> [1] http://www.spinics.net/lists/linux-omap/msg73965.html
>
> though I haven't applied this patch I have DMA activated (CONFIG_DMADEVICES and CONFIG_DMA_OMAP). Found in some other thread [1]. As far as I can tell, debounce clk is the problem.
>
Sorry. I miss-read the message.

Regards
santosh
