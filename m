From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH V2 2/2] power: twl4030_charger: attempt to power off in
 case of critical events
Date: Thu, 5 Jun 2014 01:30:40 +0300
Message-ID: <CANOLnOMbjpLd2mGcTRcR-+jcp80H1z7g4-eZ6yMJvovEB2__RQ@mail.gmail.com>
References: <1401313610-14252-1-git-send-email-nm@ti.com>
	<1401313610-14252-3-git-send-email-nm@ti.com>
	<CANOLnOPb1xbqb5WXaK5-kdCezVuDhNxTtE5VV_MbCi4WTd2=oA@mail.gmail.com>
	<538F18B6.7070102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <538F18B6.7070102@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: dbaryshkov@gmail.com, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, dwmw2@infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 4, 2014 at 4:01 PM, Nishanth Menon <nm@ti.com> wrote:
> On 06/04/2014 05:04 AM, Grazvydas Ignotas wrote:
>> On Thu, May 29, 2014 at 12:46 AM, Nishanth Menon <nm@ti.com> wrote:
>>> Attempt to power off in case of critical events such as battery rem=
oval,
>>> over voltage events.
>>>
>>> There is no guarentee that we'd be in a safe scenario here, but the=
 very
>>> least we can try to do is to power off the device to prevent damage=
 to
>>> the system instead of just printing a message and hoping for the be=
st.
>>
>> At least "battery temperature out of range" does seem to happen quit=
e
>> often while charging on hot summer day. I'd prefer my pandora to not
>> shutdown in such case, it could just stop charging instead.
> Yeah, We could call
>   twl4030_charger_enable_ac(false);
>   twl4030_charger_enable_usb(bci, false);
>
> But then, is that sufficient?
> From the TRM:
> 7.5.8 Battery Temperature Out-of-Range Detection
> Battery temperature out-of-range detection detects whether the batter=
y
> temperature is within a specific
> range. Detection is possible for two temperature ranges. When the
> battery temperature is not in the
> 2=E2=80=9350=C2=B0C range or is in the 3=E2=80=9343=C2=B0C range, the=
 TBATOR1 and TBATOR2 status
> bits rise and an interrupt is
> generated.
> This MADC monitoring function can be enabled by writing to the
> TBATOR1EN (BCIMFEN2[3]) and
> TBATOR2EN (BCIMFEN2[1]) fields.
>
> Battery pack at high temperature is a risk, no? and it may not be jus=
t
> charger that might be causing such a condition. Is'nt it safer to shu=
t
> the device down in such a case?

I don't know, so far nobody has complained about the battery exploding
and anybody getting hurt, but it would make the device unusable for
people in hot climates. From what I remember the automatic charge is
stopped automatically on this condition, as some people complained
they couldn't charge their device and saw these messages in dmesg. I
guess mainline could choose the safer option and shutdown, no strong
opinion about this.

--=20
Gra=C5=BEvydas
