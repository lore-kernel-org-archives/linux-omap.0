Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888580;
	b=s8+ZRCvWDxp+KKLYKlrDMQDJh2LCJtyewGt2vQEeKP23F3MF15SKoKJsU7ZXoIF9NIIV
	 8ZUqmKevQV7j07wCE+PXpFCDtAxFswjovZucVsRfm74p+OzJ2n+TqCbepb4KJrhfVCVUX
	 ap/nlhVcyKDGV3ywrQas4Igy2s8RMa3Q/E+l96H8FAdsT2Rv0Z2owltCrphJIP4trFsBU
	 MpeJq7Z+hOwK1PPwdxVEViJ8a6qKcl0vnk75s4r7hfmjDaT4hsl9q0p8FmhQ+WUEdJpN9
	 2YF4pX1Hw5zgqU1RCSG6Z35p7qNcraj/moIg7uZgF7pqIClwjsf59YNEn+88WzI1C2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888580;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=fr/sToHFkpF9BPihxA953uG8doO1fE0lFSHPRxWhDoE=;
	b=U7Dh5zbJaSE4+k8E3AAl7dpNXC+IqrGNusY7aXFwOLic5YlfeCYwpH/fJAQNEiwfcims
	 Mhwo/uYdR48Anp3oqCgUfIQ/YpcSHP3pGNAc9rSYOya8NjZKi/pCkCQ3f57ivDGQzr4Ab
	 RiyZqq2287FUKRD0lboHVBk4lTlmwOg3elQesYxsNPc0tfadcb3Djtj6i3a/InDPZQVeg
	 BzLfPP/cQgOJv1NPlirf6m1erZZrKiZTafImpiYsle1PHSNfQcjWd8ZGGkgE8Z8pTSDZu
	 HOnmYN+ZghZFfa6Xp7fRhWigDsO6idZBBgSvGES/7IasXIHNQ5/Da6+962OOoZXmvOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kqUQNpzO;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C548606A326;
	Thu,  5 Nov 2026 14:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C548606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kqUQNpzO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793888580; x=1825424580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8aE99+VJcMQQ2lFtFNMEVuo+WAHaGpOaIlVw0wUkjj8=;
  b=kqUQNpzOAFCaYDSHcp8Wj4WmpoX3nJS4a+Kgf73h8jtx535iIXYYaWOe
   K0Ea57swpZPo5j8bLuVT7bTDYB4F+f0tuwUQH4ZC99CXKTnfsFDX5TXY/
   i6xUcn5URrVaHkYLilXDyz909mDABgqMSPSqwyt9RxltWwqH0JvaREGZX
   Ofz5IGRm296N/vS+3rBNBIhX/rQ4IfGN4Uy7pR6YI8GSgrLaksPFXeES8
   KU9Dr+YOg76ZZmPaFzwIFGav1dnKbeabAUU7RzNkIgXYEpEPxT85n/Ebe
   bct31QF/JCTlCuG/1Mod9N6tbDgiVUZCYJf6T/+vjf7AaH8uVllOkmbT5
   g==;
X-CSE-ConnectionGUID: 1l10Jx00QbyIWqho+oNmdA==
X-CSE-MsgGUID: dc6UTu26R/qspd0UlFgWQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2703073"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2703073"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:22:59 -0800
X-CSE-ConnectionGUID: /K275MsMS2iu65atWdhLvw==
X-CSE-MsgGUID: RsKg5am+RfCPmB5pvRDPCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7192371"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:22:47 -0800
Date: Thu, 5 Nov 2026 16:22:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-hwmon@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org,
	asahi@lists.linux.dev, linux-mediatek@lists.infradead.org,
	openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Michael Buesch <m@bues.ch>, William Breathitt Gray <wbg@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 00/23] gpio: Improvements around device-id arrays
Message-ID: <auyRNagFOmxf_3nW@ashevche-desk.local>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
 <2hfpcbk6r56vvhkqyiex2apl3pinieybad5sd3vkvvabqs3uto@lydt3gin5kxe>
 <auxh9PxpJScFO3i2@monoceros>
 <le5gbua6s2mhhv32di4j77qr2we5z5ngzyzmiemhodmblvjiji@q4wf5tdgrbtv>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <le5gbua6s2mhhv32di4j77qr2we5z5ngzyzmiemhodmblvjiji@q4wf5tdgrbtv>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 01:25:34PM +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 05, 2026 at 12:06:33PM +0100, Uwe Kleine-König (The Capable Hub) wrote:
> > 
> > Maybe you just need to add `-3` to your workflow? ISTR this should be
> > the default for b4, but it seems if failed to mention the -3 in the git
> > am cmdline.
> > 
> > Should I still resend?
> 
> No, it's alright. I would have preferred a clean b4 shazam but that
> works too, thanks.

To make that one should really have a unbiased base with the gpio/for-next,
say v7.4-rc1. Then with --base present `b4 shazam` should follow that.

-- 
With Best Regards,
Andy Shevchenko


