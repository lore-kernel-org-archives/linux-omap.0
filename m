From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] regulator: core: allow consumers to request to
 closes step voltage
Date: Fri, 21 Jun 2013 15:30:18 +0100
Message-ID: <20130621143018.GT27646@sirena.org.uk>
References: <1371669474-24473-1-git-send-email-nm@ti.com>
 <20130619223828.GK1403@sirena.org.uk>
 <20130620124542.GA28320@kahuna>
 <20130621095157.GK27646@sirena.org.uk>
 <20130621124355.GA16513@kahuna>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FT/vNgDLxVq4t/AU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130621124355.GA16513@kahuna>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, viresh.kumar@linaro.org, cpufreq@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--FT/vNgDLxVq4t/AU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 21, 2013 at 07:43:55AM -0500, Nishanth Menon wrote:
> On 10:51-20130621, Mark Brown wrote:

> > No, the consumer really doesn't want to be aware of linear step
> > regulators.  Why would it care that there even are linear steps?  If
> > the consumer is doing this based on the properties of the regulator
> > rather than on the properties of the consumer this indicates that the
> > consumer has a problem  If the consumer is doing this based on the
> > properties of the regulator rather than on the properties of the
> > consumer this indicates that the consumer has a problem

> The specific case that I am trying to tackle is as follows:
> cpufreq-cpu0 uses definitions of voltages that are SoC specific. For a
> given frequency, the optimal voltage is X, max voltage(Y) is already
> expected to be in constraints for device functionality. We however want
> to find the closest voltage for a regulator in range X to Y best
> achievable by regulator. I think the area where I am getting confused is
> this: I am thinking the job belongs to the consumer/regulator core to
> find the best match. However, looking at implementations in existing
> regulators and based on your explanation, it seems to be the job of
> the regulator driver rather than the consumer/ regulator core to provide
> the best match.

Right, though the consumer does have to provide a voltage range to the
regulator to allow this to happen - if the consumer doesn't provide a
range then there's only one option available.  The consumer provides a
range and then the driver satistifes that as best it can (after it's
been filtered through the constraints).

--FT/vNgDLxVq4t/AU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRxGN3AAoJELSic+t+oim9ZQAP+wcN8g9WOJc6pMq3Sadxu08R
hZM51wOKYIM4KSx9Rn5yL5KrsRoBtYxWZeYiNuLzezVMOheDQ5wC1k0Caa6OoYyl
Xdwljq5iMr7bjhRGTnJgbwoeeUmcTTFkUXRw297GpRnkkl4/MAstRZo5Q8t1/lqv
mwQe6pvW75dwxbOWmiSOVrbhx0cdWa3jS3/a4LL/VNJVmqr3NFZwRxtrs6/ZevVz
FO2jql4/H5/LR1x0Dn3iZFSVHOCpYs8DDZdsbcBoS79DS/2+ME6QmlNKPcnsdSPQ
pGw3+MaVtXd69kyFZTDZU2BG7bHleqQrSXGxzgwlyR/Uw/nzo+2G0g+3xdimdlRS
Ek5yKv0e7tAvy31qdohBOTuPJILVavyAzAp2QuCEu4RanFXwLKix+T38ZTdKE1oU
L21Xw/EKL7FotdK8/DcUjognQqsrCWMgHtvhl7XFLYrPqhJ+DrhsfDHIOlVd3Owg
2G8CXGvClwUoQoRyIegAkUXCwL0M/korA/823XqNRfRPYVxhIO84vF2TtEEmNMFX
nvgRP4JLQ279trvQLMEMfTWMTgqZcEfhy8LO8Nyl6nqpJdMS79bDzbrnHoMQ1Uaz
N9A73vjmk4zJ9xjGENRXkmwj+amEj87azfVu4JcIPmfMlhQDzS/RHmyMlZO5UWP7
NtVCGUdHGZGvPoydJZTc
=K6xo
-----END PGP SIGNATURE-----

--FT/vNgDLxVq4t/AU--
