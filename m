From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and G121X1-L01
 LCD displays
Date: Fri, 20 Jul 2012 18:14:55 +0530
Message-ID: <500952C7.70200@ti.com>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com> <CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com> <500912C7.8080204@ti.com> <CAJe_Zhd3KXNVTi0S5PiPwzJXDNRpDGgSSgJbY1km4ZEi-VzwCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58223 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab2GTMqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 08:46:35 -0400
In-Reply-To: <CAJe_Zhd3KXNVTi0S5PiPwzJXDNRpDGgSSgJbY1km4ZEi-VzwCA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Raphael Assenat <raph@8d.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Friday 20 July 2012 05:43 PM, Jassi Brar wrote:
> On 20 July 2012 13:41, Archit Taneja <a0393947@ti.com> wrote:
>> On Tuesday 17 July 2012 09:57 PM, Jassi Brar wrote:
>>>>
>>>> Add timings for ChiMei G121S1-L01/L02 and G121X1-L01 LCD displays.
>>>>
>>> Display panels are board specific and there is no limit to the number
>>> of panels that could be connected to omap dss.
>>>    Does it make sense to get panel params via DT? Or at least have them
>>> come from board file? (esp when there is hardly a panel shared by two
>>> boards, and some panels aren't even used by any board in mainline)
>>>
>>
>> A panel specific param should stay in the panel driver, it's something which
>> is specific to the panel and not the platform it is in
>>
> Yes it is board specific, but no it should not stay in the driver. The
> driver simply needs one compatible set of 15 numbers to do its job.

I agree that the panel on the 'current' platform just needs the 15 
numbers. The older way how this was done was to have a separate driver 
for each such panel. There used to be a ton of panel driver c files 
doing almost the same thing, having only these 15 parameters different. 
This was merged into one generic driver, with each panel's properties as 
an element of the array.

>
> Let me explain my point in detail....
> The array generic_dpi_panels[] is but a limited list of compatible
> configurations of a 'generic' panel. Each occupying ~20 lines in
> kernel. There would be dozens of supported panels that exist but are
> not listed in this array, and countless more that are possible to
> manufacture. If I submit a 2000 lines patch with only 100 such
> configurations you would have no reason to reject other than "I know
> what you mean" :)

I think I get what you mean now. You are saying that we should create a 
struct/member in DT which supports this class of dumb DPI panels. You 
are sort of reducing the panel to a set of parameters like resolution, 
hsync/vsync polarities.

It sort of makes sense, but this will be exclusive to such dumb DPI 
panels. The moment a panel becomes more complex, for example, have it's 
own register set, I guess we would need to have keep those properties in 
the panel driver, rather than DT.

I don't know much about DT. But are there other devices which are 
completely represented by DT? For example, would a keypad/keyboard's 
parameters be totally represented in the DT blob, i.e, the number of 
keys, the mappings etc?

>
>> It's true that currently omap platforms don't share the same panels, but
>> there is no stopping us to do that. We could remove the default panel and
>> attach a new one, even though we won't upstream non default panels in the
>> DT/board file, it would be always easier to make this change in software if
>> most of the panel specific info stays in the panel driver.
>>
> You mean you want to hardcode parameters in the driver instead of
> modifying the dtb that you pass to the kernel?

I meant that, but if we go with your approach, which sort of makes sense 
now, it would be in the dtb file.

>
>> Also, 2 platforms of different SoC's may use the same panel. Currently the
>> panel drivers are SoC specific, but there is work being done between
>> different display maintainers so that the same panel driver works across
>> different SoCs.
>>
> Doesn't that make the case for DT/platform_data even stronger?
>
> Of course you as a maintainer have the final say. I am out of ways to
> explain my point.

I get your point now. You are generalising/reducing a panel as a set of 
properties which can be linked to a platform. I didn't think of it that way.

One little negative I see with this approach though is the integrity of 
the panel parameters in the dtb file. If a person working on a new 
platform has a panel that's already in the 'list', he/she would only 
need to specify the name, and be assured that the driver has the right 
parameters to configure it. With the dtb way, if the person feeds a 
wrong value in the dtb, say an incorrect resolution, we'll be in 
trouble. But as I said, it's a little negative, it's not our fault if 
the dtb writer of the platform makes mistakes :)

I am not the maintainer, Tomi is :), we could wait for his comments once 
he's back from vacation.

Thanks,
Archit

