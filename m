From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
	please read
Date: Tue, 29 Sep 2009 22:42:52 +0300
Message-ID: <71a0d6ff0909291242w30cc879erbf6021324989abe3@mail.gmail.com>
References: <20090928190404.GE18957@atomide.com>
	 <94a0d4530909291024kcac6b20m727b2908b2a76b88@mail.gmail.com>
	 <20090929182639.GA16865@atomide.com>
	 <71a0d6ff0909291220ve586b41s7c75ff580f34cb95@mail.gmail.com>
	 <A24693684029E5489D1D202277BE89444B781B7C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:49620 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbZI2Tmt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 15:42:49 -0400
Received: by ey-out-2122.google.com with SMTP id 4so350747eyf.19
        for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2009 12:42:52 -0700 (PDT)
In-Reply-To: <A24693684029E5489D1D202277BE89444B781B7C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2009/9/29 Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com>:
> From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.=
org] On Behalf Of Alexander Shishkin [virtuoso@slind.org]
> Sent: Tuesday, September 29, 2009 2:20 PM
>> 2009/9/29 Tony Lindgren <tony@atomide.com>:
>> > * Felipe Contreras <felipe.contreras@gmail.com> [090929 10:24]:
>> >> On Mon, Sep 28, 2009 at 10:04 PM, Tony Lindgren <tony@atomide.com=
> wrote:
>> >> > Hi all,
>> >> >
>> >> > I've updated our linux-omap tree to v2.6.32-rc1. I've also
>> >> > added a branch omap-2.6.31 for the old code.
>> >> >
>> >> > This time I also nuked the remaining omap legacy code we
>> >> > still had lurking around :) The commits at the end of this
>> >> > mail describe what I did first as commits, then I merged
>> >> > everything to be the same as the mainline v2.6.32-rc1.
>> >> >
>> >> > So currently the linux-omap master branch is:
>> >> >
>> >> > v2.6.32-rc1 + omap-fixes + ehci + cbus
>> >> >
>> >> > The new model is that I'll be resetting the linux-omap master
>> >> > branch to mainline at each -rc, then merge in our various
>> >> > upstream queues back in again.
>> >>
>> >> Excellent! I was wondering why this wasn't being done. I certainl=
y
>> >> hope linus' 2.6.32 will work on omap right away.
>> >
>> > Yeah, let's hope Tomi gets in the DSS2 code too.
>> >
>> >> Anyway, I haven't been able to make 2.6.31 boot on beagleboard, a=
nd
>> >> other people report similar issues:
>> >> http://www.spinics.net/lists/linux-omap/msg17968.html
>> >>
>> >> Have you got 2.6.32-rc1 (+fixes) to boot?
>> >
>> > Hmm, looks like it's musb again. This is what I get on my
>> > overo after applying the DEBUG_LL hack from omap-debug branch:
>> >
>> > <3>musb_hdrc musb_hdrc: musb_init_controller failed with status -1=
9
>> > <1>Unable to handle kernel NULL pointer dereference at virtual add=
ress 00000000
>> > <1>pgd =3D c0004000
>> > <1>[00000000] *pgd=3D00000000
>> > Internal error: Oops: 5 [#1]
>> > <d>Modules linked in:
>> > CPU: 0 =C2=A0 =C2=A0Not tainted =C2=A0(2.6.32-rc2-05967-gd350540-d=
irty #892)
>> > PC is at musb_free+0x68/0xb8
>> > LR is at musb_free+0x34/0xb8
>
> <snip>
>
>> >
>> > After disabling musb, it boots further but can't mount root on the=
 MMC:
>> >
>> > ...
>> > <4>regulator_init_complete: incomplete constraints, leaving VUSB1V=
8 on
>> > regulator_init_complete: incomplete constraints, leaving VUSB1V8 o=
n
>> > <4>regulator_init_complete: incomplete constraints, leaving VUSB1V=
5 on
>> > regulator_init_complete: incomplete constraints, leaving VUSB1V5 o=
n
>> > <4>regulator_init_complete: incomplete constraints, leaving VMMC1 =
on
>> > regulator_init_complete: incomplete constraints, leaving VMMC1 on
>> > <6>twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:=
00:00 UTC (94)
>> > twl4030_rtc twl4030_rtc: setting system clock to 2000-01-01 00:00:=
00 UTC (94668)
>> > <6>Waiting for root device /dev/mmcblk0p2...
>> > Waiting for root device /dev/mmcblk0p2...
>> >
>> > What are you getting with DEBUG_LL enabled and the associated patc=
h applied
>> > from omap-debug branch?
>> MUSB enabled gives me the same backtrace. When I disable it, I get
>> (this is beagle B6):
>>
>> <1>Unable to handle kernel NULL pointer dereference at virtual addre=
ss 00000000
>> <1>pgd =3D c0004000
>> <1>[00000000] *pgd=3D00000000
>
> <snip>
>
> Hi,
>
> Can you please try attached patch?

Yep, thanks! (provided it's actually the same patch that Toni referred =
to).
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
