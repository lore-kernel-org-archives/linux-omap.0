From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] Query on Audio DMA using DMAEngine
Date: Wed, 3 Jul 2013 19:12:26 +0100
Message-ID: <20130703181226.GY27646@sirena.org.uk>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
	<51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
	<51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
	<20130702121345.GL27646@sirena.org.uk>
	<51D3EA42.3040205@metafoo.de>
	<20130703094307.GE27646@sirena.org.uk> <51D46598.6070005@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0564249526=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51D46598.6070005-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Cc: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============0564249526==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N+tBtqvhbbu3guFw"
Content-Disposition: inline

--N+tBtqvhbbu3guFw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2013 at 12:55:36PM -0500, Joel Fernandes wrote:

> When would it not be possible to cope with a large period size? Are there any
> guidelines on what to consider when fixing a period size?

This is an application issue not a driver issue.  An application that
wants low latency may need high resolution information about what
exactly the hardware is doing.

--N+tBtqvhbbu3guFw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1GmHAAoJELSic+t+oim9M08P/jNHuw186utt4oqEtIt0HVXE
BWw7fIj07ZjXu9kR0NH8IguMJU+UEl64DGbX3XhJoJ4QHcCbeigIKLt+eYWgudDD
LHviwfou4PgHkDjeTERZZi5qdzJnMt9u5bpEcsVEXKQ3kwdIcTCQKd1CSEJs1qfM
fmFxQEViFHHAzGEeKLvRiCzrjuIf9zUmQDfwZ4faGj8OhCbANBZ/d6wQ1on7KPs/
Iexap0IwakgiSNJe6ayXsx6+4T7TOZUX+2dtAjbVBVxUZBAghRtqvOaKA2TVM/Ie
pWLkKZgQYZozaszz8A7n+so1EwOp6VWe1QWitpqdyz+gEH5Z7OHZ+pth/4RmEfHS
seG3TW7lOdNX8VIOGG0WeStxxDo4RfYLhDXedqUAtLEa1xqzUTyuN/v+7VSo9nQI
AbNOqOaQK4E5iGRhmrak9f04SSeaKZF2SzRoKizWfv99Ds2y3B1/lRgKkK3dNqd8
d2as9DEx7Bem2A7ftUyHybfwsqO2ekt4IJj6Q+biTzP8ZuXMSh71fnrjHXKz5zP3
vXUa5jJF4575SefWUiCNBTehEnoT5muYGTW3oc9qiNk3o8kXSlpMDX2pkvCzz9R0
6KiaoGWFDzFxDgBPzbjSUuL6qHVSF30hWUTR7w3cKbEsKt/V/6TlqR0CKqKnQKYL
i0L6awH+laMjYjavENd/
=PVbY
-----END PGP SIGNATURE-----

--N+tBtqvhbbu3guFw--

--===============0564249526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0564249526==--
