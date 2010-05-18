From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Tue, 18 May 2010 22:58:35 +0300 (EEST)
Message-ID: <20100518.225835.116348725.Hiroshi.DOYU@nokia.com>
References: <AANLkTim5SxEb64QbBQgBhufhgpQ33MNFBhuHixfUeVKp@mail.gmail.com>
	<20100518.163145.232774311.Hiroshi.DOYU@nokia.com>
	<AANLkTik_FL2keLD9mdBcg8Rm9n8uYDElg1NdyeT2yy6B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42753 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155Ab0ERT7Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 15:59:16 -0400
In-Reply-To: <AANLkTik_FL2keLD9mdBcg8Rm9n8uYDElg1NdyeT2yy6B@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux@arm.linux.org.uk

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Tue, 18 May 2010 18:57:55 +0200

> On Tue, May 18, 2010 at 4:31 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com=
> wrote:
>> From: ext Felipe Contreras <felipe.contreras@gmail.com>
>>> I'm not familiar with this kind of module loading, but certainly no=
t
>>> all systems have udev.
>>>
>>> I realized the problem because I have a bare-bones system in my
>>> beagleboard where I had to manually load mailbox_mach.
>>
>> With udev or something equivalent, it should work fine.
>=20
> But still, you are relying on udev. I don't think we should, and I
> don't think there's any need.

Some expert may give some comment here.....

>>>> The platform device omap2-mailbox accomodatess logical mboxes.
>>>
>>> Wouldn't it be better the way my patches handle them?
>>> =A0* devices.ko: =A0doesn't care about mbox
>>> =A0* mach_omap1/mailbox.ko: =A0registers "omap-mailbox" platform de=
vice
>>> with a list of logical mboxes for OMAP1
>>> =A0* mach_omap2/mailbox.ko: =A0registers "omap-mailbox" platform de=
vice
>>> with a list of logical mboxes for OMAP2
>>> =A0* plat-omap/mailbox.ko: creates platform driver based on logical=
 list
>>> of mboxes from platform device and handles the list internally
>>>
>>> The end result would be the exactly same, except that there's no ha=
rd
>>> dependency between the mach, and plat code.
>>
>> With the attachemnt, which is just 17 lines of code, you will get th=
e
>> structure of logical mbox devices, which are located under the singl=
e
>> platform device, "omap2-mailbox". This is more _descriptive_ since
>> it displays the connection of a platform device and logical devices,
>> IOW, where these logical ones come. I don't see any point of not usi=
ng
>> this struture.
>=20
> That's neat. Am I understanding correctly that that's not an argument
> against the split of mailbox_mach and plat mailbox?

I may not get your point. That's just 17 lines of code, nothing else.

>>>> Would it be possible to rebase them on the top of my coming patch =
to
>>>> get back logical device entry?
>>>
>>> Where is that?
>>
>> Attached. Would it be possible to rebase the cleanups on this one?
>=20
> I think it would be easier to apply the patch on top of my patch
> series... specially since it's so small. Would that be acceptable?

I can pick up some of your cleanups if applied on the previous attachem=
nt.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
