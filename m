From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 40/46] usb: gadget: epautoconf: rework ep_matches()
 function
Date: Tue, 4 Aug 2015 13:30:59 -0500
Message-ID: <20150804183059.GC9623@saruman.tx.rr.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-41-git-send-email-r.baldyga@samsung.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2597694409143107442=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1438351258-31578-41-git-send-email-r.baldyga@samsung.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: nicolas.ferre@atmel.com, robert.jarzmik@free.fr, m.szyprowski@samsung.com, devel@driverdev.osuosl.org, cernekee@gmail.com, michal.simek@xilinx.com, stern@rowland.harvard.edu, Peter.Chen@freescale.com, dahlmann.thomas@arcor.de, leoli@freescale.com, johnyoun@synopsys.com, linux-geode@lists.infradead.org, haojian.zhuang@gmail.com, andrzej.p@samsung.com, linux-omap@vger.kernel.org, petr.cvek@tul.cz, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linuxppc-dev@lists.ozlabs.org, daniel@zonque.org
List-Id: linux-omap@vger.kernel.org

--===============2597694409143107442==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline

--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 04:00:52PM +0200, Robert Baldyga wrote:
> Rework ep_matches() function to make it shorter and more readable.
>=20
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

this regresses at least mass storage. How did you test it ? I'll keep
all patches up to this one, please fix the problem, rebase on
testing/next and resend the remaining patches.

cheers

--=20
balbi

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwQTiAAoJEIaOsuA1yqREn9QP/0X2aNlkKVBwLNCCW3TvSshr
7CcCEFbtFfBMwSHAowzm5A/XxS3LVYc8oIDc6O1ZaUP3RqB3WTXuPC4bZ/B7Xtgl
bP+Us6DqMcxCUm4w512IfW2hhHzfFL2ZcgjLxyuRM1xJBGzfLYEp4iP8NPYbO9S+
BRZ7h0w5ob10FrS3uwh0rswBv1jnrs5GEVfOMu/r9e81IPmijbi1B1qSs56tanXW
Rq4yVUTa9YoRX1BAwynKwNPfGl4cZdPCLSxwFR9R3xA5J58nSzcRLJOE5z3PwswB
mm2KEGJA9kwiteasTDX6pYYgj38tCUlZL4odBN7n0Wyjo3R5lDO/fGgQGrkM4M3i
mVTF2KW82+u6wkmfbYZD/tjQ0aNXFIK9mnujI7vajF+4H/FfHQrTan1/9CybnOCu
Fzx4lR4ch4lOZEc1vzy9oo6RxmGMrt1KDIVnRJbBV6thhRsu3TWIy4/IlUvWvv0S
zD7AzLcCPMwvT7UrcLzsWQiJyphyQGBQkvvWcfc7pKclENWE3EB3lAKnA0qoE+7l
Xs/2SMuPuNd9Bsp797F8XideVU1aYeXDsbfBdeG5vXZKHKqaHCIVeUApxNiuGqT8
Rv7e0VRNLpgswc5hfVIjeQSKZuNPSaGHO81AH8tP4Q60naoBZ6TvEPzHIqCtehF3
xn56Ib1RMFe3n2POJcHf
=yCEP
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--

--===============2597694409143107442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============2597694409143107442==--
