From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: omap3-igep0020: Add HS USB Host support
Date: Mon, 7 Oct 2013 12:22:03 +0200
Message-ID: <CAAwP0s0XHN+ynMH2Mrn4oNuDo1js86wY2vxkZ=+MG_2=Sgrt9Q@mail.gmail.com>
References: <1380931479-16142-1-git-send-email-javier.martinez@collabora.co.uk>
 <1380931479-16142-3-git-send-email-javier.martinez@collabora.co.uk>
 <525271D5.9070009@ti.com> <525275C8.2050208@collabora.co.uk>
 <5252799A.5030301@ti.com> <52527B21.5040602@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59198 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab3JGKWY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 06:22:24 -0400
In-Reply-To: <52527B21.5040602@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Roger Quadros <rogerq@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Oct 7, 2013 at 11:13 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> On 10/07/2013 11:06 AM, Roger Quadros wrote:
>>>
>>> Well that's a very good question indeed.
>>>
>>> The thing is that the IGEP0030 is a Computer-on-Module [1] that is used in
>>> conjunction with expansion boards and some of them have USB HOST support such as
>>> IGEP Paris [2] and IGEP Berlin [3].
>>>
>>> Support for this expansion boards is still not in mainline but there are plans
>>> to add them using Device Tree overlays [4] once/if this land on mainline.
>>>
>>
>> Why would your boards need Device Tree overlays? From the looks of it, the configuration
>> of SOM + base board don't seem to change at runtime.
>>
>
> Indeed, a static configuration (DTS) would be enough now that I think about it.
>

Hi Roger,

Now that I had coffee I remember why I think that even when Device
Tree overlays are not strictly required for a SOM + base board it
could be handy to use. If we use a static configuration (DTB) then the
same firmware can't be used by any IGEP COM Module user. She would
have to choose a DTB to pass to the kernel on boot.

While using DT overlays the same firmware that provides a minimal DTB
can be used regardless of the base board used (as long as there are
all the needed fragment/overlays hooks in the DTS).

After all the SOM has a NAND flash memory and a uSD/MMC slot so a
minimal DTB is needed to boot and the support for all the peripherals
present on the base board can be added by triggering a device tree
overlay load from user-space.

Or maybe I'm misunderstanding the use case for DT overlays since I had
just read about it but I don't have practical experience with it.

Thanks a lot and best regards,
Javier
