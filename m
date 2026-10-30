Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356474;
	b=AuJpKsrS7KayipwVeUDEPuAORHTZHdX8SNr8s8rbc/jc7UYN8jYmtZNXveLDBtyR8WFo
	 R9DhZGAbvxoI9QlxHAIZR8hV1gzsW/hvCO5s81jn+9QvSIvXhM0vvP1J9GUVeTxX/TL4E
	 eQf46OKAZ09q1x8YHpe6nQyxGOBYeuVlaHNKKwWh8FwNP2k5/P35a3dZU4SIB7P1fZcO9
	 lAOYC/fMQQQJ0qrDDc8MZbfl6PYdAAtIMbIS9e/lZ8Q6638vrUAA7Sztv6o5Y97jHmvQ3
	 FNYDg6WA2gDzJGVZCAUjO7n1qITAi6pbCxXIFHvwdCnlaTSLyKogxE9QjvXPYXANBgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356474;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+SIrY3lV5sFHoGq82hO8Ug8L5qjWnUkl/nbUlfalUZE=;
	b=4OKui92ACJ2kV+SUo2HYSLY0kZ2wZYCafMu7QFXGOKY/nPCnVw8C+wZHFk4l9RvGcA5B
	 pvA4WJTgUVNykN4+ets6URTkmPnhJkFew7PSF9iQG9+fzf/1PZaOuupj5wDYoksLZPtKN
	 UlJT7Te3WkT8zbeHQO165/vuEmUWc4stVlYaoFzS6cDn1643YiT/5kpcW63++Z90HdYn1
	 8ptDgDr5oDMvAWLyzRQJXGGDcNdXbTwTgyAwqyd7gmaGbHPyBp56F5Ji1xOHYm1w/dx+r
	 JOI2t+CFuEtIEuDmyop4bibkaI5zllg0s//+hO0udTD0kCzyRdcOU/acRG0sJE9wM7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=U0+bGrtt;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207A360A3838;
	Fri, 30 Oct 2026 10:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 207A360A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=U0+bGrtt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=+SIrY3lV5sFHoGq82hO8Ug8L5qjWnUkl/nbUlfalUZE=; t=1793356473; x=1794566073; 
	b=U0+bGrttW6HKP6d69hZzL8HR2GtKq7Rggnc0n/xmCu1YGXjQI9ior9ofPAB9/8hUSlGaghrbkuW
	bhpVBrg8UNMBibppokevG3gKUPSNbx3liEdTELB22Pj/8SWg34+JQqxR1G++f+VWAQDLXGctmyn+1
	07hDGg7okTCttMjCu373kZJ4zqnCq/Tc26QqIpxF58ymxSPkgBbtp+LwLfzxNKUaK0eS97f+9ySII
	D1Q35iByRZU4iC4MVxRHikYsIcZmw4K2Jka/i73tbd+ZS/j9zHkHr+mi5XTAvds3qUZi6+XMsrfjz
	+Yqntni5mOTkP8IXqzVsVK5nUdNDocdqseTg==;
Date: Fri, 30 Oct 2026 11:34:24 +0100
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
Subject: Re: [PATCH v2 2/9] ARM: dts: omap: dm816x: use dedicated SoC
 pinctrl
Message-ID: <20261030113424.3f4f53fc@kemnade.info>
In-Reply-To: <20261028-patch-ektor5-dm8168-dts-v2-2-4544429251e2@linaro.org>
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
	<20261028-patch-ektor5-dm8168-dts-v2-2-4544429251e2@linaro.org>
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

On Wed, 28 Oct 2026 17:06:03 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> In the TI Sitara DM816x SoCs, the pinctrl configuration macros are not
> identical to OMAP2/3. They are actually inverted between Pullup/down
> enabled and disabled (third bit in pinctrl registers). Using dedicated
> DM816x pinctrl header to differentiate between the SoC families.
> This changes the effective pull configuration of the dm8168-evm NAND
> pins. Tested on DM8168-EVM with no functional impact.
> 
> Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

> ---
>  arch/arm/boot/dts/ti/omap/dm816x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> index ee0090f7aa64..261ebca8863d 100644
> --- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> @@ -3,7 +3,7 @@
>  #include <dt-bindings/bus/ti-sysc.h>
>  #include <dt-bindings/clock/dm816.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/pinctrl/omap.h>
> +#include "dm816x-pinctrl.h"
>  
>  / {
>  	compatible = "ti,dm816";
> 

