From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Tue, 5 Oct 2010 13:36:08 +0800
Message-ID: <AANLkTimtfm+Tq6y=Gv=-JWEZ-1CYUpsO71aE0AjkSbHQ@mail.gmail.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com>
	<4CA9C5F6.7060902@ti.com>
	<AANLkTi=C55AbJhCWkFAM06vL2c5UM=aH3z2r8i4_55Mk@mail.gmail.com>
	<AANLkTin++-F7dZWhqM6DG4v-95rfOpOwHSqj8xhTdS3k@mail.gmail.com>
	<87wrpy0xp3.fsf@deeprootsystems.com>
	<AANLkTi=k+aZ2t2ZgXMcwuoBVPEjzyiGov1ZmSxe+Pe4-@mail.gmail.com>
	<87iq1hzt3u.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43811 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab0JEFgK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 01:36:10 -0400
Received: by wwj40 with SMTP id 40so5152982wwj.1
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 22:36:09 -0700 (PDT)
In-Reply-To: <87iq1hzt3u.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Pramod <pramod.gurav@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2010/10/5 Kevin Hilman <khilman@deeprootsystems.com>:
> Ming Lei <tom.leiming@gmail.com> writes:
>
>> 2010/10/4 Kevin Hilman <khilman@deeprootsystems.com>:
>>>
>>> Why? =A0What do you need from the PM branch that is not in l-o mast=
er?
>>
>> Seems master branch works fine for me, my beagle board doesn't hang
>> uart3 disabling clocks.
>
> Master branch and PM branch have exactly the same functionality for
> UART hwmods. =A0The problem was that you manually enabled DEBUG in
> omap_hwmod.c.

Yes, you are correct. If DEBUG in omap_hwmod.c is enabled manually,
and pass the parameter of 'earlyprintk loglevel=3D8' to kernel from boo=
tloader,
this issue can be triggered even with master branch.

>
>> I only want to have a try of the runtime pm feature of omap3, so use
>> PM branch to do the test.
>
> master branch and PM branch have exactly the same functionality for
> runtime PM

Thanks for letting me know it.

thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
