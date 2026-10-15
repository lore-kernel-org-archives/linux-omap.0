Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE0F51D51C;
	Thu, 15 Oct 2026 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065931; cv=none; b=JJxYxldWqWmS+MVNRSQA2k0xhyF6cMSLCze2JK6WO3KsbdxjJqLCgKmpH65T7qKu/Me3rp40AD10HDPSE7AS0yReKMMUML6X0ZHKxxuundZ0AwpT3MVq3kFm9D8bbqtYz27+HtRZbh5V34rUjVeqC2J/VdIJ86ky3HoOr8+H+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065931; c=relaxed/simple;
	bh=hS6N0AxDP3dqhcP6QWsvCMnvOGEGVSpRlLinYBdMDvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQFtT1eK53Z0jNm91WUVVi/Si/e/XN4mVh6VYqxmHhC3phGQpdrzW9TLAzV4rU3IhEh9MhcSYq0kNo00V+O+P9b54Z7zahkhF/aW+wJDIZoc83N+V+fPfuBvJqWoR0K6oQR01bg+Svtyvn2Mqi9H/al8bAIRBPHbOTdG4LCFzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSN31RNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSN31RNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D14E1F000C4;
	Thu, 15 Oct 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792065928;
	bh=L5uYYZaIH1zFAqJtxP6qzAMnxHuOOFBJFJUkfgN7CA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cSN31RNX+haGjAGIPOYvrI5V6XZUfkUFwdOOv+i3sXqAUR1kUpwyA5Cos8OXul/Li
	 pQMUn/SJ9Ei4fUFVu5dW7S5SIhIFU5RY/GJ5iGZAv78QSfsizqAhLLmM8BgZyit2A7
	 Tz05tK5szt81zrCVelj+PYhTMLadC7sv3omtYQY+zMzNJkczZAS4d7AIpLaggQEVY1
	 fkw9311LiYz1cHs5go2N8Ruf0yHa+zYNvjH9fGjJgpj/KGZtSy9PuFpycgi7QUsGz7
	 ZIHvVNQzyM3yFRCQebKXMujpbqDWJpU63+aPrv+QQ5nW2lhWH2PCvQ9JFxroEMUgva
	 evzpOMKTf+EoA==
Date: Thu, 15 Oct 2026 13:05:23 +0100
From: Lee Jones <lee@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: mfd@lists.linux.dev, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	open list: OMAP2+ SUPPORT <linux-omap@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>;
Subject: Re: [PATCH v3] mfd: twl-core: Allocate modules with twl_private
Message-ID: <179198497618.839288.9266863610003754798@kernel.org>
References: <20260926013325.75073-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926013325.75073-1-rosenp@gmail.com>
X-AI-Review-Draft: <20260926013325.75073-1-rosenp@gmail.com>

On Fri, 25 Sep 2026, Rosen Penev wrote:

> Use a flexible array member to allocate the twl_client array together
> with struct twl_private. This removes a separate devm_kcalloc() and
> keeps the module data tied to the main private structure.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v3: Capitalize Allocate.
>  v2: don't use twl_get_num_slaves().
>  drivers/mfd/twl-core.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index f86df356d658..0b78fe30e047 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -159,7 +159,7 @@ struct twl_private {
>  	unsigned int twl_id;
>
>  	struct twl_mapping *twl_map;
> -	struct twl_client *twl_modules;
> +	struct twl_client twl_modules[];
>  };
>
>  static struct twl_private *twl_priv;
> @@ -770,7 +770,9 @@ twl_probe(struct i2c_client *client)
>  		goto out;
>  	}
>
> -	twl_priv = devm_kzalloc(&client->dev, sizeof(struct twl_private),
> +	num_slaves = (id->driver_data & TWL6030_CLASS) ? 3 : 4;

What's wrong with twl_get_num_slaves()?

> +	twl_priv = devm_kzalloc(&client->dev,
> +				struct_size(twl_priv, twl_modules, num_slaves),
>  				GFP_KERNEL);
>  	if (!twl_priv) {
>  		status = -ENOMEM;
> @@ -787,16 +789,6 @@ twl_probe(struct i2c_client *client)
>  		twl_regmap_config = twl4030_regmap_config;
>  	}
>
> -	num_slaves = twl_get_num_slaves();
> -	twl_priv->twl_modules = devm_kcalloc(&client->dev,
> -					 num_slaves,
> -					 sizeof(struct twl_client),
> -					 GFP_KERNEL);
> -	if (!twl_priv->twl_modules) {
> -		status = -ENOMEM;
> -		goto out;
> -	}
> -
>  	for (i = 0; i < num_slaves; i++) {
>  		struct twl_client *twl = &twl_priv->twl_modules[i];
>
> -- 
> 2.55.0
>

-- 
Lee Jones
