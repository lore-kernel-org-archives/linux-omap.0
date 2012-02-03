From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 20:54:01 +1100
Message-ID: <20120203205401.5ddf241d@notabene.brown>
References: <13274430881471@kroah.org>
	<alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
	<20120126042155.GA3185@suse.de>
	<alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
	<20120126191604.GA15516@suse.de>
	<alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
	<alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/_MTzvXv2F3/H0Bna.kfFifF"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41342 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303Ab2BCJyT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Feb 2012 04:54:19 -0500
In-Reply-To: <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Greg KH <gregkh@suse.de>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Sig_/_MTzvXv2F3/H0Bna.kfFifF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Feb 2012 22:45:53 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrot=
e:

> Hello Neil.
>=20
> On Fri, 3 Feb 2012, NeilBrown wrote:
>=20
> > Can I comment??...  They are good but ....
> >=20
> > I've tried two approaches to getting serial behaviour that I am happy w=
ith.
> > They are with and without runtime pm.
> >=20
> > If I enable runtime pm by setting power/autosuspend_delay_ms (e.g. to 5=
000)
>=20
> Runtime PM should be enabled even with power/autosuspend_delay_ms =3D 0. =
=20
> I think you are simply enabling the autosuspend timer.  There was a=20
> significant behavior change here from 3.2, I believe.

However the default autosuspend_delay_ms is "-1", not "0", and "-1" does
disable runbtime_pm completely.  It increments usage_count (see
update_autosuspend()) so runtime_pm can never suspend the device.

>=20
> > then CPUIDLE enters lower states and I think it uses less power but I
> > sometimes lose the first char I type (that is known) but also I sometim=
es get
> > corruption on output.
>=20
> I don't see any output corruption on 35xx BeagleBoard, either with or=20
> without these patches.  So this is presumably a 37xx-centric problem, and=
=20
> unrelated to these patches, I would guess.

Maybe it is 37xx specific.  I think this is a DM3730.


>=20
> > The problem seems to be that we turn off the clocks when the kernel's r=
ing
> > buffer is empty rather than waiting for the UART's fifo to be empty.
>=20
> pm_runtime_put*() calls will write to the CM_*CLKEN registers if the=20
> usecount goes to zero.  But the PRCM should not actually turn off the=20
> clocks if the UART isn't idle.  So I would suggest that you first try som=
e=20
> hwmod CLOCKACTIVITY changes to fix this (described briefly below).

Hmm... I thought it was the other way around - CLKEN could gate the clock
off, and PRCM could also turn it off after a handshake.  But I finally found
the relevant text:

   The software effect is immediate and direct. The functional clock is
   turned on as soon as the bit is set, and turned off if the bit is cleared
   and the clock is not required by any module.

so it seems I was wrong.

Still - something is definitely going wrong because I definitely an regular=
ly
see garbage characters.  And the patch fixes it.  So some runtime-suspend
handler must be doing something bad, and it must happen while characters
are being written.


>=20
> > I can remove this effect with:
> >=20
> > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap=
-serial.c
> > index f809041..c7ef760 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -440,7 +440,8 @@ static unsigned int serial_omap_tx_empty(struct uar=
t_port *port)
> >  	spin_lock_irqsave(&up->port.lock, flags);
> >  	ret =3D serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
> >  	spin_unlock_irqrestore(&up->port.lock, flags);
> > -	pm_runtime_put(&up->pdev->dev);
> > +	pm_runtime_mark_last_busy(&up->pdev->dev);
> > +	pm_runtime_put_autosuspend(&up->pdev->dev);
> >  	return ret;
> >  }
>=20
> Well this change probably makes sense anyway, just to keep the autosuspen=
d=20
> behavior consistent when an autosuspend timeout is set.  But the effect o=
f=20
> this patch may be a little different than what you think; see below.
>=20
> > i.e. when the tx buffer is empty, so turn the clocks off immediately,=20
> > but wait a while for the fifo to empty.  Hopefully the auto-suspend tim=
e=20
> > is enough.
>=20
> Hmm, this statement is a little unclear to me.  The clocks won't be turne=
d=20
> off immediately - the request to disable the clocks only happens when the=
=20
> autosuspend timer expires.  And even then, as mentioned above, it's just =
a=20
> request.  The hardware should not actually disable the functional clock=20
> until the UART FIFO is drained...

