Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566929;
	b=Oyn05/oh83cp7JyuwmRc4GYzDJl6hxo6NhU+nb+UgckF1Jauw9XbRju4IYBqWQrUr360
	 qtM1x5qwHYc5ZbzuwsBvWL8Uw+B0nouvNkw89hGYKgYleJYjx0G81yR0Q3W4xmarvk4iO
	 BJ4uhGG/Q+Ass2fe+lw1Yxgz5KYgLGUF3WyiENbzgwHmU0vMJ2rxFFYXBSwECFCsVAORC
	 jYYCM7Mm7Jd0GT/tuHZqeKBZlS9PFBjqdP7Jq4Qt+SwLwwb6pvaZw7K4ysGu+5Yb93j2W
	 WewWZhu1V1FR3Z+yX9xaoXTF2b4R9Dqgj9c7gPsAvgJSBOBAyMpiNVQWC1cuHJDdOHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566929;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Q6d4prkW47e596Nxbaxs+/eGK3TktVb4Okv7FDT6eK4=;
	b=QT6p0fcfKjYtgl0A/n1AMcBY4QycuEzqRtc2S+Xr390SR289NCMAS2zRnUNYFecDfUIK
	 WCahCDbFLH/tKAE9/D6YYRbvlkdUCmf4R8TYuJkF+EpR9G8EY6dBeeMncUObts8i5AXoS
	 3cML/0m8R9GPXM1flDVj2dSeifIjqLlVbBesw30/jMUkodpc+Z+0cby/gWaORUWSyPx0d
	 IH79cROaBQMvPrEzRGVSu3Nf/alL7gOTUx5K6g8RQtzNgcgMFptp4u69R8hVpgBjORGry
	 F4yh2ZDekLrn896co6UVQykxxslt+OPYejZioGo8zAK1mi5ioTBeJsrkYpdC8cHgZcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+SitBTB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BCE606A321;
	Fri, 13 Nov 2026 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+SitBTB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAF11F000C7;
	Fri, 13 Nov 2026 10:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794566929;
	bh=Q6d4prkW47e596Nxbaxs+/eGK3TktVb4Okv7FDT6eK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+SitBTB088USLXwo/uw0sEtXcWJ6MV73Q8RFBcTdf3hRMO00MlLtW+DbpHPxz+bt
	 eERKcNIZTt3h0eKr/EZ9hQMDZodncdBX558zDbfvihBCtMl5xfWEpxruLOb+PlgQ0J
	 L6hl3tmSVpYenpvKN0T626cBaKcdAv1AIGD5DdnvkjFWcu3jAHgneatlYPGZ+E4la9
	 N1pSWz/CUy9niLyAw/mgu3zR+ISJKLgNQt6QayGeFrknnzR9VtGDldZ46znuEE1CmG
	 pwBUsfr7R2kmAEh4POKFbVB/q1u6MPUR2w59gg9K2VmdUGDSVa/q/TRNndqPkkPUr2
	 T0RPclU2NpQKw==
Date: Fri, 13 Nov 2026 11:48:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Mark Jackson <mpfj@newflow.co.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: vendor-prefixes: add eets and newflow
Message-ID: <20261113-handsome-agate-beaver-a641b5@quoll>
References: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
 <20261111-ti-omap-dts-fix-v1-1-19022d1ff4b4@gmail.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111-ti-omap-dts-fix-v1-1-19022d1ff4b4@gmail.com>

On Wed, Nov 11, 2026 at 01:22:31AM +0530, Bhargav Joshi wrote:
> Add vendor prefixes for EETS GmbH ("eets") and Newflow Ltd ("newflow").
> These prefixes are needed to document the compatibles for the in-tree
> AM335x PDU001 and AM335x NanoBone boards.

I see no eets in tree user. Neither newflow.

Best regards,
Krzysztof

