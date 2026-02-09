Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8526ED48;
	Mon,  9 Feb 2026 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770673080; cv=none; b=caIojxXY2QUt5CjQOoEsp/3r9bX8fsW2IwTb6fMi7coaqUnGnU5PcJmi9ofA9M3wMtTP8coPlXhhWK5JOSu9jjxEPuhO8l3M5n04nlBO1mxohEUvfd307dTnW24IuMcbU3jKvPKjbU274ldeHErhu6sx8R6sQrI2N5T+K4Nc6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770673080; c=relaxed/simple;
	bh=V5k7yronzuPg2/sQDnDLiZPJmoREh3DS6In0CZNegm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piIlRZXY6Mfu2eSviplCwfkkE1eyLvZlHb5WAAdiz5D8cEWL6R4c9WEq10XxKgE96lg++MZbd9bJ2PKqg/3XTGAxxu51oSsLX4DHYgBfH0wLngNYTNL1fjs4EN4VXK7e+pwYhEBMg30ozZkxS+eVUOdA4c0f86TSIaNIJCZ/cws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2/CxZyE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2/CxZyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A991C116C6;
	Mon,  9 Feb 2026 21:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770673080;
	bh=V5k7yronzuPg2/sQDnDLiZPJmoREh3DS6In0CZNegm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2/CxZyE7D7NuC7727GzKNmG8L0gFdn827lwUEFhrk1GcDYwfKzMWilh9KCwLySN2
	 tDMTyIgjKpNBsz+CrnFUB8QrkqCqmuexDnRgYALsArlPL7MYxDDAkqQGMRry/iQQEz
	 tXkZ9aLz2eqJBLP0lhFLwX/6MjqEStYuaBxUaPzS36VebR2KunZkZR9O1OXhOtXp8N
	 y7WKLM3eEtcCOQ9wRj+umXbC0jg6B9FNMdR1WBBVMG3pafl6iUuxvb1YkCeBuik/q3
	 twvcXwcELPoyngclQnEGLBF2iDgahBFNYk+KVc3S2d7b59tHFINf47IiCuGxldwxT1
	 EqvORhp9jn0CQ==
Date: Mon, 9 Feb 2026 15:37:54 -0600
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
Message-ID: <epechyewxhlkp2dgw7yxmz5duak3illbmjpeux5jgt2ewskc3j@cre3vpa5wnhy>
References: <20260125184654.17843-6-wsa+renesas@sang-engineering.com>
 <aXc7DxsqiCGdfzxi@smile.fi.intel.com>
 <aXc-Zxw05XQLb1Dy@ninjato>
 <aXdAB2bLTy6u8G8c@smile.fi.intel.com>
 <aXdCBu6kzdw1NWay@ninjato>
 <aXikZ5wc6bvgRqF6@ninjato>
 <aYnBrN0JRCf9-UjB@ninjato>
 <yl4bbbev7lgrmnqys2izkolo5egzg24faukvqar5eh26q5ra7p@42rcegfpqqt6>
 <aYo60vooftdem4Lt@ninjato>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYo60vooftdem4Lt@ninjato>

On Mon, Feb 09, 2026 at 08:51:46PM +0100, Wolfram Sang wrote:
> Hi Bjorn,
> 
> thanks for the reply!
> 
> > > Moving maintainers from CC to To ;) Do you, in general, approve this
> > > change to the headers?
> > 
> > Certainly, I don't think we should force unnatural slicing of drivers
> > across the source tree.
> 
> Cool, glad you like it.
> 
> > I've always found the current model unergonomic, resolving this part
> > might very well have the side effect that Andy is looking for (and I'd
> > welcome that).
> 
> Yeah probably, but frankly the task of redesigning hwlock-allocation is
> a bit exceeding my bandwidth for this project. Can we make this a second
> step on top of this series?

I'm okay with that. It's winter and the yak might need its fur.

> And if so, would be this series acceptable
> as-is then (modulo the better include-sorting mentioned by Andy)?
> 

Sounds good, I'll pick up your v2 once we get out of the merge window
and share a immutable branch for the other subsystems.

> Hope you are well,
> 

Likewise,
Bjorn

>    Wolfram
> 
