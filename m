Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FDA3033F9
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2026 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771230895; cv=none; b=rCS84hJXj2jS8unRQRBNj+Og5vhxj02SsFBBEOfKGMAOj1t3AzfZdk2WzJ+EU2rXjHR7iNZJ+oOtPVFzLrdJnWlyplWzTtz5fQT/vCJnzuL6aGFopqYUKmLPV24pM+lc85NqM61BtavdFbOxQfhJ5VbGLU3elywtMBnEJ1Uyi0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771230895; c=relaxed/simple;
	bh=dvQgcaenU0SHlZ2HJsbaNWEWu0qsn7uquDLz40HRHfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frjlgiPKzKZPYxophAadDMJwbwul2Ybj3D7nW53VS8NN/ObNafoTGoeyNYxqfcxVTEzLf+1nxBlWVZHrqT4LHBGNpOEdWo86eJf/eRXyYy4xzWt9hOAIYTsPYtelqDMGBVFSeKIJUOsnWRQwgJ697XNzB3jUwegn57uGyU6d+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JiawxJRN; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JiawxJRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=udWn
	s0/tE9VKlKkv9PZVrjAGz6UPCuc03cHhjm82iJE=; b=JiawxJRNnzOnh5J1hVMh
	E5duxMm3nyH2uDC+IPLFgg3q1xpmC7YqD9esUnX1lU/oL7BU9hRdwHsHasD69/fa
	gfyDd7xv69iBMmdpaeoSlfesWXrKB35LRWiALI/TJIhAAteXx697Uw6Z2QsWpNxZ
	JYobhZkrtlvxpVbjZ9nsh3dB+cpmAtgEt0WmB0vSJXkVOGRhxu93MVFPt7papNLM
	ZSfv0rFQ4rku+pla5XnOn7G+ab5NbnREMvkE/EBWTAGSP/AkabrJ6weMmqYFysIJ
	orrqckAcPD/DdHyruK3K0KYRCMwldOcIUxYCus5bHrfo8yM1kzBAT+jvmKSAcDiE
	vg==
Received: (qmail 3164830 invoked from network); 16 Feb 2026 09:34:44 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Feb 2026 09:34:44 +0100
X-UD-Smtp-Session: l3s3148p1@2umq0+xKxoEujnu0
Date: Mon, 16 Feb 2026 09:34:44 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Lechner <dlechner@baylibre.com>, driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-arm-msm@vger.kernel.org,
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
Subject: Re: [RFC v2 PATCH 00/13] hwspinlock: move device alloc into core and
 refactor includes
Message-ID: <aZLWpM8XOvidXJl7@ninjato>
References: <20260215225501.6365-1-wsa+renesas@sang-engineering.com>
 <aZLJ8Z4XOTEUJfmh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZLJ8Z4XOTEUJfmh@smile.fi.intel.com>


> > Looking forward to comments. I especially wonder if the last patch
> > should stay as-is or if it should be broken out, so individual
> > subsystems can pick up their part (with a fallback in place, of course,
> > until the last user is converted).
> 
> Coincidentally I have briefly reviewed it in the Git tree before you have sent
> this to ML. I like the whole series, but what I have missed is the explanation
> of the removal of Contact: comment in some of the files.

Ah, thanks! True, documenting it slipped through the cracks. Sorry about
that. The reason is, of course, we have MAINTAINERS for this kind of
information. Plus, Ohad Ben-Cohen hasn't been commiting upstream to 10+
years according to git history.

