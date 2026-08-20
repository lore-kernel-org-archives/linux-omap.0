Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C633986F;
	Thu, 20 Aug 2026 05:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787202158; cv=none; b=IthVS9EMJhZpIVgCVuBjlv0BvyiwZKr4JZhqjL72NA2Sz/rjxA/Q3X0EDpj4KjQko1vd6piq5ll9hSoh7sZH5Xt3KuJRehWl9ivAulafZ5BYg32vdKldaaTOJYJhTEJdCTkR/ot1C+mn8q2xEmLh9sM6HVIgE7yAqznIps42klI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787202158; c=relaxed/simple;
	bh=pY4cXMl9g1/YDScEen6tbm7WPEsJq7UDTp5xjJNYt7k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=a+MVihDYDA7kRebriaZp6V6EE67F5i2hmxlBQwbVTZPV0pmzvsvtAB4S0dBDvrYzS3l0RFoWxDgPiR9ki83BIXVoNvNO3ftZRF7X8ri7lq6P2H10gyr5eS5Cpc0IOdeLQ0ddWuvmYfhuBD0VO8NvnuwbJCYJL/NQKTFM3Oi+9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d+qe4FcP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d+qe4FcP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 47FA41A1754;
	Thu, 20 Aug 2026 05:02:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D5445FF59;
	Thu, 20 Aug 2026 05:02:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB63311C75D87;
	Thu, 20 Aug 2026 07:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787202147; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I2eZLHoFTLtYnqAPbAqSK2Rpc5EQeElhxYx0vz8zAvQ=;
	b=d+qe4FcP1K7JQejOsetBB+a4w9v32yPTsVG3+rfnPI+JwdnSHy+3Lh2q7zrru87RoH3/0l
	jv8gE28PvnVnK04uypiXw1Ilr2+GI+hx1KSDR13AFKBhVBc3VGlNI5CGWSedKOtpOsb54j
	qqbUuSVob2hC18z9jLlLjNei5SRX+K+XOSwuHBKudeKI5nljkafUugazoZMg7mxD6HX0x5
	N/X0dLT5et5k2UphW6SIm5dLf63UYkVCq3MiokZFUDnagNTzg1DwwFJx/m22VTC+s3jV5b
	oH2iYEwn3LbCYOM5yy3HvqnjN/NVntP5yjR+M1m20bddieKDztRJ0301W7e0jQ==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 07:02:18 +0200
Message-Id: <DKTIA7WYL54O.163XHIM9WV1X4@bootlin.com>
Cc: <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-hwmon@vger.kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
 <linux-spi@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Geert Uytterhoeven" <geert+renesas@glider.be>, "Tero Kristo"
 <kristo@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney"
 <bmasney+clk@redhat.com>, "Jerome Brunet" <jbrunet+clk@baylibre.com>,
 "Nobuhiro Iwamatsu" <nobuhiro.iwamatsu.x90@mail.toshiba>, "Nuno Sa"
 <nuno.sa@analog.com>, "Guenter Roeck" <linux@roeck-us.net>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Jonathan Cameron" <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, "Andy Shevchenko" <andy@kernel.org>,
 "Sunny Luo" <sunny.luo@amlogic.com>, "Xianwei Zhao"
 <xianwei.zhao@amlogic.com>, "Mark Brown" <broonie@kernel.org>, "Kees Cook"
 <kees@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>
Subject: Re: [PATCH treewide 1/5] clk: ti: Make sure clk_init_data is fully
 initialized
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <cover.1787165329.git.geert+renesas@glider.be>
 <e6f52b34163c8e708c1100107b437af0b3b049a6.1787165329.git.geert+renesas@glider.be>
In-Reply-To: <e6f52b34163c8e708c1100107b437af0b3b049a6.1787165329.git.geert+renesas@glider.be>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Aug 19, 2026 at 9:05 PM CEST, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
>
> _register_mux() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
>
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
>
> Fixes: 667f420c09f1417c ("clk: ti: mux: resolve parent clocks by DT index=
, not by name")
> Closes: https://lore.kernel.org/CAMuHMdU3yVqoyHC4eNF2NuYo8wy+6ODLoYat4R71=
X99Mxc_=3Dkw@mail.gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Thanks again for the fix.
