Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19374171BB;
	Sun,  6 Sep 2026 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788679997; cv=none; b=KTXIjRVZFN/XOEqJNMTK1BeQCzPBUb53MgIbKy2JzNu+P46QklPu0Rsswr3PjAMKMLK4E8rUkjSTcVrPJPsr0riU/pPnTSbVsPen+tJ3nb3IWu47qL02AQmdDGif6NeI9WfZU1ZZXRm4h9tg32ExA4L8QCFoTsN3z6r1LlLzBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788679997; c=relaxed/simple;
	bh=XKVVobAe0uixj3aaF5J47JXf1IU9hX+dFu3smmla0hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zg9c2AVhOtb00m2gZR7I6YDNQarMeSqIo46i4EPGNr3wrqfokaYi9LIJGLrn7GhAsfHrDyfFM1iIqAx3CIyuSfLGVVNAcpifre8eMxWpZo1dDk83uPZYI1NRcZnls6m/8UXwlQzcX/+arLhdKuQIQFAV2xnpKk7iWSImX+O2kr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=K0b7Fyp9; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="K0b7Fyp9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=HXwwW5MflXtebrops4jKjGoABUQ/YtxAfVoVUCVVlbY=; t=1788679996; x=1789889596; 
	b=K0b7Fyp9NYvefi8usAM12edxCDt0RXt+N/ERD/wps60VdwPEqrl75N0NsUlG9IDK5CfpJu+39nz
	Mn210ba2lhAPXyypfnCk1YXu8WkYETuMR8uxvebkKuSK6fZRu2S28ZBTlv6c5oOm9ru5AISshBHL9
	eWFgau9+9ZWTtvin42V2LmtsftXWV2Mldo/uW4DvAfY2CsvYswGAqSvk0BFDZUK7ZAVqniLh7SSYb
	AVbE6XO6H4v86hPtKElcxKVyDgo9MnewoeHqxtKkDtq2s7xtsX5z43SkdPzoCeA/aHcZHEnwCNHJR
	UzVgx8EiHv2qzmJGkxGARJj/xrKDWpPT1asw==;
Date: Sun, 6 Sep 2026 09:33:01 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Andrew Davis <afd@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, Kevin
 Hilman <khilman@baylibre.com>, "Roger Quadros" <rogerq@kernel.org>, Andi
 Shyti <andi.shyti@kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] i2c: omap: Drop bit shift for I2C register
 addresses
Message-ID: <20260906093301.01fa544e@kemnade.info>
In-Reply-To: <20260904131252.2126353-2-afd@ti.com>
References: <20260904131252.2126353-1-afd@ti.com>
	<20260904131252.2126353-2-afd@ti.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Sep 2026 08:12:45 -0500
Andrew Davis <afd@ti.com> wrote:

> No remaining board device uses a shift other than 2, and no DT supported
> platform ever did. We can drop this flag and use the pre-shifted register
> addresses. This simplifies the register access.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/mach-omap1/i2c.c              |  4 ---
>  drivers/i2c/busses/i2c-omap.c          | 50 +++++++++++---------------
>  include/linux/platform_data/i2c-omap.h |  5 ---
>  3 files changed, 21 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
> index 94d3e7883e027..bc7828a858941 100644
> --- a/arch/arm/mach-omap1/i2c.c
> +++ b/arch/arm/mach-omap1/i2c.c
> @@ -61,10 +61,6 @@ int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *pdata,
>  		       OMAP_I2C_FLAG_16BIT_DATA_REG |
>  		       OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK;
>  
> -	/* how the cpu bus is wired up differs for 7xx only */
> -
This could perhaps go into the commit message, but besides of that
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

