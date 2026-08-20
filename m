Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E238F249;
	Thu, 20 Aug 2026 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252027; cv=none; b=rm7Y4DjqnrpWt9GUtIvdRHQaPVonpJ+zG1Vjb3ghE0X6tnhU9AbmoNAerSEmLQiBdIRBWoPRDDlhw27K0MoTFC8xE5KBv80H4PhCxDODpVdJEiKRudWlfMzBKrNNdexoYlHY++pQ1bXD7nRvMkekhRJiuofMCDHxt92aPnFj+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252027; c=relaxed/simple;
	bh=T4O6Ytd+oVjquoKgE7hf+vP7Dh6bPlJfF2fa2COS54M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dj9GnINFDRy68XUdR0/ezzELKPAO8zGln/jeXz+fUurkZ9G/QEV3q3qjhW9a19vtGVaohkNi6EBtsC1RE46OaE/NKSQslWqfg7lnGrn7RnTeTIVr0JkxffDXtc5VndEr2+WKtlPE1Mnpw/eQF0pCNvNQ7+w6M7Im2x5Ad4VErOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0NP1aHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0NP1aHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490B21F000E9;
	Thu, 20 Aug 2026 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787252026;
	bh=j4+HEzu84tHiUAZOxRhDjFI/ug5GzBnvn/WLzOcpkyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=H0NP1aHU1Kw2CsPh2H8BLbi6yqq5B182IUlX89TgqPSaIxveE5Jr3xi/Qcs3m7Xbd
	 Y/befz+dDSuMEw7cndcbClLTwxPwc7YMS+Vi8jIm9FtAqL3cw54XFz7L5DBWi3jfUE
	 VrLuxAHW68PsF4lFUW7glviay0Vqno/Hsk28QJhgmyIzPusNpwE7QnGXQ1kXqITIZd
	 OpolHzWzmiPZELFdVHuOc73iCDT/vmumH2CHy4zYLFJtx5hsqWVO+H6JB998UjdRTA
	 Og3YldTWRaRSDHc7iJubIDoaPP5HJp+E6InQYoqeywDSj3o7EzcgG1aOAPxnFpFT5g
	 dA666zqlo005A==
From: Mark Brown <broonie@kernel.org>
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
 Nuno Sa <nuno.sa@analog.com>, Guenter Roeck <linux@roeck-us.net>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Kees Cook <kees@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-hwmon@vger.kernel.org, linux@analog.com, linux-iio@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1787165329.git.geert+renesas@glider.be>
References: <cover.1787165329.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH treewide 0/5] clk: Make sure clk_init_data is
 fully initialized (part 1)
Message-Id: <178722791204.89147.8075686338925258822.b4-ty@b4>
Date: Thu, 20 Aug 2026 13:11:52 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=broonie@kernel.org;
 h=from:subject:message-id; bh=T4O6Ytd+oVjquoKgE7hf+vP7Dh6bPlJfF2fa2COS54M=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBqh00yfuqNALH6N3AXS+G0HCah2fOyCOhjzME7f
 KNnVXeAwAOJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaodNMgAKCRAk1otyXVSH
 0AShB/dhLJEEeXKrFQP9gPrIolmzi20NN0M7zC8KH9y3aa0HDRIJ7TvS+Mlng+fdUJET/6Z7YdN
 WwL1wHIjh3EU33JMDcZr5roVJlS2GMOtkapj/U0/KKGaNeIjzv4dfTSJHfNsGJzAEbsAl1DJOG2
 EL9hRt5A6Bm6qkLavFafXoAOgXgTNPvroZfhwTUzkSICx+buDnmQ0FulKgO8h9wYKRMOsrRfyLO
 0vz7DyM9o2N/dZFZc+ioL0Zr6TqUFedhtZO+ICe+0AauztCGPgGqinrzsgRgm+I8INFJZoPOmt3
 Ua3StNsCFMpgq0hNzFgNCUVp74ea+Y3GiTcnrWUWzMbP5B8=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 19 Aug 2026 21:05:14 +0200, Geert Uytterhoeven wrote:
> clk: Make sure clk_init_data is fully initialized (part 1)
> 
> 	Hi all,
> 
> The clk_init_data structure contains three mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  When commit
> fc0c209c147f35ed ("clk: Allow parents to be specified without string
> names") added the last two methods, this was done in a
> backwards-compatible way, using a priority-based scheme:
>   - .name, .ops, .num_parents, and .flags must always be initialized,
>   - if .num_parents is non-zero, .parent_names must be initialized,
>       - if .parent_names is NULL, .parent_data must be initialized,
> 	  - if .parent_data is NULL, .parent_hws must be initialized
> 	    and valid.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[5/5] spi: amlogic-spisg: Make sure clk_init_data is fully initialized
      https://git.kernel.org/broonie/spi/c/b2702908ee23

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

