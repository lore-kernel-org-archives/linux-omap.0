From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
Date: Sat, 22 May 2010 01:09:12 +0300
Message-ID: <AANLkTin03gFY1uc9__lGO8lHiKMjuSBRSYcFDhLYDIMD@mail.gmail.com>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
	 <20100521215730.GK11042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41669 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758577Ab0EUWJO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 18:09:14 -0400
Received: by bwz7 with SMTP id 7so206506bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 15:09:13 -0700 (PDT)
In-Reply-To: <20100521215730.GK11042@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Felipe Contreras <felipe.contreras@nokia.com>

On Sat, May 22, 2010 at 12:57 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, May 22, 2010 at 12:44:32AM +0300, Felipe Contreras wrote:
>> [no changes since the last v2, just rebased on top of the latest
>> git://gitorious.org/~doyu/lk/mainline.git for-tony-mailbox]
>>
>> Currently, the code is split into three places:
>> 1) mach-omapX/devices.c: for platform_device_register() the resource=
s
>> 2) mach-omapX/mailbox.c: do platform_driver_register(), fetch the re=
sources,
>> =C2=A0 =C2=A0and register logical mailboxes with omap_mbox_register(=
)
>> 3) plat-omap/mailbox.c: implement omap_mbox_register() to add the mb=
ox
>> =C2=A0 =C2=A0to an internal linked list (static struct omap_mbox *mb=
oxes)
>>
>> So, obviously 1) is always built-in, but 2) can't be because of the
>> dependency of omap_mbox_register(), which is in 3) and cannot be tak=
en
>> out.
>>
>> Users of mailbox will load 3) due to omap_mbox_get(), but not 2),
>> therefore, no mailboxes will be registered.
>
> This doesn't make sense - why would 3 be loaded due to the dependency
> which comes from 2, but not 2?

All the exported functions, including omap_mbox_get(), are in 3).

2) depends on 3) because 3) implements omap_mbox_register(). 3)
doesn't depend on 2).

> The only reason 3 would be loaded due to that dependency is if 2 were
> being modprobed, which means it's going to be inserted after 3 anyway=
=2E
>
> I don't see anything else in 3 which would trigger it to be loaded.
>
> The "platform:omap2-mailbox" module alias of 2 should result in 2
> being modprobed,

I see, at initialization?

> causing 3 to be loaded to satisfy the dependency.
> As already pointed out, this should happen as a result of udev or
> (older) hotplug initialization.

Well, in the minimal system I have in my beagleboard it doesn't
happen. I load bridgedriver, which loads mailbox, but fails
immediately because mailbox_mach is not there.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
