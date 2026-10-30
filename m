Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356274;
	b=uCd3MGcCDZ+khTOgWVvj63mVXR/38fShIOf/CyJFtKrLNqsJ1C8jrw5rMgFwRYp5HLnT
	 ADITqi0NUS8bOhKdhXr91zX+NVNGzvLaXdJHMCLYBhTNssickb7kFC51JcCqcaKsOnhJD
	 Z/4WSjP3IbeojT6fdlmCsIdUGTDjzUReG8zOqs0nsoXvMVJfK2Ycls9XlwsvrQoNyzcc+
	 5QOwUrR10wWW0D7QJFTpDuGAJhfRXOlnocp0GSy88Hg0yZxxeRxFOMv+PxX1U4XHWqY3U
	 SBv/GqLmoXYCA3VFynbf+k26+XUqP1t93iN1Wj4NCStK6S23ChsQ054V8FY9xzn2qVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356274;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rDB876/ff+fBnvKU3vkMsJPrB3yMK9FSKQEQCqA48Qk=;
	b=qnttbREQtPHOcX1up4yVMrXmo9vQ7fAZIEL7Tb6tBAGHw0methKg4ejnkEcK2ztuz5xT
	 Lauwgjd4uOya9yJo2EPzeEeTxTs5Z/El7BySy7mEsN1SRO4aLrbm1m0PfkgI8lXmmb4so
	 pqcbFAAypJyilgeyNCIUdTitw4aVN0k9wWGlxmk+QGey3LCq/8Hbg66m/xDPSRT8nVjP8
	 6Y8l4VhCtGXW4ydoYsLOGGWZj8E6UN0I2u0NuZv02bo4QbS73v6BqdVq1snP11Uq6yIpu
	 3q/yabtaqxNhGUuH1l1eI228fIGplBCTKUROwq9vUVD2VAt1CJH6xW9DJvKe5TruOHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=rpi2pbA6;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431DE606A325;
	Fri, 30 Oct 2026 10:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 431DE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=rpi2pbA6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=rDB876/ff+fBnvKU3vkMsJPrB3yMK9FSKQEQCqA48Qk=; t=1793356273; x=1794565873; 
	b=rpi2pbA6ef11vCe9Ivh+TbHb/Ix01uAtK37wORuD90ahOWaGfFKg2CMwYhtRbyrK7xfJNnKDUdT
	TI6L9r6+KDJz325yGgpH3Dsazn0IEVNyvZfAOg5sRAPJ5XoqUjErlhcUxb+nEXjx7kosjUsyLQWJq
	K7vBxZGw2JPd/UCiPQ12121ZYpX27gLNEdbNPwBnBhMz9suSh8Y1Kcw9bYz+GBDfbPh8PonUZWHCK
	YvxO/cuqI0y5zIWAv+i0pwTLbhboVveizLQERQIAJFNo6zyK2xGxDok3PEhSjsuP8WRVA2DKU/xvd
	WR4dJRuzAM34pe/MRmvXTCu6EHhCFI3lfwWw==;
Date: Fri, 30 Oct 2026 11:31:05 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Christopher
 Obbard <chris.obbard@oss.qualcomm.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Paul Walmsley <paul@pwsan.com>, Russell King
 <linux@armlinux.org.uk>, Rouven Czerwinski <rouven.czerwinski@linaro.org>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/9] ARM: dts: omap: dm816x: Add specific pinctrl
 config defines
Message-ID: <20261030113105.15042e2b@kemnade.info>
In-Reply-To: <20261028-patch-ektor5-dm8168-dts-v2-1-4544429251e2@linaro.org>
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
	<20261028-patch-ektor5-dm8168-dts-v2-1-4544429251e2@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026 17:06:02 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> Add pinctrl config defines for TI DM816x SoC pinctrl configuration.
> Using same definition as OMAP2/3 except pullup/down enable macros, which
> are inverted for this SoC.
> 
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/ti/omap/dm816x-pinctrl.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dm816x-pinctrl.h b/arch/arm/boot/dts/ti/omap/dm816x-pinctrl.h
> new file mode 100644
> index 000000000000..b93f971cbe95
> --- /dev/null
> +++ b/arch/arm/boot/dts/ti/omap/dm816x-pinctrl.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * This header provides constants specific to DM816X pinctrl defines.
> + */
> +
> +#ifndef _PINCTRL_DM816X_H
> +#define _PINCTRL_DM816X_H
> +
> +#include <dt-bindings/pinctrl/omap.h>
> +
> +#undef PULL_UP
> +#undef PULL_ENA
> +
> +/* DM816x mux bit defines */
> +#define PULL_ENA		(0 << 3)
> +#define PULL_DIS		(1 << 3)
> +#define PULL_DN			(0 << 4)
> +#define PULL_UP			(1 << 4)
> +
> +#endif
> 

