From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 07/12] rtc: omap: silence bogus power-up reset message at
 probe
Date: Mon, 13 Oct 2014 10:56:35 -0500
Message-ID: <20141013155635.GG21709@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-8-git-send-email-johan@kernel.org>
 <20141010180054.GS31348@saruman> <20141010180256.GU31348@saruman>
 <20141011102004.GD18988@localhost> <20141012005007.GC21128@saruman>
 <20141012184240.GA2786@localhost>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8692125445441232505=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141012184240.GA2786@localhost>
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

--===============8692125445441232505==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Content-Disposition: inline

--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 12, 2014 at 08:42:40PM +0200, Johan Hovold wrote:
> On Sat, Oct 11, 2014 at 07:50:07PM -0500, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Sat, Oct 11, 2014 at 12:20:04PM +0200, Johan Hovold wrote:
> > > On Fri, Oct 10, 2014 at 01:02:56PM -0500, Felipe Balbi wrote:
> > > > On Fri, Oct 10, 2014 at 01:00:54PM -0500, Felipe Balbi wrote:
> > > > > On Thu, Oct 09, 2014 at 09:06:29PM +0200, Johan Hovold wrote:
> > > > > > Some legacy RTC IP revisions has a power-up reset flag in the s=
tatus
> > > > > > register that later revisions lack.
> > > > > >=20
> > > > > > As this flag is always read back as set on later revisions (or =
is
> > > > > > overloaded with a different flag), make sure to only clear the =
flag and
> > > > > > print the info message on legacy platforms.
> > > > > >=20
> > > > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > > >=20
> > > > > Reviewed-by: Felipe Balbi <balbi@ti.com>
> > > >=20
> > > > oh, btw. This should be done for DT probes too.
> > >=20
> > > What do you mean? This is for DT probes (of "ti,da830-rtc" and
> > > "ti,am3352-rtc"). DT probing of legacy RTC IPs is currently not
> > > supported.
> > >=20
> > > Are you suggesting I should add a new compatible string for that?
> >=20
> > it seemed to me that you're only passing the new flag through
> > platform_device_id table, not DT table. Did I miss something ?
>=20
> Ah, that's just the way the driver currently encodes the IP revision
> differences. The platform_device_id entries are references from
> of_device_id data. Should probably clean that up as well.

oh, alright :-)

> Thanks again for the review. I'll post a new version when I'm back from

no problem.

--=20
balbi

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUO/YzAAoJEIaOsuA1yqREP0AQAIkLWaDOJJTpFvhKcAdhb30P
zrErSKM6Igf2zCVwk4n9is58jsKi1HW2mQwk8DVCAId4vMLg+V3ADYugQqZpvPg1
ztYe24OoVe4VHZZ4/RJbJBCi3JRcq9LlutiGsTryjOfYwAqH+GdQ6fCf1VRgE251
ADcH99wB5rRfBSlTKAQuku7UjtYF5AA2CArG+z/433XoZUS8NuCwfkHns5MTxFDE
JJDNpPnH8d+tS3fq0hQXrrnjFYjBB++CfYbPNLMpkrhUhpnPne7OJfh/3kJ7dKcb
OQcpHpeia6VvZkdJBQPDYNev/8vxvtIG6ym4ZiY3SkUR5pELv5QnnUjmrLQWkA4y
+YTpXj9gFhT1I+KcSL1fKBoCc7y0YFqJk0DuEFWTxVuGyOcJIr0uCpeMF7jBQkrD
Ezm7AWmJvblkuxoujUQF2elGYd2GHrl8JicXuE/klXm04LEpXrOnGDVvFUyX2NMj
DwROaiNIt03B6976O/vweWgA3IiNG2O+gUOim7C+Kl686mVQySidw65F67NB1Tff
t1wS1Jwt7NN5LVj5+9LJXrZGb0hydzO+kxeT2VciQWj5+kuWFraLcTVhlik1U1C/
7a3DpU+xla1plmqJnLIOQXBZ4lcfp29tiFintXL9dRexF1oZxDWFLn8RJ/m8Ea7X
xYoEskPxphUWdLNNoly4
=yAIG
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--


--===============8692125445441232505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8692125445441232505==--
