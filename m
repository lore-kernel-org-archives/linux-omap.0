Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512615;
	b=BYa/4NS2Q2WquxKg3glyvv5lNMW4rS1AHHoGEhVbpvwJN5cPvSDsBTUM+FxLfHqoUmKB
	 zPHKccZDt0uAvcBNF0i38uIYsWsWrO42YrkR59K9cT7GJNbniM4Yb3CeQNSgJqNr8HoFK
	 EB981Oj6l+ou3UsXWD5tdvP6c9Fv66/aIlN01ULSJVS//Bgb7SsU3V3VLnjomVNHH/wHU
	 L2NWPaAyEinc3Xl5gCwMZGo1oCbPuJhMEhsTrSWKk/PyUdp7ZFcpcsArw3z5aTraB/TgM
	 JtMHHfEzYeH2OJvwlivN/0Y6YHfaStK99dP0PSvrjNI9QlJynuXg9xXzxOG3jJ1xzfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512615;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mNgCIbmsH0oNU5mw8fmrTinxZczxUxL31e0miMo7kPU=;
	b=RlsUMPnNzT5Keo2cs3CqdWa86QqbLgZhWQJ5jhAmP5Mpb2oynp1gJIcDQz2nMWCF2mlX
	 fxXfUCxSLSbtMNTNe/V2/lNZoKnpxvPNc5Ii2xDLKhgP/nkD27TyA6WfECBgnzYNiXqsx
	 iKWkhQSNLDFFRTsXtk7ZH1kzBl8jMGGjv7nhT1iRuSO/pyl45TZnTn+h2xgHEEiz6DpYD
	 vKT9uD2SmEBD8kRXkbt3MxPMRnetXkK6g445XXPZLcj0oZC3MjkJ6+SaBC3avd6y+qFx3
	 y4rAzE0ayap7/wi9vRY6scs1eCIE+j/VDgfmXWaLIfAMMD7sWQc/TqDqR6IeYWk5hMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=q5aI78by;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A986606A326;
	Tue, 24 Nov 2026 09:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A986606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=q5aI78by
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=mNgCIbmsH0oNU5mw8fmrTinxZczxUxL31e0miMo7kPU=; t=1795512614; x=1796722214; 
	b=q5aI78by7+dKlRXpCMOK4AlyOizav1dkOB7nj97U/oJ2BhUEuNtUnKVdMdK65D9MlQJO654iffa
	oDjNBVrn+QTbmCdvpdPsl5MS90douVsB4yP6uxB4lddiPDndOfnkd/4uuioUvqgasAyCy/Gz3BcHt
	Ugxs5U8TVhqHDJoO9RehWm0/e2EcOLTem7sNwt9GbqNXmYuo7rZzb3fkS54VAKzpHoDurN9cUov/q
	qPnTaZ5+10Mx/lqJ0LFFztP26kuSstK2d/4oY56xE8AdowJJWu14hEkF/5OXY/naoGbwsDfU+NEvM
	16DU+KlfIo0NmvEw6lxBMCnnINEzcdlogA/w==;
Date: Tue, 24 Nov 2026 10:30:03 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar
 <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Alexander
 Sverdlin <alexander.sverdlin@siemens.com>, Jiawen Liu <1298662399@qq.com>,
 linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: do not unprepare the debounce clock twice
 on probe failure
Message-ID: <20261124103003.1900db6d@kemnade.info>
In-Reply-To: <20261124085231.3696739-1-congnt264@gmail.com>
References: <20261124085231.3696739-1-congnt264@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Nov 2026 15:52:31 +0700
Cong Nguyen <congnt264@gmail.com> wrote:

> The debounce clock is now obtained with devm_clk_get_prepared(), so
> devres unprepares it when probe fails or the device is unbound. The error
> path added for a failing pm_runtime_resume_and_get() still calls
> clk_unprepare() on the same clock by hand.
> 
> When pm_runtime_resume_and_get() fails and a debounce clock is present,
> the clock is unprepared twice. The second clk_unprepare() warns that the
> clock is already unprepared.
> 
> Drop the manual clk_unprepare().
> 
> This issue was found by auditing the driver with an LLM coding assistant.
> 
> Fixes: 9df982f1f283 ("gpio: omap: handle debounce clock preparation failure")
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gpio/gpio-omap.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 0da628ae77be..0af26c3f7197 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1463,8 +1463,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0) {
>  		pm_runtime_disable(dev);
> -		if (bank->dbck_flag)
> -			clk_unprepare(bank->dbck);
>  		return ret;
>  	}
>  

