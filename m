From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/2] pwm: pwm-tiehrpwm: Low power sleep support
Date: Mon, 14 Jan 2013 08:08:56 +0100
Message-ID: <20130114070855.GA21994@avionic-0098.adnet.avionic-design.de>
References: <1357823024-17585-1-git-send-email-avinashphilip@ti.com>
 <1357823024-17585-2-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49259 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3ANHJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jan 2013 02:09:07 -0500
Content-Disposition: inline
In-Reply-To: <1357823024-17585-2-git-send-email-avinashphilip@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Avinash <avinashphilip@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gururaja.hebbar@ti.com


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2013 at 06:33:43PM +0530, Philip Avinash wrote:
[...]
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
[...]
> +static int ehrpwm_pwm_suspend(struct device *dev)
> +{
> +	struct ehrpwm_pwm_chip *pc = dev_get_drvdata(dev);
> +
> +	ehrpwm_pwm_context_save(pc);
> +	pm_runtime_put_sync(dev);
> +	return 0;
> +}
> +
> +static int ehrpwm_pwm_resume(struct device *dev)
> +{
> +	struct ehrpwm_pwm_chip *pc = dev_get_drvdata(dev);
> +
> +	pm_runtime_get_sync(dev);
> +	ehrpwm_pwm_context_restore(pc);
> +	return 0;
> +}

According to Documentation/power/runtime_pm.txt, the PM core runs the
pm_runtime_get_noresume() and pm_runtime_put_sync() before executing the
.suspend() and .resume() callbacks. Are you sure you need to call them
here explicitly?

Thierry

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ868GAAoJEN0jrNd/PrOh1ecP/2BiUloIaHU05MVuLhyBeBKU
VumB5tqYR3hVG060XcVPeA0daFSDODNTf+Ld5kQrVYCdAdhEpmVFgYCXQt9OW7e6
P7msrz8dpJJeXQrO1H9ZnvYUvsrs8dcERTLvgtvUSzYchoaVeAueyoc6uS+GZxaF
iizOKqFqUb+fsKBBP+yxtjKP5+bhm5xMQvaGKbOwugY+NliBNB/B09wko/oCCEsb
SxhsLa5cS0jNbbi77YhdjrOaUlCn7ZEZ2iGltWzBO15TnxcmuPfQDjCEDH7FEpQ3
G10KkVF1I1juoOKu/C+jmmQALtp/WTXVSJWnmAWzBp+WuewUwApIWR1as1fFpEdA
hEHas22MAjMm16OYpq0Zzj8bXpXY6Fd7vT2CsKkk9qKnVfmSPjs+78uj0cnGfzBw
KXwQA3IgLZuipW0vydnXQ577qzfguv40xhoiGXXcGKX7fLGub7MVJ7HhxJzLmN/U
/aJBMwNbTOPebdiCts2e3IKpt9HN7jbK3S+yqF2ZM9WfD9Mc+0Ucz/hen0I3dFfS
SHPYcQKWLOTcB3Wi39Tg/bwKHaLcgZ9ixekQ3pd2h+FpD6/Wq+8z99ZtvYQdGhQj
3tklNktNhTLv0zIFvaliiR748JtvMYKF0OvQNRWGreXLxFab3HMGyWgqDNVBJewF
YTX7Wi+RnMNvvuBiGfIf
=ZNgT
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
