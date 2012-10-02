From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3 1/4] mfd: smsc: Add support for smsc gpio io/keypad
 driver
Date: Tue, 2 Oct 2012 15:43:22 +0300
Message-ID: <20121002124321.GD30762@arwen.pp.htv.fi>
References: <1349089282-22105-1-git-send-email-sourav.poddar@ti.com>
 <CAAe_U6+zEGuwMC1yn7O=LXE6PhPvPc2i7DCF0EAprkE8s+-iEw@mail.gmail.com>
 <20121001114454.GA9170@sirena.org.uk>
 <CAAe_U6JX9QDWvWA3KH7E9sOv0EHGkozVONuXDgn+a2MZ4GTE7Q@mail.gmail.com>
 <20121001120907.GK4360@opensource.wolfsonmicro.com>
 <CAAe_U6K6nAjsZUOk2rBFweWHtJmcLF7EJDpu9O6FXrq3tzv3yg@mail.gmail.com>
 <20121002123856.GX4360@opensource.wolfsonmicro.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3762561315589200449=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121002123856.GX4360-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============3762561315589200449==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

coming late to the discussion, so bear with me

On Tue, Oct 02, 2012 at 01:38:56PM +0100, Mark Brown wrote:
> > This means mfd framework does not have an API to create a device from
> > dt data or so do I think since of_platform_populate() is used. Thats
> > why I suggested the idea of extending mfd_add_devices() (or adding a
> > new API in mfd framework) to create child devices from dt data so that
> > we'll have API's in mfd framework to both create and delete a device.
>=20
> The trouble that always exists with representing MFD children in DT is
> that unless you've got a usefully reusable IP block which is clearly
> separate from the chip integration you end up essentially just dumping
> the Linux data structures into DT which often doesn't leave you with
> something which describes the hardware.

do you mean to say that children creation should be left into the driver
(outside dt) ? That should be doable, indeed.

BTW, OTOH writing all children into the DT actually describes the HW,
no ? And depending on the device I feel it'd be better to write that
data to DT. Think of twlxxxx (TI's PMICs), we might have completely
unrelated drivers using one of TWL's GPIO lines as an interrupt source.

If that particular children isn't listed in DT, it can't be used as an
interrupt-parent, right ?

--=20
balbi

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQauFpAAoJEIaOsuA1yqRE/HAP/1r9EzyEad9ZUeIYsUMBVDPQ
ZoYiCfT426o+iEBNMRb58hccVRkUc0z3bpLBGrXaqt2NreF7aV286ovUtvZVyZdt
CGolKWSpmm/qa7XR7Z/tvOY/OYvDHxR/XUi9eA1iGsyBQCA3qwypkV0g2JA/fkl8
aV8T6gzzfqyVaaTyPcM5RD4DNdgV+NDu0s3DQnLL7guu6I0pI1gCo/FXAYaBrRXH
S8427upmY137cr9XJbXPBIZ6FK9x+c3PGr3f20dR15vCqJOyBoklI0tb3fvgwIxH
iB3ukZxhbX0Cj06gvwkTqwGAZhskZ0T/oIzQb6v0hRmYnZ/cG6the5IwCGH/foPn
AtBLY0r3h13BtStjQgNGcj2Gn1rHc+H1JXL+sRDQ2DHxJDbJX/kLMkej0qbHuz4u
BZYNQuaWZ9Y5xk42JgIkX7L7ZNMMCnshp1UF2v3VJSrOjpPPubbycUabiKeB3/0+
ce6HxU+XbYUiGEDW5tUVLLR2YP1IARkftPrDAl7ijInN0lk6lzyv6KZ/oAP7ogvr
kjiGpi0YfzZMSrH5nN6V6GaYCzL5apBSMcbnPkBwdcJGwC056NJ+VIt6nw49+X5y
2ZMmePhS5XNeDUbR/LXJQBUqG8uysdXeyZClj6GyQ/2KsDnKAsXB+49uJgIK5OTD
E3LT7VI4S2G0xtTuVne0
=a1xD
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--

--===============3762561315589200449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3762561315589200449==--
