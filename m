From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PATCH[V2 1/3]: Update Platform files for SPI
Date: Tue, 16 Feb 2010 14:02:19 -0700
Message-ID: <fa686aa41002161302l4c15f034t4629dbac61c2ff29@mail.gmail.com>
References: <9629.10.24.255.17.1265192505.squirrel@dbdmail.itg.ti.com>
	<20100209222513.GJ21755@atomide.com> <fa686aa41002091440p588ad328i14d0fb28390b2672@mail.gmail.com>
	<20100209230710.GL21755@atomide.com> <20100212214825.GV21755@atomide.com>
	<45106.10.24.255.18.1266331093.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f185.google.com ([209.85.223.185]:33635 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933294Ab0BPVCl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 16:02:41 -0500
Received: by iwn15 with SMTP id 15so5704000iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Feb 2010 13:02:39 -0800 (PST)
In-Reply-To: <45106.10.24.255.18.1266331093.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net

On Tue, Feb 16, 2010 at 7:38 AM, Hemanth V <hemanthv@ti.com> wrote:
>> * Tony Lindgren <tony@atomide.com> [100209 15:03]:
>>> * Grant Likely <grant.likely@secretlab.ca> [100209 14:38]:
>>> > On Tue, Feb 9, 2010 at 3:25 PM, Tony Lindgren <tony@atomide.com> =
wrote:
>>> > > * Hemanth V <hemanthv@ti.com> [100203 02:19]:
>>> > >> From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00=
:00 2001
>>> > >> From: Hemanth V <hemanthv@ti.com>
>>> > >> Date: Fri, 27 Nov 2009 14:22:30 +0530
>>> > >> Subject: [PATCH] Update platform files
>>> > >>
>>> > >> This patch updates platform files for
>>> > >> fifo, slave support
>>> > >>
>>> > >> Signed-off-by: Hemanth V <hemanthv@ti.com>
>>> > >
>>> > > This should get merged via the spi-devel list with the other pa=
tches.
>>> > >
>>> > > Acked-by: Tony Lindgren <tony@atomide.com>
>>> >
>>> > Personally, I prefer not to carry arch/* changes in my next-spi
>>> > branch, since it means that my pull requests are less obvious for
>>> > Linus and there is greater chance of conflict.
>>> >
>>> > But if you still really want me to merge it through my tree, (or =
if
>>> > getting the patches out of order will break things) then I'll pic=
k it
>>> > up. =A0Just let me know.
>>>
>>> OK, if you ack it, I'll add the header into omap for-next. That
>>> might break git bisect for some configurations depending in which
>>> order the patches get pulled by Linus..
>>>
>>> I guess eventually this header should not live under plat.
>>
>> Hemanth, the patch is missing line breaks so it won't apply:
>>
>> http://patchwork.kernel.org/patch/76675/
>>
>> Please resend, I'm not editing patches manually any longer thanks.
>>
>> Regards,
>>
>> Tony
>>
> Pl find the patches attached, hopefully it doesnot get corrupted this
> time

This one is okay, and I've got it in my tree, but I need patches 2 and
3 resent also.

Thanks,
g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
