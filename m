Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B043F4DA;
	Thu, 20 Aug 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228757; cv=none; b=jZM8jFCniLJlwL/YGlWDkZ9s4+sfqIXOhJbtuty8AoLsyhs+Oh+V/Hmm/4y7BaZyoV64vOqM8SoRfIraWO5DgAzYmdGRZ2Xrexsy+cNxBmcxIxRew/L1htIIl0p/ORAN/u0Lel9BlESUaXKp7hF6ecU2vHY3YRLsvDVg8LQWfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228757; c=relaxed/simple;
	bh=uTNLyswJdwJULKL+jsklTzg/ST0iMnNONutfEMVGGH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cp7KVnw77X2SvQl0jAqTaJL0h50uVz4D0uLXSAySLVhHdsOge0revEKeqSTeab3esDxdDeC89XswycB6TQTUr+Lyk1Dx3uFUsa39v3Gx8/45LIiopCVpEibfaienxwh2DkIk4zRf9z5GNa0BaNsKWSMkCVCgOSF4mDqB8hQ5Vvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=0LQiG2/z; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="0LQiG2/z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=sH2Hz7vQyOp3tVLowWA2S7WAT1Eob61l1V2mpIugraY=; t=1787228755; x=1788438355; 
	b=0LQiG2/zaEWnPkPBwmbDuHOQZcpj2+/SUA6QaOtwmtLfO1AaB95tPjXyNFbFyuYm3Z4aGMmEh0R
	LYlsW7LklG93SU/yoWwsnDWFPkjxkQ5iSCuv1DIphZyphM08y73JPsghB71EUDLjTcp8RcO76+ar5
	exzs7QI7sh1WRx78+NYNIGk6L5/3fIlATWx+wlWDCRUtAl8UyDU2R7GvglVQ0Q1bdKnbnPSJmqyyC
	T1T/XgkM9Qnsz4GyljfeENtXzhEWBKSooVQJdC8ilHl+yn2L/+xvQkN2tXkJV4xQ5c22tFbF2sVJM
	26j5rRcMBbP2kS6O+MlXdsTC5T4Nx0C/W79g==;
Date: Thu, 20 Aug 2026 14:25:47 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Jiawen Liu <1298662399@qq.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar
 <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: handle clk_prepare failure in probe
Message-ID: <20260820142547.63b85ca3@kemnade.info>
In-Reply-To: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 17:08:54 +0400
Jiawen Liu <1298662399@qq.com> wrote:

> omap_gpio_probe() ignores the return value of clk_prepare(bank->dbck).
> If clk_prepare fails, the clock is not prepared, but bank->dbck_flag
> remains true. Later, omap_gpio_remove() or the probe error path calls
> clk_unprepare(bank->dbck) unconditionally when dbck_flag is true,
> leading to an unbalanced clock operation.
> 
> Check the return value of clk_prepare in omap_gpio_probe. On failure,
> clear dbck_flag and return the error, preventing unbalanced
> clk_unprepare in remove or error paths.
> 
> Signed-off-by: jiawen <1298662399@qq.com>
> ---
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1462,7 +1462,12 @@
>  				"Could not get gpio dbck. Disable debounce\n");
>  			bank->dbck_flag = false;
>  		} else {
> -			clk_prepare(bank->dbck);
> +			ret = clk_prepare(bank->dbck);
> +			if (ret) {
> +				dev_err(dev, "Could not prepare gpio dbck\n");
> +				bank->dbck_flag = false;
> +				return ret;
> +			}
>
What about simply using devm_clk_get_prepared() here? That would simplify
things a lot, given that AFAIK,  prepare is a no-op here anyways.

Regards,
Andreas
