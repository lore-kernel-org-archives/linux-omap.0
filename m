Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7843A7D9E;
	Wed, 15 Jul 2026 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141925; cv=none; b=jBkK6uRSr5ikJnpO5AJzDPYNacI/PT7Pyp7ZVTEbaGgJpDHDmOHXcvpeNWfl0+wmJhB3c+nvgmSWZneWjiJfC0FlwTVbfC2/1qJR/6Ohp+QaO7odRxAMwuWOVvPMgHtC5nz4gWxT1gQPMZnug3Kn4OxCdU3eY5Mw9pmkYEKZ4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141925; c=relaxed/simple;
	bh=o1wdb3hvZg8Mwx/nf5Q5Kz1h9rVn80wGsO8ZhPlCSqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzyIhloKsu3XgdTsSlWBELjrqkWqm8brC0IGN0hxE6z5y6YDqGIeUwn5EgsNNGglKTeWxFgM+Fb0gZyD6r+pO54ERW+ZY2ZctE8+MeDznXuIh/oD/NbDM3Y5q6cI2qrYqWwEk5DRdUu6lAhH8EC7OQ77bDdk/XEqv7ls5xceVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/Hbkcke; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/Hbkcke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784141922; x=1815677922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o1wdb3hvZg8Mwx/nf5Q5Kz1h9rVn80wGsO8ZhPlCSqA=;
  b=n/HbkckensbobOzm7FcgRY5B/EIJXpWbPY7XMHVrTdI5Bag3fD5KFM/M
   rYY5MXH2u6rDULz8of0eOz9mTiWx/NvlhaHH9U+vQdo3WLL3Eg5USG5PR
   kjz4Wq5RmqtDzd8td4lKfn9YGlm/pz5TRMX1uwt5BBsWq6NOWnI5PJ2gM
   QAg8nUhG2/zPV8AZ+S4PXDTspYjrIi5fBra8DFp45eE7jwmldUzE4FPNC
   jJoU/EoG3kIekm++PXZVYZg2MSUDs14qOFDmaN0IqTTCxPB0Sf7++VzLT
   B/3WVNffEetl/HSKSuA2442pj469CoAE8+t7gv9xik+EOT4QZ3aOLzwAd
   A==;
X-CSE-ConnectionGUID: YBTg6K9ZSzefdbahi2FzjA==
X-CSE-MsgGUID: Krh71h4vRoiVHTdsc4T49A==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84834934"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="84834934"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 11:58:31 -0700
X-CSE-ConnectionGUID: 49XMinnBQ1q16eL0jxD8dg==
X-CSE-MsgGUID: kjqxmeOcQsKaDHlmEkIC5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="253661823"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 11:58:10 -0700
Date: Wed, 15 Jul 2026 21:58:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	"Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	Kalyani Akula <kalyani.akula@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Joshua Kinard <linux@kumba.dev>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	Salah Triki <salah.triki@gmail.com>, Yury Norov <ynorov@nvidia.com>,
	David Carlier <devnexen@gmail.com>,
	Achim Gratz <Achim.Gratz@stromeko.de>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Patrick Wicki <patrick.wicki@siemens.com>,
	Markus Heidelberg <m.heidelberg@cab.de>,
	Markus Perkins <markus@notsyncing.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
	Chen Ni <nichen@iscas.ac.cn>, Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-omap@vger.kernel.org, mfd@lists.linux.dev,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/8] nvmem: core: make reg_write() take a const void *
Message-ID: <alfYQP4a1U9pI6UR@ashevche-desk.local>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
 <20260715175229.24672-2-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715175229.24672-2-linkmauve@linkmauve.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 07:52:17PM +0200, Link Mauve wrote:
> This callback used to take a mutable void * for no reason, this was
> found while drafting the Rust abstraction.

I don't understand how it was compiled. const void * != void * in C and can't
be implicitly covered, if I am not mistaken. So, this patch heavily should
break the build. What did I miss?

-- 
With Best Regards,
Andy Shevchenko