If you pm_runtime_put_autosuspend(), the suspend won't happen immediately b=
ut
will wait the timeout.
If you pm_runtime_put_sync(), the suspend happens straight away.
If you pm_runtime_put(), the suspend is schedule immediately in another
thread, so it happens very soon.  It doesn't wait for a timer to expire (no
timer is ticking at this point).

Just because an autosuspend timeout was set earlier, that won't cause
pm_runtime_put() to delay in suspending the device when it is called.

So I think it does request that the clocks be turned off immediately.


>=20
> Anyway, consider trying a different CLOCKACTIVITY setting for the UARTs.=
=20

My TRM saids that SYSC for the UARTs doesn't have CLOCKACTIVITY. Only
 AUTOIDLE SOFTRESET ENAWAKEUP IDLEMODE

Is it worth trying anyway?
=20
> There are fields and flags for this in the hwmod code; see for example th=
e=20
> I2C SYSCONFIG settings in mach-omap2/omap_hwmod_3xxx_data.c.  It's=20
> possible that the UART is currently assuming that its functional clock=20
> will stay on when it idle-acks.  That might cause the corruption that you=
=20
> are seeing.
>=20
> > But I decided not to pursue this further as turning off the clocks seem=
s=20
> > like the wrong thing to be doing.
>=20
> The clocks should be getting disabled when the autosuspend timer is 0=20
> also.  It's just that the UART driver will request to disable the clocks=
=20
> immediately, rather than waiting.

But not when it is -1.


>=20
> > The OMAP UARTs have auto-suspend/auto-wake so I would rather depend on=
=20
> > that.  And turning off the clocks loses that first character at 115200=
=20
> > and above (not below).
>=20
> If you make a change that causes the kernel to keep the UART clocks on,=20
> the enclosing clockdomain and any associated clockdomains (probably=20
> CORE_L3, CORE_L4 & PER) will be prevented from going to sleep.  So just b=
e=20
> aware that the strategy you are considering will incur an energy=20
> consumption cost.  The lowest C-state you should manage to reach should b=
e=20
> C4, at least in mainline terms.
>=20
> Incidentally, it's unclear to me how you are keeping the clocks on?  Are=
=20
> you disabling runtime PM for the driver in some way?

Yes, leaving autosuspend_delay_ms at the default of -1 .... :-)

>=20
> > So I explored leaving the runtime_pm setting as it was.  This set a max=
imum
> > latency of 4444 usec (which should be 5555 as there are 10 bits per cha=
r)=20
> > so it didn't get very low down the CPUIDLE levels.
> >
> > So I disabled the latency setting with hardware handshaking is used (as=
 you
> > suggested once):
>=20
> [snip]
>=20
> > and now CPUIDLE uses lower states (especially if I enable_off_mode).
>=20
> That's good.  One important note is that the CPUIdle statistics don't kee=
p=20
> track of what C-state was actually entered -- it simply tracks what=20
> C-state that CPUIdle intended to enter.  So you'll want to check=20
> /debug/pm_debug/count to be sure.  Also, the PM debug counts are=20
> approximate.

Yes, I'd begun to realise that - thanks.

>=20
> Incidentally, I have some patches to fix the latency calculation here tha=
t=20
> are in the works, similar to the ones you describe.  The current=20
> calculation in the driver is pretty broken, but since the changes to fix=
=20
> the calculation are rather involved, Kevin and I thought it would be best=
=20
> to defer most of them to the v3.4 merge window.  The calculation fix in=20
> the 3.3-rc series is simply intended to deal with a very basic power=20
> management regression, as you know - not to make it ideal, which is more=
=20
> complicated.  Anyway, the patches are at git://git.pwsan.com/linux-2.6 in=
=20
> the branch 'omap_serial_fix_pm_qos_formula_devel_3.4'.  Keep in mind that=
=20
> at least one patch in that branch is broken, but perhaps you might get an=
=20
> idea of where they are trying to go.  Comments welcome.
>=20
> > However I am using a lot more power than in 3.2. =20
>=20
> Is this without disabling the UART clocks?  If the driver is keeping the=
=20
> UART clocks enabled, then increased power consumption is definitely=20
> expected.

Both. With clocks kept on (autosuspend =3D=3D -1) I'm using about 30 mA mor=
e than
before.  With clocks allowed to go off it is closer to 40mA more !!! Weird,
isn't it?

