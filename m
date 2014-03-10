From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: tlv320aic31xx: Add basic codec driver
 implementation
Date: Mon, 10 Mar 2014 15:47:44 +0000
Message-ID: <20140310154744.GJ28112@sirena.org.uk>
References: <cover.1394440470.git.jsarha@ti.com>
 <dc68ce35a3f44b5c8a55be928e06f72f463338fa.1394440470.git.jsarha@ti.com>
 <20140310125848.GI28112@sirena.org.uk>
 <531DBD55.6030008@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YKGyq5YQxDjF8U6+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37828 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbaCJPrv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 11:47:51 -0400
Content-Disposition: inline
In-Reply-To: <531DBD55.6030008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com


--YKGyq5YQxDjF8U6+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 03:25:41PM +0200, Jyri Sarha wrote:
> On 03/10/2014 02:58 PM, Mark Brown wrote:
> >On Mon, Mar 10, 2014 at 10:52:21AM +0200, Jyri Sarha wrote:

> >>>+- ai31xx-micbias-vg - MicBias Voltage setting
> >>>+        0 or MICBIAS_OFF - MICBIAS output it not powered

> >So, on every other version of this patch set I've suggested removing
> >this as there's no reason why the bias would be wired up but disabled.
> >Each time you seem to agree that the option should be removed yet here
> >it is again...

> I agreed on not to have it as the default. I can still imagine
> couple of reason to have this option around. For instance, if the
> board designer decides to pull the bias voltage from outside of the
> chip completely, or like in my test setup when I feed the mic input
> from a headset output of another device, because I do not have a
> microphone around ATM.

To repeat what I said first time around in those cases the pin wouldn't
be connected at all so why would it ever be enabled?  You're not
specifying that it's going to be always enabled at a given voltage.

--YKGyq5YQxDjF8U6+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHd6cAAoJELSic+t+oim9trQP/3U2wxnnI8EB/Ivyu57yxfbH
KzqT0hcQfFKpGcYkrh/LFcAqCdV4DR3zDwrVcpJ+5Q9g1l5E7rmHL/cVSTpOFzb2
Xw5AMjOpDsZo+R52JMVDhaBI+Di9f/J334VWOLIUcV+9fm6s5jX2HhX/RPrxxznd
z2X509a7rPs/CuiaH2+sAWHc4DVIPwB24EkkTjH8Ayfqogx8l3PLMhwDE4eCbMcL
NxhseMHC3lIs9SgduxW1ynU49PCpEe2Ul4LX609AOwnfT0UwfbxriPx6HvwUpwla
EYYtRn6HDHuIRPJiGZoM5HGJ88tOADLSgGPmrUUiBP0HtxAKf/pCFkRtLnjYcYqp
cWYOjM6xll8pO0GFb70sSsZ2noef0L1y2idFM+ZCEk0v7OI/MUNB3iSp/EVMxUk8
qBp5mBv+2FiGUrM89n9oVw915NKeiY9AH3vU5ZDIiiCGgw0YMiTnUY1EXoY0mv4p
GBQ+M99i4vcikxBbOeBncrDQdDv8IY0NeC1NGV3+IsCKXVDyG2GXQ/AoqmGhaXb/
vld2yX8XbddMlEMGwNL4OQIxGNBTq/vTIHhX4rCF4E194vHcXfwX3OG4euJkwyaH
wcHoaS07x1ROWuVj5BNNzJ68hH46T88Agt3z1NpvN0n2o55YMm0tCxQ91ebQ4lFD
u4+eLwlPp3uBHQoxuF6A
=NU/C
-----END PGP SIGNATURE-----

--YKGyq5YQxDjF8U6+--
