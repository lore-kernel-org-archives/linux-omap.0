From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage
	Scaling)
Date: Fri, 27 Apr 2012 18:56:58 +0100
Message-ID: <20120427175657.GP18260@opensource.wolfsonmicro.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<20120426191159.GA9415@sirena.org.uk>
	<CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4879448653714740865=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: khilman@ti.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, j-pihet@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============4879448653714740865==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iq/fWD14IMVFWBCD"
Content-Disposition: inline


--iq/fWD14IMVFWBCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2012 at 11:09:10AM +0530, J, KEERTHY wrote:

> Devfreq and cpufreq are related to dynamic frequency/voltage switching between
> pre defined Operating Performance Points or the OPPs. Every OPP being
> a voltage/frequency pair. Smartreflex is a different
> power management technique.

But presumably these things should integrate somehow - for example,
should devfreq and cpufreq be providing inputs into what AVS is doing,
and if so how?

--iq/fWD14IMVFWBCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmt3jAAoJEBus8iNuMP3dwCIP/1i2rPocJbbB7yGsjpZmoc0F
b3lRK6RmOuad98MAeSv1AO7/J6QI3N7s7oVhJfkP69j3mxzXdQf2AE6DSgqbWJT4
wU1qRVsrC1WniNeDHU8ucXq6wIMalxUapfVhUJDChz4Ui04+si6xkKfWjkKHMSZa
zv+7TequN2Rk8EVmZtMdyonyBjXTNchjIJ7AREUfrXKHL1LTRn5zljr/QMb+bKiW
fN0ndG7iDizDTwDY67tXDdMN5WlIVl7FexGV/L44V32F4iENeBkOn3rfI2AzLSKX
XBpKidSO54q1s4HrrzdPBGAkV70K/BBNktQWAd85CFptQ3jP4TNTrr0FV56/URNK
waLW58bP3RfWYEQyBIsixdFVbgk6/M01FmwSUOdFf26dsQi0sDh29LrM67RkNKmt
p2O+oLuJRKAjUh5dJOtyqkXpjdSEKBcl/gmREQqdS1AGzhdaP6BZ0mN1XIuYGPi/
JsRHUbXAlFzYNc4F2dEYE5WIo1fj1q/9kWwhY8vLPvFZlCWyEr8NfgASdpY0gxbC
Hn9YjPv+fCQN6SUKaUfLiaGThTh7e5zysuvjHU+w+eGNZBNSgvZA7ofaf/TsX+Ba
ike7OfcLi/Noho5LBD2Dxsbtg/lNamL5n8pdDFu+OwCoqj64cspjz7mOFcJaaSFd
xPst2wKotL3rtuxYiVMl
=IFMA
-----END PGP SIGNATURE-----

--iq/fWD14IMVFWBCD--

--===============4879448653714740865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4879448653714740865==--
