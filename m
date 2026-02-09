Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC26636CDF3
	for <linux-omap@vger.kernel.org>; Mon,  9 Feb 2026 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635698; cv=none; b=GD1i96Nc7LIMAa58mYf1+xnyn2m+vzXqvF1JGueD9mljn4+7vynACz7I3PlsW34raKGH5DWuNLk6GOSGiNoXOFp8HoB6U7bI0CQRncxQ1jpoq4M9aI8zp8YObvBLMILugJ0wv76iRMA19YLXVihyZjdLY5qK1+AWPO5+hKmq/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635698; c=relaxed/simple;
	bh=OVdS08gW0bB1ClYIfSFtOyc9cg1QAZlOhyvl9iZaeXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZfg/Mh++kfFFfwb+qm9RPDFHZPEz7JAZQh6mpM9hx3R2Et1403qU9t/uMMndv+BurgrrXuTn/d2iulXy2YfH+Bkm1oWaxtorKdehSluKZ3T+u2GVO+12gh7O8jsV16krh1rt7z6V6uSC25ngsrU/K0LaaZItbaUHEtbmbjYrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=k8VPT7hv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="k8VPT7hv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=hyJp
	fMLiM1wKpMBA2O+7vpAMxxFPZoy9mfo7m5xJgDI=; b=k8VPT7hvskJ17pNTGk/p
	OMUecbFTEQv8Q3W4Co99Lq0BZhs/NomreXe6Xrlxk2T42voNhbTUQl1jNoHJns8j
	ehXryUyaUi3lJ+B4WVkq3K9s8XVt6QJlmVYeD4ngmlSojEp7lsJ/PLJsF4MsKDNj
	bEve9pBnnmEn2pnjaOVhCUjCSXae0BJZYfhm7nu05rYE1vYq6Qh4hrmR9COFayUX
	1YhnGJcKfaoMR00FaNv1ZG+r8cg5D2kUGIF2gBX+fqnYI2l0XrEAhOtfOgFIvAIG
	0eybVyRgjShP2dHKMGSbwAQmGYaTB9ay5AXzTWOeEqOVDh94mir23iNibMod6Z+J
	Nw==
Received: (qmail 1143365 invoked from network); 9 Feb 2026 12:14:53 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Feb 2026 12:14:53 +0100
X-UD-Smtp-Session: l3s3148p1@2nmBP2JKPNgujnuv
Date: Mon, 9 Feb 2026 12:14:52 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-renesas-soc@vger.kernel.org,
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
Message-ID: <aYnBrN0JRCf9-UjB@ninjato>
References: <20260125184654.17843-6-wsa+renesas@sang-engineering.com>
 <aXc7DxsqiCGdfzxi@smile.fi.intel.com>
 <aXc-Zxw05XQLb1Dy@ninjato>
 <aXdAB2bLTy6u8G8c@smile.fi.intel.com>
 <aXdCBu6kzdw1NWay@ninjato>
 <aXikZ5wc6bvgRqF6@ninjato>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXikZ5wc6bvgRqF6@ninjato>

Hi Bjorn, Baolin Wang,

> > > > Providers need it, especially the 'priv' member. Consumers won't see it.
> > > 
> > > But can't we make it opaque?
> > > 
> > > We may have getters and setters for the priv member...
> > 
> > I think we could do that.
> > 
> > Two drivers use the bank member, but only for the device
> > (lock->bank->dev). That can probably be refactored away, I'd guess.
> 
> I am willing to develop this series in the above direction. Before
> though, I'd like to know from hwspinlock maintainers if they agree to
> this refactoring in general.

Moving maintainers from CC to To ;) Do you, in general, approve this
change to the headers? I think it is more modern and e.g. the mailbox
subsystem has a similar structure, a header for the client and a header
for the controller. And do you also prefer an opaque 'priv' member?

Happy hacking,

   Wolfram

