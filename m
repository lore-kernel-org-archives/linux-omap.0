From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Fri, 20 Jul 2012 21:08:42 +0530
Message-ID: <CAJe_ZheysNmr4exGS7jKiKqgxQ0AUXoDXhtm-_8w_UxeAQkDrA@mail.gmail.com>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
	<CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
	<500912C7.8080204@ti.com>
	<CAJe_Zhd3KXNVTi0S5PiPwzJXDNRpDGgSSgJbY1km4ZEi-VzwCA@mail.gmail.com>
	<500952C7.70200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57220 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2GTPin (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 11:38:43 -0400
Received: by vbbff1 with SMTP id ff1so3022415vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jul 2012 08:38:42 -0700 (PDT)
In-Reply-To: <500952C7.70200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Raphael Assenat <raph@8d.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

On 20 July 2012 18:14, Archit Taneja <a0393947@ti.com> wrote:
> On Friday 20 July 2012 05:43 PM, Jassi Brar wrote:
>>
>>> It's true that currently omap platforms don't share the same panels, but
>>> there is no stopping us to do that. We could remove the default panel and
>>> attach a new one, even though we won't upstream non default panels in the
>>> DT/board file, it would be always easier to make this change in software
>>> if
>>> most of the panel specific info stays in the panel driver.
>>>
>> You mean you want to hardcode parameters in the driver instead of
>> modifying the dtb that you pass to the kernel?
>
> I meant that, but if we go with your approach, which sort of makes sense
> now, it would be in the dtb file.
>
In dtb or via platform_data until we have common DT bindings. I have
sent a patch doing it via platform_data, which maybe taken as such or
after making it prettier to taste.

Thanks.
