From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 31 May 2010 23:47:24 +0200
Message-ID: <201005312347.24251.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org> <201005302202.39511.rjw@sisk.pl> <AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Monday 31 May 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/5/30 Rafael J. Wysocki <rjw@sisk.pl>:
=2E..
>=20
> I think it makes more sense to block suspend while wakeup events are
> pending than blocking it everywhere timers are used by code that coul=
d
> be called while handling wakeup events or other critical work. Also,
> even if you did block suspend everywhere timers where used you still
> have the race where a wakeup interrupt happens right after you decide=
d
> to suspend. In other words, you still need to block suspend in all th=
e
> same places as with the current opportunistic suspend code, so what i=
s
> the benefit of delaying suspend until idle?

Assume for a while that you don't use suspend blockers, OK?  I realize =
you
think that anything else doesn't make sense, but evidently some other p=
eople
have that opinion about suspend blockers.

Now, under that assumption, I think it _generally_ is reasonable to mak=
e the
system go into full suspend if everything (ie. CPUs and I/O) has been i=
dle
for sufficiently long time and there are no QoS requirements that aren'=
t
compatible with full system suspend.

Rafael
