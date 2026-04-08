Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866F39891D;
	Wed,  8 Apr 2026 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635048; cv=none; b=r4/fOSPUaBD8FASVjK7eIZ7uwiPJZwppKOFKA/my2FaXgBzz+9mFoeZomHRdq3jakkgMllbtwYqSELCzFlQc+sYmj/C8Wyl4bwOUaaYXubOIuqKbyUg6Nt7bi+Ugl9geTDN0s7b0IUyhLFuNlXZtjUwg4G+0cFEt5LyRq6nPAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635048; c=relaxed/simple;
	bh=RLGEFpyI9pvm/PlKN71Wt8S04ww3ygVZKp8oCyzHPEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEmAuIw4PvAXqgrO9t+KJWUvebfyhu4HHw2OzUOFz7q9mZPEjQL1fTZLQesRyGSvnNhobmp7nx8M+ceTKqC3nMScVmfX/HZThjC6rQovD/9Ksm+/oGnZOVXc90iUuwQNPT2qRqOoqv2tqmPoEe6AJrglMPOSNu+gmYELBqe+1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tuQ1FZ2o; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tuQ1FZ2o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 230B94E42978;
	Wed,  8 Apr 2026 07:57:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF7DD603CB;
	Wed,  8 Apr 2026 07:57:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22A8E10450313;
	Wed,  8 Apr 2026 09:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775635043; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=VR6odhlK+/dkz5N+TCsylMiayDUrGCxEmji/ieXKteg=;
	b=tuQ1FZ2okNcwPg2TO6vf/DwocO2xVMBHT+AAzfg/45MgDpQ7ku+5U1ePHAn7E+fZd+SqI5
	HTpLB4OyBjA8JRKQjrW8PNM48Zi3J9pQ0iUatTbtIaca/W4u9Vuk1vswHAxouT7fpOAkcd
	LXAzW6PXAR8W1+X7sdMMqVXB+kIyHKmi0cVrOzWll41xtbFHpod05IAxG0Gg6WXGXC9OKJ
	r419Og3E4JKD7qLsM+A8o3lAoVhzWmU7uTkilhzjKHkmYEEZIaMgQbOvPMyVoZNpxMS6Ff
	JbIzscAwdeVM79FKS+420NkFCk/6yr6iS5jOQ5QguhRmYyIO/grf5K/I22nTZQ==
Message-ID: <6b637950-2018-41d8-bdd2-27382a9b67d8@bootlin.com>
Date: Wed, 8 Apr 2026 09:57:20 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] dt-bindings: regulator: ti,pbias-regulator:
 Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
 <20260330-omap4-fix-usb-support-v2-1-1c1e11b190dc@bootlin.com>
 <20260331-demonic-boisterous-spider-5ed5c6@quoll>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20260331-demonic-boisterous-spider-5ed5c6@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Krzysztof,

On 3/31/26 10:21 AM, Krzysztof Kozlowski wrote:
> On Mon, Mar 30, 2026 at 03:43:58PM +0200, Thomas Richard wrote:
>> +$id: http://devicetree.org/schemas/regulator/ti,pbias-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: PBIAS internal regulator
>> +
>> +maintainers:
>> +  - Thomas Richard <thomas.richard@bootlin.com>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +  PBIAS internal regulator for SD card dual voltage i/o pads on OMAP SoCs.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - ti,pbias-dra7
>> +          - ti,pbias-omap2
>> +          - ti,pbias-omap3
>> +          - ti,pbias-omap4
>> +          - ti,pbias-omap5
>> +      - const: ti,pbias-omap
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  syscon:
>> +    description: Phandle of the system control module
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +patternProperties:
>> +  '^pbias_*':
> 
> That wasn't in old binding and underscore is not allowed, so this needs
> explanation. Old binding mentioned only the names.

I did it to match existing devicetrees.
I guess I should define properties like 'pbias-mmc' and 'pbias-sim',
then update node names in devicetrees to match binding.

Best Regards,
Thomas
