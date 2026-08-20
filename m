Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D532720C;
	Thu, 20 Aug 2026 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205407; cv=none; b=PyRl6YkvunKLI0aEC4z+j1aFJXe6qdvRnQXATh+u6MhftNuq4tkE4NB0N7GCgZCi2yRossSFjhZE1tskk8YnSDEu5+drlV4SfiUhHBbnY9WAjyVYBH5BHmTeuaVx8ZvNagK2SpZ9quS/FExE/HnUbqD/Be8mNetb02fk+YXiNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205407; c=relaxed/simple;
	bh=3PohkSJtw9muz0t558UK1h6O3L340dMlDRbS+VCaczg=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=iwzDHy13CnWLTSPEvv7O+hyjI28ojwgsJdELfqIppT0c0QQL5bVVu62wB4iqG5s5PX6fhnVhX8r48SSHpopDVumveXvDxcQ8v64pMfeinSXpmFGWPxkAsaRHAkGZkw7msmxJQ2TisMkeKEU2pxWgjnzEjp4pybhMpMi+lnCtZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etYSeNq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etYSeNq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38B71F000E9;
	Thu, 20 Aug 2026 05:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787205405;
	bh=KQGmZS4Slygo8kjpwsfEXvWz/G62+OKPWR1aSR0J71o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date;
	b=etYSeNq25EJMXXv4u5We4cSMs+GN9cIyEzv2VY7UVBuVRs1OBZawK1rI2umLSfm+8
	 Z10bjPIGE1Lm2YLQKzTktrGyVont59HrfdephXigQ4nUZtsbP9+TtXX9q20dMYC8vk
	 GG3DYNvaOzjfgKsYxNyKYqSbGMQW22RXnFuPMfW7U7ULdUqfBmCO4aIZCoLojraMQm
	 G264652k98yGakemQGwc7QYSY9Dx5F/StiLfx6Lu5vftbtTFUAHuYGXrYlF380Mpzp
	 HJsJUKYr2mwKN90sdfE5i4F0EoBpkoWG6z2aYvHlVkxmW/+DaGFLcJCrBUipyHOxEW
	 vY/mvnQxFLwhA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <42dd7be99acbbea1343e2fcc0ba4ffb91f8517ca.1787165329.git.geert+renesas@glider.be>
References: <cover.1787165329.git.geert+renesas@glider.be> <42dd7be99acbbea1343e2fcc0ba4ffb91f8517ca.1787165329.git.geert+renesas@glider.be>
Subject: Re: [PATCH treewide 2/5] clk: visconti: Make sure clk_init_data is fully initialized
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, linux@analog.com, linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
To: Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Brian Masney <bmasney+clk@redhat.com>, David Lechner <dlechner@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Guenter Roeck <linux@roeck-us.net>, Jerome Brunet <jbrunet+clk@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Kees Cook <kees@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Mark Brown <broonie@kernel.org>, Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Michael Hennerich <Michael.Hennerich@analog.com>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Nuno Sa <nuno.sa@analog.com>, Sunny Luo <sunny.luo@amlogic.com>, Tero Kristo <kristo@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Date: Wed, 19 Aug 2026 22:56:44 -0700
Message-ID: <178720540417.4726.17820278351018025650@lazor>
User-Agent: alot/0.12

Quoting Geert Uytterhoeven (2026-08-19 12:05:16)
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
>=20
> visconti_clk_register_gate() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
>=20
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
>=20
> Fixes: b4cbe606dc3674b2 ("clk: visconti: Add support common clock driver =
and reset driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next
