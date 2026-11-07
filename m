Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049567;
	b=M8iMatRNdu/8OUHV8QwClpEKi7J0NumuzbQA0sZZdQ2Vg5BJz2BRX+UnkZZQPG+bzfSW
	 sAPnZ8Lx7wJKMOWX1v1W9x1hO99h5w64rVspftUV/tfnKE+QI0oN9DQJm0urQH7lMLvhq
	 /7NDmOjI29lHb5GGqkPW9k4jPsvvF2f+R7b+cIqdYn7bD5RpFa5qT8HIV9+PstxOMNe94
	 Ry7X/T84ir+60je+AowkvAFkCiHZ4NQTBYqkLOv+/rx3AHH9pYqo06eVcklpsiDB/s0F9
	 1iiln6a1BH5P85CwkyDb7mnihpyoXivyuezOpN6W0HsOg0eNaBdNpeKMOYP2pLJ2Cog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049567;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UG+kev6sv6bJydTreZxT+p4tWO+j9O42mYRD9kAExIc=;
	b=HMCTkavtim9KFbHlMeso8ljqvDezGsgLJFwO85yaH8HABf47IdixngN4vDAHjEjotK59
	 SaE5pMZ09wJYqmFeqat9x37pLaH+axjoWc0/CRI/W6RkDV8NSTVp72UztsPQax84sLtTx
	 Sx95MgR9GZgXcmOdUQs+QO7IiZMy4V9Fmwu1pcP2t4CLbxFvcUfL0Tbdl3plJUrFIIfJe
	 BCxdSR80INBHRCt6yBCiGbYfX9UOBphs706BzgIbGpcB85Um04EMdC+/ZGGVPZd2v8jv0
	 W0QVUXRmJ1eQdNC6ebXvkb/F23GBQ9fNABoPW1oYi65VAlrFsAVezrXkzCNYCMDOqfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=D1W2Rqdb;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1C606A326;
	Sat,  7 Nov 2026 11:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A1C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=D1W2Rqdb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=UG+kev6sv6bJydTreZxT+p4tWO+j9O42mYRD9kAExIc=; t=1794049566; x=1795259166; 
	b=D1W2RqdbMVNNhuSPk4uyHtxv2dhfdaJrcaqbCSq4BY61geo11rVqEpAFMK6if9KjvKXReSGMYdd
	TkySxZySn47R+PlVIASG+YiYBZM6QjOTdwjj1Fc/Dzf3ugc88BcCkr1zJj4qhM0oEJyt33ZKqmnLo
	o7TL8+n6jSFtCXPHdNZK8GO97h0EdJbJKOwaI/2BV9q1LPMWQ90txQmHzW1XgVhNifAcljyMA9UzQ
	u6AHvt7gZT0t+IFtiAWwtLd+6hPzpskcEkkE1uQhh5m/9Hoj0zP/tKwMzf7tmDDkZkorBZayfZ7/6
	EFzVGz2eBg/DeAAeBEAC/zSW13OZSM0erq2g==;
Date: Sat, 7 Nov 2026 12:05:59 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Myeonghun Pak <mhun512@gmail.com>, Kai Svahn
 <kai.svahn@nokia.com>, syed khasim <x0khasim@ti.com>,
 linux-omap@vger.kernel.org, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: twl-core: Reset twl_priv using
 devm_add_action_or_reset()
Message-ID: <20261107120559.50c33c09@kemnade.info>
In-Reply-To: <20261105110332.1874728-1-lee@kernel.org>
References: <20261105110332.1874728-1-lee@kernel.org>
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

On Thu,  5 Nov 2026 11:03:23 +0000
Lee Jones <lee@kernel.org> wrote:

> Register a devres cleanup action immediately after allocating twl_priv
> with devm_kzalloc() so that twl_priv is automatically reset to NULL just
> before its underlying memory is released on probe failure or driver
> unbind.  This removes the need to manually clear twl_priv in both
> twl_remove() and the probe error unwind path.
> 
> Suggested-by: Andreas Kemnade <andreas@kemnade.info>
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/twl-core.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 21fc0acb827b..6077a87282f5 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -711,7 +711,6 @@ static void twl_remove(struct i2c_client *client)
>  		twl->client = NULL;
>  	}
>  	twl_priv->ready = false;
> -	twl_priv = NULL;
>  }
>  
>  
> @@ -728,6 +727,11 @@ static const struct mfd_cell twl6032_cells[] = {
>  	{ .name = "twl6032-clk" },
>  };
>  
> +static void twl_reset_priv(void *data)
> +{
> +	twl_priv = NULL;
> +}
> +
>  /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
>  static int
>  twl_probe(struct i2c_client *client)
> @@ -776,6 +780,10 @@ twl_probe(struct i2c_client *client)
>  		goto free;
>  	}
>  
> +	status = devm_add_action_or_reset(&client->dev, twl_reset_priv, NULL);
> +	if (status)
> +		goto free;
> +
>  	if ((id->driver_data) & TWL6030_CLASS) {
>  		twl_priv->twl_id = TWL6030_CLASS_ID;
>  		twl_priv->twl_map = &twl6030_map[0];
> @@ -906,10 +914,8 @@ twl_probe(struct i2c_client *client)
>  	if (status < 0)
>  		twl_remove(client);
>  free:
> -	if (status < 0) {
> +	if (status < 0)
>  		platform_device_unregister(pdev);
> -		twl_priv = NULL;
> -	}
>  
>  	return status;
>  }

