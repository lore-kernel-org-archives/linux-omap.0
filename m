From: Sebastian Reichel <sre@debian.org>
Subject: Re: N900 device tree conversion: how to do first step
Date: Fri, 19 Jul 2013 20:14:16 +0200
Message-ID: <20130719181416.GA1204@earth.universe>
References: <20130609015944.GA23559@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1090849420522341877=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130609015944.GA23559@amd.pavel.ucw.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: lauri.leukkunen@nokia.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============1090849420522341877==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 09, 2013 at 03:59:44AM +0200, Pavel Machek wrote:
> I'd like to convert Nokia N900 to device tree.
>=20
> Unfortunately, serial port is not easily available (very special cable
> would be needed, does someone know where to get one?)

One way to get one is building it yourself. I finished mine yesterday:

http://elektranox.org/n900/adapter/index.html

-- Sebastian

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJR6YH3AAoJENju1/PIO/qa4AUP/A/PMxO7JXevqRqpadVwUHWe
cqMCdksgCF+iMTnwmIl/s53Vx78qnL9PXHihxD4+BK+qO5ELX7zvliW0sT3LfjNl
lsKVMW58Lei2gNBAOWs8elcD0/0wrfqxlQNqOrBtr7NNyi0PCEkKxR+3GDjCByKn
zcgctecqfPjUhfTvHNKHGg+C9L2O2NoQOaUhH0obY5S8RNDg2th9ywQ/dy+cK6C5
9DPTnAM/NuWGkU9BrTzDHtq3zKsZqmGDK0q3o6HrrnI3yZKrWqX7015moeyu94/B
89OqvIBrj1nH1HZ+95ZPfbuvN8neRIL5ZM9JeS4n2cheHumoxjGIUNNRTrYkfEkk
0UvEe5xuWclS0B7TopzYozA6rKpJuRw5lroKf5UPMPU5T9C/plHysikYfTp2QHLt
ZYNI4yWKJL2KWKl1b7vsiTdfyFweRD4sCesnVS+NLxlhgQh3EnNatQfzbiaNHoyc
8hz4LGXyXNAyHQUPJC6/NpRsUmrGOHK7W3+SRWzWqZdB9NgCLGzJyPWW1aYoxKu9
yQ3iCzUN7Cr8SrQag2nwnXTUSOKCN8FYIdHtR3iUpMxwhGgif/2vFh7fX0RQ9Q7U
m3otvuEB5BUWs40ZcU4RwDWLDa+INk7A3PMk2sFzHcvfUFI63CHfMclxGwow8/BI
P8YG8dPzZ9WFNNsmWwR+
=jDnC
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--


--===============1090849420522341877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1090849420522341877==--
