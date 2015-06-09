From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] ASoC: davinci-mcasp: Choose PCM driver based on
 configured DMA controller
Date: Tue, 9 Jun 2015 19:01:11 +0100
Message-ID: <20150609180111.GU14071@sirena.org.uk>
References: <e5dbf0a5fbb101792fd106461929c4b814dffc06.1433275670.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HFKwn2g6R1ux/FzN"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e5dbf0a5fbb101792fd106461929c4b814dffc06.1433275670.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, misael.lopez-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--HFKwn2g6R1ux/FzN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 11:09:34PM +0300, Jyri Sarha wrote:
> Find the configured DMA controller by asking for a DMA channel in the
> probe phase and releasing it right after. The controller device can be
> found via the dma_chan struct and the controller is recognized from
> the compatible property of its device node. The patch assumes EDMA if
> there is no device node.

Applied, thanks.

--HFKwn2g6R1ux/FzN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdynnAAoJECTWi3JdVIfQxugH/2lIDBFlmjb6GmcMns7HwqCC
J53opTwP2govMthznEGtQd/smw3VXdzdNnHv8VKH3jU9emVBQ33OSQ3wsUlscaYQ
MVSXMuxqDXlWt7xYgX+RS0CWu0+/t4/S4ON7AuNHmrzY5AAw33V5w0pRX8MF5CEl
2NmOq8ydR4tUBrlFC+pjl7xHAmn8QAxBBdZqB9So4V11BAbtkHwhQLMAaXhe05Ls
A7AJ3dslHd2EsQZsNR44zDCoKQHM2AW+LnadAXWkgIXWOt34dJCv31l+x9yhnk9l
txBs44l0eBvwt90fbC0SF5nDtCG04n/lprs6zPd/orTFjag0d2UTOhPpHuf9myw=
=vSwc
-----END PGP SIGNATURE-----

--HFKwn2g6R1ux/FzN--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
