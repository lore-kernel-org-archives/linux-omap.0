From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Fri, 29 Aug 2014 09:12:22 -0700
Message-ID: <20140829161221.GO16006@atomide.com>
References: <20140815210211.GD9239@atomide.com>
 <53F5AF0D.5060409@linutronix.de>
 <20140821184416.GF10066@atomide.com>
 <53FE3779.5090908@linutronix.de>
 <20140827202313.GF16006@atomide.com>
 <20140828082348.GA5413@linutronix.de>
 <20140828164645.GG16006@atomide.com>
 <53FF84DF.7080406@linutronix.de>
 <20140828225454.GM16006@atomide.com>
 <540048B4.7010807@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <540048B4.7010807@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: balbi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140829 02:32]:
> On 08/29/2014 12:54 AM, Tony Lindgren wrote:
> > OK thanks, I'm seeing the same issue as you. And the idlest registe=
rs
> > don't show any blockers. Looking at the errata docs, seems like
> > "Usage Note 2.7" in sprz318f.pdf says:
> >=20
> >  Details When configured for DMA operations using smartidle mode (S=
YSC[4:3].IDLEMODE =3D
> >  0x2), the UART module will not acknowledge incoming idle requests.=
 As a consequence,
> >  it can prevent L4 from going to idle.
> >  When there are additional expected transfers, the UART should be p=
laced in force-idle
> >  mode.
>=20
> Ehm. So I haven't found an errata document for omap3630, there is
> nothing like that in that one I have for am335x or dra7. The document
> you mentioned is for AM3715. Interesting=E2=80=A6

Yes I would not be suprised if that same bug is in all of them though..
=20
> > So I've added also Paul to Cc, he may have better suggestions for t=
he
> > hwmod flags to use. The experimental patch below seems to allow idl=
ing
> > for me, care to give it a try?
>=20
> Yep, this one works. And I see DMA transfers (for RX side) after the
> core hit idle so it seems to look good :)

OK great :)

Looks like the paste bug is there for sure, doing off idle and pasting
240 characters to the console can hang the UART RX after few attempts,
and pasting 16 charactes won't show up at all if the system is idling.
So you may want to play with that too a bit :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
