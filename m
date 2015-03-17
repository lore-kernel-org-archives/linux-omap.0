From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/35 linux-next] regulator: constify of_device_id array
Date: Tue, 17 Mar 2015 12:11:28 +0000
Message-ID: <20150317121128.GH28806@sirena.org.uk>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-3-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gqUrV6DUXoHnB0ku"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426533469-25458-3-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--gqUrV6DUXoHnB0ku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2015 at 08:17:08PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)

Applied, thanks.  Please remember to always include people in the cover
letter for patch serieses so they know what's going on with regard to
dependencies and so on.

--gqUrV6DUXoHnB0ku
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCBnvAAoJECTWi3JdVIfQY5MH/2XX3be4loeibyXav80nwHQF
dCPrX8qK46/wiLm6E6DOYHFiZ7Sd6eO/JecBqj4Fjq+k+F/RP/DO/CUoUGb6Gn+r
euZKgco08qIpVbNsBLdJJA/1raUnUB/ODIQhtVLecCtsCOca7AettG400OnJIX0i
0d2qMz/RMMMpRHhnCNTkM7xTF4X0UzXLoFEm1LBsQFPaui52JYeaa5u7Q3xHPjhk
vWaJ+dBSBiWsGZaKmmq2j5Mpsr25/spmPhoQ7PapjkGZLV1nyPm9pUshOvESjdbg
jwvTxgZJTfeuLc14FlC3NFf7gBVvtxRhykxCBZpaaclMJdLljBpNrEBeeBXrp5E=
=LqyN
-----END PGP SIGNATURE-----

--gqUrV6DUXoHnB0ku--
