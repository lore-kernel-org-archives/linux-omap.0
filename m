Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D33914E1;
	Fri, 27 Mar 2026 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616159; cv=none; b=ko4nxImUZhZtHY6hQ4smK+OtPTCPaK1Z7v+Sr26aphe/bYlYOkyDG8S71ZCqgwJ4H4Q397qibfyzXuUPktNuNqcFHHDPRasCnJd81zyhhLVSGkgAwtOaAIiLt0ucBOXJyakx1LGmyTMX+NcQSmLFC8rjy3EvHhT5KxAf0hibTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616159; c=relaxed/simple;
	bh=wI265DU1zQyJuVh/cOxpbjdnIdFBQbqGC5Af6QBodKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mb8Xg+N4QzsUaFem+v+xBVUJQ8xkc5LJnEtm+axmv4R/Xfsm25hOI3Y+Q5HCkWajm/bCYsYG669vbr6JJ6g8rjTp5PzEdp2z6Yt4Z6bo5TVlWxHn2m6vDdUl3G32GdvrCyYSiIA7eqyXnZda/hmVG1iBDDnT09rgmVuLxczFHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=UuDXQ6UH; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="UuDXQ6UH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cMp2C5O1khQmjkF3fvxbwjVEMOLIqREAg3Lz7C/AiC4=; b=UuDXQ6UHwHs1C5K+O8cL9Pj1Hg
	8VI42USN8Rp99l9uoEaA+8QNuDUc5lhms5SN9XQov7MmCdkWxUNHU7hah6Qadsb6e833D1RS1Gv1C
	Hdw8F8T8jjgN8bn79+Ddn0SVoIZfZEc/ZocCGG9zRkizaopxFLr5Sf4N1Ep3kgT1H3aZlMrIf0Og0
	8Ep1V1k45Uj8sO3AGz93W84cOzhIplQvtH1AB1mka5tkBxv8wB3CaqEFp9HqWSeFIwumrRACR9XNy
	T3BBhj9TBoCc+x7fFR4c5CByBsZdJqjIvzK2ixTSEg8jYPpCY/myZQD4DILQnGj4AaFvKQUVCiXsg
	laoYkizw==;
Date: Fri, 27 Mar 2026 13:36:12 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones
 <lee@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] regulator: pbias: Add pbias SIM regulator for OMAP4
Message-ID: <20260327133612.6ee909fd@kemnade.info>
In-Reply-To: <20260323-omap4-fix-usb-support-v1-1-b668132124ac@bootlin.com>
References: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
	<20260323-omap4-fix-usb-support-v1-1-b668132124ac@bootlin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 16:02:42 +0100
Thomas Richard <thomas.richard@bootlin.com> wrote:

> Add support for the pbias SIM regulator found on OMAP4 (for USB I/O cell).
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/regulator/pbias-regulator.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
> index cd5a0d7e44555f04d1e44470036c6e3d9feb7be6..10c4940e73635293bebd26bf99a9067eb6e39107 100644
> --- a/drivers/regulator/pbias-regulator.c
> +++ b/drivers/regulator/pbias-regulator.c
> @@ -81,6 +81,16 @@ static const struct pbias_reg_info pbias_sim_omap3 = {
>  	.name = "pbias_sim_omap3"
>  };
>  
> +static const struct pbias_reg_info pbias_sim_omap4 = {
> +	.enable = BIT(28) |  BIT(20),
> +	.enable_mask = BIT(31) | BIT(28) | BIT(20),
> +	.vmode = BIT(31),

BIT(27)? or am I mixing something up?

Regards,
Andreas
