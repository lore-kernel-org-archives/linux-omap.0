From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 23:07:20 +1100
Message-ID: <20120203230720.28666cc6@notabene.brown>
References: <13274430881471@kroah.org>
	<alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
	<20120126042155.GA3185@suse.de>
	<alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
	<20120126191604.GA15516@suse.de>
	<alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
	<CAAL8m4ztuB-kJvLGd=8PqPCLFcvPW9AQcdcFQ+e03vDT240vog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/35QOn6iGflvbtKTEerRfsGH"; protocol="application/pgp-signature"
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4ztuB-kJvLGd=8PqPCLFcvPW9AQcdcFQ+e03vDT240vog@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--Sig_/35QOn6iGflvbtKTEerRfsGH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Feb 2012 12:26:14 +0530 Govindraj <govindraj.ti@gmail.com> wrote:

> On Fri, Feb 3, 2012 at 9:37 AM, NeilBrown <neilb@suse.de> wrote:
> > On Thu, 2 Feb 2012 13:03:01 -0700 (MST) Paul Walmsley <paul@pwsan.com> =
wrote:
> >
> >> Hi Greg,
> >>
> >> On Thu, 26 Jan 2012, Paul Walmsley wrote:
> >>
> >> > On Thu, 26 Jan 2012, Greg KH wrote:
> >> >
> >> > > Ok, I've just reverted both of these patches for now, please send =
new
> >> > > ones when you have them.
> >> >
> >> > Thanks. =C2=A0A pull request is at the bottom of this message. =C2=
=A0The patches
> >> > are also available from the mailing list archives here:
> >> >
> >> > http://marc.info/?l=3Dlinux-arm-kernel&m=3D132754676014389&w=3D2
> >> > http://marc.info/?l=3Dlinux-arm-kernel&m=3D132754677914395&w=3D2
> >> > http://marc.info/?l=3Dlinux-arm-kernel&m=3D132754676014388&w=3D2
> >>
> >> Any comments on these?
> >
> > Can I comment??... =C2=A0They are good but ....
> >
> > I've tried two approaches to getting serial behaviour that I am happy w=
ith.
> > They are with and without runtime pm.
> >
> > If I enable runtime pm by setting power/autosuspend_delay_ms (e.g. to 5=
000)
> > then CPUIDLE enters lower states and I think it uses less power but I
> > sometimes lose the first char I type (that is known) but also I sometim=
es get
> > corruption on output.
> >
> > The problem seems to be that we turn off the clocks when the kernel's r=
ing
> > buffer is empty rather than waiting for the UART's fifo to be empty.
> > So I get corruption near the end of a stream of output ... not right at=
 the
> > end so something must be turning the clocks back on somehow.
> >
> > I can remove this effect with:
> >
> > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap=
-serial.c
> > index f809041..c7ef760 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -440,7 +440,8 @@ static unsigned int serial_omap_tx_empty(struct uar=
t_port *port)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&up->port.lock, flags);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D serial_in(up, UART_LSR) & UART_LSR_T=
EMT ? TIOCSER_TEMT : 0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&up->port.lock, flags=
);
> > - =C2=A0 =C2=A0 =C2=A0 pm_runtime_put(&up->pdev->dev);
> > + =C2=A0 =C2=A0 =C2=A0 pm_runtime_mark_last_busy(&up->pdev->dev);
> > + =C2=A0 =C2=A0 =C2=A0 pm_runtime_put_autosuspend(&up->pdev->dev);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> > =C2=A0}
> >
>=20
> But looking into it UART_LSR_TEMT("include/linux/serial_reg.h") =3D> 0x40
>=20
> from omap trm:
>=20
> TX_SR_E =3D> bit 6
> "Read 0x1: Transmitter hold (TX FIFO) and shift registers are empty."
>=20
> So it means all data from tx fifo has shifted out and no pending data in
> tx fifo.
>=20
> But we had used UART_LSR_THRE (0x20) here for tx fifo emptiness comparison
> then  from omap trm
>=20
> TX_FIFO_E =3D> bit 5
>=20
> "Read 0x1: Transmit hold register (TX FIFO) is empty.
> The transmission is not necessarily complete"
>=20
> So I think all data has been shifted out from tx fifo for
> serial_omap_tx_empty check.

