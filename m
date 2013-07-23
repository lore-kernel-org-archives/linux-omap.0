From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Tue, 23 Jul 2013 18:34:54 +0100
Message-ID: <20130723173454.GK9858@sirena.org.uk>
References: <3419798.aorxYv8pdo@flatron>
 <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3310697387910759336=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-fbdev@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-doc@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, s.nawrocki@samsung.com, kgene.kim@samsung.com, swarren@nvidia.com, jg1.han@samsung.com, Kishon Vijay Abraham I <kishon@ti.com>, grant.likely@linaro.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, george.cherian@ti.com, arnd@arndb.de, Stephen Warren <swarren@wwwdotorg.org>, b.zolnierkie@samsung.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kyungmin.park@samsung.com
List-Id: linux-omap@vger.kernel.org


--===============3310697387910759336==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i5oaXLJ4GqfCAla0"
Content-Disposition: inline


--i5oaXLJ4GqfCAla0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 10:37:05AM -0400, Alan Stern wrote:
> On Tue, 23 Jul 2013, Tomasz Figa wrote:

> > > > Okay.  Are PHYs _always_ platform devices?

> > > They can be i2c, spi or any other device types as well.

> In those other cases, presumably there is no platform data associated
> with the PHY since it isn't a platform device.  Then how does the
> kernel know which controller is attached to the PHY?  Is this spelled
> out in platform data associated with the PHY's i2c/spi/whatever parent?

Platform data is nothing to do with the platform bus - it's board
specific data (ie, data for the platform) and can be done with any
device.

--i5oaXLJ4GqfCAla0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7r67AAoJELSic+t+oim9mQgP/jtUcLJCh8K5fwvGamn4opPT
Lmfss8MxAGPhgblBb24+aRD7dKntVOSYIQKc51TUXDfzjyUWqCfEo6U46ej6lfkD
kiHlIHfy6YjqIeMmI08dX/OyzgJf9wg/Btf8f3niSmEaQ6GiyuOy+ok3VLJqoIae
lTa+q8mGrWIqHb0+sP0rolztvR4dqHWg8DseVc6mH21kR+RTexwlJcBSJJcL8xmA
IrUbMzt4/35JMeLrgf43T0cuKrP59hT+9Cl4oEVx92We+9Jrc1b4o2LyhlxyAkM/
X7B86hl3ExmvYnPgHMR0N4PiRgsG1XIgFAPHrQQRvfieLm3irgLUnTc9RMIdzpS7
jsgBzR8x14b33ZtGJ8fo9WMlfO9N3ELrLQY4a6g39DPtqxCzyYMbCy5+HVNbUxvP
nnC9V/2Mi01G9AFK1sOocgSZjKjvXa3W5Dgc8KNXIa0d7M8Gy1j/ToGFdDT2Rk9F
f5OjxvRZv8mSffV/vp3GbNbjOhfzB3jRQp3ltmh+ayhnZmfmraOCMiQvfFuacPaC
/QqPWfXLBO+S8iUYsxY5SqhbgP7qbOcfPFzMy6YtDuuNKvNCLbMubhW8fgDX64pt
/nVnmWZa48yb0dCJj0rY/lNNWvFRjb2D3YEhoSxSg7i0oZk8lPO0Ivid3VCZ3AXt
It00egc7+yTUssZUPYJW
=NMIj
-----END PGP SIGNATURE-----

--i5oaXLJ4GqfCAla0--


--===============3310697387910759336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3310697387910759336==--
