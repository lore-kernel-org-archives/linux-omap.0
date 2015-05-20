From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2 4/4] DTS: ARM: OMAP3-N900: Add lis3lv02d support
Date: Thu, 21 May 2015 00:09:48 +0200
Message-ID: <20150520220947.GB28218@earth>
References: <1427467186-9360-1-git-send-email-sre@kernel.org>
 <1427467186-9360-5-git-send-email-sre@kernel.org>
 <20150514224012.GA1835@earth>
 <20150520172121.GA10274@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150520172121.GA10274@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 20, 2015 at 10:21:22AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [150514 15:41]:
> > On Fri, Mar 27, 2015 at 03:39:46PM +0100, Sebastian Reichel wrote:
> > > This adds support for the N900's accelerometer to
> > > the Nokia N900 DTS file.
> > >=20
> > > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > > Acked-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > > Quote from Tony:
> > >=20
> > > This at least currently does not conflict with anything I have
> > > queued, so I suggest you try to get Greg to take the whole set:
> > >=20
> > > http://article.gmane.org/gmane.linux.ports.arm.omap/125020
> >=20
> > It seems Greg did not see this message (this patch did not make it
> > into 4.1-rc and the driver changes did), so could you queue this
> > patch for 4.2?
>=20
> Hmm seems to be there as commit 1ac4e6fee41d6.

uhm right, my mistake. No clue how I missed it (especially since it's
the last change in the n900 dts file).

Sorry for the noise.

-- Sebastian

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVXQYpAAoJENju1/PIO/qaQsoP+gOU99FpuPSmlUF13FBKm4gC
bsKrpXaFtQVtG6mHNSfjTJ6BhFwnhDX3yQi7F5Z1AEpMIr0cHrU4fKRsZMBVXo2s
GCrinC4i/u9UdT1eFhJSkU+/sOSQRmOJNMPNlzsjzgLymsRl/Zz3GUTTFie29AiW
/q/1+q8htQYLnyuckBX9/MHOd00LfplczdaMKbrtNEZlzMKCHdcPRNy3AZgiKDnt
xpK5JtszgNgE1dqQJbh47GEjxLrUxTgiOmwxVFgc7OmC43Q1QBjGMue4xpf2YEjD
Njn+G+NmF8NsytLvzizVn/ANPtd8J2+iWIR1btB0mjcV6447a0NRhH0YhXXhaMVD
kjhiqabquEYBm7pXF/qRM4BmFcEkNlgdyuBi8nbcvf/s3j6FD7jg0sD6/nREocaH
7vKxnNczrAaGNdwMuE96jcqsjBwof65yw6e48AQ4X71e8fLQrsHHCDMEyUep8UYw
wF5dsfa7iR4eWxNHipVa/fMVQfNI/dbt9B5zBmSucel0xkbH3gB0YgMIcQzO1mAD
e/kFcBcmSlTZrYSornDzZlJSPPcy11g064Fh1DklagVphaz4v7zIAtXyMDoNnKdZ
2ACV7yn2xs63CDQNtG0ufauy9S2zy9Fu2jLuKK8rGsaR8lSSfCiSJKygCR4dMMXp
veA+W6e/spU8c51miycv
=ddm0
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
