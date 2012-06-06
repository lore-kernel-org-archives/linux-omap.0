From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Please help! AM35xx mm/slab.c BUG
Date: Wed, 6 Jun 2012 08:53:41 -0700 (PDT)
Message-ID: <1338998021.81010.YahooMailNeo@web125203.mail.ne1.yahoo.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com> <20120605070853.GE12766@atomide.com> <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com> <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com> <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com> <20120606071024.GP12766@atomide.com> <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com> <20120606084123.GU12766@atomide.com> <4FCF32DB.7000208@bitmer.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm18-vm2.bullet.mail.ne1.yahoo.com ([98.138.91.94]:47286 "HELO
	nm18-vm2.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754738Ab2FFPxn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jun 2012 11:53:43 -0400
In-Reply-To: <4FCF32DB.7000208@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All,

Thanks for all your input and time.=A0 We'll try rolling our sleeves up=
 and looking at these GPMC timings again.=A0 Looking through those link=
s I shared previously, it looks like the AM35xx GPMC may be setup a bit=
 differently than the OMAP or DM.=A0 What items should I be taking into=
 account as we try to draft this up ourselves?=A0 For instance, from (h=
ttp://e2e.ti.com/support/dsp/sitara_arm174_microprocessors/f/416/t/4939=
4.aspx), it appears that my L3 clock should be set to 166MHz and GPMC_F=
CLK should be 83MHz.=A0 My source is new enough that it now includes th=
e various patches to enable the MPU to run at 600MHz instead of 500MHz.=
=A0 (This patch is part of that:=A0 http://lists.denx.de/pipermail/u-bo=
ot/2012-February/117018.html.=A0 There were more, but I couldn't find t=
hem quickly when pulling this email together.)=A0 Does that adjust anyt=
hing here with respect to these GPMC calculations, or is the L3 held st=
eady so it does not matter?


After all that crashing yesterday and the day before, we setup some add=
itional tests, and now it seems we can't break it...=A0 This is precise=
ly why we've had to keep hunting for this thing for so long.=A0 It rear=
s its ugly head and crashes us a ton, only to disappear back into the v=
apor.

Thanks again for all your help and time.=A0 If we get any more points o=
f interest I'll certainly share.



----- Original Message -----
=46rom: Jarkko Nikula <jarkko.nikula@bitmer.com>
To: Tony Lindgren <tony@atomide.com>
Cc: CF Adad <cfadad@rocketmail.com>; "Shilimkar, Santosh" <santosh.shil=
imkar@ti.com>; "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org=
>
Sent: Wednesday, June 6, 2012 6:37 AM
Subject: Re: Please help! AM35xx mm/slab.c BUG

my 2 cents.

On 06/06/2012 11:41 AM, Tony Lindgren wrote:
> * CF Adad <cfadad@rocketmail.com> [120606 00:55]:
>>
>> Do you folks know of a good reference for properly calculating these=
 GPMC settings?
>=20
> In theory you just need to know the timings of connected components,
> then check which ones depend on cycles and which ones depend on time.
>=20
I afraid paper-and-pencil gpmc exercise is often required but after tha=
t
it is more easy to see from charts if e.g. original settings were not
optimal or too near to edge. Helps to understand and point possible
problems on oscilloscope measurements too.

> Also take into account latencies added by level shifters if you have =
those.
> Paul Walmsley noticed a few years ago that those affected the smsc911=
x
> timings if not accounted for.
>=20
I've noticed the same. Even one-directional level shifters easily add a
few ns and double amount in read operation since then there are two
level shifters in a path: one in clk/cs/oe/etc cpu-to-chip signal and
one on chip-to-cpu side.

Pay also attention if there are extra latencies in chip. Chip memory
reads/writes may be slower than chip register access (probably similar
than smsc fifo issue what Tony mentioned earlier in this thread).

--=20
Jarkko

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
