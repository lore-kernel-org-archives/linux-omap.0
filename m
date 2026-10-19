Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4A44C4EB;
	Mon, 19 Oct 2026 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392395; cv=none; b=fkq0CC8BV3vgIdSoiFlItfhtvgFrVnjbQ7bdi3//Y1KTPfVxyQb1RgDbymGBWpoXHD2j63Lbj37RegMz5wWfwdG66WebTRfr463sorPa3KXi1WQ6InZ/FMNqTj8m+//oAMa1xaUtPUUkB4ozHTQoHrl8dFs1QJW5MiCQvAHsKoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392395; c=relaxed/simple;
	bh=37I9CARlFCU1xG5fKvhYTBKhZLC0V9LSdCg9kfryZoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzcmxtt9Dd1AEHonP232KyQcJyONQNh27I2xfp6B3Ft5pnjP9N59MPpQ8bHoMMvF9KIwEAc+7r5c3PH5tSavK4eUGPmT5RRoXJdhVcUu3fnv7Wc9NEFytf9Z2ir4lOcPaACDaH57nYLh5Uoox/+m2hK8DegcIvZO6/q1GnKhOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANIO6COD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANIO6COD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127BB1F000C4;
	Mon, 19 Oct 2026 06:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392393;
	bh=DGoXhPoI5376byb4Q1/FqBBP93iRO5Sm+PEzaj4opog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ANIO6CODbaC7na1giOrLiQRtvtz6+SLcf9UMTdeaHhEumMaZnm/YeWpusrCgBxbDT
	 KWTKXDifxZLiwQPlzXXZMHwE7BS1aQi+rIvPO+l421j5MEGHXt1ODYgC5xVjdzUB6X
	 nLTzHG6K5cLu70OD+ssyFqqqnFNdiV0hXfU+UwXeUCBANmN1oxu2vp8ZhMFSz2C2XA
	 QUTC721QnUhVBZUSyHzHwbLNt9w7u5HwczAysL6CUsy2UThPZDGSwlD3jOsb8TOhF7
	 VPAoAI5/Ze6LmTlKpIUZNmkaE49cy/pz7TkW21ox6qggkd50Jx7Hg/Ld9WswClvcfi
	 QGqhZwyMcK7fQ==
Message-ID: <46414ff2-1273-4690-9001-4d1f825d8cf6@kernel.org>
Date: Mon, 19 Oct 2026 08:46:26 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] dt-bindings: pinctrl: Add devicetree bindings for
 DM816x SoC Pinctrl
To: Ettore Chimenti <ettore.chimenti@linaro.org>,
 Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Christopher Obbard <chris.obbard@oss.qualcomm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Linus Walleij <linusw@kernel.org>,
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
 <20261016-patch-ektor5-dm8168-dts-v1-2-b4ce30217028@linaro.org>
 <ec27fd26-1862-43cf-803a-428846d66663@kernel.org>
 <DM6CUP7TSOMH.31T789KQ3Q6OB@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <DM6CUP7TSOMH.31T789KQ3Q6OB@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2026 17:07, Ettore Chimenti wrote:
> Hi Krzyszrof,
> 
> On Fri Oct 16, 2026 at 4:51 PM CEST, Krzysztof Kozlowski wrote:
>> On 16/10/2026 16:41, Ettore Chimenti wrote:
>>> Add devicetree bindings for TI DM816x SoC pinctrl configuration.
>>> Using same definition as OMAP2/3 except pullup/down enable macros, which
>>> are inverted in this SoC.
>>>
>>> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
>>> ---
>>>  include/dt-bindings/pinctrl/dm816x.h | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/pinctrl/dm816x.h b/include/dt-bindings/pinctrl/dm816x.h
>>> new file mode 100644
>>> index 000000000000..15aa15bca9bd
>>> --- /dev/null
>>> +++ b/include/dt-bindings/pinctrl/dm816x.h
>>> @@ -0,0 +1,20 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * This header provides constants specific to DM816X pinctrl bindings.
>>> + */
>>> +
>>> +#ifndef _DT_BINDINGS_PINCTRL_DM816X_H
>>> +#define _DT_BINDINGS_PINCTRL_DM816X_H
>>> +
>>> +#include <dt-bindings/pinctrl/omap.h>
>>
>> I do not see this being used here, IWYU.
>>
>>> +
>>> +#undef PULL_UP
>>> +#undef PULL_ENA
>>
>> Why are you undefining other macros? That's not a easy to follow code.
> 
> Do you prefer to duplicate `omap.h` defines? Only the defines above do not
> apply to DM816x.

Not sure what you need to duplicate, but if you add header with bindings
for this device, then you should not include headers for other devices.

> 
>>
>>
>>> +
>>> +/* DM81xx mux bit defines */
>>> +#define PULL_ENA		(0 << 3)  /* Pullup enabled  => 0 */
>>> +#define PULL_DIS		(1 << 3)  /* Pullup disabled => 1 */
>>> +#define PULL_DN			(0 << 4)
>>> +#define PULL_UP			(1 << 4)
>>
>> I do not see this used by drivers, so why do we need one more header?
>> What part of SW are you binding here?
>>
> 
> I added those (DN/UP) because they are not defined in `omap.h`. It may be
> convenient for future board upstreaming. I can drop those if undesired.

Just add the header to proper place - DTS. These are just not looking as
bindings.

Best regards,
Krzysztof
