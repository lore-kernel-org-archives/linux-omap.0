Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF33DB992;
	Mon, 18 May 2026 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779083231; cv=none; b=izm+GNseGcAfAqbVbm4iMzAYVW/0pwPEvfe4VQ9T6D+rc0z3EQ4l0L9bSUUJ+RgRndrqqiKPXo6jijEYxxdh71r4vM+qgTrv4E2ldKFi6shn1DRveYKbXoYUN1uw1sAGEa9h5R97lC8L1hSjxwv16zmImf5nLVKw/GHUa87aH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779083231; c=relaxed/simple;
	bh=tBRKNUgCMhgrc8M5bkaBGtZ1/1XjM22LZu01tzk/6Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0lPLnoFe/fM3j5SRXC740udhIkL9wPBEjsteSqMSSrL8ZtvKDlqRNODYcdYKot87XVK9XjtZSKJ4Jcy6NzT+Oikmagw7u11mxZflSfD1TpL8sqqRkQCxb2n3IF/TIC1qr5oDcnCZtd6xYOWW29c8nnnVG5dNYYRU3qj/Wn0lpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=QOLkXL3A; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="QOLkXL3A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dqdUAIArrCAeRnc/yrJEEcne9qs2t36nyTigupMFe/Y=; b=QOLkXL3AxljXlXBNy3aDmsDtTz
	Do4IwGBYSStzwUtC49eveYIvEWUSyz2UpzCrk+LQ802FMnHeqmkpJ8XWTqzosadGfQFEUzlvLP06j
	v3hSSyox4meh1fPFUpQKBNEmpdvbYqH3bqeIZ/bVZmfyYSGLtCgxp16bl8uqS9WkVsRRyyrkv4VzO
	z3nXZcFc3mUzej4hjCYQvQ0xy59junCJeC5wQEaIqqOlTHb9+4ki/Ls6E9IOh5vDa6laqucrI/9WJ
	ejeS+gT4hd7DZ2CH+u+fgZqygX2aQIshx6EB9UOawBYxedSvitRJIJTpfL6tGSRlyTqh0Xmz4nmOO
	PeFA7Zag==;
Date: Mon, 18 May 2026 07:46:31 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin
 Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] mfd: twl6030-irq: Use of_device_get_match_data()
Message-ID: <20260518074631.532e25dd@kemnade.info>
In-Reply-To: <20260518041558.765958-1-rosenp@gmail.com>
References: <20260518041558.765958-1-rosenp@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 21:15:58 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Use of_device_get_match_data() to fetch the IRQ mapping table directly instead of open-coding an of_match_device() lookup.
> 
> This also lets the driver drop the of_device.h include.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/mfd/twl6030-irq.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> index 0ca00f618d4d..8831c81a1f90 100644
> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -27,7 +27,6 @@
>  #include <linux/suspend.h>
>  #include <linux/of.h>
>  #include <linux/irqdomain.h>
> -#include <linux/of_device.h>
>  
>  #include "twl-core.h"
>  
> @@ -293,10 +292,10 @@ int twl6030_init_irq(struct device *dev, int irq_num)
>  	int			nr_irqs;
>  	int			status;
>  	u8			mask[3];
> -	const struct of_device_id *of_id;
> +	const int *irq_mapping_tbl;
>  
> -	of_id = of_match_device(twl6030_of_match, dev);

twl6030_of_match is used only here.

> -	if (!of_id || !of_id->data) {
> +	irq_mapping_tbl = of_device_get_match_data(dev);

so how should of_device_get_match_data() know about it?

Regards,
Andreas
