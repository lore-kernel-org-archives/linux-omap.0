Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291D2DEA93
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171537; cv=none; b=YbKjm6ratq+3qIseTdaPhanY2pJyPutI7zDjb0aRrzhN96wL82OD4KkwQedvzrDneBgDOg8B3ZiFWpyaODBaEaSuO0U2+E7hWl0dKiTamrQz8Xf+yMjWMIdXJXpcri2zjueg6b8oxeyGwH1oyyqky6mkFGH0swpqJY8i9a4+bs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171537; c=relaxed/simple;
	bh=sR917INAPqiRWTwUavwb9f+zXWLqhKiK8ywqX9IbxYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyi8ghEQ0IInQL7JZw3cjmuRV9z3slPQ2Q7rtgsL+zUgjnEKBH67q3c5wrky9qXlY9nwEwZqvkEsNRTJf/eYMPMoZ8gd1bHFQZkATUZGZHqsywZnEgeAh5FIF174/Uk6UWG6MF5uhu/DHMFso+YPd+WNnJUDkSXO4SChL4ZQsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp1RrccS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp1RrccS"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1891686a91.3
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787171535; x=1787776335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kakQd7SwwB4qJFxzAT3GLQtskQ627s0NDgwkRoO1YnU=;
        b=Wp1RrccSlW1X9+Uaa1CnjB3s3pmxp7EniiOiDc+oDMhRJ6u8Tk5F2zuqktrdtcNhzV
         M05YvG3dnqFyPg8Rrs85KXdVDVM8jnXUco8dRrKVhfDahOSRUuchMInR2YiYfFBVTH/p
         Nkxc2Q+cXV77WyL93cqYvy7OUjulbrY045zyjER18oCu282KE8BG2txIAJy+WhBCE4Tl
         nG2fQ8j3JZtIuOuXSTuqmUY180bhQo3EjyFgCfoA/jz020Im456ZWaDGgqg5bWRLkDwr
         mWyickHWeugP70D72A+1XE/fWH8wF4tdxOEiJ22QUA+D+iUkpJxnqHy9PRAxvzpPnGR3
         TuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787171535; x=1787776335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kakQd7SwwB4qJFxzAT3GLQtskQ627s0NDgwkRoO1YnU=;
        b=RCUyDQjUj/XWhfQdgq8W0+DpHPV0jOoaka4zTzPXJ9Qqcq0+riarcRhHnek/YUwF05
         UFcMmTRpMjFoglVC5OGhHnaE6PwcyLHMT9PRp4oqbB21UgcEEeRdjamykXVsT7VcHCiv
         QhubUPeoP4RQKdga4nmrrSUX4QBraK/pTDwWxyG7iI0EHkwepqHSmtYAT5YDJsqlsoCu
         iTswkOqA5xzSVzUeGkjpEE73BRXxDNd7cgc8zBJt94ILorA9txBwNjl3qU8TBq6Q9w45
         IGpXxbhx7FKgWIOCMdjxwQuC2o//PlvLEY9PRXfsCOpqQP5J7IC8Bn0kHv/wL6w09gMA
         ju/w==
X-Forwarded-Encrypted: i=1; AHgh+RpzxWEhSrCb42UQqoFG7Cj4eih8hJFGYxHo6IRsyCNz2weOP4ddkAPq7THQbFyNGnUNz7S2l38p2vlw@vger.kernel.org
X-Gm-Message-State: AFuF++lC+THx2G5sZEIgggdaoq/Epd8qRtogMtmTGtInJNsU+SYsFeAn
	gY49ArsMzxBDvnNhVyf/YKxrPPs/UJUdu4x2UU4z9XJK9QghQ70UEm0R
X-Gm-Gg: AR+sD12ZDEO7wNtADROlZZh6IfCMt+ahzJluJIDA6jTGnP1PVJGtIrPH3B6RsPgDQ3D
	y3y0JbZH3TQX5IH0jCgtqHP09kr8mDajNXhOFIuTGh4xoePRPgP/7umKIxCpOcRSqxyHrMuupIw
	KVqslNYm0xP5SKffPIZKmFxmDMdApuJmRFQbbncxvh2MBZIDzXqvQaiHIuIvTL4Dcix82fdWRGi
	yhVkjg0wwV34xivwkbGe6A0t1aVHMWPdIUDs2KnV0zeUksXFaf3mdOPbXSx1h+QQGYXuZGco4ZI
	+hLHg6mxOtEyzG6fTyVGCT+EGbhPmhw0WbemhdSdAFtPewp14TXLSE5YlZSkhdyHUj5pIj7xHW1
	CZKoS1Ee6Ow4XiOtEa9/qo1HqG3wsQORpNmz2Z3f9+Ee3L3UDNAZZulwNstMMwAXqu+wVx8Jldj
	l5aCM0hE4UFBKwz4ruVYbgPpEh++PNaHFoY8GIANZRw05L5ua6ViRlSLYBsrqKL0ByndFXQGRUj
	w==
X-Received: by 2002:a17:90b:4a8d:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-39580553dfamr13842543a91.0.1787171535016;
        Wed, 19 Aug 2026 13:32:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad6060asm16706081c88.6.2026.08.19.13.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:32:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 19 Aug 2026 13:32:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH treewide 3/5] hwmon: (ltc4282) Make sure clk_init_data is
 fully initialized
Message-ID: <0ee768d3-f913-4d29-902b-39f8bf973dd6@roeck-us.net>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <8ec3c5cbd2df675a938f090470f5da5f22008517.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec3c5cbd2df675a938f090470f5da5f22008517.1787165329.git.geert+renesas@glider.be>

On Wed, Aug 19, 2026 at 09:05:17PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> ltc428_clk_provider_setup() does not fill in any parent clocks, and
> assumes that init.num_parents is NULL.  However, the latter in
> uninitialized, and thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: cbc29538dbf7d740 ("hwmon: Add driver for LTC4282")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied.

Thanks,
Guenter

> ---
> Compile-tested only.
> ---
>  drivers/hwmon/ltc4282.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ltc4282.c b/drivers/hwmon/ltc4282.c
> index b1675dc5b3c7fd2f..54ba4b8542e94b7b 100644
> --- a/drivers/hwmon/ltc4282.c
> +++ b/drivers/hwmon/ltc4282.c
> @@ -1106,7 +1106,7 @@ static const struct clk_ops ltc4282_ops = {
>  static int ltc428_clk_provider_setup(struct ltc4282_state *st,
>  				     struct device *dev)
>  {
> -	struct clk_init_data init;
> +	struct clk_init_data init = {};
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_COMMON_CLK))
