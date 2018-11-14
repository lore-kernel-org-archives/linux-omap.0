From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
Date: Tue, 13 Nov 2018 16:33:45 -0800
Message-ID: <20181114003345.GV2089@sirena.org.uk>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <1c2c1031-a6b4-cbce-ceed-c2ce229c204e@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kM/PxlMMHsUUNZZW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1c2c1031-a6b4-cbce-ceed-c2ce229c204e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Grant Likely <grant.likely@linaro.org>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-omap@vger.kernel.org


--kM/PxlMMHsUUNZZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2018 at 06:11:26PM +0200, Peter Ujfalusi wrote:

> if we revert the commit then the original issue will re-surfaces. afaik
> it was not only audio which hit the 'last driver to be probed from the
> deferred list would never probe, unless we provoke the kernel to load
> additional module, or remove/reload the module' issue.

Right, aren't we just going to be swapping one bug for another?

> Do I understand correctly that in your case you have two modules
> (dwc3-pci and extcon-intel-mrfld) in a deferred probe loop, iow both of
> the drivers returns -EPROBE_DEFER and they just spin?

> If both is deferring, how this supposed to work?

I'm struggling to follow the original explanation too :(

--kM/PxlMMHsUUNZZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrbWMACgkQJNaLcl1U
h9BMfwf/SGcoei9hwsRaGXL/3Tv+0Qikp9WNRT/2sUol+X6k9NHZwWTd59ts+w5+
OOV7Cij0cIKBCKSr6X/AGsVL2Oa2MEU8CCdwAKSXVAcNaTXqIWraTFaXRR0YtuY4
7Uu9Na60NPsDZY/tVmxK8XnAV6wj7IWhgnDGbe05wYnxPLC2oFt2wAGDw7ZMW1RE
Bzv2NnVs11ZIPphUNa4Eu7mwmYaj9dRAHQN3FEjwMXNXnOKJS3UbRS3PKOJmfzgl
Nf5PWsBcGLgd99i+s5AZFiZHopRsO75Pld3Vu0T+U252zyXFR1eI4jicojuYrZjF
DERVmON8tTuNbxNwGpdv71b2jhzOpg==
=nxIU
-----END PGP SIGNATURE-----

--kM/PxlMMHsUUNZZW--
