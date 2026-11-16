Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855402;
	b=I62stbdtraJ7TnPLANx8jPI3cMi0GvHkTX9t6CR72eNTIrWO+nQhcjf50747GKojbWlT
	 HoXdrxnFxtnoMEEEIGnabSveAIFhWts6Yz87ZzONRXwUG59dc+W6m6eQDTGOEHYAjqXI0
	 r6pVb83BpGww3i3vJiTF5peERW76hV2guazRsUfop1tLM3xB5FB9tPnGJ7/RSXUKbWeME
	 Ry6DgWO89LqqzG1Nd1r8MJFeLgZ0MBBQleCZyWWqiE7yVP1mCxqKVjNLFPjpZppS110Ac
	 RdNehlSbh5tzDObS8Yor13FJ+oKECLfIkc047d3Ni+DZHgpUa99uN1Sm1UT1v5+1Tiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855402;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QPBj2OiHEsD8oSSw9ct6pezY21YN5Ixn4FQ3VxqCYUE=;
	b=E2eZlbfh9lylE1ouQQi2426qRU+X2ZJhiCQiFlKzms2gcYuPD1OEhFLtBj3AENn0hqBL
	 5bnSh7m7DcHj2d9UXjiUGjgf31nDBs6sJv8N8LDV4PLSPI7/rN9y6SKKWrGv4nydP4wsu
	 ygC2K2urgFIozQSvC4tR0+LgV674lmHCU9ITK+2OYJZdWc+XbVN/K10ygoX7KjoEEEb+A
	 96kAABBglG6NLg0VpHA7k7ieNE4sKkcciEcmLlZmx0VpQ2BFb/A8r7TM4MjVWM35o1Asz
	 OxEGCSlMnAOiZvSVjyqJlcSgFesZ/UL8iQEMv3y06ZU4Ip/JNPd+tjjctQzPLTlmOAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehO0nWie;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C89606A31C;
	Mon, 16 Nov 2026 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehO0nWie
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1041F000C4;
	Mon, 16 Nov 2026 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855401;
	bh=QPBj2OiHEsD8oSSw9ct6pezY21YN5Ixn4FQ3VxqCYUE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ehO0nWie3OgQn1m4ccsYGi9+2nJiGb+rA5FI+/MBk/fy+WAfsvXOSt4u5Ka1VxN6J
	 4L/OIo6XoAYx+2NzjpM7lKhHX4GXxaWpW9OXysumThPNdIGJulqh7mqX96IgbUUw+r
	 6HtDr83dLU9V+oFMFyRHxCqm9jxBLNYGQpWQyeKR7abWEZjxmcAWqdv6PB27UAUqvx
	 raIDiceFGm6kbbc9FY+n7oS6fgUS1txDFV8LnEh7XGbh8ktVdh7T4Azy9dUgNW1WmY
	 mJ/sxkXj3TfaXak9acb3qvrRMdpY+QU/0H6Vr1omES+5MOZRPV3j9cFpG+7qhYgdv1
	 a51cZQCev8NaQ==
From: Brian Masney <masneyb@kernel.org>
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>, 
 Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Brian Masney <masneyb@kernel.org>
In-Reply-To: <20261113-patch-ektor5-dm8168-clk-v3-0-a42cd1edc5f3@linaro.org>
References: <20261113-patch-ektor5-dm8168-clk-v3-0-a42cd1edc5f3@linaro.org>
Subject: Re: (subset) [PATCH v3 0/4] clk: ti: fapll/dm816x: clock tree and
 calculation fixes
Message-Id: <179485539142.153342.17977965808888261924.b4-ty@b4>
Date: Mon, 16 Nov 2026 13:56:31 -0500
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
X-Mailer: b4 0.17-dev-ca76d
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=s8Tw7ZNGmtvgURa5ttmZPdTGfAUInI9PvqI1Tfk0Qig=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLJ+Bz6sPyjw6kPqxe2vGb5XS7+ptDe8wOtdqrf//X+Nk
 uJEx4kmHaUsDGJcDLJiiixLco0KIlJX2d67o8kCM4eVCWQIAxenAEwkVYmRYUtnhMyV1OIHjudM
 6u+ZNayNeSk5q2Yiu0D51wuLj+XYpzH8T12XpyYSa/Ki8jmv7yTd+DKnL57n6prPrrljvGTGWVF
 fZgA=
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087


On Fri, 13 Nov 2026 22:30:46 +0100, Ettore Chimenti wrote:
> clk: ti: fapll/dm816x: clock tree and calculation fixes
> 
> During TI DM8168-EVM board testing we found that the clock hierarchy and
> clock calculation was broken already on 6.12:
> 
>     main_pll_clk1       <--- main PLL should be parent of other PLLs.
>        sysclk1_ck
>        main_pll_clk7
> 		...
>        main_pll_clk6
> 		...
>        main_pll_clk5
> 		...
>        main_pll_clk4
> 		...
> 
> [...]

Applied, thanks!

[1/4] clk: ti: fapll: remove ti_dt_clk_name helper
      https://git.kernel.org/clk/linux/c/b8cec302edf5
[2/4] clk: ti: fapll: Fix clock speed calculation
      https://git.kernel.org/clk/linux/c/7f64adfdf118
[3/4] clk: ti: fapll: print clock name that fails to register
      https://git.kernel.org/clk/linux/c/9d081472626d

Best regards,
-- 
Brian Masney <masneyb@kernel.org>

