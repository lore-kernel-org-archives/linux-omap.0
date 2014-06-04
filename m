From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 2/2] power: twl4030_charger: attempt to power off in
 case of critical events
Date: Wed, 4 Jun 2014 08:01:42 -0500
Message-ID: <538F18B6.7070102@ti.com>
References: <1401313610-14252-1-git-send-email-nm@ti.com>	<1401313610-14252-3-git-send-email-nm@ti.com> <CANOLnOPb1xbqb5WXaK5-kdCezVuDhNxTtE5VV_MbCi4WTd2=oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANOLnOPb1xbqb5WXaK5-kdCezVuDhNxTtE5VV_MbCi4WTd2=oA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: dbaryshkov@gmail.com, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, dwmw2@infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 06/04/2014 05:04 AM, Grazvydas Ignotas wrote:
> On Thu, May 29, 2014 at 12:46 AM, Nishanth Menon <nm@ti.com> wrote:
>> Attempt to power off in case of critical events such as battery remo=
val,
>> over voltage events.
>>
>> There is no guarentee that we'd be in a safe scenario here, but the =
very
>> least we can try to do is to power off the device to prevent damage =
to
>> the system instead of just printing a message and hoping for the bes=
t.
>=20
> At least "battery temperature out of range" does seem to happen quite
> often while charging on hot summer day. I'd prefer my pandora to not
> shutdown in such case, it could just stop charging instead.
Yeah, We could call
  twl4030_charger_enable_ac(false);
  twl4030_charger_enable_usb(bci, false);

But then, is that sufficient?
=46rom the TRM:
7.5.8 Battery Temperature Out-of-Range Detection
Battery temperature out-of-range detection detects whether the battery
temperature is within a specific
range. Detection is possible for two temperature ranges. When the
battery temperature is not in the
2=E2=80=9350=C2=B0C range or is in the 3=E2=80=9343=C2=B0C range, the T=
BATOR1 and TBATOR2 status
bits rise and an interrupt is
generated.
This MADC monitoring function can be enabled by writing to the
TBATOR1EN (BCIMFEN2[3]) and
TBATOR2EN (BCIMFEN2[1]) fields.

Battery pack at high temperature is a risk, no? and it may not be just
charger that might be causing such a condition. Is'nt it safer to shut
the device down in such a case?

--=20
Regards,
Nishanth Menon
