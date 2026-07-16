Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6B3F39CA;
	Thu, 16 Jul 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223858; cv=none; b=ofCwsl1UJz+Ua/5/8zUxUX0BRJLGkgiq9CTL9XiGyuA28ZEce8XBuU7TjZc38/MVIcBa8Ok9mNmOmZ5ad7Mo3SR9qMGnekKeDTytAI+zdz4rxPhdW2T1jN+hxrLVL09PPUuJkmzlWbJQ9cmFqaTlmrHwTjEJ6eXlRg8DIsk+OH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223858; c=relaxed/simple;
	bh=jR5j9NUUUDWrKfOXsM73JV6fyT1VqUxtuhsCIIn6jKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq7rnB6583hxcRDYrDiE19b0KqXCX0bfNIiDqziOz+Lo8A4vsEMa7JPBlkNI8ihsEP/HRY/sx2jgaq6+HpIsoSPPz7+ChSdrIVdi1ru4O+2q6APNqphV3L2UGxs8ruZJRlO9k744Mckz+LTGKRZWZviija5ZtaoAqqnvpnl656g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBFu8dIS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBFu8dIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784223857; x=1815759857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jR5j9NUUUDWrKfOXsM73JV6fyT1VqUxtuhsCIIn6jKM=;
  b=PBFu8dIS6lPrXKqPR/f3wVgD/fhR/CvWS2WZCTQBLoRRwd8XNeuipGrM
   LAxkimcOd3KMvfSEAM1uhZViALQHUf+8J4QeGf8ZVoPFFvEoT68WSbXzD
   0oYTFW8Ag3RDbzHC8e2PGyET9EfpQIFbQTS8pQuRHmC+srczE5qMto14R
   sb38PpvblsL1RIlgSopAA9u/cIEHZmPQ+Fkvv5BNTMP+UsfyXFdMjKDNg
   ox1dTQgiJ0R34AKrdmDJc6V48uuMYDjNl432gauZAGY9TUktL1ZNiWNku
   Lz03fiSonJs0fY6X3hFGvVm2Spyb7rW4C6LLbKlJnk1eNKs9KkyhNsaR1
   w==;
X-CSE-ConnectionGUID: /RpLniRTTC+vhxHSYO9vew==
X-CSE-MsgGUID: I98l0juhTWevECEuCp28EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="83877238"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="83877238"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:44:15 -0700
X-CSE-ConnectionGUID: aMxhVdAuQT2VWNRoxPa/nw==
X-CSE-MsgGUID: NDeukz9TQ02LlIOQEavzaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="256023287"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:43:55 -0700
Date: Thu, 16 Jul 2026 20:43:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@openwrt.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Alban Bedel <albeu@free.fr>,
	James Cowgill <james.cowgill@blaize.com>,
	Matt Redfearn <matt.redfearn@blaize.com>,
	Neil Jones <neil.jones@blaize.com>,
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>,
	Doug Berger <opendmb@gmail.com>, Keerthy <j-keerthy@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Bamvor Jian Zhang <bamv2005@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Michael Walle <mwalle@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org,
	asahi@lists.linux.dev, linux-mediatek@lists.infradead.org,
	openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Michael Buesch <m@bues.ch>, William Breathitt Gray <wbg@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 00/21] gpio: Improvements around device-id arrays
Message-ID: <alkYWcuMsfE5jkLR@ashevche-desk.local>
References: <cover.1784133987.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1784133987.git.u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 06:55:05PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> as with v1 the original motivation for this series are the patches that
> convert the arrays to use named initializers, see
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> for the idea behind it. Then by not closing the eyes for small issues
> spotted while working on that, this series grew a bit.
> 
> Changes since v1 (available at
> https://lore.kernel.org/linux-kernel/cover.1784013063.git.u.kleine-koenig@baylibre.com):

Sorry, but at first glance it seems this version is messed up.
I'm not going to look into it deeply, waiting for *carefully*
checked v3...

-- 
With Best Regards,
Andy Shevchenko


