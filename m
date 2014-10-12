From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 07/12] rtc: omap: silence bogus power-up reset message at
 probe
Date: Sat, 11 Oct 2014 19:50:07 -0500
Message-ID: <20141012005007.GC21128@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-8-git-send-email-johan@kernel.org>
 <20141010180054.GS31348@saruman> <20141010180256.GU31348@saruman>
 <20141011102004.GD18988@localhost>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8135585668297284520=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141011102004.GD18988@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

--===============8135585668297284520==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline

--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 11, 2014 at 12:20:04PM +0200, Johan Hovold wrote:
> On Fri, Oct 10, 2014 at 01:02:56PM -0500, Felipe Balbi wrote:
> > On Fri, Oct 10, 2014 at 01:00:54PM -0500, Felipe Balbi wrote:
> > > On Thu, Oct 09, 2014 at 09:06:29PM +0200, Johan Hovold wrote:
> > > > Some legacy RTC IP revisions has a power-up reset flag in the status
> > > > register that later revisions lack.
> > > >=20
> > > > As this flag is always read back as set on later revisions (or is
> > > > overloaded with a different flag), make sure to only clear the flag=
 and
> > > > print the info message on legacy platforms.
> > > >=20
> > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > >=20
> > > Reviewed-by: Felipe Balbi <balbi@ti.com>
> >=20
> > oh, btw. This should be done for DT probes too.
>=20
> What do you mean? This is for DT probes (of "ti,da830-rtc" and
> "ti,am3352-rtc"). DT probing of legacy RTC IPs is currently not
> supported.
>=20
> Are you suggesting I should add a new compatible string for that?

it seemed to me that you're only passing the new flag through
platform_device_id table, not DT table. Did I miss something ?

--=20
balbi

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUOdA/AAoJEIaOsuA1yqREN7gQAJ6r4QzIbHpnMJV2fbejr0Wd
JT2YIdRQjkgc6FQ0rPxWAJ8CY1vHdsE+c/EdwRjGzFXxfPJiyp+7+f3a7k6Y5aYK
196sdl7IPFaAVoFVFThGL1MfCWdv7fHXF1/4OKQHNJGRl2SsPuWR9Or9KXbSrev4
mJ5OuRQs//mOXgkE5Q1LTk7i9hwNwIG7Im9PJOrV4kxgo4bT/2K9QGmH+VeWzOYg
lS7w9qqp3qj0JAXpoLK89ERFanb9T6f5x5P3zy9pGlQJFwvkfFViJFvpxslfqnBL
DLnGCz0YrYLRNAHbYyUKpTx0WqiPopHuYLF3R9yZEhYd9hb56ZY7mBFf7ZwFJhag
LEEweayI63pz8TH3Rko5MaTnjSTpBt6z3kZrSywuAH/hPv7EJNC8zBBRPYdiSRCv
O3yujY/E7miL4RJo7YnrzexJcemuMsq2TD7V0cmaoTd2jUeRBREk3NzzGezUaRt7
vyHeudQsvPTg6YImu41uakLFa9ikX47mKjeyEpgFW6H7oC5nGg88OnfUgPaXh0yz
2mKrYGd/mmA5XELWqKGPFVnaXF950wDUbGqkZ4ahGQVLiH4iGJT2Z8fZyy8vvVnA
u4tz+aNvSvVEt2JbJTxi5mTKlMjqMwVIP09eWYAhlavRfjdWgQSpdkzJGsCoJLgs
BIFgAA736mfQ1QgpRACy
=4p+c
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--


--===============8135585668297284520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8135585668297284520==--
