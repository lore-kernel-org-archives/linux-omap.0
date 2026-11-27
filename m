Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809787;
	b=a7zjSc7upRdml388vT7J/DNgdUoMsau953ZZiwngl3K8UURt4QyhxEgRP2N6oDJ9KtTx
	 KaNj3+uzRNMiIkD6/yAwHDMApdJAJb9LOmmSl4XeTbftgnMiNJ7LFNu2mB+jkgM13Pqn7
	 zALzGwhUpPgnq1sbXBmFJd7Lld5QdIhyNu+0W8irqNJMhXGfC70lML6QYq7BE6/D6xor0
	 Fm7X0Tc/C1SEszNHTNffJasp3GNDKEBVsSABurizaa/l+SA8XAv/r08FBEvZa29CTQsmA
	 miDZAQNcB4amVJ/fFrbOyMAGtrZq2aU8YnOVKmakGkUmDSxfKqu76AlvIc5E7hb+Mdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=L/E3JJyk32BLVSmJPSu88QD4Xx3KecbTtSFMtKZvIaA=;
	b=lkB9UCIVMc7N7PIsg89GRbdDUWnn73DPft3hsQL9O7axCre4J4LuvF7OGyJf0opXzurq
	 5syb2phBp5OHuEAu2U74M+VltFdcPKQiVu+okggcvAjjAJlFyvpAhcYvvYPUcu6SMQuXT
	 56ldc3tPEMrdZwthC3mRStMhsRgkhDRP+CYhr1hUUVARWYBmnEFQASJlxztJzQfepR4y+
	 hny7x8S420urh5bA6yNJgEp9Fk1NBcXzif08ZAMU2yo/mJFfJ/agi/u8WDb1TLDGCLmjt
	 XybKDokRBHlur9Eqr91tqoE9NiOAEQYRWHsw5hflsYM89VsmwF7G9U1s7rQiiEQacPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=USVugUGJ;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBDB606A31F
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2026 20:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DBDB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=USVugUGJ
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6bab10842f8so9959511a12.0
        for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2026 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795809785; x=1796414585; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L/E3JJyk32BLVSmJPSu88QD4Xx3KecbTtSFMtKZvIaA=;
        b=USVugUGJ0OGFei1oWOv3ixK8kXmdxW89ohPqYbYPFavNwb4jr4xK/cCB4y9hnjKBRM
         aMOvkgqxflag6ZhfKgZn6Crc/Q0pKn6tBIJr46jAuxAaLmM6loQMdtPdlzh1ApFcCcIo
         B9aE8+dPxpxuHlLdrD194YCNFEvbZV3F+cl0P53tTPOcbIF6UF8cTL4S14CNVv4DUmuA
         AEgFaEREQj2bq+B/IQqtj2BIkyBdW4uRS3Y7P0eYNo5+b5iJKu53Sp17WIb/C/drqg3q
         +O8oCjm7LKaIgd6H5wW5LXl6/Pd9/2GoHH9kdvrEAwaYwOXV+667Uk+wJ1cWl86UfOSi
         Xo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795809785; x=1796414585;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/E3JJyk32BLVSmJPSu88QD4Xx3KecbTtSFMtKZvIaA=;
        b=efiThiNYjmDRl+2llBJ0+g/EXvJXNI2ufPVCCPvDhquhn4QYxotvobbAzIfdtfS2p5
         fxq4V88DJSsCgyfBWEKOg9n29JW8U3Rm2uSTL+9ECsGsnUDRbgqNtNauDBNq20cS5IWI
         Li+SZQYKOSDeFjjbrxuGoDyQOfFOVSjFzq9Tksnh+tPb5AcvfTN8xEImblm2H7BLl/FU
         AGAOqu5LMj/7KDFWtdaD/SI/FO6JogSCGsgS9xHb01EorcG/qgZ3q1j3OcKw81IXSDbb
         Zss56kzsSZn1riDjDfaeZw7zQHgONWFH+ljQVTPTzXWakHowqeUcz+BbzHLp8uFFlkKY
         kJZQ==
