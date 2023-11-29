Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="DqijIydb"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5D6C4;
	Wed, 29 Nov 2023 02:16:15 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 61B29603F4;
	Wed, 29 Nov 2023 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1701252974;
	bh=L/eV/0fIB7OL8iIm/1Q/TNqJah06A0ocA8A8tBMVvGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqijIydbV8fHBr6ftecfvoR+1xhJRxVErWKVOPIDtD63ROz84ZMm6F80SoWOJbmd/
	 s9dyXk8duKVCXmNGabn9QbYN37QTUCavuABFw4tJgfAT0OkbXJC8otwwJQDYgS6uXN
	 mdOnnvs3xC9pMxN297FOFHhlDpntdFeX3Agj0dZyL5OffSxV0qovPWkNy6pWf7Png4
	 njmjw+ZfwYlkw1kF2qVLZOc/lEbWG5bG7GsxetQNrmCvpdj2r97nC1jyNSguT+DWCj
	 ullrpOXA+gFEsAz6vffiIAOl/12mc+MHQACCctR4S+a3BVFZ3ivBa46145+SYWs21y
	 AcaJ5J5a68Dgw==
Date: Wed, 29 Nov 2023 12:15:35 +0200
From: Tony Lindgren <tony@atomide.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
	theo.lebrun@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: pinctrl-single: add
 ti,j7200-padconf compatible
Message-ID: <20231129101535.GW5169@atomide.com>
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
 <20231128-j7200-pinctrl-s2r-v1-1-704e7dc24460@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-j7200-pinctrl-s2r-v1-1-704e7dc24460@bootlin.com>

* Thomas Richard <thomas.richard@bootlin.com> [231128 15:35]:
> Add the "ti,j7200-padconf" compatible to support suspend to ram on
> j7200.

Reviewed-by: Tony Lindgren <tony@atomide.com>
