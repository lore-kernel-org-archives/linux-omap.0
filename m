Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138845;
	b=hnVHVO+ncpH1tJeLe7Vr4uuumQ0ndxWRIPBNE6gu63JF9Y+ktFIiB2N6l4KkEtV61yF2
	 YpWJHpWbipI/G68pd1SWUFbkbaB6sqJ2NQknuaqDdh1SX+HLpvsAumSG+k52hyxluPrU1
	 jWUpwthFR1FraSrujZqEL8+v3yoSrhBSEc1Y/pokRt7qk5+YJSDOf5OP8EndQKkdTeNU5
	 w7G1bPa70oR/WbbFGdklJnrCOXpmdBGIHTLt05p4Yz/v+P/l1Vmm9LyhbUpIHy2kWpXf2
	 eIaX66po8ywIjyYGROsiER5KoiaClJ3LFFcQCwTiKM03SnryBR3++vuxdUkKvmaAqJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138845;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=arPn7WtxfLxdl/Ql8VXSpyR7twcFlAaLYoR9XNbcjQM=;
	b=R6RgqjAYwf/R4eqw2O/2oBfHc2JT9co5dh7GMOGzTdy/JhndIeOKZA7QTmu4M2+TmEgq
	 3CgAtxRHhq/78s3n9AKSVttKIOmICMpMKMHWefq7DkjvQk9UisqS51UoKuGL731zEcoER
	 0a/6MlngczvmF1vxoT/4KYflOdSigb+TggL+Fqrl8GI2+ZGU17g20eSxfU6z+uwSbGzBy
	 GHQf4ygamAZSJc2feHDBnlMooit4L1GRsZSEXIEF3XVcpLyH5vu5qUtuTUBxC4pwaiQq4
	 OuwAF+b4mam9tX4o3CNAazeTqXOcTm90vaSwTTCCsAwacv4mUTXwMuEu49YW0RHVuWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVbG+S8r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589A606A325;
	Fri, 20 Nov 2026 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVbG+S8r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441261F000C6;
	Fri, 20 Nov 2026 01:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138844;
	bh=arPn7WtxfLxdl/Ql8VXSpyR7twcFlAaLYoR9XNbcjQM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=YVbG+S8rzbkIJ+L3qzj8M1Nv3YTRq8wfpnXXRit2wivQK7cZmk51c4i4YUy46lqgA
	 nz8NoVJv37mMZoZssUFZqsD4AahF68TDEgFhQFi4ZPXP/lGqXa0lmnePowvvENNmDA
	 yYAWkAIlIYS7MqAWQqlf4yTqSkybmyyKwygPjSVPSa4ihgIFlTIzTUMTar9VFF3ZMd
	 nyZsTG+bJT7oazO3jwFTBLlbrsLGpnf7Oh68XMv3UKuWjfiEV171dLDPmLiyV/6Ekv
	 RDKIdt3vHNJSVW+1yXz+i3tQRje/IRlYiKYFugiUe1JlVrrKdY6GKweW5NQA7AzkFV
	 SopICCUUdFmzA==
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] clk: Remove unused clk.dev
From: Brian Masney <masneyb@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>, 
 linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, Brian Masney <masneyb@kernel.org>
In-Reply-To: <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
Date: Thu, 19 Nov 2026 20:40:22 -0500
Message-Id: <179513882271.284394.17357508909448455391.b4-review@b4>
X-Mailer: b4 0.17-dev-8145e
X-Developer-Signature: v=1; a=openpgp-sha256; l=3498; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=z1U18tUBXV2KWpqoDsfdQQ2VwXPEc5TWEUSZc5tPF08=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL+L+UOKLbN0At7HldxNMuj6q7jI+/5bMeYzSawW5bon
 y5cfXxBRykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABOJuMjIcFG5+MsMfhUXoXfW
 GZeY7l+0Od/4dLF1k2iEg/nK408C8hgZ7s94f/tdwmWfdwsdNnoE3H22+r6q9/npQWUmnTvmXZG
 7zwcA
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

