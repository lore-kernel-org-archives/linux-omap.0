From: Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: manual merge of the usb-gadget tree with the usb tree
Date: Wed, 18 Oct 2017 17:04:42 +0100
Message-ID: <20171018160442.kgdwfzobxtcbf636@sirena.co.uk>
References: <20171018144912.qlc7vlnhdqmr5tdd@sirena.co.uk>
 <CAGXu5jJFTczR39wPX=B+6nWHfHUW12HxA_f6iRg41uNre6msww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="td5ldxmizzp7fmgw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jJFTczR39wPX=B+6nWHfHUW12HxA_f6iRg41uNre6msww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Felipe Balbi <balbi@kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Allen Pais <allen.lkml@gmail.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--td5ldxmizzp7fmgw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 18, 2017 at 08:40:04AM -0700, Kees Cook wrote:
> On Wed, Oct 18, 2017 at 7:49 AM, Mark Brown <broonie@kernel.org> wrote:

> > I fixed it up with the USB version and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.

> FWIW, timer_setup() should be preferred over setup_timer().

Bah, that's unfortunate.  When more of these come up I'll do that.  It
would be better to sort these out in the relevant trees though, there's
quite a few of these conflicts and it's not super obvious if you're not
into the timer code what's preferred.

--td5ldxmizzp7fmgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnne5kACgkQJNaLcl1U
h9AKBgf6A2WhnLcvWwwbXLd0hXyaIS+U6lx0m25qO0N3+GspQSDZzBonCYiEwKh5
ri8NUwF9kPVPln3HVqU3C13izhvWAIK+7l6Pjh0CWT3/djAhOIPavSHFviV70daw
E5YkB0cQDJGwg99ca62p79g39UtSFFGwDttaAFsuBzCGe9qLq3DLd3SqtmXZbQnN
KnbzNh1FSn2dqaw6p2n1EVpvweG46iZYmcjKpAC2Mhv7/o1k0dDTUtY/nTH9wchi
dxNvRDvO8mh4G+xnRhsUPGvQB4EGx2mQgALu9JbpxIqN+C1GC4P+H9VV4nbN0NXH
/GX+/+y2XT2LG5NRxAX4ErW4qWI7rA==
=dKuH
-----END PGP SIGNATURE-----

--td5ldxmizzp7fmgw--
