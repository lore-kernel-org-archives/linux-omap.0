From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 07:21:28 -0800
Message-ID: <201001260721.29275.david-b@pacbell.net>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com> <201001260535.21689.david-b@pacbell.net> <20100126141443.GE10690@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754530Ab0AZPVc@vger.kernel.org>
In-Reply-To: <20100126141443.GE10690@nokia.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 January 2010, Felipe Balbi wrote:
> >
> >Thing is, supplying current is a bit more involved. =A0If the
> >board can't supply 300 mA, the USB configuration selection
> >mechanism has to know that, so it never selects peripheral
> >configurations which require that much current.
>=20
> but that's done already by the usb core, no ? It rules out configurat=
ion=20
> based on the hub->power_budget (can't remember if the field is that=20
> exact name).

Yes, it handles that ... but where does the power budget
come from?  That's what I meant by "more involved".

As in, the host/supplying side of the power equation can't
be event driven like the peripheral/consuming side can.

And that's another reason I think it's best to fully solve
the common (peripheral, recharge-that-batter) case first.

- Dave
