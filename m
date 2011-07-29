From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC v2]: Issues implementing clock handling mechanism within
 UART driver
Date: Fri, 29 Jul 2011 15:19:08 +0300
Message-ID: <20110729121907.GM31013@legolas.emea.dhcp.ti.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
 <20110729095512.GE31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
 <20110729113713.GK31013@legolas.emea.dhcp.ti.com>
 <CAAL8m4wq7RQ_Rp-+LMWYY=dtTnhtR5UY+8HpO5C_54goKezaTg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mI5TpPl/qDRoXxBg"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAL8m4wq7RQ_Rp-+LMWYY=dtTnhtR5UY+8HpO5C_54goKezaTg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: balbi@ti.com, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--mI5TpPl/qDRoXxBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 29, 2011 at 05:29:12PM +0530, Govindraj wrote:
> Yes fine, But there are scenarios even before first runtime_suspend happe=
ns,
>=20
> ex: uart_port_configure -> get_sync -> pm_generic_runtime_resume
> (omap_device_enable in this case) debug printk -> console_write -> get_sy=
nc.
>=20
> there are numerous such scenarios where we end from runtime context
> to runtime api context again, or jumping from one uart port operation
> to uart print operation.

calling pm_runtime_get_sync() should not be a problem. It should only
increase the usage counters... This sounds like a race condition on the
driver, no ?

What you're experiencing, if I understood correctly, is a deadlock ? In
that case, can you try to track the locking mechanism on the omap-serial
driver to try to find if there isn't anything obviously wrong ?

> So either we should not have those prints from pm_generic layers or suppr=
ess
> them(seems pretty much a problem for a clean design within the driver
> using console_lock/unlock for every get_sync, and for
> runtime_put we cannot suppress the prints as it gets scheduled later)
>=20
> or if other folks who really need those prints form pm_generic* layers
> to debug and analysis then we have no other choice rather control
> the clk_enable/disable from outside driver code in idle path.

yeah, none of these would be nice :-(

I think this needs more debugging to be sure what's exactly going on.
What's exactly causing the deadlock ? Which lock is held and never
released ?

--=20
balbi

--mI5TpPl/qDRoXxBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMqU7AAoJEAv8Txj19kN1g4oH/188EVO7WsJ7AruGD1YLbS4Q
ikA+ECceM8E1JmoxdMMXNJRzN45WZW2SyCA61yjiwjMrGbh2/Q88u4cfncXaOVl7
+xZEFg8TZz0RVvtarJf+R6mmJdRMiuvxKPZz1552aopKFOLqpgrU6kes3tDjepkq
Z6E4Gv8Ijx8rBrGbR9YLkGTsQEW7bSXDeCr9pxIV/624p+gAp6lauizfpKKxGD4X
lvwNJybZn1se7+NYXdSjJIpd5dHwub7D/Np6n4uo3WfHMMDHyFXaVvz1mBf+UyEX
D33tExXx8RMkOhmYuwe7eB4sT2sg9r6nLnOnJ2t1c1PFiHce3Od1BuRVV7dqgko=
=t6Co
-----END PGP SIGNATURE-----

--mI5TpPl/qDRoXxBg--