> This basically reverts commit efa850487a6b6742 ("clk: Inform the core
> about consumer devices").
> 
> This commit added a struct device pointer member to struct clk and a
> parameter to clk_hw_create_clk(), but the new member was never used
> beyond setting.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/clk/clk.c    | 14 +++++---------
>  drivers/clk/clk.h    | 11 ++++-------
>  drivers/clk/clkdev.c | 14 ++++----------
>  3 files changed, 13 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 673eac47450b..858f4d60ed2d 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -160,7 +160,6 @@ struct clk_core {
>  
>  struct clk {
>  	struct clk_core	*core;
> -	struct device *dev;
>  	const char *dev_id;
>  	const char *con_id;
>  	unsigned long min_rate;
> @@ -4249,7 +4248,6 @@ static void free_clk(struct clk *clk)
>  /**
>   * clk_hw_create_clk: Allocate and link a clk consumer to a clk_core given
>   * a clk_hw
> - * @dev: clk consumer device
>   * @hw: clk_hw associated with the clk being consumed
>   * @dev_id: string describing device name
>   * @con_id: connection ID string on device
> @@ -4259,9 +4257,8 @@ static void free_clk(struct clk *clk)
>   * consumers. It connects a consumer to the clk_core and clk_hw structures
>   * used by the framework and clk provider respectively.
>   */
> -struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
> -			      const char *dev_id, const char *con_id,
> -			      struct module *owner)
> +struct clk *clk_hw_create_clk(struct clk_hw *hw, const char *dev_id,
> +			      const char *con_id, struct module *owner)
>  {
>  	struct clk *clk;
>  	struct clk_core *core;
> @@ -4274,7 +4271,6 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
>  	clk = alloc_clk(core, dev_id, con_id);
>  	if (IS_ERR(clk))
>  		return clk;
> -	clk->dev = dev;
>  
>  	/*
>  	 * Pin the provider module only when the consumer lives in a different
> @@ -4303,7 +4299,7 @@ struct clk *__clk_hw_get_clk(struct clk_hw *hw, const char *con_id,
>  	struct device *dev = hw->core->dev;
>  	const char *name = dev ? dev_name(dev) : NULL;
>  
> -	return clk_hw_create_clk(dev, hw, name, con_id, owner);
> +	return clk_hw_create_clk(hw, name, con_id, owner);
>  }
>  EXPORT_SYMBOL(__clk_hw_get_clk);
>  
> @@ -5392,7 +5388,7 @@ struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
>  {
>  	struct clk_hw *hw = of_clk_get_hw_from_clkspec(clkspec);
>  
> -	return clk_hw_create_clk(NULL, hw, NULL, __func__, NULL);
> +	return clk_hw_create_clk(hw, NULL, __func__, NULL);
>  }
>  EXPORT_SYMBOL_GPL(of_clk_get_from_provider);
>  
> @@ -5420,7 +5416,7 @@ static struct clk *__of_clk_get(struct device_node *np,
>  {
>  	struct clk_hw *hw = of_clk_get_hw(np, index, con_id);
>  
> -	return clk_hw_create_clk(NULL, hw, dev_id, con_id, NULL);
> +	return clk_hw_create_clk(hw, dev_id, con_id, NULL);
>  }
>  
>  struct clk *of_clk_get(struct device_node *np, int index)
> diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
> index 5009380863a9..ba23700149de 100644
> --- a/drivers/clk/clk.h
> +++ b/drivers/clk/clk.h
> @@ -5,8 +5,6 @@
>   */
>  
>  struct clk_hw;
> -struct device;
> -struct of_phandle_args;

Did you mean to remove of_phandle_args?

Otherwise this looks good to me.

Brian

-- 
Brian Masney <masneyb@kernel.org>
