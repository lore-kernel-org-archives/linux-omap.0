Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F83A7839;
	Wed,  8 Apr 2026 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775639463; cv=none; b=cTFwjyvb1rviZkn7riSgbZDk/Ef+nlnHaW7zB5XnnklCHziCZEBq/iVSz0da+wr1BpkcV94NOfEsEVM+LEjidolO5t4wOKnLZKfW6knq2naytP7tvJk6Xb6KH709iW6DXvC6xJIWx4A2FYpljAmNPVXB8Xn7KC2n5WREXRnKvF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775639463; c=relaxed/simple;
	bh=2VV+jYCUy1KUMjQ952zuke1nZqlR8VBr0ssTABOVfMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfS1etu7V6nPrgst4JBoPWrC1gJnw3OBvGRxND3N8xnfUJd9U7txrSgosPZg9uLEh7CUim52mY2yPmeUplUos/4q65Nkwxb3M+dUrakXlI6u7A5KwiGAinA6ZSoy13yzpfRArsUtesnmWPqYuHQzuRblsXskhGgA3ldhYlJ40s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+PJ0We1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+PJ0We1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BDFC19424;
	Wed,  8 Apr 2026 09:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775639462;
	bh=2VV+jYCUy1KUMjQ952zuke1nZqlR8VBr0ssTABOVfMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+PJ0We1keeJf67c5ymP8UhsDm73D9gznBNPMNOK94g18/nMlL8u80sz0SxjrwH15
	 FRLmKlDDEtJsIVGJ14D3fKPHgqRvJPrzfMA7rMJfVRoiYajWlsMSG/GJ6XVtqXRd+d
	 Omz1tiTCKhdvoDdwyXJsuDgC0DL+P48QCeU+YCUKbW6pSGNvldncxlJVkPg9F6+sew
	 G3StpZjKFHLV0FaB6vO8NnDraDTXr3mXY4UqbDXsA+f4ckRp2wmVFzg7/HuDYwlrNE
	 YlZ8m3cCcT7/PvX41ffwecnU3iUUWJLjdhmvrADnw7rSmKxk04yKCoc/RWmS6AGEub
	 zh+1QiOyTWN1Q==
Date: Wed, 8 Apr 2026 11:11:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:PIN CONTROLLER - SINGLE" <linux-arm-kernel@lists.infradead.org>, "open list:PIN CONTROLLER - SINGLE" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: pinctrl-single: Add
 brcm,bcm7038-padconf
Message-ID: <20260408-crazy-efficient-ara-05233f@quoll>
References: <20260407235611.550515-1-florian.fainelli@broadcom.com>
 <20260407235611.550515-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407235611.550515-2-florian.fainelli@broadcom.com>

On Tue, Apr 07, 2026 at 04:56:10PM -0700, Florian Fainelli wrote:
> Add the "brcm,bcm7038-padconf" compatible to the pinctrl-single binding.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> index 9135788cf62e..afe7329a1df2 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
> @@ -38,6 +38,10 @@ properties:
>            - enum:
>                - marvell,pxa1908-padconf
>            - const: pinconf-single
> +      - items:
> +          - enum:
> +              - brcm,bcm7038-padconf
> +          - const: pinctrl-single

If there is going to be a new version, entire block should be placed
before 'ti' to have some sort of sorting by compatible.

But no need to resend just for that.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

