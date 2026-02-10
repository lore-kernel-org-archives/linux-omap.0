Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F4342144
	for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720272; cv=none; b=PFbK4ESI9YhyzVWfoy+0fg+hCn43viEHuRyQObeuiUvFYj+uK+kq/1pz2Y67/y/hcTOn6TxJ+46aIHO4ve6yKC4m28Dgd2yqT6SxZOY2fP1k/zXCk7jpGpxeRPpYuoXOsLfFt53tXph5PGWmb5YvQ64eMfBXnnqNXleN6ub4WoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720272; c=relaxed/simple;
	bh=kKRt1VDf6faQ+Z3AusG7TiXDalebbQps7t3bNPdqgpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB3FLfcvlBvKEHtmM91oJ5rMenXnZ2/shYOsEsG7jmvTtAoKtTb0KoodOu7a17UVuTv9ckvms5IWaer53HMIBz5wSJZscQTtfeeM3pAMv1s6Uhn9kXEHyHe+lSAP6/uM+fwg6rMteXft8ADo4nZJcv6F0Uq1TApkfmSvRe15Jy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Ygj+nx5z; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Ygj+nx5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=VtWN
	b7NUdO5bUCDMyQfroR5tgGFvHUsvicqnxM22+PI=; b=Ygj+nx5zicnCg4B/9Jjo
	ymkrXvds95xu+rHV423jWbmfMbIgr2ZgCTevfkAnWZ8IARilWWLpa4CK/wQVXM5x
	4w0A8FpsGIvoAQxpkqhXdmYRN0qT43xKzlQ1ykfgou4qtX6Lg9tcBT3ocv3L+8df
	n1pLf99ijj7d7hTzrn6bF6m7LtzBNM6u1fdqNKGnt5N+oJAYY99m8k/tzSvDYlQ4
	ieOIPOpbfZEiorpZhGkdg4dr/vXBFAROteKjLAN1o94Fw3Oi3TQpMAt45wXG+YrD
	sAp2VOd6rjRXGob9dobJIE+8tFEqCG9UtOAVzHE/ajBCVdIrcAnKfoW+0CsOnkMh
	kQ==
Received: (qmail 345109 invoked from network); 10 Feb 2026 11:44:25 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Feb 2026 11:44:25 +0100
X-UD-Smtp-Session: l3s3148p1@zQVt8HVKEroujnuT
Date: Tue, 10 Feb 2026 11:44:25 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-renesas-soc@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
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
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
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
Message-ID: <aYsMCVf1qpLSCXTs@shikoro>
References: <20260125184654.17843-6-wsa+renesas@sang-engineering.com>
 <aXc7DxsqiCGdfzxi@smile.fi.intel.com>
 <aXc-Zxw05XQLb1Dy@ninjato>
 <aXdAB2bLTy6u8G8c@smile.fi.intel.com>
 <aXdCBu6kzdw1NWay@ninjato>
 <aXikZ5wc6bvgRqF6@ninjato>
 <aYnBrN0JRCf9-UjB@ninjato>
 <yl4bbbev7lgrmnqys2izkolo5egzg24faukvqar5eh26q5ra7p@42rcegfpqqt6>
 <aYo60vooftdem4Lt@ninjato>
 <aYrcVE9HsDNAwqIB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYrcVE9HsDNAwqIB@smile.fi.intel.com>

Hi Andy,

> > And if so, would be this series acceptable
> > as-is then (modulo the better include-sorting mentioned by Andy)?
> 
> *From my experience it's not the Q "will they or not?", the Q is "when?"
>  they start abusing it. I really prefer to hide as much as possible from

I totally agree with you on that.

>  day 1. Maybe the structure can be split to two? Currently IIO has a

I also thought that keeping some internal header might provide that
safety. When looking into it, I didn't see an obvious and somewhat
elegant way. Even more, I got a better picture of why Bjorn named the
current approach "unergonomic". I got some ideas which look doable in my
time frame. I will try going the full route, after all.

I'll start with some cleanup in some minutes.

Happy hacking,

   Wolfram

