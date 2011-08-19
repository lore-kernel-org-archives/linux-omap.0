From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP4: clock: re-enable previous clockdomain
	enable/disable sequence (was Re: Oops on ehci_hcd when booting
	3.0.0-rc2 on panda)
Date: Sat, 20 Aug 2011 02:08:06 +0300
Message-ID: <20110819230805.GA13317@legolas.emea.dhcp.ti.com>
References: <1307356643.23002.413.camel@cumari>
	<20110606104417.GP18731@legolas.emea.dhcp.ti.com>
	<20110606110218.GS18731@legolas.emea.dhcp.ti.com>
	<1307358348.23002.419.camel@cumari>
	<1312889168.2407.148.camel@cumari>
	<CAK=WgbatbaSj=U7+SAva4Woh7uaOoCzQck5yjfLvVGLR-UCVHg@mail.gmail.com>
	<4E43C41E.1080808@ti.com> <1313065224.2407.857.camel@cumari>
	<CAP05o4+sBa_DO-ReoF20L=v5kbt5936_1vAGTQ10E4Lh+YXdNQ@mail.gmail.com>
	<alpine.DEB.2.00.1108191647430.9948@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0720764524=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1108191647430.9948@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Kevin Hilman <khilman@ti.com>, Luciano Coelho <coelho@ti.com>, "Cousson,
	Benoit" <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, balbi@ti.com, linux-usb@vger.kernel.org, "Munegowda,
	Keshava" <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--===============0720764524==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 19, 2011 at 04:48:52PM -0600, Paul Walmsley wrote:
>=20
> After commit 665d001338b494d6d62810aa99b4c0fa1a0884b9 ("OMAP2+: hwmod:
> Follow the recommended PRCM module enable sequence"), device drivers
> for OMAP IP blocks that do not use runtime PM can cause oopses or
> kernel instability[1][2].
>=20
> This is because those non-runtime PM drivers do not use the hwmod
> code, which implements the correct IP block enable and disable
> sequence.
>=20
> Several options for dealing with this problem have been proposed:
>=20
> 1. Add a new field to the OMAP struct clk to mark clocks that are
>    currently used by non-runtime PM drivers.  Modify the clock code to
>    use the old clockdomain sequence for these marked clocks.  As
>    drivers are converted to use runtime PM, remove the annotation from
>    the clocks.
>=20
> 2. Similar to #1, but associate the flag with the struct omap_clk
>    instead.
>=20
> 3. Add IDLEST wait support to the OMAP4 clock code, similar to the way
>    it is implemented for OMAP2/3, and enable it in each struct clk
>    currently used by non-runtime PM drivers.  As drivers are converted
>    to use runtime PM, remove the annotation from the clocks.
>=20
> 4. Do nothing; leave the problem to those responsible for the
>    unconverted drivers.
>=20
> 5. Re-enable clock-based clockdomain control in the OMAP4 clock code.
>    This would revert back to the behavior of Linux 3.0, simply with a
>    slightly longer module enable/disable latency.
>=20
> Unfortunately, no approach seemed particularly good.  Options 1
> through 3 seemed unwise due to the following reasons:
>=20
> A. The OMAP struct clks are intended primarily to describe hardware
>    clock nodes, and the intention is that no driver-specific data
>    should be stored there (applies to #1)
>=20
> B. The resulting patch would have been quite large for the -rc series
>    (applies to #1, #2, #3)
>=20
> C. The patch would have been a new, yet temporary hack; and similar fixes
>    have drawn negative comments in the recent past (see for example [3])
>=20
> Option 4 is undesirable because commit
> 665d001338b494d6d62810aa99b4c0fa1a0884b9 ("OMAP2+: hwmod: Follow the
> recommended PRCM module enable sequence") has resulted in a less
> stable kernel; and kernel stability is more important than OMAP4 power
> management.
>=20
> Option 5 is the approach taken in this patch.  This seemed to be the
> least intrusive approach for 3.1-rc.
>=20
> The approach in this patch was originally proposed by Ohad Ben-Cohen
> <ohad@wizery.com>.  I'm simply writing the commit message and passing
> it along.
>=20
> ...
>=20
> Thanks to Luciano Coelho <coelho@ti.com> for reporting the problem.
> Thanks to Ohad Ben-Cohen <ohad@wizery.com> for tracking the problem
> down, generating a temporary workaround, and proposing a patch to deal
> with the problem.  Thanks to Rajendra Nayak <rnayak@ti.com> for
> proposing another patch to deal with the problem.
>=20
> This patch is intended for the 3.1-rc fixes series.
>=20
> 1. Coelho, Luciano <coelho@ti.com>.  _Re: Oops on ehci_hcd when
>    booting 3.0.0-rc2 on panda_.  Tue, 09 Aug 2011 14:26:08 +0300.
>    Posted to the <linux-omap@vger.kernel.org> mailing list.  Available
>    from (among others)
>    http://www.spinics.net/linux/lists/linux-omap/msg55213.html
>=20
> 2. Munegowda, Keshava <keshava_mgowda@ti.com>. _Re: Oops on ehci_hcd
>    when booting 3.0.0-rc2 on panda_.  Thu, 11 Aug 2011 13:51:05 +0530.
>    Posted to the <linux-omap@vger.kernel.org> mailing list.  Available
>    from (among others)
>    http://www.spinics.net/linux/lists/linux-omap/msg55371.html
>=20
> 3. King, Russell <linux@arm.linux.org.uk>.  _Re: [PATCH 5/8] OMAP4:
>    PM: TEMP: Prevent l3init from idling/force sleep_.  Thu, 23 Jun
>    2011 16:22:49 +0100.  Posted to the <linux-omap@vger.kernel.org>
>    mailing list.  Available from (among others)
>    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51392.html
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Luciano Coelho <coelho@ti.com>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Beno=EEt Cousson <b-cousson@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/c=
lock44xx_data.c
> index 2af0e3f..fe6508d 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3379,7 +3379,7 @@ int __init omap4xxx_clk_init(void)
>  	}
> =20
>  	clk_init(&omap2_clk_functions);

maybe add a comment here stating why this line is commented out ?

> -	omap2_clk_disable_clkdm_control();
> +	/* omap2_clk_disable_clkdm_control(); */
> =20
>  	for (c =3D omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
>  									  c++)

--=20
balbi

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOTuzVAAoJEAv8Txj19kN1t+cH/2xyVdtV8j78VgzLTxuNyp3P
l/qx4+juBPajneMvC0jsDyzvCpTwtBGTv9PFsOx3vWh112ETLNApJnVbhxQaDEuG
jUe7wZt3Av83pvWniSX5RaQrmK8q4/cOwI9SmzLJLSC1C+c3ZvdxasxhO+daW/O1
EsBNqZ3oj3J811fYebbNtB3/eeyZlGFjmEx1sfGcDWxZ9u08RI5F82MgUcU0cxpo
iDuXaYOx6R9mjkTMqGJ5FwbelUbXhl9MQ04AZQPWambdkLXT6YRg5kX78ybuQesl
VKRkNKnF7HINRQTCm4j9Fmrw3kn1KOSZT1mDVcyjymTxmVUr53qhC8K6Csr2X6U=
=pU5P
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--


--===============0720764524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0720764524==--
