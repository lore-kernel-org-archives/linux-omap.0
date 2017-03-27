From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing
 handle_reread
Date: Mon, 27 Mar 2017 18:49:52 +0100
Message-ID: <20170327174952.jsfleql654m2h45i@sirena.org.uk>
References: <20170322171052.7006-1-tony@atomide.com>
 <20170322171052.7006-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ua3n4cnu66ce4dek"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170322171052.7006-2-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--ua3n4cnu66ce4dek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2017 at 10:10:49AM -0700, Tony Lindgren wrote:
> At least Motorola CPCAP PMIC needs it's device interrupts re-read
> until there are no more interrupts. Otherwise the PMIC interrupt to
> the SoC will eventually stop toggling. This seems to be a bug in the
> CPCAP PMIC where it can stop driving the GPIO interrupt to the SoC
> with pending CPCAP interrupts.

> Let's allow handling issues like this by introducing a flag for
> handle_reread and by splitting regmap_irq_thread() into two separate
> functions for regmap_read_irq_status() and regmap_irq_handle_pending().

So, I see your use case but the fact is that as Charles observed this is
exactly the code used for emulating level triggered IRQs with edge
triggered interrupt controllers.  This means someone is doubtless going
to end up using it for precisely that.  This makes me uncomfortable, we
do have this open coded into various drivers already but this is more of
a core thing and it feels like this should be in genirq rather than
here...  that said, looking at the code:

> +	do {
> +		ret = regmap_read_irq_status(data);
> +		if (ret)
> +			goto out_runtime_put;
> +
> +		ret = regmap_irq_handle_pending(data);
> +		if (ret < 0)
> +			goto out_runtime_put;
> +
> +		if (!ret)
> +			break;
> +
> +		handled += ret;
> +	} while (chip->handle_reread);

There's no protection against screaming interrupts here, I'd really like
to see that.  Also some tracing of the number of times we spin.

--ua3n4cnu66ce4dek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljZUL8ACgkQJNaLcl1U
h9ACagf/QG57ADMyUm2y4peOi1CKUIx+9actz8t7jOMCD1VOh7+Du+cGvfuEi05m
l2Kq9XDcbnqZmgHl/4v3AxEMZV2o2XNek3uuWIj1B+QSdDJ5LW2kvwUyim1nLrcd
FUTIq6MANpFcGPVt+XxQNbTqR6boGEnnASWXbwd6D8sVtCvSp6lzT1c1knclFZWm
BWhqboieprnB+RfBp+A5eR7KUCVb/wCha5Pyf86wVXXDg+mLnpHPZQTeUhpems5R
L0s+ZsV8+OyqfcGjsYrRCX2Pq5/DWUEtyLz+DChtjwaf1zPDMh/uMWouCTYva1zA
JU6mw/p/QJZIJuekHz0wkO4NCw0GxA==
=mrql
-----END PGP SIGNATURE-----

--ua3n4cnu66ce4dek--
