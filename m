From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Sat, 21 Jan 2012 23:12:16 +1100
Message-ID: <20120121231216.16c7e318@notabene.brown>
References: <20120113222045.37f9b4ec@notabene.brown>
	<1326870839.1954.23.camel@deskari>
	<20120118221538.342b4782@notabene.brown>
	<1326886940.1999.5.camel@lappy>
	<20120119073032.74cc0992@notabene.brown>
	<WC20120119101721.07072A@terrafix.co.uk>
	<1326969658.1935.24.camel@deskari>
	<WC20120119112911.670749@terrafix.co.uk>
	<1326973019.7926.7.camel@lappy>
	<WC20120119122128.020787@terrafix.co.uk>
	<87y5t3trek.fsf@ti.com>
	<20120120080508.0dc0c758@notabene.brown>
	<87ty3rql2q.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/sR3GCi.Gj6Ra1=K803cvMzP"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42201 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab2AUMMc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 21 Jan 2012 07:12:32 -0500
In-Reply-To: <87ty3rql2q.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

--Sig_/sR3GCi.Gj6Ra1=K803cvMzP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Jan 2012 16:22:37 -0800 Kevin Hilman <khilman@ti.com> wrote:

> NeilBrown <neilb@suse.de> writes:
>=20
> > On Thu, 19 Jan 2012 11:37:39 -0800 Kevin Hilman <khilman@ti.com> wrote:
> >
> >> "Joe Woodward" <jw@terrafix.co.uk> writes:
> >>=20
> >> [...]
> >>=20
> >> > If I do (either from the console or via a button press on the screen)
> >> > then I never get a SYNC_LOST.
> >> >
> >> >   echo 0 > /sys/devices/omapdss/display0/enabled
> >> >   echo 1 > /sys/devices/omapdss/display0/enabled
> >> >
> >> > Just trying to think of some ideas that may be affecting the DSS...
> >> >   - Could it to be to do with the GPIO being used as a wake source (=
i.e. does the GPIO driver do runtime_pm properly?)?
> >> >   - Could it to be to do with the UART as it seems to fix itself whe=
never a character is pressed?
> >> >   - Could it to be to do with the ordering in which drivers are resu=
med?
> >>=20
> >> Here's my guess/hunch as to why the UART wakeup helps and GPIO doesn't.
> >>=20
> >> The UART's are idled using timeouts, so after any activity (including a
> >> wakeup) the UART timeout will not alow the UARTs to idle (and thus the
> >> system to hit low power states) for a given timeout period.
> >
> > While I agree with that, I'm wondering if there might be something else=
 odd
> > relating to the UARTs that we haven't spotted yet.
>=20
> I suspect the problem for both is constraints that aren't stated
> explicitly.
>=20
> > I'm chasing done the different problem of HDQ not coping with CPUIDLE b=
ut I
> > think it is very likely to have a similar root cause, as HDQ goes wrong=
 at
> > the same time that DSS goes wrong, and is a vaguely similar way.
> >
> > I just tried compiling omap_hwmod.c with "#define DEBUG" and got some s=
trange
> > results.
>=20
> Strange indeed.
>=20
> I assume you are you using the runtime PM converted driver from Paul?  I
> tried that branch on my 3530/Overo (console on UART3) and didn't see any
> nul's on my UART3 console. =20

I found out what is causing this.  I'm open to suggestions for fixing it.

I turned on debugging in clock.c and found that just before the nuls start
appearing, I'm told
        clock: dpll4_ck: disabling in hardware
and just before it starts working again I see
        clock: dpll4_ck: enabling in hardware

The uart3 fck depends on dpll4_ck, but this early it boot, uart3 hasn't been
initialised (I use earlyprintk to see this at all).  So as soon as something
that depends on dpll4_ck goes to sleep and disables its clock, the uart3
clock can get turned off because the dependency isn't known yet.

I think it is mmc3 turning off that initially turns dpll4_ck off.
Then when HDQ wants hdq_fck which depends on dpll4_ck, we get the uart clock
back for a while.
Then when uart2 gets enabled, uart3 comes back on, and soon after uart3 gets
enabled, which keeps it on.

So it seems we need some way to avoid turning off any clocks until all
dependencies have been registered.  At least when earlyprintk is being used.

Would that make sense?

Unfortunately understanding this issue doesn't seem to give any insight into
the other issues that seemed to be related - ah well...


