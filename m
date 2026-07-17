Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32C372066
	for <linux-omap@vger.kernel.org>; Fri, 17 Jul 2026 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303343; cv=none; b=TccJ9+vGtawp8RnL+An3aADMW7+nAHXVh+OuwstubRYXWEmMtb8nwtd4zdJ7xma9Uiz0XM8FmvilbIrHVQ1qWyohKyHRQPU2mSD1VICbUyaNs592KFcR1GXK2FMq1n2cOC2Wi+DXhruuvQw7Tg42BcOhMr8p8ecfQVry4N+sSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303343; c=relaxed/simple;
	bh=CdYffOknbQzfYo84GJKwjvjNyEgTmS9hyxrBV2P7e3A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GHydeD4oMospT6mtcGvuPi15vi876YHp5MBE/QmUbgM+B9974jPaZo5WFnaKVYJVLo3eVUoul5AY6nm8Hf6zt0MXYmwN0Jb2lOTCNfnqwi8EEOFxRoOSji9Lc7evkEMUMWwNAAm4GgNIQvJW+3jA2Ye5TVg9aJJXC8zm1Q5T/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J9HcSJMe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J9HcSJMe"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 54E421A1067;
	Fri, 17 Jul 2026 15:49:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 21B8F60361;
	Fri, 17 Jul 2026 15:49:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B32411BD0B3F;
	Fri, 17 Jul 2026 17:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784303339; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uTIIYIE6om+/XCvC1iyGmOlpuExfe0fVOZRcI5zo7h8=;
	b=J9HcSJMeSCGCasvs4WDFZFkm/IB1E5oGJmO4gqwy0hJ2sUwI/WLfMNoG0gVfua1Ge5FiE5
	P3Eb+ObuUQ6rp9BEZaBOvrybhNAaa708GvhI+frpKcJRrswHkINyI0iOY3mZUOCqhypkfD
	2ypwebzxTcvqT7Xk/6bxBiBCr2b5rEi776AtnqZ2kTy5GI5i2lTMYL6RKHPyk8Ggym1qTI
	c0jILYNguwpkCiR5Os7HUchIWOQRMn/SZ9UOdjEkhp+6FL77Drej7/CDmcOCa5rkApcWuA
	zF//gU/3Nxsyjs6JpNJf1kZU8ucYGSPNYWjAQ3zz0Gk3jTb8cnVTivKjjR+JIg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Johan Hovold <johan@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Richard Weinberger <richard@nod.at>, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <901ca5f67bc57219a9222115fabe1a1729b87e25.1784229863.git.ukleinek@kernel.org>
References: <901ca5f67bc57219a9222115fabe1a1729b87e25.1784229863.git.ukleinek@kernel.org>
Subject: Re: [PATCH] mtd: nand-omap2: Move omap_nand_ids[] to raw nand
 driver
Message-Id: <178430333794.4128272.17925627795201974759.b4-ty@bootlin.com>
Date: Fri, 17 Jul 2026 17:48:57 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 16 Jul 2026 21:25:23 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Defining a static array in a header results in each .c file that
> includes the header (here: drivers/memory/omap-gpmc.c and
> drivers/mtd/nand/raw/omap2.c) to contain a copy of that array when
> compiled to an object file.
> 
> With sizeof(struct of_device_id[3]) ≥ 588 having omap_nand_ids[] twice
> just to do two string comparisons is quite some bloat. So move
> omap_nand_ids[] to the nand driver which actually needs that array for
> its module meta data and do the compatible check by hand.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: nand-omap2: Move omap_nand_ids[] to raw nand driver
      commit: f97bdc8ec1dc7b33781a702eeba55326c206be56

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

