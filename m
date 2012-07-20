From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and G121X1-L01
 LCD displays
Date: Fri, 20 Jul 2012 13:41:51 +0530
Message-ID: <500912C7.8080204@ti.com>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com> <CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35569 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab2GTINb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 04:13:31 -0400
In-Reply-To: <CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Raphael Assenat <raph@8d.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

On Tuesday 17 July 2012 09:57 PM, Jassi Brar wrote:
> [CC'ing OMAPDSS matinainer]
>
> On 17 July 2012 19:31, Raphael Assenat <raph@8d.com> wrote:
>> Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD displays.
>>
> Display panels are board specific and there is no limit to the number
> of panels that could be connected to omap dss.
>   Does it make sense to get panel params via DT? Or at least have them
> come from board file? (esp when there is hardly a panel shared by two
> boards, and some panels aren't even used by any board in mainline)
>

A panel specific param should stay in the panel driver, it's something 
which is specific to the panel and not the platform it is in, things 
like the gpio reset number, i2c connections with the panel etc would 
make sense to come via DT/board file.

It's true that currently omap platforms don't share the same panels, but 
there is no stopping us to do that. We could remove the default panel 
and attach a new one, even though we won't upstream non default panels 
in the DT/board file, it would be always easier to make this change in 
software if most of the panel specific info stays in the panel driver.

Also, 2 platforms of different SoC's may use the same panel. Currently 
the panel drivers are SoC specific, but there is work being done between 
different display maintainers so that the same panel driver works across 
different SoCs.

Archit
