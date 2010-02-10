From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: PATCH[V2 1/3]: Update Platform files for SPI
Date: Wed, 10 Feb 2010 15:33:51 +0530 (IST)
Message-ID: <34696.10.24.255.18.1265796231.squirrel@dbdmail.itg.ti.com>
References: <9629.10.24.255.17.1265192505.squirrel@dbdmail.itg.ti.com>
    <20100209222513.GJ21755@atomide.com>
    <fa686aa41002091440p588ad328i14d0fb28390b2672@mail.gmail.com>
    <20100209230710.GL21755@atomide.com>
    <fa686aa41002091610y59d55626nf783fa2f5b8171e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36445 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536Ab0BJKEE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Feb 2010 05:04:04 -0500
In-Reply-To: <fa686aa41002091610y59d55626nf783fa2f5b8171e9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Tony Lindgren <tony@atomide.com>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net

> On Tue, Feb 9, 2010 at 4:07 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
>> * Grant Likely <grant.likely@secretlab.ca> [100209 14:38]:
>>> On Tue, Feb 9, 2010 at 3:25 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
>>> > * Hemanth V <hemanthv@ti.com> [100203 02:19]:
>>> >> From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00:0=
0 2001
>>> >> From: Hemanth V <hemanthv@ti.com>
>>> >> Date: Fri, 27 Nov 2009 14:22:30 +0530
>>> >> Subject: [PATCH] Update platform files
>>> >>
>>> >> This patch updates platform files for
>>> >> fifo, slave support
>>> >>
>>> >> Signed-off-by: Hemanth V <hemanthv@ti.com>
>>> >
>>> > This should get merged via the spi-devel list with the other patc=
hes.
>>> >
>>> > Acked-by: Tony Lindgren <tony@atomide.com>
>>>
>>> Personally, I prefer not to carry arch/* changes in my next-spi
>>> branch, since it means that my pull requests are less obvious for
>>> Linus and there is greater chance of conflict.
>>>
>>> But if you still really want me to merge it through my tree, (or if
>>> getting the patches out of order will break things) then I'll pick =
it
>>> up. =A0Just let me know.
>>
>> OK, if you ack it, I'll add the header into omap for-next. That
>> might break git bisect for some configurations depending in which
>> order the patches get pulled by Linus..
>
> git bisect breakage is breakage enough.  :-)  You're right.  I should
> pick this one up.  I can see that now that I've had my tea and I'm no
> longer grumpy.
>
>> I guess eventually this header should not live under plat.
>
> Any reason the header cannot be moved to include/linux/spi/ now?

Quite a few board files use this header file, which would also require =
changes.
Tony, are you ok with accepting changes to board files.

Thanks
Hemanth
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
