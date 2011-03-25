From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: 2.6.38 not booting on sbc8100 (aka devkit8000)
Date: Fri, 25 Mar 2011 08:57:04 +0100
Message-ID: <AANLkTimdQKo40r9FzhHe94uAF28qGLcf5_5ZzcOrJuTA@mail.gmail.com>
References: <AANLkTikAO+FA+0fCNiVj=9wVZ3t+vfx9tJX_SnJ7FGSd@mail.gmail.com>
	<20110324151844.GT2811@atomide.com>
	<AANLkTik8PW4ad2_4=UxzvL-V7HcpH0=dg-Un5NLkj6Yi@mail.gmail.com>
	<20110324190030.GW2811@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58421 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab1CYH5E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 03:57:04 -0400
Received: by iyb14 with SMTP id 14so239651iyb.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 00:57:04 -0700 (PDT)
In-Reply-To: <20110324190030.GW2811@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, Mar 24, 2011 at 8:00 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Belisko Marek <marek.belisko@gmail.com> [110324 08:18]:
>> On Thu, Mar 24, 2011 at 4:18 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
>>
>> > * Belisko Marek <marek.belisko@gmail.com> [110324 02:50]:
>> > > Hi,
>> > >
>> > > Try to run 2.6.38 on my sbc8100
>> > > (use mach-type for devkit8000 because boards are similar) board =
but
>> > > when u-boot load it to ram I see just:
>> > > ## Booting kernel from Legacy Image at 80300000 ...
>> > > =C2=A0 =C2=A0Image Name: =C2=A0 Linux-2.6.38-06570-g79c21b4
>> > > =C2=A0 =C2=A0Image Type: =C2=A0 ARM Linux Kernel Image (uncompre=
ssed)
>> > > =C2=A0 =C2=A0Data Size: =C2=A0 =C2=A02967164 Bytes =3D =C2=A02.8=
 MB
>> > > =C2=A0 =C2=A0Load Address: 80008000
>> > > =C2=A0 =C2=A0Entry Point: =C2=A080008000
>> > > =C2=A0 =C2=A0Verifying Checksum ... OK
>> > > =C2=A0 =C2=A0Loading Kernel Image ... OK
>> > > OK
>> > > Starting kernel ...
>> > >
>> > > I have changed bootargs to: bootargs=3Dconsole=3DttyO2,115200n8 =
doesn't
>> > > help. Any ideas what could be checked?
>> >
>> > Can you enable DEBUG_LL and EARLY_PRINTK in your .config
>> > and add earlyprintk to your cmdline? Then you should see
>> > what goes wrong.
>> >
>> Forgot to mention. I already test this options but result is same li=
ke I
>> report in
>> first email.
>
> Maybe add some printk statements to start_kernel function in
> init/main.c and see if you get any output?
Add some printk to function you propose bu no output.
>
> Tony
>

regards,

marek

--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
