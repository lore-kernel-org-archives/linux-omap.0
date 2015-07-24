From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] ARM: errata 430973: move !ARCH_MULTIPLATFORM to
 Kconfig
Date: Fri, 24 Jul 2015 02:16:06 +0200
Message-ID: <20150724001605.GA1453@earth>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
 <1437612483-30160-4-git-send-email-sre@kernel.org>
 <20150723123553.GE7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150723123553.GE7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russel,

On Thu, Jul 23, 2015 at 01:35:53PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 23, 2015 at 02:48:03AM +0200, Sebastian Reichel wrote:
> > Having the !ARCH_MULTIPLATFORM dependency in the Kconfig file results
> > in one option less to think about when configuring the kernel.
>=20
> > -#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULTIPLA=
TFORM)
> > +#ifdef CONFIG_ARM_ERRATA_430973
> >  	teq	r3, #0x00100000			@ only present in r1p*
> >  	mrceq	p15, 0, r0, c1, c0, 1		@ read aux control register
> >  	orreq	r0, r0, #(1 << 6)		@ set IBE to 1
>=20
> NAK.  Please read the mailing list history, I'm not repeating myself
> again on this.  Thanks.

It's a bit hard to search the mailing list history without a bit
more information.

I guess you prefer to just add the !ARCH_MULTIPLATFORM dependency to
the Kconfig entry without removing the additional check in the code?

-- Sebastian

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVsYPCAAoJENju1/PIO/qaKmsQAIUJopuLDR9RukmynwELLnH6
9zgnCJIDUMjxScmeDiofN4wAWoFIS/MpSY+rAyNDsjblfBLZ6PFIyJMSVthBPjs0
vRMuHVJyKEpMggB8YIlA2xBhtKnGwV10RvU+DTbCZQH8GZZKcZI+PwlgkwUr3v7n
r6+FX9XvsZCn7dIf8F8ABCRR5nPftizJiUZBTSbYlq8AOm+qsLlRhVR3nqEsw4Uk
KYHSqQiptn87Iy75dVtFEaEDcoa7zaIbmohuPOGjQX6csx2LqDob4TGqAhwNpUZz
sjZsQgheTFazU7tDyNgumhiJzzSClQQP+6wl/yFkBH71mvVAH4gyRtQostxgzZNB
aKnosDcJlpGcpuUVf+dq2kABW0CM/Ycwg5OOxRRkVXeK5ovjXfEbaoBKKWF8yL5A
hS4hmyZPASY1MM884xQhHQHyh//NF4iOJU4AOm/km5BTTrFZbo6LXQ1QCtiTOzVB
4lZwG2He2c64XWXIewNvI/vsqiyfjwb7F9xYY1oFF4Nh/KYAGRrDLSVnTcnSWZSq
hXETpA+yEWPBi/PLDSlcaJgzJ5WJ/j6G52B1GeE2xQJ5VPGqg2iWgWceRqF8NSZY
rZGPd3rvU3AI5uLdJJd07LH/7bLR0h7GZ634VvTCwwQogPc5bLIdgcjDjUaKS5Iu
2c+QELx6o1XvFHrA86F5
=fUXy
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
