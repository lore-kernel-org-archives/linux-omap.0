Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252445DF46;
	Wed, 22 Jul 2026 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734212; cv=none; b=bTFiqdO++ZyGWyBe/XECtqOsiZ9Dl9aBugXWHknyM/xHchMeu3WHs+sY0Wx+kJqMbjtt4BlUFOErdzmBVjQFi3bunWnjluTa527ZQ5w7mwUuWqoesgGQRx/9fCbLgSrCf18T8QlgZkiX83VyaZKwSenT0r5TU39bNF2UvifUVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734212; c=relaxed/simple;
	bh=bof1UXbN9s+UThAJ5mqZwNPiuCvCvCsBlvl0XlHq9LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfAjmHD7oZXSDS4MyVVPdB+p0n0L6tUSWZbuX9PwFyeaQub5vQ4e0QMuf2y4olv3uEOD8DpI3S7BiOHGKSAhoz2BQLl+nZWShFkVp1YQrXAxsr7fOnyJzti1jRHwyMoixZsSEuyLrfHERahF2Bqi0T2y8/DPcXdRnYU1INreOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCC4R1v0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCC4R1v0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6371A1F000E9;
	Wed, 22 Jul 2026 15:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734191;
	bh=MiQon9B13JCqJ0ZBlba87Lc4HaPjX/zchUwplkS+IdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCC4R1v0jWUsMNFaS+5KjDDT5n6lfO+NQiaCp6DGdH/9ttyBE8R7oW8Di/T1K26D6
	 NHL1ntBZsVBOj4HBGUptwxozE8WItQ56Xt8C8/hayvKKTmuDdfdaBWMFhQTGVoQATN
	 PfV4nB4XbnSa35JCZWL3GDknVu+0UKlTHGEF5ZFyE0vTmoJhTbJDcxY3QGib247hdO
	 lctF+SW9X1YfFB8ZwE50VK53NKjXNBiYGWtBSsys24ymDGfnI2cw6DQi69r3+3iL7s
	 fnLPfn/ZBXiPxVMlQbkaCvHMYHJQQk1zpR3LAugohRIdnWuIRd5/H8xKC1sRFljfpF
	 5A1HeLvUar2Og==
Date: Wed, 22 Jul 2026 10:29:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <brgl@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Linus Walleij <linusw@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: phy: motorola,cpcap-usb-phy: add
 optional safe pinctrl state
Message-ID: <178473416255.967931.16569030812535097273.robh@kernel.org>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
 <20260711204210.197144-3-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711204210.197144-3-ivo.g.dimitrov.75@gmail.com>


On Sat, 11 Jul 2026 23:42:05 +0300, Ivaylo Dimitrov wrote:
> Document the optional "safe" pinctrl state for the CPCAP USB PHY.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  .../devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml      | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

