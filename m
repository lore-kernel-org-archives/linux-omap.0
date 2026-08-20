Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0CE248F57;
	Thu, 20 Aug 2026 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787189891; cv=none; b=in/FTvY+5YJMxhdk/oZO2D4tf6fcEBYaWtNTuN9GfDvGio6G6D7LEV66w9Xajo1+cQEYJMP7e7/JH4xmOtV3UdkGF24GB/F1asT2Y+mTR3nlRcBqDOU/q9znlNF/pZo0f6gzlYj/Ptxr2GVeqGiFdWKkVUXCZN+q5hrUS7hYGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787189891; c=relaxed/simple;
	bh=iet/7H98mF1FsB49qFXUOZ7OBCzJuXp5v9b0TrWXekA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQTWIrI8qJlR1WCV2+HzVgi92TmSnoR7O/POpVHrYN3nAbnvwu2Bcl4dIcELaPHakihLiwPPpk2coywf0cR/gHcaYA7e1u3M3NR2VunbcjpSFgKrAvS9M6shbUHFBYtr8fL7tfVGexwObGq/UtKIReCyf/APlIhkZqD2s3oqPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZMkr2kw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZMkr2kw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609D21F00A3A;
	Thu, 20 Aug 2026 01:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787189890;
	bh=7A6JesNR31qbM8jFMjX5uG+J+rXUo91CSdPomfFkkHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CZMkr2kwPcjJvMeEgedtJWG1ojnfdOz1937Nbdm4EWQtkYeYW3m8xArP3mLJBF/IL
	 MAzJJOKD1scDjgvBwwrST/fB2Jyoba4j+Ghq+nagPOPxbnNunmQdQSKZJbchZeudbP
	 u60FNlGetJI1+3ALTuQlVRqScRpi3GxzpuLlPi+b1cdT0n8e/ciunLYs4aoo9opzbG
	 5ANoIuR92ive30NLGR3Li7Im5/YYatfyQ38MydVx17mtmSaoTstgpdYg3ErKSUqwDb
	 mrU/dAosK/xAWqC6BYR3TTcIYb5TLnj1g1ZvFGwsio8ZBGuUkQVQkJQ6Hf3h7DmGMJ
	 d3yZMkfxkhAnQ==
Date: Thu, 20 Aug 2026 02:38:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Tero Kristo
 <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Nuno Sa
 <nuno.sa@analog.com>, Guenter Roeck <linux@roeck-us.net>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Sunny Luo <sunny.luo@amlogic.com>, Xianwei
 Zhao <xianwei.zhao@amlogic.com>, Mark Brown <broonie@kernel.org>, Kees Cook
 <kees@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Mathieu
 Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hwmon@vger.kernel.org, linux@analog.com, linux-iio@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH treewide 4/5] iio: frequency: adf4377: Make sure
 clk_init_data is fully initialized
Message-ID: <20260820023804.70ba61d1@jic23-huawei>
In-Reply-To: <aoYeoSnvf5-l69lE@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
	<302584628c4c0699239a0218376fe1c11cdc8944.1787165329.git.geert+renesas@glider.be>
	<aoYeoSnvf5-l69lE@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 17:22:41 -0400
Brian Masney <bmasney@redhat.com> wrote:

> On Wed, Aug 19, 2026 at 09:05:18PM +0200, Geert Uytterhoeven wrote:
> > The clk_init_data structure contains several mutually-exclusive members
> > for different methods to specify the possible parents of a clock,
> > prompting drivers to initialize only the members they need.  However,
> > not initializing all members may cause subtle issues, which are only
> > exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> > enabled.
> > 
> > adf4377_clk_register() fills in init.parent_data, and assumes that
> > init.parent_names is NULL.  However, the latter in uninitialized, and
> > thus may cause a crash.
> > 
> > Make sure all members are fully initialized, to fix such bugs, and to
> > avoid future breakage when converting drivers to a different method for
> > specifying the parents.
> > 
> > Fixes: 60e5448ddbec2dc2 ("iio: frequency: adf4377: add clk provider support")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> 

Applied to the fixes-togreg branch of iio.git
I'll rebase on rc1 before sending a pull request (so waiting for that
to be available)

Thanks,

Jonathan
