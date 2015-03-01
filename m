From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: Enabling DBGEN signal in GP OMAP3
Date: Sun, 1 Mar 2015 02:03:57 +0200
Message-ID: <CANOLnOMSbAM1bnAPFQt4Pk-rzZMS=q8Uu62F_x=hxBCLqCu2rg@mail.gmail.com>
References: <CANOLnOOpzK9BvaOk+bgREPBEKs+OErf_1DfXmefSDweb4XjNxg@mail.gmail.com>
	<20150216175826.GT2531@atomide.com>
	<CAALWOA_JZgWWKvFnDmzZRTSqFVJPZOEar1L0D7KR5VoU_7FqCg@mail.gmail.com>
	<CANOLnOO6HWtptks+TXbJEim9fhk5mp5q94gg1wva77x4H7c3pg@mail.gmail.com>
	<CAALWOA_DWjDkmnTj1h0EaSKPeJB_Xd+8YAa6Yv=_HgH9W+ijWA@mail.gmail.com>
	<CANOLnOOgTtTeg_OBvJSGy9OOwdA65omwN=_8Webt8M5E6DoJbg@mail.gmail.com>
	<CAALWOA_Hj4bNHX2LX8w_vBBaThpnwQ+=JxScF710vc_itEfV4Q@mail.gmail.com>
	<CAALWOA_Vw=1xC=yUYJBUhp4QqZWvk+EsiLSB=J7+EQmBMTgEkQ@mail.gmail.com>
	<CANOLnOOBHmHjydhtH3_gL9D+ZPWywxsXHtn9RRaNWCSJb50Cnw@mail.gmail.com>
	<CAALWOA8k44uQvQK18qvGRgOYDY3n5xKow4t94c+FyH8u79_BBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42984 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbbCAAD7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Feb 2015 19:03:59 -0500
Received: by lbiw7 with SMTP id w7so23706033lbi.9
        for <linux-omap@vger.kernel.org>; Sat, 28 Feb 2015 16:03:58 -0800 (PST)
In-Reply-To: <CAALWOA8k44uQvQK18qvGRgOYDY3n5xKow4t94c+FyH8u79_BBw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>

On Thu, Feb 26, 2015 at 5:14 AM, Matthijs van Duin
<matthijsvanduin@gmail.com> wrote:
> Thinking of it... unless the control module and relevant GPIO module
> are connected to the same L4 interconnect (which they aren't in my
> test case) I should actually perform at least a dummy read (aka "OCP
> barrier") from the control module before accessing GPIO since
> otherwise it's not even guaranteed that all writes to the control
> module have completed. Joy.
>
> If you want guaranteed reliability, modify tck_pulse() to insert
> aforementioned barrier + an actual delay at all three points where I
> put comments about them.  usleep(50) or so should do the job.

Adding just the barrier works reliably for me, even at 1GHz.

>> I guess I'll still connect TDO as it's not so much fun without it,
>> going to try connecting to EMU0 too, hopefully it doesn't mess up th=
e
>> boot modes.
>
> Note that you can use *any* gpio. I just used one of the EMU pins
> because the am335x lets you reconfigure those to GPIO and it was
> conveniently nearby.

Same here for me, this allowed to avoid adding a long wire which could
interfere with case parts, etc.
I've already performed the mod (just a solder bridge) and it works fine=
=2E

On Thu, Feb 26, 2015 at 6:01 AM, Matthijs van Duin
<matthijsvanduin@gmail.com> wrote:
> On 26 February 2015 at 02:09, Grazvydas Ignotas <notasas@gmail.com> w=
rote:
>
>> Anyway I'm attaching my code too
>
> Ah, if this works then apparently the omap3 control module doesn't
> check privilege.

Yeah, even OMAP5 doesn't do it for me.

> BTW, is this comment in hw-omap3.h true?
>
>> 0x23'002100, // assert cortex-a8 DBGEN
>
> My impression was that bit 13 of DAP's tap control register either
> does nothing or at most enables the DAPCTL registers to be written,
> but that setting bit 13 of the DAP_PC_FER register would still be
> needed to assert DBGEN.

Yes you're right, I've cleared bit 13 and everything works same way as
before, and in all cases additional ap_write() is needed to actually
set DBGEN.

>
> Also,
>
>> // address of cortex-a8 debug regs on debug APB
>> constexpr u32 a8_debug =3D 0x54011'000;
>
> If bit 31 isn't set, then these writes should (afaik) be equivalent t=
o
> just performing them directly through the interconnect instead of
> using JTAG.

I don't know about that... To enable DBGEN, I just do:
ap_write( 0x5401d030, 0x00002000 );
and it works. Using 0xd401d030 seems to work too.


Thanks again,
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
