Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7B2EEE61;
	Thu,  6 Aug 2026 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023494; cv=none; b=hsTta2+GtkkIaWP+1CHOplihIW4swd/l9j0HzzE/uFR21AT9LvHlGohodWqeaSwS+aYOZ6PbgzZcIkv9i7ruDOEJ5jXuk1bCWPMD+4HxSglxFu85DEw+g5UPabPtQIX9dVoQI3yNWLiBAkcY5a9qpdWCPrwS6hamRsjXd49w1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023494; c=relaxed/simple;
	bh=XQS+wkppmRUz9vtZB/fMBUTa/mSTPZhDecFyW4qIheQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jykiiZ55v2oRvYUPnPaFEQ/dZj0AkBH4wGvghffDlBg+gspyNmiBBThJkMR2ZX1ZURnz2qpw2iYhl7e3JEN4m6jbhF6M150y0YR3FmtoqVnJPGIQg/6h4A+t52XGp/yc004ztMofII/y9olcjj7WrOj0odmPX6TUkNBr5IBuZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoxNPG1z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoxNPG1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55AA1F00A3A;
	Thu,  6 Aug 2026 13:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023493;
	bh=QWCIJYBdf1Vr1nl4/C7Q2LQVneCNu7uCDjSKsXTeDqk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OoxNPG1zHsQLhYfcK7XcrbsJnbPsZXOO94mQNF7q6WEIWlr4y2Tv6PmsnrsXmTrOI
	 hMpfwVT6HcaWifoXf9e8u16CbC2KtX5O1WG4TN1ZCvWiYTCUiABaxSRMllrwKJ6hK+
	 F+kdcByZSBcVf07aABS6IjmAgIxWdsVNqsA9pEG3vpABfBxGe45AWYpEM/5msgFC4/
	 smzMda896V/02Yhpr1wt/Hn8Yf1dS28wzZxTCjVFry9oK9tJBAEJ2iYwc7Nh569MNc
	 1WDyVs/v6wF4m+XU5+XHW/O1mNQcvtx6VUQpiPLlOQDU201gu7vNWwPq0G0HsvHUPN
	 VDAMT9jDyCkig==
From: Lee Jones <lee@kernel.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com, 
 m-chawdhry@ti.com
In-Reply-To: <20260723100605.628882-5-egbostina@gmail.com>
References: <20260723100605.628882-5-egbostina@gmail.com>
Subject: Re: (subset) [PATCH v4 4/4] dt-bindings: leds: backlight: Convert
 TPS65217 to DT schema
Message-Id: <178602348845.2925958.12911324342700206975.b4-ty@b4>
Date: Thu, 06 Aug 2026 14:38:08 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 23 Jul 2026 10:06:02 +0000, Eduard Bostina wrote:
> Convert the Texas Instruments TPS65217 bindings to DT schema.
> 
> During the conversion, the following updates were made:
> - Documented the 'regulators', 'charger' and 'pwrbutton' child nodes,
>   which are used by the boards but were missing from the old txt
>   binding.
> - Documented the 'interrupts', 'interrupt-controller', '#interrupt-cells'
>   and 'ti,pmic-shutdown-controller' properties, which are used by the
>   am335x boards and read by the driver.
> 
> [...]

Applied, thanks!

[4/4] dt-bindings: leds: backlight: Convert TPS65217 to DT schema
      commit: 95231a92250ec6d04b295b912ea42135875f6c53

--
Lee Jones [李琼斯]

