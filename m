Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB83F12D6;
	Mon, 20 Jul 2026 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545518; cv=none; b=e5EkQ41sOFzzeQKTuZTIttTFoEK5cWvTb6DnANzSU3YJBLc3JIV6653vY+6OQAG94NIEEp1BhMU23fWnGzz8IhlzxOfHX/lWgIBmlzuCYWMQJ3z/deZ+pvjMUgbbwwa6wdHDJfcQYG7EvJtZQhVBATuWz1f8fVqixxQNoUtUutI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545518; c=relaxed/simple;
	bh=cgrVbqvHirhm8/ft9p1L7cLcou2SKIvhDcqiCnRwQmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=punmFMMeBHxQkPwzXOpK7eXZBNWam2GpBTlxpy3PVyA2HUONTsmyVIC+DoRXeENoVjyO/M7lXnxpsixrW13XDdQW7UYXL+SFQpaha9iH6lPsEQQW8ulOSPVaVVWy1hNmc4m0yk/kdHszyoO1DHbY0MDEC6j4n94jGLDY2x42kCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbQhZmNX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbQhZmNX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784545514; x=1816081514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cgrVbqvHirhm8/ft9p1L7cLcou2SKIvhDcqiCnRwQmo=;
  b=TbQhZmNXGDXG+x1MU/a/q0WQHGGiMkzyvVPB1eMw77COylZi4l5U1J3H
   nIRyiXtIU5egjnG+FJ5DVKpwWyRwBvIzXomQtQkUkpgUj/GjAG07T71jg
   jv8fX85x5V05GmleSHOVj+HX39FRUVdm24LJT4J4PJDAxHv6hyOBsaM/U
   B4xs5XhQMlwU4eFL2X8kQptSr3o/DMhdm3vTes+fPtIi2ice59juiU3rU
   vIwgtd/nO+WEsnWpHj9X99p/MrD4ndtHUUh4SJpW/vLoqK76ZwT4AKXhs
   pTA+AlXMv1D15OzK2eRyCHBxdkvFUADtJDAt9EblpTikIUJmHKCNQlB5e
   w==;
X-CSE-ConnectionGUID: alarHK8ZQKuVwJmkgWw3fg==
X-CSE-MsgGUID: stUzc/8hToa9fNY0A2WWJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="84106768"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="84106768"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:05:09 -0700
X-CSE-ConnectionGUID: b65oAi9yQSiq7NfKO+hA7Q==
X-CSE-MsgGUID: BER5zIsIRdezir+MK+zDWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="254815588"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.94])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:05:01 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id D5319121C2B;
	Mon, 20 Jul 2026 14:05:03 +0300 (EEST)
Date: Mon, 20 Jul 2026 14:05:03 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: johannes.goede@oss.qualcomm.com
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Srinivas Kandagatla <srini@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
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
Subject: Re: [PATCH 8/8] media: ov2740: remove NULL reg_write callback
Message-ID: <al4A3wmBCrCy_HDs@kekkonen.localdomain>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
 <20260715175229.24672-9-linkmauve@linkmauve.fr>
 <al3sxMUgeK49dwNs@kekkonen.localdomain>
 <8d86ca46-d329-4e65-a7bf-2b79fccddf05@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d86ca46-d329-4e65-a7bf-2b79fccddf05@oss.qualcomm.com>

Hi Hans,

On Mon, Jul 20, 2026 at 12:34:10PM +0200, johannes.goede@oss.qualcomm.com wrote:
> Hi Sakari,
> 
> On 20-Jul-26 11:39, Sakari Ailus wrote:
> > Hi,
> > 
> > On Wed, Jul 15, 2026 at 07:52:24PM +0200, Link Mauve wrote:
> >> This field is already initialized to NULL, so there is no reason to
> >> write it again.
> >>
> >> This prevents it from appearing while grepping for reg_write in the
> >> future.
> >>
> >> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> > 
> > I believe we need a real name here.
> 
> We don't need a real name / official name here, just a "known identity",
> IOW not "anonoymous1234" since Link has clearly is using Link Mauve as
> their internet identity (given they went through the trouble of
> registering it as a domain) I believe the S-o-b here is fine as is.
> 
> See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
> where the "real name" policy was weakened to "known identity".

Ack, thanks for pointing that out!

-- 
Regards,

Sakari Ailus
