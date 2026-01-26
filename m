Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD29A329E49;
	Mon, 26 Jan 2026 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421603; cv=none; b=f5TTxjw1zFP4xgyUhEkICwuk8Vivt/LOkHaVxUmEFWq+8jnqFXoCQw9+AQ9YL22ppn2cYoH6xQ9vJ/7V5m9J7NQaQyxKSCmd7dtAur6ynGtIhYjQx7vxc+EbIpPE1zjzo6w73jc6tdTba2y1qi7B0V1NCaRhk3mCPHPzG4hm/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421603; c=relaxed/simple;
	bh=8+66ynW/UosBvC/E+PZZmULkSUQHS1YNGDIGs4shhqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdf9+TAoWpIk49DpS7cfNTCLBKzzquI+QiPS+2PTAYY+MZ7nmjMtN8tMpeQoLWjGF+eOaDV6GQhXMyfqmhKjrLSvjQjSLHrxzmnl7biwqmBbWPxfva7seZUc+3ZXSxJUA3hTL38d4NNvZ43ykogIiM6uoq2MfDfI2x0P7AAoWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmTer1ie; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmTer1ie"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769421601; x=1800957601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8+66ynW/UosBvC/E+PZZmULkSUQHS1YNGDIGs4shhqw=;
  b=NmTer1ieWlIOpTqEXaCTGgZnw9ZQIPsQJuCT/9TAvZLDhOVPiWmb4mP5
   5qhmuU+nkBIbTt0wFvZXw/NDEPUJxxd2W5EUI1F3Fb3VQ5pOzri1Nf1H4
   LE2u9+fCmG329hDGdp//fXII7iWOtpxY3Fet7vE+0nOVt26zABq//VZzq
   zHT6O5NSpPB/E+QKfrlZBmk4VHstnxpXK8aujzLbLJlKwMKKnqdH/24Ni
   m42psYQKb7w4zZA4AeaW6QJC2lequ7yxtE6vOoKyUAvbAstLaXVrX16xx
   m+sesm6wT4CbTzeqsfGaOxAeCw2UqFfs34DZDZmuIhb+AcxglBJ7L3IQD
   w==;
X-CSE-ConnectionGUID: WhTd4SGrTlyoerr4iIgAVg==
X-CSE-MsgGUID: k9B5vsF5RLKF7qsj6uSZxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="73183351"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="73183351"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:59:55 -0800
X-CSE-ConnectionGUID: XFLH6wX1QCeVh2rWVMlKBw==
X-CSE-MsgGUID: lTttj+paRWeICoj+PaAr/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="212501718"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:59:46 -0800
Date: Mon, 26 Jan 2026 11:59:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Waiman Long <longman@redhat.com>,
	Wilken Gottwalt <wilken.gottwalt@posteo.net>,
	Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 0/4] hwspinlock: refactor headers into public
 provider/consumer pair
Message-ID: <aXc7DxsqiCGdfzxi@smile.fi.intel.com>
References: <20260125184654.17843-6-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125184654.17843-6-wsa+renesas@sang-engineering.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jan 25, 2026 at 07:46:51PM +0100, Wolfram Sang wrote:
> TLDR: I want to create a hwspinlock provider outside of the hwspinlock
> directory. So, I refactored the headers into a provider/consumer pair.
> Which seems to me like a reasonable seperation anyhow. No functional
> changes. My build tests went fine and buildbots are happy, too.
> 
> Longer explanation:
> 
> There is a device (MFIS) in newer Renesas SoCs which combines various
> things like hwspinlocks, mailboxes and other stuff. Sadly, these are not
> strictly separated. Registers are kind of mixed and its register
> unprotection scheme will need one of its own locks. I tried various
> paths to handle this device (MFD, auxiliary bus) but I concluded that
> the sub-device dependencies give enough reasons for a single driver in
> drivers/soc/. So, this series will allow me to instantiate a hwspinlock
> provider from the other directory.
> 
> Patches 1+2 do the actual refactoring with a fallback being in place. I
> used '-B' with git-format-patch in this RFC, so the actual changes are
> more visible when the headers are moved.
> 
> Patch 3 converts all the users. There are not many. We could try to get
> all the acks for this single patch. Or I can break it into single
> patches and send them to subsystems. I don't mind.
> 
> Patch 4 simply removes the fallback.
> 
> Looking forward to comments on this approach. If the hwspinlock
> maintainers like it as is, I would kindly propose to apply patches 1+2
> after 7.0-rc1 comes out. This might sound a bit hasty, but a) I want to
> avoid chasing a moving target and b) this would remove one dependency of
> the hwspinlock driver I originally intend to upstream, of course.
> 
> I would take care of patches 3+4 as needed.
> 
> A branch can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/hwspinlock/refactor-includes
> 
> Patches are based on linux-next as of 2026-01-21.
> 
> Opinions?

I don't like the idea of sharing internal stuff. Why would we need to have
a struct hwspinlock to be visible?

-- 
With Best Regards,
Andy Shevchenko


