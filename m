Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445968;
	b=f9JVLKJQ6SzDxF472jSxLc4hmETW4JkU3JiQB/trdMWPHmfNYQdAJqSfuRU+nR4Jan2C
	 /hz5Hegr+epToLEn32feLMIZvmQhFduFueCnshVDWcGNTXd3pxPWrfQq0l+WEpNokgzW2
	 BFR+6llvIZal81M7QeY3UrTQSj1EJpCNL7jIp32e0qdghpc4K/FRjwOWwiMt17F7ZrT8m
	 W4PfUk/fwq2H3uiUIsInHLW/Y8mSzMnF9hrFThtw2uiZYtyxKgDMJuE0hue5DqHIvbaUA
	 FevhGz5Y/L6Rqnls30XOD38qsyeEEsN4WCeUwnZIY9asKd0E5uUACSZDD3pT/BVoWJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445968;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4jZDYEse9/cxWg8da60qIF7+IB1zsTlFu70WzJPQGc4=;
	b=r9SpHBkrWFpuaslPoJtiy23shkLFnfEOGNH7PuP6DG4idfJFoUgqWL+oTABZJE0Z0jZv
	 171GzoMOsQ+nJaj1oe8qdGMK/QJwcLJ87RvAmZemP1Kl+N1aDhlOp72Grq74zyjKzoAdK
	 aSwyhX6270p4YlCglcICJRyG5nk+e21BC0uwxQA3+zJAQdqU3knrP722m0NAudVvT1R/I
	 4IQCoobtLcxq+aDJ6QMwB3iw+sRrknnOLvuXShQAFaWbn/3AbsHkY1Ieo3AKRx1/nN8ns
	 P3wZd9a80ZGAZgZ8ry549OLaKySWg3slE6s9N2FNTZX0Y9xJoq+6+Phsw1Yo2Tt8EHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8+6zJSm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB57606A336;
	Thu, 12 Nov 2026 01:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8+6zJSm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FAB1F00A05;
	Thu, 12 Nov 2026 01:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445968;
	bh=4jZDYEse9/cxWg8da60qIF7+IB1zsTlFu70WzJPQGc4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=T8+6zJSmt7tfJ5c2nOMCrhrFY74bhuQIe6ly5GCJWOcdKg/QQdc7trF3B4IlL0NxH
	 XrAcHui92koqniXvelvo9vehfMBMapS29db/zYNPoU1WZLmHRPtf0fZWUxludETVzg
	 GAaIFrBT4wsfqYr2JKUXyyGVDuRqhIa3d342qhqzZ36oZjfEt8q4zbdCmS9AcL+WQP
	 0Ko1yhSIfALD9vLkJ7a/KPwpFw5OOvG4rIWiG97p9cIHW3W/UMhtsspzulCOwkKb5D
	 07F/86deXQHRAxpfgql0Ox2eSImniaS+5HF6AXT65c3FvWdIbCJX9fBVIOTCcCWuX9
	 2A9VLrkFp7vAw==
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
Subject: Re: [PATCH v2 2/4] clk: ti: fapll: Fix clock speed calculation
From: Brian Masney <masneyb@kernel.org>
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Michael Turquette <mturquette@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>, 
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <masneyb@kernel.org>
In-Reply-To: <20261028-patch-ektor5-dm8168-clk-v2-2-dc6bf0fabae4@linaro.org>
References: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
 <20261028-patch-ektor5-dm8168-clk-v2-2-dc6bf0fabae4@linaro.org>
Date: Wed, 11 Nov 2026 20:12:39 -0500
Message-Id: <179444595968.1126566.8596406047613157255.b4-review@b4>
X-Mailer: b4 0.17-dev-7ca47
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=HWqIi2/K4de0Y7TXW4gZV832Fi37kbHMZBBFeGOcPnc=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLK+CnX/j1mQcORt9NFUkTmPjrCtqpFrDTypenjKfI8LA
 uwaynuCO0pZGMS4GGTFFFmW5BoVRKSusr13R5MFZg4rE8gQBi5OAZjIikJGhk+f/urGyc4oyHz8
 f8/EE7Vzjm/ITc3/dmr//IWn91m1hIsw/C9LOuC3emJy8XOW6GkWW6qkW31jXeUVxfcEh9zsqJB
 dwAQA
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Hi Ettore,

> The fractional part of the divider was being treated as 1/10000000
> whereas it is in fact 1/2^24 (1/16777216). This led to incorrect clock
> speeds being reported when a fractional divider was in use. Correct it.
> As well as fixing the clock speed calculation when read, also update the
> calculation on set in a similar manner.
> 
> Fixes: 163152cbbe32 ("clk: ti: Add support for FAPLL on dm816x")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Should there be a Co-Developed-By here and on the other patches?

> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> ---
>  drivers/clk/ti/fapll.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
> index ae2f6fed10f6..8ab9acd57b60 100644
> --- a/drivers/clk/ti/fapll.c
> +++ b/drivers/clk/ti/fapll.c
> @@ -336,8 +336,8 @@ static unsigned long ti_fapll_synth_recalc_rate(struct clk_hw *hw,
>  		v = readl_relaxed(synth->freq);
>  		synth_int_div = (v >> 24) & 0xf;
>  		synth_frac_div = v & 0xffffff;
> -		synth_div_freq = (synth_int_div * 10000000) + synth_frac_div;
> -		rate *= 10000000;
> +		synth_div_freq = (synth_int_div * 16777216) + synth_frac_div;
> +		rate *= 16777216;

The 16777216 magic number appears multiple times. Plugging this into my
calculator, I see it's 1 << 24. How about adding some defines:

#define SYNTH_FRAC_DIV_BITS	24
#define SYNTH_FRAC_DIV_SCALE	BIT(SYNTH_FRAC_DIV_BITS)

Brian

-- 
Brian Masney <masneyb@kernel.org>
