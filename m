Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B4387362;
	Mon, 30 Mar 2026 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888858; cv=none; b=ghNq+3eD08NQzYoACOMiXek5Ga6m6mVolfqrIH7O///GR9OOuZxjGpOLY3K6ZdUMiXR3lEO5GRflitQPoydL9idopIyUgH44KLBiYQAGjTpJoOMYIuZBQqcRg090ozZNr1xlTUaY6APSXwNOuRGXrkrxrAf2EOO3VnD/2aGK7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888858; c=relaxed/simple;
	bh=bpeWtipLnVmfOQRtesH8geWVIabjT0Ic4+iwHw6Yd78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0nAh2r/x3lKr+nhaeC51tImiPsOKgDp5yDAfPGiz+zFGCcCZiHlnwCLTIsX0NL0Ya/Gje2A8PXdIhDqykHUEZvVQnr4UjlrpQA29e+I9ublc3xeSWVCjphTGxiXw01TMJDwhUC0/L/NE+gTLKTJbYMNXfDS7mVeo7EidWae46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GTCzhQXv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GTCzhQXv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1C343C566B3;
	Mon, 30 Mar 2026 16:41:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D86A45FFA8;
	Mon, 30 Mar 2026 16:40:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A760B104507B4;
	Mon, 30 Mar 2026 18:40:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774888853; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1GVIJ14Rcnu3aWGSyZMGL/UvjT6CVFMLKw9tvpzQihI=;
	b=GTCzhQXvVWcDqCGJtMD7wlkyB3V2ABlOK4iazVK+tIYFW5nIv1n9Rb5XMJ59l9i5o/5uy+
	SKsCFm4F+bk9tp2ymc2R3aQat6jdnlDBtYPfee0WvGlZA0Ipq/0SUPIMR0h2CEUUIokWrY
	jmkhCUtgBel6dqpLauLB4R+7Je0NHrWd+uWYrWzM9PMRD6EvnUq+uPMa6iUCgUv5M5XoHe
	i24mEnFNW9iSUY0Kn82FifsHhVAKEXfs/FR/ikOD8huCJUTSV1DyuKlR49xOf8nGCwAGFv
	+vI69oOvEUBcUq7c1kIsJr0J+x/1F2bDNzNQmIeUt5EQStQ27vJW89Vs41hnzA==
Message-ID: <e9f864af-190a-411b-b6cc-80e6a29449ba@bootlin.com>
Date: Mon, 30 Mar 2026 18:40:49 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] dt-bindings: mfd: ti,omap-usb-host: Add
 'pbias-supply' property
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
 <20260330-omap4-fix-usb-support-v2-9-1c1e11b190dc@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20260330-omap4-fix-usb-support-v2-9-1c1e11b190dc@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 3/30/26 3:44 PM, Thomas Richard wrote:
> Add the 'pbias-supply' property, it is used to specify the voltage
> regulator that provides the bias voltage for USB cell.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
> index 3b5b041f0321..d0a61dec4961 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,omap-usb-host.yaml
> @@ -83,6 +83,12 @@ properties:
>  
>    ranges: true
>  
> +  pbias-supply:
> +    $ref: /schemas/types.yaml#/definitions/phandle

I'm sorry, I missed dt_binding_check error. $ref is not needed.

Best Regards,
Thomas