Useful and interesting - thanks.
However what it really shows me is that I was misunderstanding the code
(If I spent the time to verify every conclusion that I jumped to, I'd never
get anywhere :-( ).  Better clarify that now.

So this function - serial_omap_tx_empty() is called to test if the
tx queue is empty.

It is called in a loop at the end of uart_wait_until_sent.

uart_wait_until_sent it calls from various places, but particularly when
doing an 'stty' ioctl.

The loop isn't a very tight loop though it would be tighter if jiffies were
smaller.  As it is it checks every jiffy and usually loops 3 times when I
see corruption.

So when I

   cat somefile

to the serial console, most of the file comes out fine.  But after 'cat'
finishes and returns to the shell - while some chars are still in the FIFO =
-=20
the shell does an 'stty' ioctl to make sure the settings are still OK.
This ioctl calls serial_omap_tx_empty which calls pm_resume_put() which
immediately suspends the uart, which seems to stop some clock - even though
we think it shouldn't.

(If is use 'dash' instead of 'bash', that shell doesn't fiddle with stty, a=
nd
I don't see any corruption).

After a bit more experimentation, I find that if either UART3 or UART4 (whi=
ch
are numbers 2 and 3 is sysfs!!!) have auto_suspend_delay set to -1, then I
don't see any corruption.
But if both are set to 5000, then I do.

(The settings of UART1 and UART2 seem to be irrelevant - presumably because
they are in CORE, not PER).

So if either uart wants PER_48M_FCLK on, then it stays on.  But if neither
explicitly request it and are only keeping it on by being active ... then
there is room for a hiccup it seems.
Or maybe it isn't the clocks ... maybe the problem is that PER goes into
RET mode, which it does for about 40msec.

If I run
 cat /sys/kernel/debug/pm_debug/time; stty 115200; \
 cat /sys/kernel/debug/pm_debug/time

then I see corruption near the end of the first output of the 'time' file,
and the time that PER is in RET goes up by about 40msec.
This could be because the clock goes off, or maybe it has some other cause
that I'm not aware of.

So yeah - I was quite wrong in my original analysis, thanks for encouraging
me to sort it out.



This is awfully similar to the problem I had with HDQ - clock seeming to
disappear when it should not.

There is something important I'm missing.... time to go back to the TRM I
guess..



>=20
> >
> > i.e. when the tx buffer is empty, so turn the clocks off immediately, b=
ut
> > wait a while for the fifo to empty. =C2=A0Hopefully the auto-suspend ti=
me is
> > enough.
> >
>=20
> [...]
>=20
> >
> > p.s. who should I formally submit OMAP-UART patches to? =C2=A0I have a =
couple of
> > others such as the below that I should submit somewhere.
> >
> >
> > diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> > index 247d894..35a649f 100644
> > --- a/arch/arm/mach-omap2/serial.c
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -54,11 +54,9 @@
> >
> > =C2=A0struct omap_uart_state {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int num;
> > - =C2=A0 =C2=A0 =C2=A0 int can_sleep;
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head node;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_hwmod *oh;
> > - =C2=A0 =C2=A0 =C2=A0 struct platform_device *pdev;
> > =C2=A0};
> >
> > =C2=A0static LIST_HEAD(uart_list);
> > @@ -381,8 +379,6 @@ void __init omap_serial_init_port(struct omap_board=
_data *bd
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0oh->mux =3D omap_hwmod_mux_init(bdata->pads,=
 bdata->pads_cnt);
> >
> > - =C2=A0 =C2=A0 =C2=A0 uart->pdev =3D pdev;
> > -
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0oh->dev_attr =3D uart;
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (((cpu_is_omap34xx() || cpu_is_omap44xx()=
) && bdata->pads)
>=20
> Acked-by: Govindraj.R <govindraj.raja@ti.com>
>=20
> Please post out this part as a patch,
> I think this change has to go through linux-omap tree.

I'll do that, thanks.

NeilBrown


--Sig_/35QOn6iGflvbtKTEerRfsGH
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyvN+Dnsnt1WYoG5AQIDORAAwp53JG5zz61Es/6d/aSc2CSW6D3nf+yf
npp9tcbYzvxrzX8AP+uwQqwZaPjn98QHg4CPrs8vz5fWeLGEO1+OrHzYUgKmsAgg
7zMcQzrrhX0F9H8JssI5jtLNZjC21JHQJO93m/7bGgR/dYJabrY+MdOnuy8qk8da
mT9yAV3xQU5Uugc/+EPpz6cM0LHS+jcSQIQbZcjR68k37DQ1douQCwpZUfHRmeaB
MdtaJBZPRo4nA+ODxx/voqM7Q5yqdiUMGF0KyF2ZscSR4SnGI+C7bNPg0uvgd8mx
VC6mbGD+63o4xp9GA13jO7yt5a9Rlz0Lr71wkqC1AmftuBpaeK5TjZdQBrepBeul
bS7zn4qRbbujU1e9cX6d9PDRlCp/+4A/qWaCP/FT2++OmJYkWIG1tY1V9aZ0PAIE
hkeoEmYsCFmknDORGZNyx2G/o/GNmu9wTMtjkuA7KiVCbmLg2hivX9kEIHaQNRUD
nSAd7WjQjBEC+PW47Lz8phwfhbwdtQlvqObZgAgHPcRgHetAVYehg+WTjYmjo9Ru
W04Uwhk91Nu4uvMWu5WdIEPuzDmBB9EV0i6AEFlcLS2oZLYT+u9QaensFZq97RcS
FVYxMrwaUw2+zJodZBnYp54fbysCToiLtgoCA9zLSmWYodkUUomfSzHD6j59ycuG
zPSSsSfu8YA=
=DfH8
-----END PGP SIGNATURE-----

--Sig_/35QOn6iGflvbtKTEerRfsGH--
