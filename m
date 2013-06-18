From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v7 5/9] ARM: OMAP: USB: Add phy binding information
Date: Tue, 18 Jun 2013 13:27:25 +0300
Message-ID: <20130618102725.GB7843@arwen.pp.htv.fi>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-6-git-send-email-kishon@ti.com>
 <20130618094438.GT5461@arwen.pp.htv.fi> <51C030B4.5070707@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8081120397044998597=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51C030B4.5070707@ti.com>
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

--===============8081120397044998597==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2013 at 03:34:36PM +0530, Kishon Vijay Abraham I wrote:
> On Tuesday 18 June 2013 03:14 PM, Felipe Balbi wrote:
> >On Thu, Jun 13, 2013 at 02:13:55PM +0530, Kishon Vijay Abraham I wrote:
> >>In order for controllers to get PHY in case of non dt boot, the phy
> >>binding information (phy device name) should be added in the platform
> >>data of the controller.
> >>
> >>Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >
> >I would rather not pass strings around, any other way to handle this ?
> >Why do you need to pass this string ?
>=20
> Our old way of binding the controller and the phy using device name
> started creating problems after the devices are created using
> PLATFORM_DEVID_AUTO. Infact non-dt boot is broken in mainline for
> OMAP3 platforms for which I have posted a RFC series
> http://www.serverphorums.com/read.php?12,708632 which also uses
> strings.
> I'm not sure of any other way to deal with this.

have you checked how other frameworks handle it ? Regulator has some
sort of binding in board-files, but I guess it passes the regulator
name?

--=20
balbi

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwDYMAAoJEIaOsuA1yqREUX4P/3OuItDq1QeDBeuFjqAIQR+8
O5h8zEMhbPGeHFY/ieRkQ66RbD60nEJNqn46EpBP/KI0bIwS8tK0T38nAhS//Dl4
/wXfCfVbDCnglIQCpdrnxnZEN0854rqDA7Gsc3CI8oEro9dBnWh1oOYjWZiBJrKX
SizirgLGvFmn1SMMTZGe+qJT/DyGWmGcd86fSsiu1amRFGXjP82Ov1HNxa4F4VvE
umzn8VDn4J08wER0F2LyIlUfXkEKxAY/DK72RewiyY8EJUXAnV0GUliGqK7hfuto
KAUi/17ZSKp80ec9LEqiredvwwQyoWvvg8TjcpMJz1UYN4Yzbl6ehiwYE4Tr423k
3fDWaH1gagwa+0Vd0HQeLCaHByR/W3utBWcc6AYe5sWsQmzYNqiB1Z1DodrldGks
m2vJn2mY13PH7emSN1AiIpy1IH9B9wZbeYfJeD3v9T8GCGhPO+N5SREkdNSqEAXB
LIPu3etHFqnIMtlhWHbhKCNfX314mP6g45rGMJSWsSyr+cokI7Sk06xp1WWJaYt7
qW3zszUTeQfuODKbxnVQjmHlDutkaMGyI3nS2wud+j1LamHnaZhCBDfJePKfGWdE
e15xd4i9PTVbSSNZy3+S06I3SS0FdXOBlx/W/5cx+cu6XOEDD+702CRCXCXVQksg
3+Ug6SAoVp+U69YFJ58q
=AoQU
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--


--===============8081120397044998597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8081120397044998597==--
