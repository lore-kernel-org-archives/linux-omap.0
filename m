From: Brian Swetland <swetland@google.com>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 15:26:36 -0700
Message-ID: <AANLkTinRH52dSTPCAO9k1yEFup1LLYizeinunxeTBzbQ@mail.gmail.com>
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
	<20100605152326.7ccd5160@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100605152326.7ccd5160@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Neil Brown <neilb@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 5, 2010 at 3:23 PM, Arjan van de Ven <arjan@infradead.org> wrote:
>>
>> We clearly have different standards for what we consider good. We
>> measure time suspended in minutes or hours, not seconds, and waking up
>> every second or two causes a noticeable decrease in battery life on
>> the hardware we have today.
>
> I guess I'm spoiled working with (unreleased) hardware that knows how
> to power gate ;-)

I'm continually surprised by answers like this.  We run on hardware
that power gates very aggressively and draws in the neighborhood of
1-2mA at the battery when in the lowest state (3-5mA while the radio
is connected to the network and paging).  Waking up out of that lowest
state and executing code every few seconds or (worse) several times a
second) will raise your average power consumption.  Being able to stay
parked at the very bottom for minutes or hours at a time when nothing
"interesting" is happening is very useful and can have a significant
impact on overall battery life.

Brian
