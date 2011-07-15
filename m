From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP: powerdomains: Make all powerdomain target states
 as ON at init
Date: Fri, 15 Jul 2011 11:17:26 +0300
Message-ID: <20110715081725.GE2611@legolas.emea.dhcp.ti.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
 <20110715080315.GC2611@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1107150204510.16606@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:40500 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964935Ab1GOIRc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 04:17:32 -0400
Received: by gxk19 with SMTP id 19so667664gxk.17
        for <linux-omap@vger.kernel.org>; Fri, 15 Jul 2011 01:17:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107150204510.16606@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 15, 2011 at 02:10:46AM -0600, Paul Walmsley wrote:
> > > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> > > index e0490bc..e61866c 100644
> > > --- a/arch/arm/mach-omap2/powerdomain.c
> > > +++ b/arch/arm/mach-omap2/powerdomain.c
> > > @@ -109,6 +109,16 @@ static int _pwrdm_register(struct powerdomain *p=
wrdm)
> > > =20
> > >  	list_add(&pwrdm->node, &pwrdm_list);
> > > =20
> > > +	/*
> > > +	* Program all powerdomain target state as ON; This is to
> > > +	* prevent domains from hitting low power states (if bootloader
> > > +	* has target states set to something other than ON) and potentially
> > > +	* even losing context while PM is not fully initilized.
> > > +	* The PM late init code can then program the desired target
> > > +	* state for all the power domains.
> > > +	*/
> > > +	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);
> >=20
> > Just out of curiosity, I was wondering if it really makes sense to power
> > up all power domains during boot just to avoid loosing context. Doesn't
> > hwmod/omap_device soft-reset all IPs during initialization ? If that's
> > really the case, shouldn't we then choose which powerdomains are
> > strictly necessary for boot and only power those up ?
> >=20
> > Sorry if this is a non-sensical question, but I was curious about it
> > ;-)
>=20
> This patch only sets the powerdomain's next power state to ON.  It doesn'=
t=20
> affect the current power state of the powerdomain.
>=20
> Let's say that the bootloader, previous OS (in the kexec case), or ROM=20
> code programs the next power state of some powerdomains to OFF.  Let's=20
> also say that the kernel that is booted has PM disabled.  The moment a=20
> powerdomain's clockdomains go inactive, the powerdomain will then switch=
=20
> off and all devices in that powerdomain will lose context.  On a=20
> non-PM-enabled kernel, that will be unexpected and will probably cause th=
e=20
> system to crash.  This patch prevents that from happening.

I see... thanks for clarifying. The comment above the code wasn't really
clear about it to me.

--=20
balbi

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOH/eVAAoJEAv8Txj19kN1hIoH/2qsUTg5kk715X5eSHL1mwBP
/nv6zJ0qmWzcRS1CdPbhnqkoSX1F0rr5GQdrmC0/3DaI0wF3Uu6P92Qlx0NujUK6
khakgWEVxlRoL8zJWRiKjQhPp+RlFUFUNB0WA0DVg5tA+q7yvClgGCGOXL+e+hT/
cqs1YgR3svWzstZyYbU2qQkANMVvaOrqm0z/HTMkgBFyGcBPH2ykDdy29543E+Ag
h0Q5cVqPUU83HO1JXT6ICayMPPkUkBXUPSPotyV/jC88fWD25ZwUjZrA21mj94fM
ruEERqqyohVWkko4AN+pWYp6k1/RhrbMhxb7uOkjFOAvxtKo+xy9Wa1M2kDaa2o=
=eHIp
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
