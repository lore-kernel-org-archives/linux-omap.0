From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4] spi: omap2-mcspi: Add FIFO buffer support
Date: Mon, 17 Jun 2013 17:17:52 +0100
Message-ID: <20130617161752.GI1403@sirena.org.uk>
References: <1371475866-9647-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0682759445681606976=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371475866-9647-1-git-send-email-illia.smyrnov-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============0682759445681606976==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNAYc2YbOB0rJD4X"
Content-Disposition: inline


--tNAYc2YbOB0rJD4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2013 at 04:31:06PM +0300, Illia Smyrnov wrote:
> The MCSPI controller has a built-in FIFO buffer to unload the DMA or interrupt
> handler and improve data throughput. This patch adds FIFO buffer support for SPI
> transfers in DMA mode.

Applied, thanks.

--tNAYc2YbOB0rJD4X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRvzatAAoJELSic+t+oim9b/MP/3IQ+uSE3C14YNAac/ZZbrk4
+y+Bw/CuDouuzQIBB1RgOzvY3Frv9Et4Mn+DdS5eXhPgDzGJRRujNA9OA/3gAJVx
ygKiUmlFo0i+sudW3Oa0hgTbu8vgV6LVvNUvrrHbNMW8Z+Jk0l+yasbfXHtlFvlz
hpL6spaIBAkCy4u0VYvcP8WPgJwl6nr9lulaHjFq6gvKFRpSM97+EzU2m6eoQnEr
zOp6tNvflGolmZn1aWOoIh17eTA0qBZaO+DONMBgZqTb2zYYEO+tZrf6VbpgDdZR
bdt6rCs39xN0iCNuf1t/eCgE0DzcpKI4FhzCSbQc8Nhms1VIS5C4ycWR9o5p4nj4
vAa+ERWpR7FqiLhVObFDur15LO1jw8GLdor/s3E5a11Uh172y+4feJsMuicvg/+x
1MejAu8Ow9WCeOUpTx91juDolqEExjtM+mPRL97gWp4cRpEBg9MBCaf3DTp9E+Lh
Mvkh3bRhksPEdeTlTSsjRht+KuHjRbu8rJxAycTR7pxUDmASQq0Thw5oQVq4+nfX
y3gUqY+A6pmEQVL90dkTgBuveHqFmq2zQ7SOp3Rk1A+aFO1jsC66JxA0id+sxABE
qmqC02wdq6WWwEYNG49qlEXv1p31SguN21yA1m3hCDQchU+56e481YO0pEudfVde
PsJ4XBAbvyI03mWIcjUj
=vHgD
-----END PGP SIGNATURE-----

--tNAYc2YbOB0rJD4X--

--===============0682759445681606976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0682759445681606976==--