>=20
> > That probably isn't all UART-related, but there is one interesting=20
> > observation.
> >=20
> > If I watch /sys/kernel/debug/pm_debug/time and see where the time is sp=
ent
> > over a 30second period when the systems is mostly idle:
> >=20
> > With runtime_pm disabled for UARTs, both PER and CORE are permanently O=
N,
> > and MPU is OFF nearly all the time. (This is with off_mode enabled).
>=20
> How are you disabling runtime PM?  Is this just with the autosuspend=20
> timeout set to 0?
     -1.


>=20
> > If I then enabled runtime_pm with a 5 second autosuspend delay:
> >   CORE is still permanently ON (I think the USB might be doing that).
> >   PER  is OFF (7 seconds) RET (15 seconds) and ON (8 seconds).
> > but more surprising
> >   MPU  is OFF (8 sec) RET (8 sec) INA (9 sec) ON (4 secs).
> >=20
> > So we get to turn PER off at the cost of turning the MPU on a lot.
> > (the periods in each state are only repeatable to a precision of 20%-50=
%).
> >=20
> > I understand that PER won't go OFF without runtime PM, but I would expe=
ct
> > it to at least go to INA as the UART is in smart-idle mode
>=20
> You are using UART3?  That is in PER and its functional clock comes via=20
> the PER clockdomain.  If the UART functional clock is prevented from bein=
g=20
> turned off, how can PER go inactive when the UART3 functional clock is=20
> still enabled?

I was thinking the auto-suspend would kick in - but I had it backwards it
seems.  I'll have to rethink things.
(yes, UART3).

>=20
> > The net result is that with runtime_pm enabled I'm seeing an extra 7mA =
(at
> > 4V). That might not be very precise, but it is in the opposite directio=
n to
> > my expectations.
> >=20
> > So there is something odd here...  ideas?
> >=20
> > NeilBrown
> >=20
> > p.s. who should I formally submit OMAP-UART patches to?  I have a coupl=
e of
> > others such as the below that I should submit somewhere.
>=20
> Would suggest sending them to linux-serial@vger.kernel.org,=20
> linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, and Ala=
n=20
> Cox since he is the serial maintainer?  And you should probably also cc=20
> me, since I seem to be stuck with fixing this driver so I can test my=20
> other patches; and cc Govindraj as well.
>=20
>=20
> - Paul

Thanks for your time.
I'm going to have to come up with a better theory for why my patch works.

Thanks,
NeilBrown

--Sig_/_MTzvXv2F3/H0Bna.kfFifF
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyuuuTnsnt1WYoG5AQKJsQ/+Ms5rkrqdSefTAtuLbcvBUdWBAuKtR19b
2ECl2EKNXfRHhFETLXg9YCk86kUco6CFAv4pWafs5E2SxcDAy74k8IcjwGSix4My
PesVkx1GIGZM6eiowNic4uZJEicfx9raDGH3ao8zsE5u/qOkO6nHW8LPGMTLLjP3
BifzksDP2ekyk+4VQYZfRwa1dHHho6KD+ZA0R7TCp0KTrolnPgmHak7kDspcSbhJ
kCd2f65O8gSxj1Mru2CM/H77pdap/qJkA0AhBeoleXcFE6Oo+KKLjFYzvn0NNjOD
//SB4m2QKyPuhtKrltIZh7shupihLnY5CiK9jVR2euD49rNIHGe8nmzT9YtBQCqG
qCwZ0Z86nIxUTIQu7yWEw6VfTDXCxUT6201usJ0Tn/5yeAb6bNhuDBkeW+2cR/Bg
Bz08QE6KzMwjrtgFwYazvA7ww386oaPYw0jaAZtJYAuzXPycKDRGn1evKf8TVtdM
axXmaTEyU7SbAFXnONlIUlI7KQheJr8CmV9C+xyWYqHhRh9GiGlg7DCn0BR5v/yZ
PspkqnbVOhHIHr82aJXKGhW/0QkQ0MoxJLJxp2t69GmMTdK5IbqNphkKkxwRzf+l
4ip6lMdgnz7Ni/QTg8ucxbt2WyRwvS8nB6dlbnGGoBMDJUWI5QpTvtoF+KLonWHk
K/hoYEsRbjo=
=1ubu
-----END PGP SIGNATURE-----

--Sig_/_MTzvXv2F3/H0Bna.kfFifF--
