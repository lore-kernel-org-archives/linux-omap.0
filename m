Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1F48166B;
	Mon, 31 Aug 2026 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184822; cv=none; b=oEfk1OvAAvQPo8OmgMVv6rMXoODpMXGMqfckYJXAx1W9nibI4PiM1K2VSE7NR/s6qbGNuHs0X87bClRiQFdBPnWS2DbtNVzctY5cqY+1G5/n9oX/IKr5JaIXVV8FPJpTsxK1E/qF06VnvCLGiMlCcGRE7Sw6cucnCkJF+O2WgbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184822; c=relaxed/simple;
	bh=6jGkc2dmHqsO4NYpn3XqDZLDizGjtvdXPQ+FHzx+rRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzqgqtRWzG44bWl16fpPDi0FJRAVoC7ady/1m0ILSVW01rJ7cmw3pOvoQ/ss2Oqf4Ut4HNdSqnGybjYmXucpyDfHSHoOwFH4lbcOaREHhEvlWAnjF57lYMf0nle/8Jb7Ar+W9sFBCHzbFGzp1JM7Yku4JdEvYfugf9H0PL5fkBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBPaL6Na; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBPaL6Na"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192F41F00A3F;
	Mon, 31 Aug 2026 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184820;
	bh=xNQtXXf+Ww8JrC6uRI24lyD+zbzJC0OkZfJ8+U3Y8ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jBPaL6NaIKdIOL/07rBq5yx5nHx6zB1qDqzZM0OVzekZ31fWfjIaM/WupjazQGqbI
	 l8iTPoJ15NLMymwF1p12sRxIA8ny2bErkJb8NL713n/NBMpqLJ/+ZSR3CxU5tYkgjT
	 UsctH4cV1R6MlszlFGrLQwPLpE2FdjiiM2NN6w4bYrl1K1ei5GSHckK1cEG9I7tXXH
	 JDMyPGC9Y/MP2lL64VADxMq4Ku4JmOQZr3Xu1Q/FavdeIryIMt7QyoEwaP2hcrC7oI
	 ndV46BjIziwdGB/zcYlR1G+57vfliAAg2a+eaqS5Sy9NDtCYdt1msDh5P1gpfxPvGg
	 RfAw7zYDEoyZQ==
Date: Mon, 31 Aug 2026 09:00:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, simona.toaca@nxp.com,
	linux-phy@lists.infradead.org, Frank Li <Frank.Li@kernel.org>,
	m-chawdhry@ti.com, Conor Dooley <conor+dt@kernel.org>,
	Roger Quadros <rogerq@kernel.org>, Ravi B <ravibabu@ti.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	daniel.baluta@gmail.com, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andrzej Siewior <bigeasy@linutronix.de>,
	Andreas Kemnade <andreas@kemnade.info>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, linux-usb@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, goledhruva@gmail.com,
	Kumar Gupta <ajay.gupta@ti.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 7/7] dt-bindings: usb: ti,da830-musb: Convert to DT
 schema
Message-ID: <178818481901.788794.2228539638923939154.robh@kernel.org>
References: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
 <20260818-ti-am33-usb-v2-7-66fd44d66824@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-ti-am33-usb-v2-7-66fd44d66824@gmail.com>


On Tue, 18 Aug 2026 19:58:49 +0530, Bhargav Joshi wrote:
> Convert the TI DA8xx/OMAP-L1x MUSB text bindings to DT schema. Since
> DA8xx MUSB node acts as a parent bus for the CPPI41 DMA controller add
> required #address-cells, #size-cells, and ranges properties.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../devicetree/bindings/usb/da8xx-usb.txt          |  69 -------------
>  .../devicetree/bindings/usb/ti,da830-musb.yaml     | 113 +++++++++++++++++++++
>  2 files changed, 113 insertions(+), 69 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

