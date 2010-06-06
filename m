From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Sun, 6 Jun 2010 10:32:13 +0200
Message-ID: <AANLkTin1Za3GvfIKbcZdx6TzjIHzCvsg5uaY_Vk4nJIh@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
	<20100604071354.GA14451@elte.hu>
	<AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44@mail.gmail.com>
	<20100604083423.GD15181@elte.hu>
	<AANLkTinQyzzeF-NOAjrAqqQXqKjFJhx85nI4uyBGRtWd@mail.gmail.com>
	<1275653210.27810.39762.camel@twins>
	<AANLkTinyjBa0KYfFz3_EFbC65hoQFwFINlTDYjCe-wM3@mail.gmail.com>
	<1275731653.27810.41078.camel@twins>
	<20100605092851.6ee15f13@infradead.org>
	<AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
	<AANLkTimKknOurmCffOpHjc1FjrP2MKf10pBwEEbLJPg_@mail.gmail.com>
	<AANLkTil1NCX91bWhpXHtC88Opr29mNjdhXD9RXQ6DI0y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTil1NCX91bWhpXHtC88Opr29mNjdhXD9RXQ6DI0y@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Arjan van de Ven <arjan@infradead.org>, tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Sun, Jun 6, 2010 at 10:20 AM, Brian Swetland <swetland@google.com> w=
rote:
> On Sun, Jun 6, 2010 at 12:52 AM, Vitaly Wool <vitalywool@gmail.com> w=
rote:
>> 2010/6/5 Arve Hj=F8nnev=E5g <arve@android.com>:
>>>
>>> We clearly have different standards for what we consider good. We
>>> measure time suspended in minutes or hours, not seconds, and waking=
 up
>>> every second or two causes a noticeable decrease in battery life on
>>> the hardware we have today.
>>
>> Are you stating that the existing Android implementation enters the
>> suspended state for hours for any of the existing designs?
>
> It varies depending on device and usage. =A0The battery monitoring on
> NexusOne happens every ten minutes, so that's the longest you'll see =
a
> N1 suspended for. =A0On a G1 or Dream/myTouch you can see 20-30 minut=
es
> between wakeups (depending on network issues and background data sync
> traffic), and if you have background data sync off those devices can
> sit in suspend for days at a time (unless you receive a phone call or
> something). =A0In "airplane mode", with no local alarms, a device can
> easily sit in the lowest power state for a month or so, until the
> battery finally runs out.

That only concerns the case when you have just turned on the phone and
left it laying around.
You have to admit that it's not the common case for a smartphone. The
common case is that you've played with it for a bit, turning on things
like BT/WIFI, running some apps and so on. And doing so you'll end up
having wake locks taken from everywhere, so I can hardly see a second
of suspend for Nexus.

E. g. when the wireless is connected to an AP, it takes a wake lock
which is released on 15 minutes touchscreen inactivity timeout, as far
as I can tell. So:

* the system will never hit suspend during this period;
* if the download was ongoing and had not been completed during this
period, it will be terminated.

So the bottom line is: the approach is very inflexible. Of course it
can give you the best power savings if you turn the Airplane mode on
as soon as you switched on the phone, but this is not what a typical
user would do.

~Vitaly