X-Forwarded-Encrypted: i=1; AL+hErHzW0qIJi4/SjUFzdRqa4A374U8ZNjxzPa83XWxCpr9rlxivIfxtlIDCSRPBqn19h90shcObU45j8fD@vger.kernel.org
X-Gm-Message-State: APuU4Z9wjyoH7XN9LneshbQeVtZ3eiU1kYZBCmkQdRuhkIhdj2acr6/F
	qgyDRapz305JgXSoO99SBfvU6wKAHDF6F8IHyXzp2mxeRDBaumGizgwSQgDBjwF7lFY=
X-Gm-Gg: AZFdTZd1k0nghASZk0fMyFQHTPUw5C6uJcDzB+UNa4tGrBnnMLGXAkq+xCSVV/fVhiz
	ZBa3UgXomFNvhK3ycHA5swJdLoRJxyOZj5uky7dPPfq3S5+phwHmRRPcGKeZqUrC2GlXCwCdcnL
	N2DA0IaIp1iyTg1jYmseuZKXbSFUvn5SckPgPiCoQoJsfzAE8NIsph9gM40+B+J+4mc95nZZRpJ
	gsgikn4YwRc2Y76Mke8dyAY4kLGBYJK3371UO5ljiU8+zO1G917I2Ff9mnQWMeWv4FRYl/DnfEa
	rpP8VWGXCtJOySazG0G+J2xjfF4TWjUPvA4YZ/Q8hRMoNjsDcpPrjkeeGgabr3RhaJsTRmFz28Z
	Mfm4aV+FM8cLtyzyoKwkLKse6ytHQhcaj6H+IS9umzqaM0I7r8Ak0o7fPNG/if9cXT0TAOMl7J0
	LR7pnWI1VIXdDCRFCSD8LlwyKU12oCjeE0Xui64+R64D+NLhdwcKuvzYarAXeoem93DVo721O8g
	wsTa3kpJ1TLPnjrrMETTAymqf6gs6b07n8O5s5FFOTb4+j2mWExZHFDNeNzH0GNPi1JvbywM3eO
	y96/NLkP9IcZqgYWM3y04mETZYiis4Gb5/SW6R3Sg2+bSzl1
X-Received: by 2002:aa7:d402:0:b0:6a9:8863:ada4 with SMTP id 4fb4d7f45d1cf-6ba1fae103fmr14763271a12.3.1795809784883;
        Fri, 27 Nov 2026 12:03:04 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba6f8fa5b9sm9906969a12.37.2026.11.27.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 12:03:03 -0800 (PST)
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
From: Jerome Brunet <jbrunet@baylibre.com>
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
 linux-pm@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
Date: Fri, 27 Nov 2026 21:02:59 +0100
Message-Id: <179580977968.3028968.220600254133838233.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=438; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=1x7I9OxtWjxbS+wEVDFGimHZA2zKBIWqfRJtzMCbXkE=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNmcD7/5dtokM+ZkaTF6K2ZGVttk1rMrH2fK8un5tvb9D
 fstDRc7SlkYxLgYZMUUWWq4q8XfSWp9mTVd5zbMHFYmkCEMXJwCMJH4Q4wMmxfdaay4eymZS6GK
 Z55007ypBev3ur2PCN636eTcxxoMGYwMv2pstwfXV9w7/0GsKypkd/dKC/bAd4cr1ViY1xxhVqj
 nAgA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On Thu, 19 Nov 2026 14:40:34 +0100, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> This basically reverts commit efa850487a6b6742 ("clk: Inform the core
> about consumer devices").
> 
> This commit added a struct device pointer member to struct clk and a
> parameter to clk_hw_create_clk(), but the new member was never used
> beyond setting.
> 
> [...]

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

-- 
Jerome

