Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2412D40DFCC;
	Wed,  8 Apr 2026 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653287; cv=none; b=KqBnnjcBJDwA4g7nXuSGtL59dTHGUjrc56sYCDjtLrozRicBx24gyt9aExQBOJf6JZIlF4cWnZUcBpvMLPWJwVWwWyjmM+ske0cKeo2n9t1WE95Aywkw90qWCQvWNEKx7BxilFU5eFo1sbF6eGAgH56J0LKBEcpE9E/sZMC3kUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653287; c=relaxed/simple;
	bh=1Hfafoc3ly3D6h4fKTZQjQMqxuMvV9JkC8Aiwyu0Uek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbsasVCwtpmuJbz6kLTy10fdtGx19Be/ZH/p+u87fsZxOZ/WodfutJ1dKFOced8MEVi1g0ZYVxiq7IQd+icPSx9VIIFKRy4uX1sKOr6C+djunbSrPRLXslyS0a4+NIfP6ebGN1q6Z8DgpyKVFqVFwBMxTCvHV2e0BznuauCw6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sxxbf7W0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sxxbf7W0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C58B81A320E;
	Wed,  8 Apr 2026 13:01:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 97D82603CB;
	Wed,  8 Apr 2026 13:01:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05E69104500F8;
	Wed,  8 Apr 2026 15:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775653281; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=huJ2L2oU4KHAc1jGEiaYIFEB7ZxYHbo7AAGmz4+EcxE=;
	b=Sxxbf7W0mx8PnpL1cL6CN8adOPRwJvhsnrNFSR2B92ZaTRlNr4j3J81ZklNxTe+JD18Fy5
	aiHv87dopMvi0ZBGL/tPjcoM462tB0eqQcOHDmP0O0EVHClu9pMvKIIZ+zzKvVk7uFEyLd
	1+ExHpOp5b51uwQxzt8PuM/TfT3MuJ924dG6y55a9/ieXKr06JWmxTgWW+Lbl8sEbhS7ku
	sFNANslJ1JhtLQUghBjy62yLAMcTzslkxRPRZWNzG8hmIvP/mpYFy4WJ956GFC3duCdMXy
	AdKYBzHjc/z0FUSkEEsPKHSXHhTEZeqNLi6jN6a3l1yyx0EMwc6gSCDDjqK3mw==
Message-ID: <c7c6c8cc-fafe-4b27-8dff-a284d399ee32@bootlin.com>
Date: Wed, 8 Apr 2026 15:01:16 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] dt-bindings: regulator: ti,pbias-regulator: Add
 pbias_sim_omap4 regulator
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
 <20260330-omap4-fix-usb-support-v2-2-1c1e11b190dc@bootlin.com>
 <20260331-funny-impetuous-bobcat-eb56af@quoll>
 <9d76f827-3967-4ab6-b6f0-77d1bd564278@bootlin.com>
 <20260408124109.GB1864812-robh@kernel.org>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20260408124109.GB1864812-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/8/26 2:41 PM, Rob Herring wrote:
> On Wed, Apr 08, 2026 at 09:58:15AM +0200, Thomas Richard wrote:
>> Hello Krzysztof,
>>
>> On 3/31/26 10:22 AM, Krzysztof Kozlowski wrote:
>>> On Mon, Mar 30, 2026 at 03:43:59PM +0200, Thomas Richard wrote:
>>>> Define pbias_sim_omap4 regulator for OMAP4. This regulators drives SIM_VDDS
>>>> supply and allows to unlock USB I/O cell.
>>>>
>>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml b/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
>>>> index 3e020d87701b..908fbb46b5cf 100644
>>>> --- a/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
>>>> +++ b/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
>>>> @@ -89,6 +89,7 @@ allOf:
>>>>                contains:
>>>>                  enum:
>>>>                    - pbias_mmc_omap4
>>>> +                  - pbias_sim_omap4
>>>
>>> Names cannot be fixed, because they represent different board naming.
>>> Why growing the deprecated style?
>>
>> Okay, so I'll drop all if statements, add a regex which matches
>> regulator names and fix the regulator name in the driver.
> 
> If a driver depends on the names, you can't change them.
> 

I mean the new regulator I add with this series. At this time it does
not exist yet in the driver.

Best Regards,
Thomas

