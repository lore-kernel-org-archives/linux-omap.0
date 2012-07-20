From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Fri, 20 Jul 2012 17:43:45 +0530
Message-ID: <CAJe_Zhd3KXNVTi0S5PiPwzJXDNRpDGgSSgJbY1km4ZEi-VzwCA@mail.gmail.com>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
	<CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
	<500912C7.8080204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61819 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab2GTMNq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 08:13:46 -0400
Received: by vbbff1 with SMTP id ff1so2830467vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jul 2012 05:13:45 -0700 (PDT)
In-Reply-To: <500912C7.8080204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Raphael Assenat <raph@8d.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

On 20 July 2012 13:41, Archit Taneja <a0393947@ti.com> wrote:
> On Tuesday 17 July 2012 09:57 PM, Jassi Brar wrote:
>>>
>>> Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD displays.
>>>
>> Display panels are board specific and there is no limit to the number
>> of panels that could be connected to omap dss.
>>   Does it make sense to get panel params via DT? Or at least have them
>> come from board file? (esp when there is hardly a panel shared by two
>> boards, and some panels aren't even used by any board in mainline)
>>
>
> A panel specific param should stay in the panel driver, it's something which
> is specific to the panel and not the platform it is in
>
Yes it is board specific, but no it should not stay in the driver. The
driver simply needs one compatible set of 15 numbers to do its job.

Let me explain my point in detail....
The array generic_dpi_panels[] is but a limited list of compatible
configurations of a 'generic' panel. Each occupying ~20 lines in
kernel. There would be dozens of supported panels that exist but are
not listed in this array, and countless more that are possible to
manufacture. If I submit a 2000 lines patch with only 100 such
configurations you would have no reason to reject other than "I know
what you mean" :)

> It's true that currently omap platforms don't share the same panels, but
> there is no stopping us to do that. We could remove the default panel and
> attach a new one, even though we won't upstream non default panels in the
> DT/board file, it would be always easier to make this change in software if
> most of the panel specific info stays in the panel driver.
>
You mean you want to hardcode parameters in the driver instead of
modifying the dtb that you pass to the kernel?

> Also, 2 platforms of different SoC's may use the same panel. Currently the
> panel drivers are SoC specific, but there is work being done between
> different display maintainers so that the same panel driver works across
> different SoCs.
>
Doesn't that make the case for DT/platform_data even stronger?

Of course you as a maintainer have the final say. I am out of ways to
explain my point.

Cheers.
