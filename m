From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 5/9] ARM/ASoC: omap-mcbsp: Remove
 CLKR/FSR mux configuration code
Date: Wed, 22 Aug 2012 20:15:06 +0100
Message-ID: <20120822191506.GL7995@opensource.wolfsonmicro.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3600701458604196044=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1345124468-8876-6-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org


--===============3600701458604196044==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7o0s4heyuo8kxM++"
Content-Disposition: inline


--7o0s4heyuo8kxM++
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 16, 2012 at 04:41:04PM +0300, Peter Ujfalusi wrote:
> Remove the feature to configure the CLKR/FSR mux on McBSP port with 6pin
> configuration.
> When moving to devicetree these callback can no longer be used in a clean
> way anymore.

Applied but this didn't quite apply cleanly, please check that it did so.

--7o0s4heyuo8kxM++
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNS+zAAoJEFJkBDiqVpZ4iqoP/iD+JdszLdkh7NGqoJPWeDXx
oBW+pfsxZDsPewLvzF+e06SdyqrFOSCuarIc/a/UAsiMfV5v/iweRKFZzZhmoN8j
YTyv8V6AClINcA1tsW4WshHkkBc/DPVWdVMW6UdZ5E7UZD+eSstffmvx09EOJx0D
S9v/lme9CrB3KeScWfE138f0NjK7zcufSF0qVTFbvHVAgi1W7ZpVQwlugMOSMaXj
m+3ZZamgQrJcyZrzg+nD583HtWaNv+5Xmi8vOEbXefdmgsMO44g9TbAej3QLzg4b
GWmAUA8IKKa3XV0Jxk6wt1vaDXA604j5cdEbXzRVvIgpEa4d1SJv5mxxBeiXhvV7
doinFBqQwcgcl+1Pv+IfowOWNabhOEqB93td3L+pUvFaSFrElXrLkUJjyFiyn8G3
b2uSvYSFYVhZBAYqXtI3/UNRZ16VLvI4BUkpjwDfw4EYiUMhe/Pp7DCVCQwSoJ6e
fRSbjELGnLcEZc3N/x+EX+crRUJberYWJu8ljybWGpudqAOO1gUNJcL8Lvd74Vlk
CI8i9j7E9xt7NtoBmGKKHDIoH3WlfBd/A44p9FkYJngypIk9MDfNAcZ9Ov900md5
PQWPxLwSBIXSKcz5CqqR5Fv5QEQ+5jxZM4zOzfx64LeDPBos6yVPnEXWtofbQ8m3
ljttjDEdVvm603g6b3wf
=Vj5V
-----END PGP SIGNATURE-----

--7o0s4heyuo8kxM++--

--===============3600701458604196044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3600701458604196044==--
