From: Sebastian Reichel <sre@kernel.org>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Wed, 15 Apr 2015 18:31:08 +0200
Message-ID: <20150415163108.GB2033@earth>
References: <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com> <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk>
 <20150409134843.GQ4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0407727277400878367=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150409134843.GQ4027@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============0407727277400878367==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 09, 2015 at 02:48:43PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 09, 2015 at 12:06:58AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Apr 07, 2015 at 08:22:08AM -0700, Tony Lindgren wrote:
> > > Works for me. The above needs the following fix folded in to build:
> > >=20
> > > --- a/arch/arm/mm/proc-v7.S
> > > +++ b/arch/arm/mm/proc-v7.S
> > > @@ -532,7 +532,7 @@ __v7_ca9mp_proc_info:
> > >  __v7_ca8_proc_info:
> > >  	.long	0x410fc080
> > >  	.long	0xff0ffff0
> > > -	__v7_proc __v7_ca8mp_proc_info, proc_fns =3D ca8_processor_functions
> > > +	__v7_proc __v7_ca8_proc_info, __v7_setup, proc_fns =3D ca8_processo=
r_functions
> > >  	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
> > > =20
> > >  #endif	/* CONFIG_ARM_LPAE */
> >=20
> > Thanks, merged into the original patch.
>=20
> Do you want to give me an ack for this, thanks?

I tried to test this together with Tony's follow up patch, but I get
this after applying the patch to v4.0:

sre@earth ~/src/linux [430973-fix] % make -j4
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: 'include/generated/mach-types.h' is up to date.
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  AS      arch/arm/mm/proc-v7.o
arch/arm/mm/proc-v7.S: Assembler messages:
arch/arm/mm/proc-v7.S:535: Error: invalid operands (*ABS* and .text section=
s) for `|'
arch/arm/mm/proc-v7.S:535: Error: invalid operands (*ABS* and .text section=
s) for `|'
scripts/Makefile.build:294: recipe for target 'arch/arm/mm/proc-v7.o' failed
make[1]: *** [arch/arm/mm/proc-v7.o] Error 1
Makefile:947: recipe for target 'arch/arm/mm' failed
make: *** [arch/arm/mm] Error 2
make: *** Waiting for unfinished jobs....

-- Sebastian

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVLpJJAAoJENju1/PIO/qa8EEP/3mRkTYCktFJJnTZPPQ3pKY5
MoCS74GfVQu+QjOQhUOWeicSKwQwK1Bmyjvrg+LzsxAtJZsed6pqDIqUB5uY4HeK
2zYHnnTG17zAtCKWegRqkyoOHlDthmVP8F1RAjjC7WBH4hm3hc2vJp6RKnZMDzwA
ObebHdzDrvHgn02fnVlgJCbZrRgvae2CnzBbVq0wjU8YE+aa/S4MoNmmpaQ1laWs
3jP6q91bYXh8w9dFre3o+zrhrXkVr+f8B95qThZik5AnCzu6bl5yF6CihvYWh9t+
BQ86FYgJ5YEuBAo3hu5vHM/Eoy5qGSXlWIYmpD8dmI9mfg7p0JdLwgLH6NiFVOKE
pe2AbzxF4RX/cuAJZSsXTGVbaBjjGySus8mrs10G9bab3lf86nQEDjM2Msbz3wO/
peVtyRV3md+lS2heRTsEacEUDcfURtIbkfwRo4uDvZlK7bVd/nwm57D8KyzCZXhA
waeogI3zpc+88l53WHpZAn65f0oRRP59U5+KeNrTK5/mNn6ha92qyqql1rJQiyaK
doWdNgWPf8fqj3z3Je7ixpzHmO3oW/FAsh1nFqYCsYfU8frYXd90b6utZVg84hG1
iJ4qvlTAiCyw7Gwlxy0w7m7ecDUrcnjVXLWC71zxqaNfIaei5KmrACyX/cByLhgq
Y72F8PvOa24I4BslW8Y7
=SEiS
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--


--===============0407727277400878367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0407727277400878367==--
