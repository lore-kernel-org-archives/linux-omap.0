From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: omap2-mcspi: Add FIFO buffer support
Date: Wed, 12 Jun 2013 16:47:55 +0100
Message-ID: <20130612154755.GJ1403@sirena.org.uk>
References: <1370970556-11713-1-git-send-email-illia.smyrnov@ti.com>
 <1370970556-11713-3-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6938546434052653239=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370970556-11713-3-git-send-email-illia.smyrnov-l0cyMroinI0@public.gmane.org>
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


--===============6938546434052653239==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K511Q2pAJ3dpTMb/"
Content-Disposition: inline


--K511Q2pAJ3dpTMb/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2013 at 08:09:15PM +0300, Illia Smyrnov wrote:
> The MCSPI controller has a built-in FIFO buffer to unload the DMA or interrupt
> handler and improve data throughput. This patch adds FIFO buffer support for SPI
> transfers in DMA mode.

> The FIFO could be enabled for SPI module by setting up the "ti,spi-fifo-enabled"
> configuration parameter in DT.
> If FIFO enabled, the largest possible FIFO buffer size will be calculated and
> setup for each SPI transfer. Even if the FIFO is enabled in DT, it won't be used
> for the SPI transfers when: calculated FIFO buffer size is less then 2 bytes or
> the FIFO buffer size isn't multiple of the SPI word length.

Why is the default to disable the FIFO?

--K511Q2pAJ3dpTMb/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuJgoAAoJELSic+t+oim9pRkP/2I71IggOYucK0rAHt0i0XUx
kDLv2kkdn7D8LJCWLTvMvIwaUDtL7/Xz6BTDnK88YUmmbeBMNxhRksFPg2Mto6+u
QK2qlQEwErIK7JPonWEq3Chr9iRaeCx1IHGFFE5RzYkI5RZtVrnHfQNtW8pfWj1Q
xGj77W+2Nvm+C5XWTWwXjQEdQ3cgAu7Xeumolsv9Kari8CqbFAxNI3ly42wN3rR7
8fjYpL4t2YtQBYveSy4DH9GppRyJf+ngAqv9Aqg6UoCgnEuxc0NEEJbuRwjqM6hM
DtLxDWrAcElZxxCW4XV93G0pMcX3P2NCcUoTH75FW4Z7hHFKS4Zg86i7L0/++tg+
YDLa1GKofUgWBcFUpHsz8/Pt0azdzkJpyPbuZuMSErxZaUHavXZ5wf13Uznqtiyg
9oiXM8tyAUELJTHOWaVnlvYSTuQ424gD9PCjYEQIDUlnMwwSbagxemCLYskNcsxy
zHv9SHWZn9B6itSNzFn9+21n/cjmFYWObUy4PoGlctvGOs5xWmkxE/KzB7UmbqQQ
RWb6MdRvbQkAuBiKgfd5vwXpTYdoaeIq1buP40vRLXEvTQxpSYrITBhIL359J9o2
6bxtxqAGDU6HURkL0pTIfSmYRUXHjhlUQIpslaVusqSJXXOAcKy1phJQr8r8DaQ6
C6xtBg4SLHzz3SOfdgBJ
=F1IR
-----END PGP SIGNATURE-----

--K511Q2pAJ3dpTMb/--

--===============6938546434052653239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6938546434052653239==--
