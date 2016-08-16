From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 5/7] Bluetooth: hci_nokia: Introduce new driver
Date: Tue, 16 Aug 2016 11:35:36 +0200
Message-ID: <20160816093535.ykkvspxqinx2ogwt@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-6-git-send-email-sre@kernel.org>
 <08EF658B-2BCB-46E2-B3DC-24FD12B4D5D8@holtmann.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h4v76xbjzrr27yfw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <08EF658B-2BCB-46E2-B3DC-24FD12B4D5D8@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--h4v76xbjzrr27yfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, Aug 16, 2016 at 10:10:07AM +0200, Marcel Holtmann wrote:
> > diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> > index a7d67aec3632..314b243df996 100644
> > --- a/drivers/bluetooth/hci_uart.h
> > +++ b/drivers/bluetooth/hci_uart.h
> > @@ -35,7 +35,7 @@
> > #define HCIUARTGETFLAGS		_IOR('U', 204, int)
> >=20
> > /* UART protocols */
> > -#define HCI_UART_MAX_PROTO	10
> > +#define HCI_UART_MAX_PROTO	11
> >=20
> > #define HCI_UART_H4	0
> > #define HCI_UART_BCSP	1
> > @@ -47,6 +47,7 @@
> > #define HCI_UART_BCM	7
> > #define HCI_UART_QCA	8
> > #define HCI_UART_AG6XX	9
> > +#define HCI_UART_NOKIA	10
>=20
> since it seems the driver is getting closer to be ready,
> lets merge this extra protocol identifier as a separate patch.

depends on the definition of "the driver". It requires
the gpio information from DT, so it depends on the new
serial bus. I still have to implement that and it has
the potential to trigger a bit of discussion :)

Anyways I will split this out into its own patch later.=20

> Then we can adapt btattach as well for it.

It's enough to set ldisc=3DN_HCI and proto=3DHCI_UART_NOKIA.
Everything else is done by the protocol driver. I still
think it should be done from the kernel and will try to
come up with something in the serial bus.

-- Sebastian

--h4v76xbjzrr27yfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXst5nAAoJENju1/PIO/qaYEUP/RLuB7P+lUfeBEsuoiB1kG2J
1qLG6vJqyoJqzbS6GOU0iEa5sEdwTJtIrizYLEepH/xy7jYG3I5fA6CxM+d3H7H0
O7jJgHo05SdK824KT816N2tGQtzFOJfr/uPuNA1FwYXq68j/m0pEiNtq7xvqVn47
VFuoUvFHUUkCHW+CH19uh16nMp0GQShbJ9tCtw6UlfTWmNoMjbBB/z7mNcozjO8J
rJeChIfPCPxY5SIJg2gV4rhlRJmSKw0nqWVWh0dNMv0uffzO4GxYQLTCpV7elbFw
USfAG/21VT3YbeJArILAqh0AMNOkjcEuguz5R0w6p6Se0FLi4sbGRt9Lj2K5Qiyu
Odr+7ioh41IGB5PTNZgbqCYHm9k9+rmzVeeV2Rf3RlXfLqTz5+NcNPn3G9hi3MLU
XF3BH7yS9UO2n8QQbcdmKvbZQbRXiK3kBAKxuny431vdHfNvpLC+6CvIXgT6wztF
+h1qsykZMwAB1eyiNyxNR8C6DtJyeQkGYayNGE5wCgl2YV5EHBH4P1Z1Vc2fnnS9
QCVDu3w6HQb1qpJSfgZK7B6DKaDm+9zIz6BjIA5pYnzVtt1PHA4xPoO01s40nFI3
0nl8G0qhHMsbpLfMfNPTUaQby4c6aUesB6yKdLBqNUUgUy2Gz+TDWTd7skJVohm9
7p/PZMK448OWmP9w7Q6Q
=UOXu
-----END PGP SIGNATURE-----

--h4v76xbjzrr27yfw--
