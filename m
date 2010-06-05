From: Florian Mickler <florian@mickler.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 5 Jun 2010 22:01:43 +0200
Message-ID: <20100605220143.08774900@schatten.dmk.lab>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005302202.39511.rjw@sisk.pl>
	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
	<201005312347.24251.rjw@sisk.pl>
	<AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
	<alpine.LFD.2.00.1006011411200.2933@localhost.localdomain>
	<AANLkTikZHmF6baP7dEXEGFE8YsbEteRjlhb5wqZX8ll1@mail.gmail.com>
	<alpine.LFD.2.00.1006020905410.2933@localhost.localdomain>
	<AANLkTinDm3FIrbS1jqEzW15THmr1hdd7ox0Mllm1VLjZ@mail.gmail.com>
	<1275471561.27810.30865.camel@twins>
	<AANLkTilLmAb2c9fQwuguzWtjcHfuTZvPUTbUx7vuwFI6@mail.gmail.com>
	<AANLkTikna-Vs_phy2VrJs0I8gIsdSmwuxTJ67gQ_2oTt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikna-Vs_phy2VrJs0I8gIsdSmwuxTJ67gQ_2oTt@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Arve =?ISO-8859-15?Q?Hj=F8nnev=E5g?= <arve@android.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Sat, 5 Jun 2010 20:44:24 +0300
=46elipe Contreras <felipe.contreras@gmail.com> wrote:

> 2010/6/2 Arve Hj=F8nnev=E5g <arve@android.com>:
> > 2010/6/2 Peter Zijlstra <peterz@infradead.org>:
> >> (and please don't mention @#$@ up x86 ACPI again, Intel knows, the=
y're
> >> fixing it, get over it already).
> >>
> >
> > I don't think it is realistic to drop support for all existing hard=
ware.
>=20
> We are talking about mainline here, there's no support for suspend
> blockers, so nothing is dropped.
>=20
> In the mind of everybody, suspend blockers is for opportunistic
> suspend, which only makes sense on sensible hw (not current x86). So
> in the mind of everybody, x86 should be out of scope for the analysis
> of suspend blockers.
>=20
> Are you seriously suggesting that one of the strong arguments in favo=
r
> of suspend blockers is x86 usage (nobody agrees)? If not, then drop
> it.

I think they have an advantage over the
30-minute-screensaver-then-suspend that current desktops do. Because
you can define what keeps the system up. I.e. the
screensaver/powermanager is not limited to keyboard- and
mouse-inactivity.

> If I enable suspend blockers on my laptop, I have to modify my
> user-space. Otherwise my system will behave horribly.
>=20

In the simplest case you have a shell script which takes a suspend
blocker and reads from stdinput. When you write "mem" to it, it
releases the suspend blocker and acquires it back again. Voila, forced
suspend reimplemented on top of opportunistic suspend.

That wasn't hard, was it?=20

Cheers,
=46lo
=20
