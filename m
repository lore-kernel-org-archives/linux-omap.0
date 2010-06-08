From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Mon, 7 Jun 2010 21:13:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006072110550.26784-100000@netrider.rowland.org>
References: <AANLkTimf_nVcOZGi0x6nDtaO-FMVSLPrxDtOzQwKTB5P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimf_nVcOZGi0x6nDtaO-FMVSLPrxDtOzQwKTB5P@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Vitaly Wool <vitalywool@gmail.com>, Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Jun 2010, Arve Hj=F8nnev=E5g wrote:

> > Remember that suspend takes place in several phases, the first of w=
hich
> > is to freeze tasks. =A0The phases can be controlled individually by=
 the
> > process carrying out a suspend, and there's nothing to prevent you =
from
> > stopping after the freezer phase. =A0Devices won't get powered down=
, but
> > Android uses aggressive runtime power management for its devices
> > anyway.
> >
> > If you do this then the synchronization can be carried out entirely
> > from userspace, with no need for kernel modifications such as suspe=
nd
> > blockers. And since Android can reach essentially the same low-powe=
r
> > state from idle as from suspend, it appears that they really don't =
need
> > any kernel changes at all.
> >
>=20
> I don't think this is true. If you stop after the freezer phase you
> still need all the suspend blockers that are held until user-space
> consumes an event, otherwise it never gets consumed since user-space
> is frozen.

No.  You don't need to hold any suspend blockers; you merely need to=20
unfreeze userspace.  Once it is unfrozen, it will eventually consume=20
the wakeup event.

What you _do_ need to do is to prevent userspace from getting frozen=20
again too soon.  That's the purpose of the list of "active" wakeup=20
sources.  So long as the power manager believes a source is still=20
active, it won't freeze anything.

Alan Stern
