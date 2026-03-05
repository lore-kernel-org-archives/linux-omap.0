Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C02FFFB8
	for <linux-omap@vger.kernel.org>; Thu,  5 Mar 2026 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737561; cv=none; b=QNh16gzqKBBcdOnXGHNc3GZuJbFrdGQjrCjlGMsu9lcIUFLpDRqaS+l63G8PGkZsI/n0dGoVRC8S+AtddneivFYkjLNjFvpxLWQ4X+nC2pCGbJ8fa9qLUm9i/FrPYJRF+3ihNJ5FUK8fWpWb2kKiOURaO4lJB1HUGOOHKjp5/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737561; c=relaxed/simple;
	bh=PoZhjt3uQ53hew80uagXcdFkYbFd19jlnF8DaZB6F8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IplWqCtkvSjE9SZi6mUsKc69jcrRFojOeZf6hlx7TzdA+aCPNjNB4SDs7hAG1QAQgFlM+3y9Eo5qi+pja9NhcPusJHoDdaVM4vjer7CdgI/roknJ/ZU7peQaXv4JPieAZwR2zojKJznTHYcIv5AUvSnVXtMKsSABlNz+lYnLbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=EcVy/bhL; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="EcVy/bhL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=PoZh
	jt3uQ53hew80uagXcdFkYbFd19jlnF8DaZB6F8M=; b=EcVy/bhLK2eBwgExPMJ3
	1rbX27cmhWjc3rjGsjxF5dRov7fUUDlpNwgi9pngCGqJG5rKUq+J2C7p8l7IBa1n
	wAix8At/9KEPwT6JYyilYtj2K1NUn9Fe6iLpr+kWvIBDV6i4EuUfuN6Gi8/pycHE
	4vAwn6qRsLPrTXt0uIMwoQrYoe5V27+qZp4xfOoSuWX7fTIVZ0s80690f6qBtlHQ
	aykgx+mmEG8fCS2XDtombi/a32mAZGwytbmjpk8rnYFTpCSaNVHVEBXYPEPH+iwl
	s9fnwEBco4uAbN1zFVh8Nns87WyRd1m0ExV4cifwtmIFoWYBRJWERmLoh5POBXHa
	bA==
Received: (qmail 1304730 invoked from network); 5 Mar 2026 20:05:54 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Mar 2026 20:05:54 +0100
X-UD-Smtp-Session: l3s3148p1@FM0uoEtMkO4ujns5
Date: Thu, 5 Mar 2026 20:05:53 +0100
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
Subject: Re: [PATCH v3 00/15] hwspinlock: move device alloc into core and
 refactor includes
Message-ID: <aanUEX9jq0Y9iNIe@shikoro>
References: <20260303192600.7224-17-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303192600.7224-17-wsa+renesas@sang-engineering.com>


I need to fix __iomem annotations. Sorry, I didn't know I have to update
to top-of-tree sparse which is now required for v7.0-rc1...

