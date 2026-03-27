Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61937C0EB
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611812; cv=none; b=ruX+48dlbwvrK9mlwYcABNQRB8ipByFl834UAZEseVpfdUpwDs1v+Ud+P1ggr8TopioYZHPYyldthhiZzJrDIO+85tXaBpErexsd+RmbXe1i5VbwPBM/HzjZdvxiT4RnsnXDvaifqomSvGxXgB7JOTAITJqwgoLpfCU/Pbdep6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611812; c=relaxed/simple;
	bh=uYAApojvLTIkmyKoZpYwJZCokmKbnpF9c6WhaIacVG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqE1/H71xU0/eDtLU2q16FBjs8eSvRNn1OpaV8Vt9WpD9d1KcWgM/dYP2mYAZ/ginJmDC9L7ZltUknkzrm71094v46pr7p5c1GHFGtiZ0ZCGJPQ3qQvmDymrBi8vmn5ADewFGlSjObgzPjEMLFCu3ZYoJuO4Vlw7Mittn68lEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=k4QvSzox; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="k4QvSzox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=H/mm
	EvjF+xhmn9Wns9betMD2C6MNmROj8DyAiLE02zM=; b=k4QvSzox0bVkfsfDjzFG
	LGuc3RY6Nc4A01kHbyNKckXguVBwpBOKFgCosfhLsRsjq4eDoNRYZpMIVCJ0O3hr
	gfeanKsyTEOWbah1eONyp6cI2lvZTWiinFUqQ1+gY2hdjjx+hPdnLjDCYK70TUJ4
	aFc/YaBf28GDjSGd7mxe254RWqDfD9attVFCtj8ikS1PeMOzQ7Wq1WpZ9OE7cTEW
	LWHjg90xTnSXm5laQso2Th3BJmrtN84wxdyQWCBE0l/PveVIj91/BXi11wFJWf4A
	0Ik6WG0aYRHLixjG/wpRM3UOW+oQhTX4llCiif+gTG5sUZ6tFSGGFUkiiWl6Oq3N
	Rg==
Received: (qmail 174700 invoked from network); 27 Mar 2026 12:43:25 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Mar 2026 12:43:25 +0100
X-UD-Smtp-Session: l3s3148p1@m9s6AgBO++RUhsJN
Date: Fri, 27 Mar 2026 12:43:24 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v5 00/15] hwspinlock: move device alloc into core and
 refactor includes
Message-ID: <acZtXL7OiM0ceyMe@shikoro>
References: <20260319105947.6237-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319105947.6237-1-wsa+renesas@sang-engineering.com>

On Thu, Mar 19, 2026 at 11:59:22AM +0100, Wolfram Sang wrote:
> Changes since v4:
> 
> * update Documentation, too, when ABI gets changed (Thanks Antonio!)
> * rebased to 7.0-rc4
> * added more tags (Thanks!)
> 
> My ultimate goal is to allow hwspinlock provider drivers outside of the
> subsystem directory. It turned out that a simple split of the headers
> files into a public provider and a public consumer header file is not
> enough because core internal structures need to stay hidden. Even more,
> their opaqueness could and should even be increased. That would also
> allow the core to handle the de-/allocation of the hwspinlock device
> itself.
> 
> This series does all that. Patches 1-2 remove the meanwhile unused
> platform_data to ease further refactoring. Patches 3-9 abstract access
> to internal structures away using helpers. Patch 10 then moves
> hwspinlock device handling to the core, simplifying drivers. The
> remaining patches refactor the headers until the internal one is gone
> and the public ones are divided into provider and consumer parts. More
> details are given in the patch descriptions.
> 
> One note about using a callback to initialize hwspinlock priv: I also
> experimented with a dedicated 'set_priv' helper function. It felt a bit
> clumsy to me. Drivers would need to save the 'bank' pointer again and
> iterate over it. Because most drivers will only have a simple callback
> anyhow, it looked leaner to me.
> 
> This series has been tested on a Renesas SparrowHawk board (R-Car V4H)
> with a yet-to-be-upstreamed hwspinlock driver for the MFIS IP core. A
> branch can be found here (without the MFIS driver currently):
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/hwspinlock/refactor-alloc-buildtest
> 
> Build bots reported success.

Sashiko found some valid issues[1], so I am already working on a v6.

[1] https://sashiko.dev/#/patchset/20260319105947.6237-1-wsa%2Brenesas%40sang-engineering.com

