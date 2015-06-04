From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Thu, 4 Jun 2015 15:29:43 -0500
Message-ID: <20150604202943.GH5710@saruman.tx.rr.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com>
 <55701E93.60303@free.fr>
 <20150604200850.GF5710@saruman.tx.rr.com>
 <20150604201825.GG5710@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34129 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbbFDUcd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jun 2015 16:32:33 -0400
Content-Disposition: inline
In-Reply-To: <20150604201825.GG5710@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mason <slash.tmp@free.fr>, Stephen Boyd <sboyd@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Linux OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2015 at 03:18:25PM -0500, Felipe Balbi wrote:
> On Thu, Jun 04, 2015 at 03:08:50PM -0500, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
> > > Also, check /proc/timer_list for a "Broadcast device". If you don't
> > > define one, the TWD timers are set to periodic mode, with hrtimers
> > > disabled.
> >=20
> > Did you manage to turn global timer into Broadcast device ?
>=20
> arm_global_timer is marked PERCPU, so it will never be chosen as
> broadcast.

Perhaps this is acceptable ?

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/a=
rm_global_timer.c
index e6833771a716..8c0170ac367d 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -169,8 +169,9 @@ static int gt_clockevents_init(struct clock_event_devic=
e *clk)
 	int cpu =3D smp_processor_id();
=20
 	clk->name =3D "arm_global_timer";
-	clk->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-		CLOCK_EVT_FEAT_PERCPU;
+	clk->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	if (is_smp() || setup_max_cpus)
+		clk->features |=3D CLOCK_EVT_FEAT_PERCPU;
 	clk->set_mode =3D gt_clockevent_set_mode;
 	clk->set_next_event =3D gt_clockevent_set_next_event;
 	clk->cpumask =3D cpumask_of(cpu);

--=20
balbi

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVcLU3AAoJEIaOsuA1yqREDj8P/2SSmPwOT4HVQpl6KTc3ev3f
dYqd0UalO9BZEf1DaRh06NDHlYLJXE6TUfEv6WWekfV8y94hpKnQ8Zx+Zf8Rced6
I+KGe47kowqbRAwdBuvCAzkliKZzXZthoM1a2PIO2XyWZYCdPJ0WiT9YsimjC/Fz
owjumpgXoMwvJ7hTAjU11bf8O8zVezJinZ1s4Eeto8SsOOe6mjEzKT0SOaHTVDpB
Jb2n1FwvneqQ5DJS+fTTZ2TTxt+dZnszyIW+wQDp+pBNOLijzlu5HGNm6T/T4h5R
bS9pZztSCtNYKIhGwV3Mw76oc7IhuyXM7joQJ96VMVhS+4ishD6SDi/kRD29oxvQ
fP/mU8axgj7Oglt0PcFQUOnDmtTdtvvenWsTcNaKro7y6ta8HxbQRauzxyqRPGGI
OC9vIEvYv9P79SeVOYecQoGEM8/Nkt5sTvfyp0rbjcRMFfDGj3v6g48rUz6B6uGi
/OIscUqWGMokqSC71indKR/2QcW4gjPXRt05RX2fgCw33b/gOLxKEKveNIiF+NAZ
NBcX6sO8VtgfsPQAL8Oqxx3p6YCARoQPAiHAgRmKQwFZMUBgmQJs3/5RPJm2fdHf
jNnT45z/m3ZOoPYFakoN629yMqmH0T5oJv+wxU4SI5AQFqwWMB5ieybvr0Hl9Y9d
chB/lMeNnQgyl9OaybtB
=CO1L
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
