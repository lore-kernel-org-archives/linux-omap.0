From: Mark Brown <broonie@kernel.org>
Subject: Re: next/master boot: 257 boots: 11 failed, 229 passed with 16
 offline, 1 conflict (next-20190604)
Date: Tue, 4 Jun 2019 17:00:18 +0100
Message-ID: <20190604160018.GI2456@sirena.org.uk>
References: <5cf685d0.1c69fb81.e3d89.43ae@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6948661190777777510=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5cf685d0.1c69fb81.e3d89.43ae@mx.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============6948661190777777510==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="boT9Oj39GmgPxYhu"
Content-Disposition: inline


--boT9Oj39GmgPxYhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2019 at 07:53:04AM -0700, kernelci.org bot wrote:

Today's -next fails to boot omap2plus_defconfig on Beagle XM:

>     omap2plus_defconfig:
>         gcc-8:
>           omap3-beagle-xm:
>               lab-baylibre: failing since 1 day (last pass: next-20190531 - first fail: next-20190603)

The boot fails silently with no output after the bootloader:

    https://kernelci.org/boot/id/5cf655fc59b5149acad51504/

which isn't much to go on, it does seem to have been OK in
multi_v7_defconfig though.

--boT9Oj39GmgPxYhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz2lZEACgkQJNaLcl1U
h9BmWQf6AoY5VMMkCTmC1WC0Xuomm1kiC7szNoyymcavNs7I8BPlfTssjnJMZTQP
JOCRjldsXBmPY8PF4YTpuBK6ANNTWE1n0WgbNgZEuOPWt2nCOT1QRvfHagOE31Eb
OAvG19faDLlh3ivrj32ACTXd/bbBudESyYXsKBC/P2JJ7KyYmSf99cPw1bqeDm49
7FAHWdODlE86i3VxYGjFseO2WLatjOf55opyVmUhsL65dX8vyssf1kWmq4iDGCgs
p4a6btnaVbHdYUBmSMuhlevIHRJAubRAaxG70XP+cnNsvTO1hUM5ITNVHemNUIPB
gAs7N1rUmpjROjkN+QGwRNN1wECBSg==
=3tvl
-----END PGP SIGNATURE-----

--boT9Oj39GmgPxYhu--


--===============6948661190777777510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6948661190777777510==--
