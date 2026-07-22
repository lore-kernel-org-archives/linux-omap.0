Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF645DF52;
	Wed, 22 Jul 2026 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734156; cv=none; b=T/Dd2f4F1eNQFVJjCE3FzatiSJmfeBTpwPCPXhSbZ1lAKwL9PjKP2vdCaf2eB42vcJeQi2v3Y/y4YhbwBMoCUNOqDojyxwYFiXNwVRIbX+OSFYJIegNys3kCsxWH98c8Kvl5hOM74lAKp4Ns8knidAOb4bzo5RD9cpiYmm/254g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734156; c=relaxed/simple;
	bh=MEYuMPg63j1OUYCo/AJGJVif7wrZl4b7B7y17ETyAzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mru69dSWaMGgvuHnaspm8rXhEthOuTgF5RiZz78yZSmhZJXTNWsigWa+Zi/zZQ++Js2lhGBbu9GT4t2ySOy9KIe45AepNARSaxYmTqmH0a8bvwfTbkTyq2RhbfRdEdp/0GbiwS7hOdTVhs/fzjHwytU4UHQYcNTnJzSnc/ZEnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmo4Z1dr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmo4Z1dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85D31F000E9;
	Wed, 22 Jul 2026 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734143;
	bh=LdZxN3Xy0zxHiFOdBkZ6bVlkCPhpR7VkSOh+0hA/f6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jmo4Z1drS8o91eD3O0GiGPu0kjx9oaz13lZOv/YMjiRgqMISfxgsKqnV1wdUIU70C
	 xi99asAk7YoUrfvAkmlbq6r5DYz8hA2C4UcdIFyY2xAAAZD31iWzt4OwpuleKqPqIq
	 eiK3uAnM+IRw6tGIfZIqJpJXmyISlyOQsOr8b8f7/+gze3gVFVru7zQCtNQutuOHdK
	 dflVF+Fv1F5Lh6c5saatIrn1AXJ2ibwzCc9nn4ZHC6vY80jBOdhJ3/2sJU/+Bs6xIT
	 TgbnYh1OxtPGafL0AcfrwqPPgsxGvrK6ZsCnwCDXtGH7yomOO/LdQfJDO4+2hI3GyT
	 osSDzKF4xObkg==
Date: Wed, 22 Jul 2026 10:29:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, linux-omap@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: phy: motorola,cpcap-usb: add
 chrg_det interrupt
Message-ID: <178473409160.966043.1743137868757405238.robh@kernel.org>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
 <20260711204210.197144-2-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711204210.197144-2-ivo.g.dimitrov.75@gmail.com>


On Sat, 11 Jul 2026 23:42:04 +0300, Ivaylo Dimitrov wrote:
> Document the optional CPCAP charger detection interrupt in the USB PHY
> binding.
> 
> Update the example DTS to include the corresponding "chrg_det" interrupt
> name.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  .../devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml   | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

