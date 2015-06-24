From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V2 0/5] drivers/rtc/rtc-ds1307.c: Basic cleanups and
 support for wakeupirq
Date: Wed, 24 Jun 2015 09:34:32 -0500
Message-ID: <20150624143432.GE21232@saruman.tx.rr.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3701170914784225952=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, grygorii.strashko@ti.com, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, balbi@ti.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============3701170914784225952==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline

--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 23, 2015 at 11:15:09AM -0500, Nishanth Menon wrote:
> Hi,
>=20
> Here is the revamp of the patch posted eariler to support wakeupirq.
> This series does a few cleanups as well prior to introducing the
> generic apis required to support the wakeirq mechanism used on certain
> TI SoCs. Cleanups done here are just minimal set of the cleanups we
> discussed in [2].
>=20
> Series is based on next-20150623
>=20
> Test log: http://pastebin.ubuntu.com/11763002/
>=20
> NOTE1: I have only tested in mcp79410 device, and not on other
> ds1307-rtc driver compatbile devices as I dont have any other.
> additional testing might be nice to have.
> NOTE2: there are additional fixes that linux-next seems to need but
> those are in omap-rtc, cpufreq etc, but those are not related by the
> ds-1307.
>=20
> V1: https://patchwork.kernel.org/patch/4759171/
>=20
> NOTE: Patch 5/5 of the series is meant to indicate the usage, and will
> be reposted along with other wakeup sources to be enabled once the
> driver changes are accepted.
>=20
> Felipe Balbi (1):
>   drivers/rtc/rtc-ds1307.c: Convert to threaded IRQ
>=20
> Nishanth Menon (4):
>   drivers/rtc/rtc-ds1307.c: Switch to managed irq allocation
>   drivers/rtc/rtc-ds1307.c: Sort the headers
>   drivers/rtc/rtc-ds1307.c: Support optional wakeup interrupt source

for the series, except the patch which I wrote :

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVir/4AAoJEIaOsuA1yqREfxMQAKWlVvUcPrDpUMPK48OO8bZa
Anm+UEMGwQmMYSSG3Cg575viJOH8LsagnPfdzaveq2ZKs5aPnAHu2MKjHBOM1Tqs
CrIDLgZVUT/VyOKJ+OmqWn5xpCXYlkVlZeO/6CimqKfzAYFsGGeTr0EJQkA9YAP+
JSK4teeX/5Ryz76MtJNK6W/qQ50ahIK36Nw9+00mJ8AXEnlAi5mDGjDJBA2Uzm/g
9cXaZHQbdz3MEB3Dt1qpvlwCKGrHqZ2QZVTCMNJHACfffGH2ApqLYdgsRuXk3gkm
WGCMAEtsaac9SlyzBFYcys8HV0yETgFiDSAXHL8fyW1Z4H8sNNpdjbdZGyQz2kOI
uhAUWBJJks0w7O0P3cIZIVW8j7de3IS8seUPVRmqbQlW8Fx2XpyXWh3so2baigHR
PET074oA19SLwlVPbyUF0JusIqlZk4GfUcKCIy5LI8z4563inZRiDqCqCvH5GM4p
BgyljhPG7BvyMJczeAgwmfEM0sng3bllxvTmqjW1lfNKbi72Ns814E5mB0q8WT+i
I+OBXA29IOtnJ2YgnoNd26OX6+fiurvkr4HZz2V0OnbHg0zuJsbP6Rt+55UUu+tZ
6JE1sYBkBZHNo9iepJ07y+eKeQhxKDNeSZ0f4M30f5kZq2cfSBWg1eIed4nAXY5c
vmF8X068D5SFFRzaVObW
=fSug
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--


--===============3701170914784225952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3701170914784225952==--
