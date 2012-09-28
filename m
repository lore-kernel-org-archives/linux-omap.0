From: "Vutla, Lokesh" <lokeshvutla@ti.com>
Subject: Re: Help needed with remaining plat headers
Date: Fri, 28 Sep 2012 15:35:09 +0530
Message-ID: <CAJ1gdca8+mtWRS13GtxNKRqcQ1OCspvx5SdhjcQKsJNskHi1sg@mail.gmail.com>
References: <20120920232907.GN28835@atomide.com> <CAJ1gdca9cPA97rbJV_Q5rEQCJydmoRPuGYE1oq1vUhmxdPnEKA@mail.gmail.com>
 <506565D8.5090509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:42354 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138Ab2I1KFa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 06:05:30 -0400
Received: by oagh16 with SMTP id h16so2769070oag.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 03:05:29 -0700 (PDT)
In-Reply-To: <506565D8.5090509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Peter,

On Fri, Sep 28, 2012 at 2:24 PM, Peter Ujfalusi <peter.ujfalusi@ti.com>=
 wrote:
> On 09/27/2012 12:57 PM, Vutla, Lokesh wrote:
>>> clkdev_omap.h
>>> clock.h
>>> common.h
>>> cpu.h
>>> dma-44xx.h
>>> dma.h
>> As a part of clean up I am looking at dma.h and dma-44xx.h files
>> ll send you patches once cleanup and testing is done.
>
> One note for the dma.h, dma-44xx.h:
> The audio drivers used to include at least dma.h, but after the dmaen=
gine
> conversion the are no longer doing it. The dmaengine for OMAP audio i=
s going
> for 3.7. You can see them for some time in linux-next laready.
Yes I am aware of this.
I am making patches on linux-next only

Thanks
Lokesh
>
> --
> P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
