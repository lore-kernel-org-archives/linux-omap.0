From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Sun, 6 Jun 2010 09:52:08 +0200
Message-ID: <AANLkTimKknOurmCffOpHjc1FjrP2MKf10pBwEEbLJPg_@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimEwznq9c_8lkuBMxEQ-42rdvpZEqA9Y71Cu-qC@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Arjan van de Ven <arjan@infradead.org>, tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

2010/6/5 Arve Hj=F8nnev=E5g <arve@android.com>:
> On Sat, Jun 5, 2010 at 9:28 AM, Arjan van de Ven <arjan@infradead.org=
> wrote:
>> On Sat, 05 Jun 2010 11:54:13 +0200
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> On Fri, 2010-06-04 at 17:10 -0700, Arve Hj=F8nnev=E5g wrote:
>>> > > Trusted processes are assumed to be sane and idle when there is
>>> > > nothing for them to do, allowing the machine to go into deep id=
le
>>> > > states.
>>> > >
>>> >
>>> > Neither the kernel nor our trusted user-space code currently meet=
s
>>> > this criteria.
>>>
>>> Then both need fixing. Really, that's the only sane approach.
>>
>> fwiw... in MeeGo we're seeing quite good idle times (> 1 seconds)
>> without really bad hacks.
>>
>
> We clearly have different standards for what we consider good. We
> measure time suspended in minutes or hours, not seconds, and waking u=
p
> every second or two causes a noticeable decrease in battery life on
> the hardware we have today.

Are you stating that the existing Android implementation enters the
suspended state for hours for any of the existing designs?

~Vitaly
