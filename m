Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7876025
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915344; cv=none; b=CD5g/11hMhn8tGe6spiZCh2DxFymQPQ5L5tOCmSauzldBM6smPk52Q8en6uPHZ5+zKD6wL3Z9lRN20vOE/XXQSYLtXKVvs0oyxe6GqzASSuOpzLJA0WOLXYEVuRGw0Nk4Jr1zkaLRQvPKZmjue1gdn6oq7cF/xSiLhaqlTLoHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915344; c=relaxed/simple;
	bh=BYIrBpMJQWQHkNBd33MWbGOnLThZyq9ymxlrpIvZAak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSyAH99r/MDyR9PfrNvQSTOfiLavr37mKOO+vZwyJBq/xaFbJVKSlRh1dogXm3NVp4GDNqc8W6rJJ7wLkj50yEs2PctvKB1Ssch2upGf/yVA23ch4c1NdlAXYk+IbWmHVP0CDVUHG56m1SY/7QnNADaByo0W78CryhgSZCUqiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yf1Xjk7g; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yf1Xjk7g"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2B5E0C23DA8;
	Thu, 12 Feb 2026 16:55:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBAF7606B8;
	Thu, 12 Feb 2026 16:55:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7559E103682C4;
	Thu, 12 Feb 2026 17:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770915338; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BYIrBpMJQWQHkNBd33MWbGOnLThZyq9ymxlrpIvZAak=;
	b=Yf1Xjk7gSmzJVkIbmTlz0maKJ4nRF74WIw0ge8IXTs0sXCJ048Hjc2C8Xpxhy6Xs7llVMO
	OaHq77LpRZtYrnyFxOpgaCS5Lm1PhxqTs31e7N+VVV2E0YDQfa8+47pN70ibUZGgOuhEW4
	UtC3/YZuRU2nXfOxQ8UtC4maEThd9+N4dyzaB/z9hA3x201t2msIlotYSsQX+3yIeyq8mV
	Ak+ZQcXVBgpflKOg8E+aWZbhzGctaQc3PN5PYhKybWBc1JiOB0rnQpZ5cg1WaUDaE4aCNV
	pV3DYfpBZctKndkpEtD15fKhZyjjr4MSeDykZj3X8EoCOI+T+jnzLgnAiUlCAg==
Date: Thu, 12 Feb 2026 17:55:32 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Louis
 Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH 1/5] ARM: dts: ti: Enable overlays for all DTB files
Message-ID: <20260212175532.0e9bb107@kmaincent-XPS-13-7390>
In-Reply-To: <bfe9f164-ac90-4647-b194-2f9b2fef2901@kernel.org>
References: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
	<20260212-feature_bbge-v1-1-29014a212f35@bootlin.com>
	<bfe9f164-ac90-4647-b194-2f9b2fef2901@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 12 Feb 2026 16:42:12 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 12/02/2026 16:26, Kory Maincent (TI) wrote:
> > Allow overlays to be applied to any DTB. This adds around ~40% to the
> > total size of the DTB files on average.
> >=20
> > Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
> > --
> >=20
> > Enable overlays for all dtb similarly to what has been done for arch64
> > TI boards, but we could only enable overlays for Beagle Bone and
> > variant boards if required. =20
>=20
> You mixed changelog with commit with invalid separator thus there is no
> final SoB.

Arf forgot one '-'. Sorry for that.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
