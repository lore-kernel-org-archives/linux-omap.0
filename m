From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 12:46:18 +0200
Message-ID: <CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
	<20120204190109.GL20333@atomide.com>
	<20120204203453.GD17309@n2100.arm.linux.org.uk>
	<20120205012556.GG1426@atomide.com>
	<20120205125904.GB11372@n2100.arm.linux.org.uk>
	<20120205172925.GS20333@atomide.com>
	<20120205175809.GF17309@n2100.arm.linux.org.uk>
	<20120205182910.GK1426@atomide.com>
	<87lioegtk9.fsf@ti.com>
	<87y5sei1qz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64934 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517Ab2BHKqT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 05:46:19 -0500
Received: by iacb35 with SMTP id b35so705842iac.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 02:46:18 -0800 (PST)
In-Reply-To: <87y5sei1qz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, gregkh@linuxfoundation.org

On Wed, Feb 8, 2012 at 2:53 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kevin Hilman <khilman@ti.com> writes:
>
>> Tony Lindgren <tony@atomide.com> writes:
>>
>> [...]
>>
>>>> Basically, it looks like the OMAP 3 UART is not delivering transmi=
t IRQs
>>>> while in some of the deeper low power modes.
>>>>
>>>> I tried reverting the rest of the patches between this one and HEA=
D for
>>>> omap-serial.c, but they have no effect what so ever on this bug. =C2=
=A0As I
>>>> said in one of my emails in this thread, the above commit can't be
>>>> trivially reverted because some other stuff that the code relied u=
pon
>>>> has vanished.
>>>>
>>>> So, the above along with the other part in arch/arm/mach-omap2/cpu=
idle34xx.c
>>>> is the smallest 'fix' I could find if resolving the regression.
>>>
>>> OK, thanks, that should be enough info for let Kevin take a look at=
 this.
>>
>> This one is indeed strange. =C2=A0I have not seen this on the 34xx d=
evices
>> I'm using (3430/n900, 3530/Overo, 3630/Zoom3).
>
> OK, I've reproduced this on v3.3-rc2.
>
> The reason I wasn't seeing this is because I'm using the fixes Paul h=
as
> already posted that fix this problem:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://marc.info/?l=3Dlinux-arm-kernel&m=3D=
132754676814391&w=3D2
>
> Kevin

But it looks like these are now queued for 3.4 in tty tree?


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
