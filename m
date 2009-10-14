From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: patch: add omap730 / omap850 rtc support
Date: Wed, 14 Oct 2009 19:39:47 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF88D@dbde02.ent.ti.com>
References: <3ea34a000910130433i36a3ac7esc6b8e7c6588185f4@mail.gmail.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF600@dbde02.ent.ti.com>
	 <3ea34a000910140126p3352a5aej50300a39521f1128@mail.gmail.com>
	 <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF6EE@dbde02.ent.ti.com>
 <3ea34a000910140627w53dffe59l977a78b866c50d8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33467 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933232AbZJNOKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 10:10:30 -0400
In-Reply-To: <3ea34a000910140627w53dffe59l977a78b866c50d8a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christopher Friedt <chrisfriedt@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Christopher Friedt [mailto:chrisfriedt@gmail.com]=20
> Sent: Wednesday, October 14, 2009 6:58 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org
> Subject: Re: patch: add omap730 / omap850 rtc support
>=20
> On Wed, Oct 14, 2009 at 11:52 AM, G, Manjunath Kondaiah=20
> <manjugk@ti.com> wrote:
> > You can acheive the same using only enum with following:
> >
> > #define OMAP_RTC_REGISTER_SIZE (cpu_is_omap7xx()?1:4)
> > #define rtc_read(reg)
> > =A0 =A0 =A0 =A0omap_readb(OMAP_RTC_BASE + (reg * OMAP_RTC_REGISTER_=
SIZE))
>=20
> That was my first instinct too, but then I thought that one of the
> register offsets wasn't related by a factor of 4 (when I made the
> patch originally it was ~ 2am and I was very tired), which convinced
> me to do a quick & easy static array implementation.
>=20
> Thanks for your suggestion.

You can add reserve register offsets into enum array to fix the issue=20
of register offsets not in sequence like:
enum omap_rtc_regs {
	SECONDS_REG =3D 0,
	MINUTES_REG,
	HOURS_REG,
	DAYS_REG,
	MONTHS_REG,
	YEARS_REG,
	WEEKS_REG,
	RESV_REG_1,
	ALARM_SECONDS_REG,
	ALARM_MINUTES_REG,
	ALARM_HOURS_REG,
	ALARM_DAYS_REG,
	ALARM_MONTHS_REG,
	ALARM_YEARS_REG,
	RESV_REG_2,
	RESV_REG_3,
	CTRL_REG,
	STATUS_REG,
	INTERRUPTS_REG,
	COMP_LSB_REG,
	COMP_MSB_REG,
};

>=20
> Regarding the 50 -> 35 change, I think it's clearly safe to do. I hav=
e
> no objections.
>=20
> C
>
=20
Ok. Change the value to 35.

-Manjunath

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
