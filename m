Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2422F388;
	Wed, 29 Jul 2026 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307458; cv=none; b=Fzedf8ZhPv5IX89mXTsfIhACDlQto9s+q2+swQlk8ZZzAALdYT3sxE2NghtWjYUfZW6b8y0wz2Wp2QRqxv5pcM3rGzRZNtMZ6H7QAy+xaxAQRvIbQ4Jo3xUsIxHyIj/VSfcLZO+Bx+UQcL+duhmVnk9xHsHGVYEMJ5eNMCq0d1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307458; c=relaxed/simple;
	bh=sLK0Px9bN5uxk6Qn8S1A33CXOtJbPApbw/EYIsT+gjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezkimIxMRUgCdaqV94YUUVeuMmSkl/NpYde0uRX3szBx9oMcbPyuMHilzrTKjgLK1b1++EcYFAvS9KM4n3tI0tQGg1YpRuEn1z0e2OWRsCA6YW0MQz+gcHHXkQ6toVNSOwp/lXXYxirg+1LTrCF/qa8KJYVjRPIV2WsoP8DiP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=3EEGSwUi; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="3EEGSwUi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=In-Reply-To:References:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=gu+SkBzNShlqBj4mZPOnaItR1bGdPkMV50LZRMhRbkY=; t=1785307457; x=1786517057; 
	b=3EEGSwUi/LmFuFu+9ZW7OK8JiSKHWbUBizI1Qn+GCCAjLsTaEBMNgOoCNY8Jgw3aZctVAtG0ONz
	mkmGCiNMqB4sXMC2eiejRNPQnq6jVTwsb5Fx4vr6EJ4VAa52WsTi4rh/l2lJf1QwJCY915LU4Yzgv
	XsY5jWb4PFU8bz8/DVnnLRW4H4ZmiQpvKoYQ8vvoFQxFtV66E8YH6m99ncfYKP7bRJpMOUcrBmCX4
	YwjIMSFlslF7AeL/ldTbYjt7b5X4diiwDS0C2+4JXSv8xy1Rzykdss3zhTcKCR7aC64h0XR/u2tRW
	yrgCczwA4TN52TEOHimubzKBOTrfypiE9xww==;
Date: Tue, 28 Jul 2026 20:27:07 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	--cc=linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 7/7] ARM: dts: ti: cpcap-mapphone: add USB safe
 pinctrl state
Message-ID: <amj0ezBlWdxKysM9@akepd>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
 <20260711204210.197144-8-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711204210.197144-8-ivo.g.dimitrov.75@gmail.com>

On Sat, Jul 11, 2026 at 11:42:10PM +0300, Ivaylo Dimitrov wrote:
> Add a pinctrl state that configures the USB interface pins into a safe
> GPIO configuration. This allows the CPCAP USB PHY driver to place the
> pins into a defined state whenever the USB interface is not active.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
