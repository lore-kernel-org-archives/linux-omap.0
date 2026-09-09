Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2D53FD5C;
	Wed,  9 Sep 2026 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967300; cv=none; b=RiD01TA/vK9CeK/JNps9UZ8FJlfEFt6eE8uUnbqEYW2v9YZz6m0rnaWlhbtogJI+YJRX3nKSStD0y7+eQoHT5pbWNfLWYdM6uxgzzORB0eSdbd/Af1YbW9Kq0G+wiW4dIFKKOOb3AGt5jF9JoZJlD/fWbv3E8Fmp5/aDzq8EIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967300; c=relaxed/simple;
	bh=xx4LjTBOF+PthZdT5ry3nARx2M+q+HqwHQs0R/a3zXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDGtEFdtl7f3q6r4cMJzS8aTXjZqn434r0bVwi/H/7VcwvzvUvxIf6ahBeb60m9Or0WdR19SI+kvcu6NFKZ/EpyVu36KltQjL4bx0/f3N/Ju9CcUkJrgL3EA6SDjMhykRX5qOlaY6rdiLR8XFEa9C0woLXG0SMqZCCL8BAGSXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alH5dShJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alH5dShJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9881F00A3D;
	Wed,  9 Sep 2026 15:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788967298;
	bh=uGWFdqzb8bYvyWRbpjTJW+Qyf4vZQkcGd0eHszCLvzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=alH5dShJtqwV9Ubk9DHdNEsuCe6uAI/KFR4g3Z6MYpeWXB2h4QL4DkQm4aoDmM8jr
	 szVG/nzcrMZifEGUU0kphu53+vfKU56XejKoO7a3wb6epPFxRQ5TBbmiquD8drwlMH
	 MIyZMhsb1lAIv2fbxHpxsF8sLm4OOVOwDu8w4YI0Rpln+/e1/wisg8oVn7HLWL8D06
	 c09eLld9OZwLTJh0Nv08R5zWA1ARUG5NkuEINS4s5nRofRj1fPIa5Hp/jy/u3ZT24K
	 jbtAv8hlkSMuWDViRAKZQnVmkbqlvXKhmfLLaybR7OiV8eF3jEECD98dKPsNWEIwz7
	 eyiEuaV04cpRg==
Date: Wed, 9 Sep 2026 17:21:29 +0200
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
Subject: Re: [PATCH v5 1/7] dt-bindings: phy: motorola,cpcap-usb: add
 chrg_det interrupt
Message-ID: <ac3a277xeybgvkcgo33jaspwp5hvwfysmnhbiy6hy2qfsfsleq@awfomjfn6fdu>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
 <20260711204210.197144-2-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711204210.197144-2-ivo.g.dimitrov.75@gmail.com>

On Sat, Jul 11, 2026 at 11:42:04PM +0300, Ivaylo Dimitrov wrote:
> Document the optional CPCAP charger detection interrupt in the USB PHY
> binding.
> 
> Update the example DTS to include the corresponding "chrg_det" interrupt
> name.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
