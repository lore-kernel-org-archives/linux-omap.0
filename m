From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 12:42:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown>
 <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-666378285-1328298142=:27947"
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Greg KH <gregkh@suse.de>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-666378285-1328298142=:27947
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 3 Feb 2012, Grazvydas Ignotas wrote:

> On Fri, Feb 3, 2012 at 11:54 AM, NeilBrown <neilb@suse.de> wrote:
> > On Thu, 2 Feb 2012 22:45:53 -0700 (MST) Paul Walmsley <paul@pwsan.com> =
wrote:
> >> On Fri, 3 Feb 2012, NeilBrown wrote:
> >>
> >> > then CPUIDLE enters lower states and I think it uses less power but =
I
> >> > sometimes lose the first char I type (that is known) but also I some=
times get
> >> > corruption on output.
> >>
> >> I don't see any output corruption on 35xx BeagleBoard, either with or
> >> without these patches. =C2=A0So this is presumably a 37xx-centric prob=
lem, and
> >> unrelated to these patches, I would guess.
> >
> > Maybe it is 37xx specific. =C2=A0I think this is a DM3730.
>=20
> Not sure if it's the same problem but with 3530 on 3.2 with
> sleep_timeout set, I usually get first char dropped (as expected) but
> sometimes I get corrupted char instead too. Corrupt char seems to
> almost always happen if I set cpufreq to powersave, on performace it's
> almost always ok, so maybe it's some timing problem,

OK so let's distinguish between two corruption situations:

1. The first character transmitted to the OMAP UART in a serial console=20
when the UART powerdomain is in a non-functional, low power state (e.g.,=20
RET or below) is corrupted.  This is not actually output corruption, this=
=20
is input corruption.

2. Characters are corrupted while the OMAP UART is transmitting data, but=
=20
there has been no recent data sent to the OMAP.

Case 1 is expected and is almost certainly not a bug.  As Neil mentioned=20
it should be bps-rate dependent.  It occurs when the first character=20
transmitted to the OMAP wakes the chip up via I/O ring/chain wakeup.
I/O ring/chain wakeup is driven by a 32KiHz clock and is therefore=20
relatively high-latency.  So this could easily cause the first character=20
or first few characters to be lost or corrupted, depending on the exact=20
sequence of events, the low power state that the chip was in, etc.

Case 2 is not expected.  That is likely a bug somewhere.  Neil, this is=20
what I understood that you are experiencing.  Is that correct?

Gra=C5=BEvydas, are you seeing case 1 or 2 (or something completely differe=
nt=20
;-) ?


- Paul
--155748971-666378285-1328298142=:27947--
