From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] regulator: Introduce OMAP regulator to control
 PMIC over VC/VP
Date: Thu, 13 Jun 2013 15:47:26 +0100
Message-ID: <20130613144726.GY1403@sirena.org.uk>
References: <1369246717-4167-1-git-send-email-nm@ti.com>
 <1369246717-4167-2-git-send-email-nm@ti.com>
 <20130610103131.GR31367@sirena.org.uk>
 <CAGo_u6qTiPpd0DDe3jnPh_UxTwox22azhcMGy=fftL8H+DGeyw@mail.gmail.com>
 <20130610164905.GJ1403@sirena.org.uk>
 <CAGo_u6ov=yaCwt8apbvW57ErAvhgUBHHw9gwADBC1fJUrfucUQ@mail.gmail.com>
 <20130610180150.GQ1403@sirena.org.uk>
 <20130613133950.GA32174@kahuna>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0330614150909490850=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130613133950.GA32174@kahuna>
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
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--===============0330614150909490850==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5LZCLy8Sy7WgNZQM"
Content-Disposition: inline


--5LZCLy8Sy7WgNZQM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 13, 2013 at 08:39:50AM -0500, Nishanth Menon wrote:

> I am having a bit of a difficulty trying to understand your concern
> here.

Your device tree for this stuff appears to mostly consist of repeating
the description of the PMIC that we already have - this really doesn't
seem like a great result.

> Problem statement:

> OMAP has this weird custom h/w where one programs the voltage and that
> voltage is send over i2c - this is not same as Tegra's lookup table
> array which automatically sends out entries, in OMAP, software has to trigger
> the voltage transition

The basic idea that's important here is that you need to figure out how
to tell the hardware what to write - how those writes get triggered is a
separate problem.

> If your concern was describing PMIC parameters in dts, I can easily move
> them inside the omap_pmic driver and provide required compatible flags.
> If, on the other hand, the entire approach followed is flawed, I'd like to
> understand the rationale for the same.

That's the biggest problem I saw so far but to be honest I've not
drilled down too much into the specifics.  From my point of view the
main thing is how this fits into the frameworks and so on, having the
register information in the DT was an alarm flag that suggested the
overall approach was a concern.

--5LZCLy8Sy7WgNZQM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRudt7AAoJELSic+t+oim9cMgP/jISyaqjXOWlKr5a3glq/Z+n
ryTsbnEsFKBqKwK2NyKkcypjbkWp5hzHwhZM+QHqpLyeunfRbJu+8Y7Zg+E99EAf
jiIFhLJ8kZllQZJFlhHnvX54dS38p6/0O3vM4OcR4OsjmIHjPDYhgqFbmVTWogKP
Am/JZOtYXg6yMtzZRW+TwV30FmlO6rm8YZ5aejtC6kH45EobKWeXI3wcRSvYeJYU
lbSTid1x4gvNzHzTps6l/06lFl2RE3/w0abNCrF9YxvP99Mr7I5Q0X6ABFQHUj7G
0St4X9QCmM9ySy26tLVh4lDqBwem/6P1m67xrg50+TVzxRn97ejEFnwXPPXwhoKT
rHy/KfHYg+Cu/JPF2h+88yfSZoN722bP8e/2akGY/Kv4ZGAkUpbCX7Lj6bbMyu/R
bFQW1d0bCn9WqbevBgG4VrDqzrCOx0gALgXSQnPIY9E7b79s+yZsTuS9rf4VS06U
9ekPl8NXphKkF+vIiou60zifHB+5mfcMHxLgWGu6z4H0ssgTT2da5DL58NmP40gZ
TN2HxNeBMaTDMLIlEOLgRV/WUUnT6GMXeDTY1LkeARs79+gMoHjF/do+4DuG1tDy
hI33kNKyps0YK2hq/9Jfos3sX3kXYKMnGv5cbLUF0V+nTqQPdrcEEXEo5ie5sTYN
4JoRvvUwmeORCCAqVkk8
=L0BV
-----END PGP SIGNATURE-----

--5LZCLy8Sy7WgNZQM--

--===============0330614150909490850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0330614150909490850==--
