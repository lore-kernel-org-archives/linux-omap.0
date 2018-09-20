From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 4/4] i2c: core: introduce master_xfer_irqless callback
Date: Fri, 21 Sep 2018 00:55:40 +0200
Message-ID: <20180920225540.GC988@kunai>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-5-wsa+renesas@sang-engineering.com>
 <ca62f8b1-26e2-2b40-d8ce-39a920d90063@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2097298319284938434=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ca62f8b1-26e2-2b40-d8ce-39a920d90063@axentia.se>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Rosin <peda@axentia.se>
Cc: Tero Kristo <t-kristo@ti.com>, preid@electromag.com.au, Keerthy <j-keerthy@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-i2c@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============2097298319284938434==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2018 at 07:41:05PM +0200, Peter Rosin wrote:
> On 2018-09-20 18:14, Wolfram Sang wrote:
> > We had the request to access devices very late when interrupts are not
> > available anymore multiple times now. Mostly to prepare shutdown or
>=20
> The first sentence is a bit backwards, I'd rephrase like so:
>=20
> Multiple times now we've had the request to access devices very late, when
> interrupts are no longer available.

Ok. Don't see much difference, but I don't mind.

> > reboot. Allow adapters to specify a specific callback for this case.
> > Note that we fall back to the generic master_xfer callback if this new
> > irqless one is not present. This is intentional to preserve the previous
> > behaviour and avoid regressions. Because there are drivers not using
> > interrupts or because it might have worked "accidently" before.
>=20
> accidentally

Thanks.

> > @@ -498,6 +498,8 @@ i2c_register_board_info(int busnum, struct i2c_boar=
d_info const *info,
> >   * @master_xfer: Issue a set of i2c transactions to the given I2C adap=
ter
> >   *   defined by the msgs array, with num messages available to transfe=
r via
> >   *   the adapter specified by adap.
> > + * @master_xfer_irqless: same as master_xfer. Yet, not using any inter=
rupts
>=20
> "Same" (with capital 'S') to match the other entries. Also, should it
> not be @master_xfer to help the tools do the right thing?

I'll check. You are probably right.

> > + *   so e.g. PMICs can be accessed very late before shutdown
>=20
> Trailing period.
>=20
> I'm fine with this change, but should it not wait until there is a user?
> (I think there is one in the wings, so that's a very weak objection...)

As I mentioned in the cover-letter, this series is RFC because it is
mainly meant as assistance for Stefan, so he could base his imx patches
on top of it. Or the TI folks for their omap driver.

I somewhen need to implement irqless transfers for the i2c-sh_mobile
driver. But this may take a while, so I hope the others are first. And
yes, I won't apply this series without a user and proper testing.

Thanks for the review, Peter!


--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlukJWwACgkQFA3kzBSg
KbauBg//cIuSvQDyUdKKtRG+CcctGYcmCGcNEn8xSr9K0swMv29p0Sp4ngxFbr9d
HknErrVXGhHfevxU3qS3Qo+Db3LYvcuakfTOpkqhO68hmxMcmVPH7ogB4tc5uAdw
4iV0lco1nP0/tqDXuMpCbZn/tHIEunBQ1a9v/a8mZbD26W1Qzb57QpH8P47+U2h9
EJ7d2GQQaWaDhJFri1g7velNnrKCqwOjU829OpKanpl/QJW4gWHsOHvGQOc0a4kZ
0RGj7zr78RpclPKMyv8Gz0LyBUkPhhp0MXGVlAdEVjehHdQyTN76rZmB8vT8tC/9
bYqhK5LZm452swOydaOhg7tHnZ21I01ApkmtgKTKSOOIC24wjBETC8MCMWBXPNCk
0VqQpvIfFoBUHn9UB6ixMaETERiVvJ43xNwlOwZh8YnUiSWlNNs8DMt/vTX4ypYA
VHSHjiuMC0Pq+cxRfdixcGC8C5nrUw2x7pXgiGwRiAbFhUUSdcQm54DpJDTsBCic
eFXB4EURgZZCmQvdBnxzkrjNDpyXcem4CXe/pMSkK+ANU0N7HsePMKPbzPFtQ13L
246bwF03587f+B1oT+bTeveo2CVoTbCWbHnGoxE1jHZtlve9MWjeixSmnN/adrfR
T/63osOby5NWYKSWgCHTYKGnDuEBmhOJ9cwMhbj5x2xyVoR2Jus=
=2qAU
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--


--===============2097298319284938434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2097298319284938434==--
