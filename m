Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDA372EE6;
	Tue, 21 Jul 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641900; cv=none; b=KSsEzbNeBvCA7CwuuitALz7NLqGgKDaZgmE3sLwQmHUdAn15AzkJtdy1RbkR/WJ0PpgYiIrF+M4js56o5m9zVNT3MMSOF5Yu9KXRJkZ/wj+PeqpFF4P4b6brYI6A9jK2nxG4cTMOKMux0E+YxbMTsRIC6xw41/PbNp1nDm3ro7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641900; c=relaxed/simple;
	bh=4/1JWH2XC9txDuv1VIhicgMyc5N7e3OQsvPjKFXbAkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9/jxrPJjChn2ugultW+3UjSbFCPdk4cL24RTe96n6hx7bo/ZlqRiBhIDN7xLbcUA39tBOMEbhmruB/VSLLjEBLkzPSo7mWffdDyfoJ/7CJ+pH8aR9c2p2kjqzYXrRl5orfVl8Om+k+O9sgSTLPPueYVSqnTrJ6PBFd6O01P2lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eopWyjO5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eopWyjO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C081F000E9;
	Tue, 21 Jul 2026 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641899;
	bh=bOlfvU+gfcD6cyQgkDN76b+sgroGf+CaPpJ352nDoo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eopWyjO5X0uXCxhQx8ZBJaEltB0EJRxxcO0Xf8fdJkNDZOBgpYFYUoJYFP8UWEOnH
	 3W9x30ynFwe7ZYN1aE5c8MtnV+78mPbSIEJi6OpCCDXSgMD7BE5NKhOPrm204XVIPN
	 VelIC9BEjJL9McT5vAhGv80MMzDvdle0AzfpxTG7FGelclDvWBGvnjAVr9ERYSQpUq
	 nO8hNBcoyuJ+sb6YNiy6GDoy4/hYZlZ6uMc0Cfatm8OGNLIZTzkwKW12u6rJ7sdYKZ
	 Mp6OiV7usAkcQyDi8J+rOnoUqFUOd6wWO4QjndGrCyPQsOhIv4nxqxX9940RPz0lcB
	 ZgOHwtxehnaHQ==
Date: Tue, 21 Jul 2026 08:51:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, linux-omap@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>, goledhruva@gmail.com,
	Roger Quadros <rogerq@kernel.org>, devicetree@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, daniel.baluta@nxp.com,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	simona.toaca@nxp.com, m-chawdhry@ti.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Convert TI Palmas RTC to DT schema
Message-ID: <178464189827.3459871.4940309738542756272.robh@kernel.org>
References: <20260719141008.3562347-1-egbostina@gmail.com>
 <20260719141008.3562347-2-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719141008.3562347-2-egbostina@gmail.com>


On Sun, 19 Jul 2026 14:10:07 +0000, Eduard Bostina wrote:
> Convert the Texas Instruments Palmas RTC controller bindings
> to DT schema.
> 
> As part of the conversion, declare 'wakeup-source: true'.
> This documents the Palmas PMIC's capability to wake the system.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../devicetree/bindings/rtc/rtc-palmas.txt    | 32 -----------
>  .../bindings/rtc/ti,palmas-rtc.yaml           | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

