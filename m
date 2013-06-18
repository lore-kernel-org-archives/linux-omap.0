From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v7 5/9] ARM: OMAP: USB: Add phy binding information
Date: Tue, 18 Jun 2013 15:35:36 +0300
Message-ID: <20130618123536.GD8620@arwen.pp.htv.fi>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-6-git-send-email-kishon@ti.com>
 <20130618094438.GT5461@arwen.pp.htv.fi> <51C030B4.5070707@ti.com>
 <20130618102725.GB7843@arwen.pp.htv.fi> <51C040E8.2050904@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4179515433463946222=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51C040E8.2050904@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: mchehab@redhat.com, linux-doc@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, swarren@nvidia.com, grant.likely@linaro.org, cesarb@cesarb.net, arnd@arndb.de, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, rob.herring@calxeda.com, linux@arm.linux.org.uk, sylvester.nawrocki@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, santosh.shilimkar@ti.com, rob@landley.net, benoit.cousson@linaro.org, akpm@linux-foundation.org, shawn.guo@linaro.org, davem@davemloft.net
List-Id: linux-omap@vger.kernel.org

--===============4179515433463946222==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline

--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2013 at 04:43:44PM +0530, Kishon Vijay Abraham I wrote:
> >On Tue, Jun 18, 2013 at 03:34:36PM +0530, Kishon Vijay Abraham I wrote:
> >>On Tuesday 18 June 2013 03:14 PM, Felipe Balbi wrote:
> >>>On Thu, Jun 13, 2013 at 02:13:55PM +0530, Kishon Vijay Abraham I wrote:
> >>>>In order for controllers to get PHY in case of non dt boot, the phy
> >>>>binding information (phy device name) should be added in the platform
> >>>>data of the controller.
> >>>>
> >>>>Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>
> >>>I would rather not pass strings around, any other way to handle this ?
> >>>Why do you need to pass this string ?
> >>
> >>Our old way of binding the controller and the phy using device name
> >>started creating problems after the devices are created using
> >>PLATFORM_DEVID_AUTO. Infact non-dt boot is broken in mainline for
> >>OMAP3 platforms for which I have posted a RFC series
> >>http://www.serverphorums.com/read.php?12,708632 which also uses
> >>strings.
> >>I'm not sure of any other way to deal with this.
> >
> >have you checked how other frameworks handle it ? Regulator has some
> >sort of binding in board-files, but I guess it passes the regulator
> >name?
>=20
> From whatever I could make of, regulator has 3 ways to get the
> regulator one of which is using the binding in board-files (but it
> also uses device name which could create the same problem that we are
> facing).
>=20
> 1.) from dt data
> 2.) from _supply_ name
> 3.) from binding in board file
>=20
> (referred regulator_dev_lookup() in regulator/core.c)

right, spot on. Which means we don't have a better, more elegant
solution now. Let's go ahead with this.

--=20
balbi

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwFQYAAoJEIaOsuA1yqRE9mIQAI2MqozlRuRD5dPS+8PB7X/n
szivthcudB8IORFZOcZcYungNvj8XALlJsDMpeP5GHMmNRHC2PCYXBrXSWgLFW0m
OVOZ1KjmpyoY9ufcR/M0T9AmaSCQ2TrVF92Ey7JL09CW9vH6/4DZiva7Nlc79wJQ
dltl8RWnltcDTOIKkzkkvwq9+cKequoiWk8j/sTK6EzYaXAb5XkegZIiRS+Taala
ZszOvqd94Wh64SJePeT95YwlZNT+yu7B1FWsNyJ10JLQju1ldJggzTEEzgYR0eSr
ljzMWJC10WHAGSNU5RqOpbYzBV9MQsDo3U91Azax08YkH8SHBxdPYcz91P2eoTF6
h1DMLKg2cOl4Fo2vF02aY5pikhH0JL3JUkTCCgpu9CGmZrQjWMiuEezBracp28rc
bd87cviLYFoN8AEju9LNgJDYwjJTBWcEmPuem4bkNqge6g0Qi9eovA5JolnTPBK3
SNTcT+6nZLSPlZ8kfl/Bstvc3/53j1aM3OBjp1RGJyOIS33dTF/uRnCW+mMaXblt
XT9WhIyTKjvA3kx8Y1T4BB/x/72+gPfVB1M1xBTLraU68stKJ/rCEHMLBHf20LkD
3olvxVPa/iNRYzDnSseUgL6bxpBWtXstIXaGx9h2QjP3SKXzN4i9lR2ORYg+xbbr
mUn/SY6GH/i1TsovMdcO
=lCNm
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--


--===============4179515433463946222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4179515433463946222==--
