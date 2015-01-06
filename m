From: Sebastian Reichel <sre@kernel.org>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Tue, 6 Jan 2015 12:52:50 +0100
Message-ID: <20150106115250.GA27539@earth.universe>
References: <20150101182053.GG582@fuloong-minipc.musicnaut.iki.fi>
 <20150102161911.GA3298@atomide.com>
 <54A6E408.1090908@gmx.net>
 <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi>
 <20150102204018.GF3298@atomide.com>
 <20150102223451.GL582@fuloong-minipc.musicnaut.iki.fi>
 <20150103000220.GE3279@atomide.com>
 <20150103121622.GN582@fuloong-minipc.musicnaut.iki.fi>
 <20150105154313.GA19336@saruman>
 <54ABC618.8070906@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44829 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232AbbAFLw6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jan 2015 06:52:58 -0500
Content-Disposition: inline
In-Reply-To: <54ABC618.8070906@gmx.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter =?iso-8859-1?Q?K=FCmmel?= <syntheticpp@gmx.net>
Cc: balbi@ti.com, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 06, 2015 at 12:25:12PM +0100, Peter K=FCmmel wrote:
> Am 05.01.2015 um 16:43 schrieb Felipe Balbi:
> >Just booted AM335x with CONFIG_PREEMPT and haven't seen any problem.
> >Perhaps this is something related to another OMAP3-only driver?
> >Perhaps HSI/SSI ?
>=20
> I see a ssi error directly before the IN-Band error:
>=20
> [    0.339935] platform 48058000.ssi-controller: Cannot lookup hwmod 'ssi'
> [    0.346893] In-band Error seen by MPU  at address 0
> [    0.346923] ------------[ cut here ]------------

mh I guess your board's dts included omap36xx.dtsi or omap34xx.dtsi.
Since ssi controller is not available on DM3xxx/AM3xxx (AFAIK) it
should be disabled for those SoCs:

&ssi {
    status =3D "disabled";
};

=46rom what I can see the following in-tree .dts files should be
fixed, too:

* am3517_mt_ventoux.dts
  Currently includes "omap34xx.dtsi" instead of "am3517.dtsi".

Apart from that the following boards seem to use omap36xx.dtsi
include, but are actually DM37xx, so they should disable the
ssi block:

* omap3-igep.dtsi
* omap3-lilly-a83x.dtsi
* omap3-overo-storm.dtsi

I will prepare a patch for that later.

-- Sebastian

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUq8yOAAoJENju1/PIO/qaatcP/0aXxLJ4/y/eyTTAGK72Vq+w
hT59E1F5Tc0WJxILcy8KMG8XgJpLxwmKP+sEcsh3yD88nNJIvyTr21t38K8eaOmw
6zyneTz0NXIgbvugILrKjjGdtAYOzzQCL8X9t1wVdIJRrNqPztKxm/cgYqlxoC7I
wp4R+aXLcqrcNsI3FVtuMqVDUFd/8QF3IFoGj8MQda+IJ9xH2H56VIhaFzTTpgk0
8yrmZoi8ApnCwcg4/QUQK04l9aW4xyE00oFyZgWUq412RVBaOGTtQP/wfYkzvgN1
sZIdiBRXGRgtJErnWuwB/3LVrzaciLlRJ6RUFRPc4G620S1V5zeRf13a0cr3G9vH
ROI1HIBoE00G/pwUEEuL4ludZcVhpoKLLvIhY2iN7TyqO4ncP2zN/L+CsQHDW2hM
dgIjB61U16asmljafM3q+bWWG7UZmsMV5YjH/0G9MrRVwbOWC5FogFizjuPd/QWI
TilEDfex73EtW7J/VMFK5tnnghWmCj6rBHljrkFvhqKo7IsrZ3bv4umIbwokMmFb
BH6sQ38EJCH35pDwa9pk2P0XBqBRDe2wEzFOZVagZiCp9eR/MnCD+CXtbEmcgqWA
M4Wl836kJFj6e9I81hwvPxOrNAGUzZ05LoUsy0spV1QtOw5l+PAMTF+I01At/dYV
iMKMcBX9fo9jhtm88tIr
=zDmY
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
