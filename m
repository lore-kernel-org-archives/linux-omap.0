From: Andy Gross <andy.gross@ti.com>
Subject: Re: Display related board specific boot args
Date: Fri, 22 Mar 2013 11:00:37 -0500
Message-ID: <514C8025.4080207@ti.com>
References: <514C1599.7080803@ti.com> <20130322151838.GB25575@atomide.com> <514C78F7.5050906@ti.com> <20130322153614.GC25575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49572 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754313Ab3CVQAi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Mar 2013 12:00:38 -0400
In-Reply-To: <20130322153614.GC25575@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On 03/22/2013 10:36 AM, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130322 08:34]:
>> On 2013-03-22 17:18, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130322 01:30]:
>>>> Hi Tony,
>>>>
>>>> As you probably know, Overo is a very basic omap board to which you can
>>>> attach different add-on modules, like LCD module. In the current overo
>>>> board file we always add multiple LCD devices, of which the user should
>>>> only use one (the one on his module). This model of allowing multiple
>>>> LCD devices on the same video bus is causing headaches in the dss land,
>>>> and I'm removing support for it.
>>>
>>> OK yes sounds like they should be all selectable, and only the selected
>>> one gets initialized.
>>>
>>>> So what we should do is add only the LCD device that you actually have
>>>> attached. With DT this will probably be handled with separate dts files,
>>>> depending on the add-on module.
>>>>
>>>> How should this be handled with board files? Is it ok to add a board
>>>> specific kernel boot argument, parsed in the board file, which tells the
>>>> add-on board?
>>>
>>> At this point I'd stay away adding any kind of custom handling to the
>>> board-*.c files as that will make the task of removing them harder. And
>>> a kernel boot argument is something we'd have to support in the future.
>>> So if something gets added, it should be a Linux generic boot argument.
>>>
>>> Some of these add on boards can be detected over i2c, but it seems as
>>> DT is the way to go in the long run in this case.
>>>
>>>> We have similar situation in some other boards also.
>>>
>>> Yeah. There's the capebus coming that might even allow hotplugging
>>> some of these add on boards eventually.
>>>
>>> How about just make PANEL_LGPHILIPS_LB035Q02 depends on !PANEL_XYZ_DPI
>>> in drivers/video/omap2/displays/Kconfig and add some comments for now?
>>>
>>> That way people can still select LB035Q02 but not for generic
>>> configurations.
>>
>> Well, I don't want to disable a panel driver totally because of one
>> board. And it's more complex than that. For overo we have three displays
>> on the same DPI bus (using the names assigned in the board file): dvi,
>> lcd43, lcd35. So even if the LB035Q02 would be disabled, we have dvi and
>> lcd43 which conflict.
>>
>> I also would stay away from custom boot args. So I guess that leaves us
>> only the compile time option. Either so that the overo board-file needs
>> to be modified by the user to change the add-on board, or a Kconfig
>> option to select the add-on board under "TI OMAP2/3/4 Specific Features"
>> menu.
>>
>> Would the Kconfig option be acceptable?
>
> Yes I think that's better than cmdline option in this case considering that
> the cmdline option won't be needed at some point in the future.

Barring the hotplug infrastructure, the Kconfig sounds like the best 
option to me.


BR,
Andy

