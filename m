Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFC3815CE;
	Mon,  9 Feb 2026 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653640; cv=none; b=VCtLf1iXro1nHrQbYcs8pJiz7qKN9duvcnoP0eMtF58sCasfYwDDZTvgVSUAXseOxdZjyQboYAfE+cfhDMfeZRsYZEBaEVfyQuOPpHOPJLym8dzvS5CXKQ2Pw1eSeUpIJNVRW/kFEjnRnkFSgL1XuxHFZ4OQPAnCZbMqCzRh+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653640; c=relaxed/simple;
	bh=LOJcn+SmxysmVh2uPMIzBp5pbzxzu9seMnrYNsHRBSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyEdr1shpiAKsjhQeOAJ+lSkRQ+N9YWlzC0urKftPwpN095HYyT1X2bkIDTgWbgPWHwPBqnu11JPWDWFl5nL01qxOzhr3/nvp1/9RaSnDB6Ns0vToDQMaCQXaeK1GPUKEp/mqy8KjkOgvyUjLjKfvRFOCh9lxgQVSe5eybm7YWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUZjPza7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUZjPza7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632F9C16AAE;
	Mon,  9 Feb 2026 16:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770653640;
	bh=LOJcn+SmxysmVh2uPMIzBp5pbzxzu9seMnrYNsHRBSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUZjPza7FPFYtADnlPyrvUQeLkRIftNqUBdxCxWsmcAxTSEC7h1y3EogopI2EN5yo
	 OHmOM4kRW0mWYsaSBWeGG94SFkrQlwoy9ERbFTMTpJ0Io+NbOKNgJNMpqw5vPFTiY6
	 qwp352Vg3bCuD/ikfLM+KvmjcmjKBagsBMSXIrGiWJHNZaw4RYV4gPr0yrtQYiRF+s
	 XbzUgmmGAWxnPB125eA5XmC+pOpdmCHQCX7Td/XoBgVqmJ4gjH0csPg+S7wNLwyOwO
	 QrRRMXCGGZHPIJ2qZsnFaSW8sWMnKrw3L0+d4bXLpB3/vn47IMQEV+DuyQG5OfBMsM
	 AqPkD6R2UBZ+g==
Date: Mon, 9 Feb 2026 10:13:54 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-renesas-soc@vger.kernel.org, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andy Shevchenko <andy@kernel.org>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Konrad Dybcio <konradybcio@kernel.org>, 
	Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, Mark Brown <broonie@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Waiman Long <longman@redhat.com>, 
	Wilken Gottwalt <wilken.gottwalt@posteo.net>, Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 0/4] hwspinlock: refactor headers into public
 provider/consumer pair
Message-ID: <yl4bbbev7lgrmnqys2izkolo5egzg24faukvqar5eh26q5ra7p@42rcegfpqqt6>
References: <20260125184654.17843-6-wsa+renesas@sang-engineering.com>
 <aXc7DxsqiCGdfzxi@smile.fi.intel.com>
 <aXc-Zxw05XQLb1Dy@ninjato>
 <aXdAB2bLTy6u8G8c@smile.fi.intel.com>
 <aXdCBu6kzdw1NWay@ninjato>
 <aXikZ5wc6bvgRqF6@ninjato>
 <aYnBrN0JRCf9-UjB@ninjato>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYnBrN0JRCf9-UjB@ninjato>

On Mon, Feb 09, 2026 at 12:14:52PM +0100, Wolfram Sang wrote:
> Hi Bjorn, Baolin Wang,
> 
> > > > > Providers need it, especially the 'priv' member. Consumers won't see it.
> > > > 
> > > > But can't we make it opaque?
> > > > 
> > > > We may have getters and setters for the priv member...
> > > 
> > > I think we could do that.
> > > 
> > > Two drivers use the bank member, but only for the device
> > > (lock->bank->dev). That can probably be refactored away, I'd guess.
> > 
> > I am willing to develop this series in the above direction. Before
> > though, I'd like to know from hwspinlock maintainers if they agree to
> > this refactoring in general.
> 
> Moving maintainers from CC to To ;) Do you, in general, approve this
> change to the headers?

Certainly, I don't think we should force unnatural slicing of drivers
across the source tree.

> I think it is more modern and e.g. the mailbox subsystem has a similar
> structure, a header for the client and a header for the controller.

gpio, regulators, resets to name a few more.

> And do you also prefer an opaque 'priv' member?
> 

'priv' is already opaque, so I presume you're asking if we can make
struct hwspinlock internal to hwspinlock_core.c?

I can see the allure of making hwspinlock::lock internal to the core,
but (luckily) I don't see it to be a matter of just slapping some OOP it
and call it solved. It would have to come with a new model for how we
create the hwspinlock in the first place - as this is currently
allocated as a whole by the provider driver.

I've always found the current model unergonomic, resolving this part
might very well have the side effect that Andy is looking for (and I'd
welcome that).

Regards,
Bjorn

> Happy hacking,
> 
>    Wolfram
> 
