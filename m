From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: suspend blockers & Android integration
Date: Sat, 5 Jun 2010 16:34:11 -0700
Message-ID: <20100605163411.6c561fbf@infradead.org>
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
	<AANLkTil0XV8EDK8WWody7f-L5ou4p_a3O_T6dTjWB12C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49560 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933664Ab0FEXbp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jun 2010 19:31:45 -0400
In-Reply-To: <AANLkTil0XV8EDK8WWody7f-L5ou4p_a3O_T6dTjWB12C@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sat, 5 Jun 2010 15:39:44 -0700
Arve Hj=C3=B8nnev=C3=A5g <arve@android.com> wrote:

> >
> > For example if the Adobe Flash player puts a timer every 10
> > milliseconds (yes it does that), and you give it a 3.99 seconds
> > range, it will fire its timers every 4 seconds.... unless other
> > activity happens independently, at which point it'll align with
> > that instead.
> >
>=20
> If you do that what you are delivering is nowhere close to what the
> app asked for.=20

yeah it feels a little bit suspended=20

> You don't need range timers for this, you could just as
> well add 4 seconds to all normal timers.

=2E. with the difference that with range timers, you naturally align wi=
th
other activity, so if there's system level activity, the AVERAGE servic=
e
the app gets is better by a LOT than just adding 4 seconds always.

but you knew that.... just doesn't help your case.



--=20
Arjan van de Ven 	Intel Open Source Technology Centre
=46or development, discussion and tips for power savings,=20
visit http://www.lesswatts.org
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