>=20
> [...]
>=20
> > The other thing I discovered is that when I set the uart 'sleep_timeout=
' to 5
> > (all uarts) so that CPUIDLE can let CORE enter the lower power states, =
I get
> > a fairly steady stream of:
> >
> > [ 1168.490478] omap_hwmod: uart1: enabling
> > [ 1168.490509] omap_hwmod: uart1: enabling clocks
> > [ 1168.490539] omap_hwmod: uart2: enabling
> > [ 1168.490539] omap_hwmod: uart2: enabling clocks
> > [ 1168.490631] omap_hwmod: uart3: enabling
> > [ 1168.490661] omap_hwmod: uart3: enabling clocks
> > [ 1168.490661] omap_hwmod: uart4: enabling
> > [ 1168.490692] omap_hwmod: uart4: enabling clocks
> > [ 1168.578796] omap_hwmod: uart3: idling
> > [ 1168.578796] omap_hwmod: uart3: disabling clocks
> > [ 1168.578826] omap_hwmod: uart4: idling
> > [ 1168.578826] omap_hwmod: uart4: disabling clocks
> > [ 1168.578857] omap_hwmod: uart1: idling
> > [ 1168.578857] omap_hwmod: uart1: disabling clocks
> > [ 1168.578887] omap_hwmod: uart2: idling
> > [ 1168.578887] omap_hwmod: uart2: disabling clocks
> > [ 1168.714263] omap_hwmod: uart1: enabling
> > [ 1168.714294] omap_hwmod: uart1: enabling clocks
> > [ 1168.714324] omap_hwmod: uart2: enabling
> > [ 1168.714324] omap_hwmod: uart2: enabling clocks
> > [ 1168.714416] omap_hwmod: uart3: enabling
> > [ 1168.714447] omap_hwmod: uart3: enabling clocks
> > [ 1168.714447] omap_hwmod: uart4: enabling
> > [ 1168.714477] omap_hwmod: uart4: enabling clocks
> > [ 1168.803344] omap_hwmod: uart3: idling
> > [ 1168.803344] omap_hwmod: uart3: disabling clocks
> > [ 1168.803375] omap_hwmod: uart4: idling
> > [ 1168.803375] omap_hwmod: uart4: disabling clocks
> > [ 1168.851257] omap_hwmod: uart3: enabling
> > [ 1168.851287] omap_hwmod: uart3: enabling clocks
> > [ 1168.851318] omap_hwmod: uart4: enabling
> > [ 1168.851318] omap_hwmod: uart4: enabling clocks
> > [ 1168.885955] omap_hwmod: uart3: idling
> > [ 1168.885986] omap_hwmod: uart3: disabling clocks
> > [ 1168.885986] omap_hwmod: uart4: idling
> > [ 1168.886016] omap_hwmod: uart4: disabling clocks
> > [ 1168.886383] omap_hwmod: uart3: enabling
> > [ 1168.886383] omap_hwmod: uart3: enabling clocks
> > [ 1168.886383] omap_hwmod: uart4: enabling
> > [ 1168.886413] omap_hwmod: uart4: enabling clocks
> > [ 1168.944885] omap_hwmod: uart3: idling
> > [ 1168.944915] omap_hwmod: uart3: disabling clocks
>=20
> At least this part is expected. =20
>=20
> In the kernel you're using the UART clocks are enabled/disabled during
> the idle path depending on the low-power state being targetted, so would
> expect to see lots of UART clock gating going on.

Even though uarts 1,2,4 aren't even in use?

Maybe this is fixed in 3.3?

I'm just using 3.2 with a small number of extras which don't include the
power-management for uart (I tries backporting some of it, but it completely
disabled cpuidle - I think because the latency is registers is much too low,
as Paul observed).

Thanks,
NeilBrown

--Sig_/sR3GCi.Gj6Ra1=K803cvMzP
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTxqroDnsnt1WYoG5AQL/EQ/+PQSvVhL5+nTjXq4nETP2I0jiqtTLO3pV
EJStBrmuUCoNZoA0obhqPpbG81F4JxjZXrdFF/0wvJm4BMT7nwHPw6RwIlTYhbpx
QN81msodFsdLCVxojKWwMXlXlPOFeEzyH/V/Hw5sv1xBS1IyprvcVXKBGME7wE2U
T3sRt5epOncZUFEPkkGDUkzC19H103my+MOCJIfpHJ+5TLILsb/AW0QtmftcCbRf
uMWhOamk25Q5mf9uOOH9Ek7nT5knKFBd8SMTf3v519A3RLmn9JhBGQx04qEV7MiY
fLtg0ac6eso3rzGva2gLF4uL/OtX/xvT2AQ9N3EHlT4J6cUKIjRLVjgW9IfAxbf4
vKtZZghLguH9M5wVODMCVpTVSoVIl2AIDcFD8hhA6U0fB19kmATjk5+8So2sSAZf
D7u0xkP83SoiCkf56pS+REBS7t0cUfUbQhPte9dzH5ciHc+4ooyLaqZ/8ho1Wqj/
uhUajJGCjSDoLkYqztvRRndgyRxjU30p21HtXA/yUSxiIZd7hc+Eazopbrxi8U9/
7rfeG1WhDayS9NN7Pt8qQXng1cJdEgzIMAhA08mkLoOFRkhE9jnhApEZ2EB2ZfqU
zd2WhGtegtIvv/Wy6CKL9mJ/7uzT6yP5J86d3DpzfCS6tXISZWHNU1h4sdpL2tiX
SVc20Mmn7Tw=
=Ul5G
-----END PGP SIGNATURE-----

--Sig_/sR3GCi.Gj6Ra1=K803cvMzP--
