From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: suspend blockers & Android integration
Date: Sat, 05 Jun 2010 11:54:13 +0200
Message-ID: <1275731653.27810.41078.camel@twins>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	 <20100603232302.GA16184@elte.hu>
	 <AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt@mail.gmail.com>
	 <20100604071354.GA14451@elte.hu>
	 <AANLkTimH4ihf3QqtKFpfGXRKtO55PrUuff9JYtaEBG44@mail.gmail.com>
	 <20100604083423.GD15181@elte.hu>
	 <AANLkTinQyzzeF-NOAjrAqqQXqKjFJhx85nI4uyBGRtWd@mail.gmail.com>
	 <1275653210.27810.39762.camel@twins>
	 <AANLkTinyjBa0KYfFz3_EFbC65hoQFwFINlTDYjCe-wM3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinyjBa0KYfFz3_EFbC65hoQFwFINlTDYjCe-wM3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 2010-06-04 at 17:10 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> > Trusted processes are assumed to be sane and idle when there is not=
hing
> > for them to do, allowing the machine to go into deep idle states.
> >
>=20
> Neither the kernel nor our trusted user-space code currently meets
> this criteria.=20

Then both need fixing. Really, that's the only sane approach.
