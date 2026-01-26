Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6077330D26
	for <linux-omap@vger.kernel.org>; Mon, 26 Jan 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423375; cv=none; b=j53vVHdLSp76pDG1gzk5g6wRFZwf7ihDqD+xDKFY6/brPpByfpzkV0qlu2x8sMR0M63+adgU4bnxuLYUYaCz1Z7D+gF75/cIjvCVDON5mEwV/E/xy1YjTzvGoGM6181uAwOo4UmDllSlA8wWDvQbZkG/hawISpWDHcUvXNbyAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423375; c=relaxed/simple;
	bh=Jh9DbPdyhqX1cvGDcyHJMZub+1uUsIMf6B/WAv++Rbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b38HJeE/D/euWUWBZKLBfGy2lDY5u37H9z9POJg+mzMmUiacrQNdyn50QZ5AsiyOpd5C9WhN2A2xyQa2MPCWNE0EtB/8/+2GIpQjAOMqqjN1HmzrtPTW28F172/7Co9Kz6v8poy9RPfDaZ6PqbkOj0qMjhTAuD+VXfxBpeJQCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jHX8+Wl7; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jHX8+Wl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=F2bF
	S/uMFLgtEVC0YCnMXZC86wb3SDlDFVJk5gHDbHs=; b=jHX8+Wl7CjOEdsajEoyd
	YLJSni1KMKFnTnF6HUkKy4i7hdARKm53juZzr7ZafJR47rtHoNyWJaaKdHJ/2sso
	LqYQH5W3d0RaRaQ8Q8J1G9u4nNTashMNVexC1gLUhUwVMKjdwdx0vBnOcNj2BbqO
	OzdLxlpS3qYwey2EMbughKgdVpyf2lbwjuTyiOgPikJmtfRlj0LYKeoBgjXrSvoV
	mlK/IzdLZzcuzrQK6IypnN/vpPwAKgfyOgmhmg2cICJBgE71R+rc1lx8MlV6l5v8
	F39Y7wqyE8Wvnw4+qlOC0DvLTWsXo+ZALNH34HFE5YzYV8NWVP6e4yVnRLb2de1H
	6g==
Received: (qmail 2710669 invoked from network); 26 Jan 2026 11:29:27 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jan 2026 11:29:27 +0100
X-UD-Smtp-Session: l3s3148p1@tFg7+0dJFMUujnvz
Date: Mon, 26 Jan 2026 11:29:26 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Message-ID: <aXdCBu6kzdw1NWay@ninjato>
References: <20260125184654.17843-6-wsa+renesas@sang-engineering.com>
 <aXc7DxsqiCGdfzxi@smile.fi.intel.com>
 <aXc-Zxw05XQLb1Dy@ninjato>
 <aXdAB2bLTy6u8G8c@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXdAB2bLTy6u8G8c@smile.fi.intel.com>


> > Providers need it, especially the 'priv' member. Consumers won't see it.
> 
> But can't we make it opaque?
> 
> We may have getters and setters for the priv member...

I think we could do that.

Two drivers use the bank member, but only for the device
(lock->bank->dev). That can probably be refactored away, I'd guess.

