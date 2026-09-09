Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC5054EEB1;
	Wed,  9 Sep 2026 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967252; cv=none; b=NQElv4fi4Wk8kQD1KHQuMwKPWgpGA1BbkUyvsIrJ+GImBOCUribQi2DVaZXhY6SQLqhoNsAn8hWQpvPBWvrXmK/uAaRIk4Iac1pfA8BBhmSYNmFoxu3YdCPyuul2twQGkHSiQZtGR35clkapit54slBEbw1QOXgTu56ZAWEnQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967252; c=relaxed/simple;
	bh=iKnrUSDT5Fz13GuLvMgcUO/V7iG0jox4Zc3GEwaDNdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O87ZAnD2gl5fj3AWOb2LxH4sGRF0IwzkvTVQpqf5SoQ/jrD9G17wRtCpBU7cwzMDM7WrIkWRyyNFtHCv7TEX1G3oM9Qomd/b/eBiBjfiXuUkUZvC0ZnnQ9YcKwi/s3c4S+w1W3mbtCQ4cBBdaUsaqaU9lC24O1V7PtDGBDR1GMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRuZHN25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRuZHN25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E753A1F00A3A;
	Wed,  9 Sep 2026 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788967251;
	bh=0ItMITfrVntq3jEk4qbDTbiHGOd3wDC+1r6p8CkKYzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XRuZHN25nHuU1pRuKySyqT8SViDEta6kvnVLNH4dXmFNksZ2AwghKYde3ICO15kr8
	 kfzg+wuJUot5cSA2/v/NauUBKD/gyOYzS2BpIYqSEkrZdRJVWd2cnLrXoZ1hjAlezd
	 V1gMYzMlIx8g3Q3oYTXijxBtTdkJp3IN1TdUh2xwUdrxT+pLQQgezXV0mHDcacQd38
	 BTyLDjLKJKPQqfpXsLlHbFEz6jyawQD0BVqG5WXp/EDbAvTKrxlWG2beK0HNCFiAMw
	 AQUbqIkNfcpDRW0w50HKXd84p4aUot8ra03TVhptKxW1Uw//90+ECl100HwQuhBO3S
	 XJTrLBs4QUhoA==
Date: Wed, 9 Sep 2026 17:20:42 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 2/7] dt-bindings: phy: motorola,cpcap-usb-phy: add
 optional safe pinctrl state
Message-ID: <cwgwosysf5wprofa2opu4ol2akv6yrjf4z5j7axgulbrhzpkq2@qjyodv2omhhb>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
 <20260711204210.197144-3-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711204210.197144-3-ivo.g.dimitrov.75@gmail.com>

On Sat, Jul 11, 2026 at 11:42:05PM +0300, Ivaylo Dimitrov wrote:
> Document the optional "safe" pinctrl state for the CPCAP USB PHY.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
