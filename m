Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BC390999;
	Thu, 20 Aug 2026 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205398; cv=none; b=GUfMgDxeDvg0oCEnvFzknzAMPKEXLJOwI0GrZ+UMbnzlLAxAIB9INxNYZDaaQ8kvNgO1OoNbz2kt/26bVJJMna5qsBManKKtWpwgyOl8a/48qrtW+jru17LKYBSCDN2wg5Z40tjQ5ScEiUq+oXA+6rvXxWZrfMHBADo1Ir6xPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205398; c=relaxed/simple;
	bh=NIjYRMAPqQCT+cM9DSxnV4H1RPZ40r9ZpwCFckgECV4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=RlUZwp9Lvw149JTtAdL3dytxHFiHcElBO15uUhZ6o283gi6pZ3YVH0glbUQW+AtEvrT4yKXnt+f5Q/xcX8BXgDoWVC+UXS4uc+mq/gx1Py3wZfZaXQUEUGA9E3sNSwnJSGB4GGaxcZR8cW/yR6aeC6ahEev++9oEDwyl7IRLXRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx/ECOxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx/ECOxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8F91F00A3A;
	Thu, 20 Aug 2026 05:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787205397;
	bh=bTtESEhDqdaJJFf13TJPMsvGwGlOkJtwU8iCH8UJRzI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date;
	b=Sx/ECOxkrorY3o+MTDG3qDlw0HT8E/cTXE/rqe8svELCermUqUrt6Wz1D0fkuY92z
	 7eoD80Sfzx2VqwviyXDW5AW0oKJRMoxoCw4Jj1l8JZgPjpzKXlZfpbveDFFFHR3CPK
	 266u2W0cPA4LXRWVFnuCOxKceTyx4BsTpWAodATgmimYdZ87R3LkX3UNZqha33FHBo
	 +luXGBcy7XhRmg1Ld3J/lJeOEeoahw/ICOwRim9qFHYNNvQbsLqy2ZSH9Unkx25M1T
	 Rlqq6pD7uQdlqkgCCpFqyShTEU7ohk5Py83Y5hDlDqESjFGj1Q04A08SxecEIy/CXm
	 lwBLBt91ZMu/A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e6f52b34163c8e708c1100107b437af0b3b049a6.1787165329.git.geert+renesas@glider.be>
References: <cover.1787165329.git.geert+renesas@glider.be> <e6f52b34163c8e708c1100107b437af0b3b049a6.1787165329.git.geert+renesas@glider.be>
Subject: Re: [PATCH treewide 1/5] clk: ti: Make sure clk_init_data is fully initialized
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, linux@analog.com, linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
To: Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Brian Masney <bmasney+clk@redhat.com>, David Lechner <dlechner@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Guenter Roeck <linux@roeck-us.net>, Jerome Brunet <jbrunet+clk@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Kees Cook <kees@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Mark Brown <broonie@kernel.org>, Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Michael Hennerich <Michael.Hennerich@analog.com>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Nuno Sa <nuno.sa@analog.com>, Sunny Luo <sunny.luo@amlogic.com>, Tero Kristo <kristo@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Date: Wed, 19 Aug 2026 22:56:35 -0700
Message-ID: <178720539505.4726.15293940846422145239@lazor>
User-Agent: alot/0.12

Quoting Geert Uytterhoeven (2026-08-19 12:05:15)
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
>=20
> _register_mux() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
>=20
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
>=20
> Fixes: 667f420c09f1417c ("clk: ti: mux: resolve parent clocks by DT index=
, not by name")
> Closes: https://lore.kernel.org/CAMuHMdU3yVqoyHC4eNF2NuYo8wy+6ODLoYat4R71=
X99Mxc_=3Dkw@mail.gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next
