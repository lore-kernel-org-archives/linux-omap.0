From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Help needed with remaining plat headers
Date: Fri, 28 Sep 2012 11:54:48 +0300
Message-ID: <506565D8.5090509@ti.com>
References: <20120920232907.GN28835@atomide.com> <CAJ1gdca9cPA97rbJV_Q5rEQCJydmoRPuGYE1oq1vUhmxdPnEKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:48871 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751235Ab2I1IyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 04:54:07 -0400
Received: by obbuo13 with SMTP id uo13so2683310obb.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 01:53:34 -0700 (PDT)
In-Reply-To: <CAJ1gdca9cPA97rbJV_Q5rEQCJydmoRPuGYE1oq1vUhmxdPnEKA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Vutla, Lokesh" <lokeshvutla@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On 09/27/2012 12:57 PM, Vutla, Lokesh wrote:
>> clkdev_omap.h
>> clock.h
>> common.h
>> cpu.h
>> dma-44xx.h
>> dma.h
> As a part of clean up I am looking at dma.h and dma-44xx.h files
> ll send you patches once cleanup and testing is done.

One note for the dma.h, dma-44xx.h:
The audio drivers used to include at least dma.h, but after the dmaengi=
ne
conversion the are no longer doing it. The dmaengine for OMAP audio is =
going
for 3.7. You can see them for some time in linux-next laready.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
