Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866687;
	b=xQA5FgFrOr6UBbSz5/cn6RNIe6nhyjiteWoZNRDuBWH4Q3Tywea98Ktrk8+4SgOV0Wgf
	 BADmc27n2W+Wu9gKnwGxdtURibgaGLNAAlFXgea/BEpMza8dpeavF2M4/UNDYlb20qHyf
	 G58+iscvkHFBnZKWdL7N8z0pN8N0+eQJXqDtHEY0YM7ZHc40DV84940hImdphWCm9TupH
	 uVYhUUIt3/nfBUxf6MA8rOBOghB+gqIyuCWMY2t9nG4vlgwa8700uUqOl5uGz9MnhlIC9
	 MJ0LJaSzY8Ce7RuNsJZ+Z5/9WCgKYmcUCPAuidlBGukBPKPXa1JnxcKPbgU4nY7ykdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866687;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TugPtM8jOK84jPf/Xqe5A1M/W5MRVkYlZUyQ33BYgdI=;
	b=VSeg0Hacnh8QB25TVI1UKpFlPutzDbUBCEM0A7uu4WlppbwVlZ11iT421poaA6lNleL5
	 t+moSWq1jR6ZD4nVCzp3DTGdayJkUC0jbwLqAXLqiLjCsCmHGXngeXY3GeREpVBcjMjo5
	 fjwNjoVJcTFdJ0k6Zg+taBfqf+JfO2KXO4kDYXQc+3lsu+sko7js4KFbSVu1qXqmxmbFG
	 0tDGgThVzYJzBkB9YgOvQrw/1PSNNEsBRyPyESp2DhAInD9ILQJMUHAc2r00Ql7P36mm+
	 goH6KAjn1F77kXPucAryqusVbQUwMImXW/8U9G+G9niO39aaze/Vj5OFWYdcw8X0eOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF4606A331
	for <linux-omap@vger.kernel.org>; Thu,  5 Nov 2026 08:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50FF4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=TugP
	tM8jOK84jPf/Xqe5A1M/W5MRVkYlZUyQ33BYgdI=; b=HP/f7wwzeKak7DumDLO9
	JVt1nbyuIbwEvmWLzblXwUa9fHA8QGq/qxdkiPvBnBdfWzA7DAKYuMswXIwiGZeI
	sifdTdpHrbkKn2cfjYz+DCejquVIc2HcrJkCdWGnfn8w8sRDZ67QMqoOAo9TyxhB
	2IGsFIsOlY5lsG4S5en4FiChy1bAl3F+ottavwgE+82fwoOAPf5WA+FMOpT3R+BF
	2KLvEAZIieAkmGBbXuYWFATGrKMGTrlv0ozHqnmpmuhSBEaBniPtSpneDXSHcEQ5
	+WhVic7v8nyGM71Z5AdhJHNCzaKZIUIrLqqcAbo4a+eEyXeofMd09ZE2E48Fpmp2
	wQ==
Received: (qmail 1062996 invoked from network); 5 Nov 2026 09:17:54 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Nov 2026 09:17:54 +0100
X-UD-Smtp-Session: l3s3148p1@cWDgIYNfIIHAwtcC
Date: Thu, 5 Nov 2026 10:17:53 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Vignesh R <vigneshr@ti.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linusw@kernel.org>, linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-omap@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] i2c: Convert to subsys_platform_driver()
Message-ID: <auw7sUcbOOG8umVu@shikoro>
References: <20261104113316.1634141-1-peng.fan@oss.nxp.com>
 <93534aaf-00f3-45f4-982e-7fd44ab3799c@kernel.org>
 <auuXnndiQOkEaOsj@ashevche-desk.local>
 <c6664dd8-871e-4b38-8017-d4c1a02fd36e@kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6664dd8-871e-4b38-8017-d4c1a02fd36e@kernel.org>


> I'll send v2 of my patch for submitting patches mentioning this syntax.

Please CC me because I would like to ack it (or review? ;))

