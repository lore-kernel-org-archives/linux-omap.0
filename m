From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] ARM: errata 430973: move !ARCH_MULTIPLATFORM to
 Kconfig
Date: Mon, 27 Jul 2015 03:14:47 +0200
Message-ID: <20150727011447.GA23087@earth>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
 <1437612483-30160-4-git-send-email-sre@kernel.org>
 <20150723123553.GE7576@n2100.arm.linux.org.uk>
 <20150724001605.GA1453@earth>
 <20150726225145.GF7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150726225145.GF7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 26, 2015 at 11:51:45PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 24, 2015 at 02:16:06AM +0200, Sebastian Reichel wrote:
> > On Thu, Jul 23, 2015 at 01:35:53PM +0100, Russell King - ARM Linux wrot=
e:
> > > On Thu, Jul 23, 2015 at 02:48:03AM +0200, Sebastian Reichel wrote:
> > > > Having the !ARCH_MULTIPLATFORM dependency in the Kconfig file resul=
ts
> > > > in one option less to think about when configuring the kernel.
> > >=20
> > > > -#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULT=
IPLATFORM)
> > > > +#ifdef CONFIG_ARM_ERRATA_430973
> > > >  	teq	r3, #0x00100000			@ only present in r1p*
> > > >  	mrceq	p15, 0, r0, c1, c0, 1		@ read aux control register
> > > >  	orreq	r0, r0, #(1 << 6)		@ set IBE to 1
> > >=20
> > > NAK.  Please read the mailing list history, I'm not repeating myself
> > > again on this.  Thanks.
> >=20
> > It's a bit hard to search the mailing list history without a bit
> > more information.
>=20
> You were Cc'd on the previous round of review...

But that discussion was about removing the check alltogether iirc.
This patch does not remove the !ARCH_MULTIPLATFORM check. It just
*moves* it from the sourcecode to the errata's Kconfig entry.

The intention was to hide the Kconfig option on multiplatform
kernels, since it's completely useless there after the N900
boardcode has been changed (PATCH 1/3).

> > I guess you prefer to just add the !ARCH_MULTIPLATFORM dependency to
> > the Kconfig entry without removing the additional check in the code?
>=20
> I was referring to the above change.
>
> However, having discussed with Will Deacon and checked the manuals, I
> think the change is okay after all: the auxillary control register is
> banked on secure parts, and the bit we'll be trying to change will be
> read-only in non-secure mode - and importantly won't fault.
>
> So, the change is fine, thanks.

I think you missed the part adding the !ARCH_MULTIPLATFORM
dependency in Kconfig for ARM_ERRATA_430973. I only removed
the check in the sourcecode, since it is no longer required
with the dependency being in Kconfig.

So I guess there are 3 options now:

 1. Add !ARCH_MULTIPLATFORM dependency to Kconfig,
    keep extra check in the sourcecode
 2. Add !ARCH_MULTIPLATFORM dependency to Kconfig,
    remove extra check in the sourcecode
 3. Remove !ARCH_MULTIPLATFORM dependency alltogether

I will send an appropriate patch, if you tell me your preferred
option.

-- Sebastian

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVtYYEAAoJENju1/PIO/qae2AQAJFkYypOGfpUVpKCwkCS40wP
wi7hFG8VTu9otkquihqezpl8mdq9miEAKGTPOlXg6lFfUWH2FbAbaqOFuBA9arNO
DUxFFOxG7wl8KsBpK5GezF5+nE+29GEMlvXcN9ceaZRMekl3demZkGh0PU6z0YAc
mBQByogxo44hfi6XcJfkwHz9mRjOSodpTAkX7NhPmWOXayl/zSErXK3dLkERJlJd
vDGlgyl0N8cDCj3vjAhUJA1JAFvkw4PZIZFv9B9RYa2XK5XKIqsptXejVntji/Ki
90DS9iGy+AONOw4/9383aptIiygZzHM+OpJQI5rSx8i5aRgfYg1e04a9PwQxaX0S
FLuxohOQh1uNZgSnBH9VoVltmRRdmtMGn4fGj9wP69Gf/8CyA28ku5AkFsGsLnmB
c/ged+4o2pq6lah1aryfZhf6DskmIkGUZEOBdGdnC7WJCxBVPiE5n4eJ4iiPP1s0
db8obwZLtafw3ZoicAmiXumrj7red3Xr+AFapI6Zf9P3XLPCctOWLjXUB9NqIxQp
uEtEvzutb5+0+aTU0ZSxi4Qyj2qIRlpIFC0oC7dfTDGiAZM18ugg/OBPhpna57gf
AepV0YmCopR+l1vBf+ETI8XDTmgtq6+YVM5VkkbdqD5frRCJjqSGsBYvKqigqJK2
Qpo8bcvwVw2beLjQCC6j
=pks6
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
