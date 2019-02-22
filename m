From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] regulator: tps65218: Add support for LS2
Date: Fri, 22 Feb 2019 12:19:35 +0000
Message-ID: <20190222121935.GA9271@sirena.org.uk>
References: <20190220164851.GD9878@sirena.org.uk>
 <1550824734-26581-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550824734-26581-1-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc: J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 22, 2019 at 09:38:54AM +0100, Christian Hohnstaedt wrote:
> Re-use the "tps65218_pmic_*_current_limit()" functions of LS3
> and calculate the different required bit-shift by counting the
> trailing 0s in "struct regulator_desc.csel_mask"

Can you please also resend the DT bindings change?

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxv6NcACgkQJNaLcl1U
h9APRQf/ZsC38d/MqWb5znW9wtYJGyGhggsCmdUJk8xXgHQ4tuubEBjwVunMnP7g
S/mvtzwcaOHDzAwMM+xXZzjzIJi5pAR43pRKfl/F6Gv4GS+eQ2B80Igpbd9rZxcy
zF5mYgaG/mqWLljEURy8OFhmc64w+5nQJ6YYMP4br/yx5CueQs4gBTnBB5sViyCo
E2P2HeMv778M7P+9piczgG2CO4Ifb58wgH/qJTa212PFsjR9ZgC78Lwh2HIauM+0
XiWdN9XxUUpkpRUQC0sAxRO6KPtRDdXJ5xvg58SxmYArxKwtOZ6IPat7CdgIr+12
tCB0p0yRUhMtC8iQA0VWeFvnpepHDQ==
=b1HD
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
