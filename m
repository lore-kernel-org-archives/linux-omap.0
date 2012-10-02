From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3 1/4] mfd: smsc: Add support for smsc gpio io/keypad
 driver
Date: Tue, 2 Oct 2012 16:44:02 +0300
Message-ID: <20121002134400.GA12125@arwen.pp.htv.fi>
References: <1349089282-22105-1-git-send-email-sourav.poddar@ti.com>
 <CAAe_U6+zEGuwMC1yn7O=LXE6PhPvPc2i7DCF0EAprkE8s+-iEw@mail.gmail.com>
 <20121001114454.GA9170@sirena.org.uk>
 <CAAe_U6JX9QDWvWA3KH7E9sOv0EHGkozVONuXDgn+a2MZ4GTE7Q@mail.gmail.com>
 <20121001120907.GK4360@opensource.wolfsonmicro.com>
 <CAAe_U6K6nAjsZUOk2rBFweWHtJmcLF7EJDpu9O6FXrq3tzv3yg@mail.gmail.com>
 <20121002123856.GX4360@opensource.wolfsonmicro.com>
 <20121002124321.GD30762@arwen.pp.htv.fi>
 <20121002125819.GY4360@opensource.wolfsonmicro.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7019998178662665156=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121002125819.GY4360-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============7019998178662665156==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 02, 2012 at 01:58:20PM +0100, Mark Brown wrote:
> On Tue, Oct 02, 2012 at 03:43:22PM +0300, Felipe Balbi wrote:
>=20
> > BTW, OTOH writing all children into the DT actually describes the HW,
> > no ? And depending on the device I feel it'd be better to write that
>=20
> Well, it depends on the hardware.  Some hardware has a bunch of nice,
> neat IPs which can usefully be reproduced and which map sensibly onto OS
> abstractions but a lot of it doesn't and frequently the abstractions
> which Linux wants to use don't bear a huge resemblance to the hardware
> (and Linux's ideas can change over time, as with the clock API being
> factored out for example).
>=20
> > data to DT. Think of twlxxxx (TI's PMICs), we might have completely
> > unrelated drivers using one of TWL's GPIO lines as an interrupt source.
>=20
> > If that particular children isn't listed in DT, it can't be used as an
> > interrupt-parent, right ?
>=20
> You can have the interrupt controller there without having to list every
> IP in the device, just make the parent device the interrupt controller
> to DT.

fair enough, thanks ;-)

--=20
balbi

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQau+gAAoJEIaOsuA1yqREuZ0QAIoB5fehsY09bdFte9fouqQs
TVFxWhnzgNcpzswXn/HiwbuM2NuqMZcLOfbOeyXtHz80+xDwvzxWeijMrSJcPWE2
IxwbrfuEjpdtKpBjpAQ+Sg5l1f4sT4FKTOTkoEqiO18Et6Bd8kiG00UGEk0YXNlx
WJqbFCCTOIvKEmWUp4iqOMLgcEJxYsezXa0wj+dRqu4uwRtXiqRcHFVRPWFU1bBg
edEPd1OouLB6eB4NyYLjrNmsMz1pJ9xwSClviRSB142xip5+pzmguCinDEJ6U224
4xpZLO3iUmFyFwVt1JVIpeu5+GFIxQzvGXmAScIldLLv5PehkimZtIzHlehsaEV9
wZXjOp6KC7nD8fx7toOT9Uk18vkPfvvVvEhR4Z8a6wLM493/SUvKV1UliawsbG19
wMFr0WHcZlTkPD5Hir98f47iflhS2/Z55QZWEcquVv8ZEK6xMp/GOYsdboqJDmcM
2X3gzoLfDm5/JOhtfMGG7nfLNqX+LJvHnqpdot3+xvvdYYrrvyFz5/gH/hswtFZz
1+bgOWmD+3y0dtTRv/bJEGsO9kUqcerircfjtyryF4EoDyrcK+vuuiZ57DR6eb0+
FMFVUvToQFDXCCYXiSG31XJB8r/vO6gVk/vseDqO+pfcHCfd0AjNbJadP/BKI+xl
srqApwYFsjn70Go+AhkS
=u8pA
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

--===============7019998178662665156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7019998178662665156==--
