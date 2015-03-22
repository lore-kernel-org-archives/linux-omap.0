From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Patch to parameterize DMA_MIN_BYTES for omap2-mcspi
Date: Sun, 22 Mar 2015 16:31:46 +0000
Message-ID: <20150322163146.GI6643@sirena.org.uk>
References: <1426741501.10003.6.camel@midgaarde>
 <550AC256.4070509@ti.com>
 <CAAQQ3un3k-0nY8xaOXKbmCznOk69ZEhbWLd5ZZV1_=rQLOyspg@mail.gmail.com>
 <550AF7F6.7080200@ti.com>
 <1426786080.13824.23.camel@symus-gk-mint>
 <20150319185129.GZ2869@sirena.org.uk>
 <550C1C2C.5080204@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e5GLnnZ8mDMEwH4V"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550C1C2C.5080204-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Greg Knight <g.knight-+7FPL3kuI1+B+jHODAdFcQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--e5GLnnZ8mDMEwH4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 03:10:04PM +0200, Peter Ujfalusi wrote:
> On 03/19/2015 08:51 PM, Mark Brown wrote:

> > You probably need both - there's often a hard limit where the FIFO size
> > in the hardware becomes a limit for DMA as well as a soft limit on top
> > of that for performance reasons.

> The FIFO is only going to be enabled when the DMA is used for transfer so we
> should have some lower limit for the PIO/DMA threshold. The FIFO in McSPI is a

Right, that's pretty much what I'm trying to say.

> tricky one anyways, since it has only one FIFO but several channels and the
> FIFO can be enabled for only one channel, if it is enabled for more channels
> it is not going to be used by either channel.

Not sure I follow this - how does this whole multiple channels thing
work for SPI exactly?

--e5GLnnZ8mDMEwH4V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDu5xAAoJECTWi3JdVIfQ9f8H/jXlMXHoNJeQb+FzdD8Mnqax
u0Uu/zMjKtwKFPzaDd0liGD0kfXdrrlKS8YdrEIrz8C1IAXgvAZckSoVbaW/F1rX
GovubBZnv+iHOU8AZWwcVnDPJ2TynJfHk2+MtDCjr3Ca6lFGKd5sW70mj0E/GtBF
Nujx2moD5ZNsHeE1Ys5K3D3FjTW55Ip2kxJoC9dRXrL6qATjkAUp8NIWb62g7Xi3
mYafUpAxZziSmbRmeNWWQKOnzi75btQv99koQQD0myUB6VmxUx1Kvado1xWysAxz
SQ7cxudTwSD7lf9MW3V2riG8mmuO8TW0tz28K5dOisfR9B9k3eXy/KBtBxpcJoQ=
=fcrt
-----END PGP SIGNATURE-----

--e5GLnnZ8mDMEwH4V--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
