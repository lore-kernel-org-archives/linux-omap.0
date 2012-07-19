From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: am3517: geting MMC working
Date: Thu, 19 Jul 2012 12:04:02 +0530
Message-ID: <CAMQu2gyGH2r1vqEx5DCiv8xr=Lp+p1_5nvrtQe9RdpnfecSoag@mail.gmail.com>
References: <5007A838.3040309@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:41667 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751114Ab2GSGeY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 02:34:24 -0400
Received: by qcmv28 with SMTP id v28so1822404qcm.39
        for <linux-omap@vger.kernel.org>; Wed, 18 Jul 2012 23:34:22 -0700 (PDT)
In-Reply-To: <5007A838.3040309@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegor_sub1@visionsystems.de
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mark A. Greer" <mgreer@animalcreek.com>, "Porter, Matt" <mporter@ti.com>

On Thu, Jul 19, 2012 at 11:54 AM, Yegor Yefremov
<yegor_sub1@visionsystems.de> wrote:
>
> What patches do I need to get MMC working with linux-omap master?
>
> omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
> omap-dma-engine omap-dma-engine: allocating channel for 62
> omap-dma-engine omap-dma-engine: allocating channel for 61
> omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
> omap-dma-engine omap-dma-engine: allocating channel for 48
> omap-dma-engine omap-dma-engine: allocating channel for 47
>
> I searched for this issue and saw some patches for common clock framework
> that were scheduled for 3.6, but I'm not sure it's enough or weather they
> are already incorporated in linux-omap.
>
I guess you need [1] to get around the issue.

Regards
Santosh

[1] http://www.spinics.net/lists/linux-omap/msg73965.html
