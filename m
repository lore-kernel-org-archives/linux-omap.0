Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D2580398;
	Wed,  9 Sep 2026 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970469; cv=none; b=WeMV3JWcTVAoUeZlPfmwfwsGZRZbQbrcCnujicGs5d0xolPI6e3GnPxN6oq2CcM/1Zttr1e5UG54MFZ8fIvChrtRYh4GtTvSTBcoDknjBb2NYgukKTI+gkxiiq7T/zJSe5MpgU66oIVxuCtB/pTADIr9ErdtWV4dDrpVIDjPoUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970469; c=relaxed/simple;
	bh=ie0mTwcofOxh0NXmlQKCG8ejXh8K8pWzU4OXJwOEXio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3U2aBq+TOtQ8Rqv5YWoM3xUYD8dpSoM6o+uC6XvJ0G/iyRejPGwwZgbsvV9X+cwSrNnalXu1HyFP+dPb/hOmHFWtEVHbvwa9kvp129VjONN1p1Ms+tvYpb224uG80tXb8zFpMOZlm1RUge8pQgEQs7vtLU+9tQmcW63FCSAtdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir0VIni2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir0VIni2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD611F000FF;
	Wed,  9 Sep 2026 16:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970467;
	bh=rbdm5hDsbnlk0c+hSr2Azc2QmffaDxhfieJZMMkSDhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ir0VIni2MAQQSr1ASJW77hBN5FPBDaHBUKiEFwzfpt91x5QMTUtoz+k+7dVYsdvV5
	 wQzX1UqjjskvLtizq+PZ1oCKyLscJB78MXIknFchyDSh8LmYtL9nIBfd+52eD8+qQx
	 EYOmyKRz0ou1ZZIR+7hIN9CHW3mT/y5zh3SQohp1AJTUp6wK+aAWfk+TT9ird3aWcM
	 ZVNi+1/OIiPw7WF3oWfwwJkZbme80yvgowhY833HN7J5bdzQFDAlQdUERF5yQo2OvN
	 m+GoHLWHwGcJFOtQ9zYSqXWz2TdYXCzoV7dOxwrpggKY/P97h+Z9+Ln71MhUGAXGGb
	 WW5SsAJ1k5mRg==
Date: Wed, 9 Sep 2026 18:14:12 +0200
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
Subject: Re: [PATCH v5 5/7] phy: cpcap-usb: add extcon support
Message-ID: <b7m36qi3rute5q3rmrfq4kp2fu5mfohgw64z6biq35aedts7ys@wbuekxxyz4ya>
References: <20260711204210.197144-1-ivo.g.dimitrov.75@gmail.com>
 <20260711204210.197144-6-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711204210.197144-6-ivo.g.dimitrov.75@gmail.com>

On Sat, Jul 11, 2026 at 11:42:08PM +0300, Ivaylo Dimitrov wrote:
> Register an Extcon device and report the detected cable state.
> 
> The driver already determines the type of cable attached during USB cable
> detection. Export the detected state through the Extcon framework so
> other drivers can consume it using a standard kernel interface.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
