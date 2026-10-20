Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498618;
	b=uyPaS48ibfrvoIebHlMSP2Xb+59OMnCeSN3pvsPBTMki9jRZwWBSj7cn73McgH9M7gjQ
	 aW/2dXzNjGES/khWnwgtr5Kk5UM8ccDOqhTMmbzyoBBhtFIr+JIqiwPxll9vuRRTJPEvL
	 GE3X30Wladq6R9phwH20ZcKFsofoRGe75BZhxvuJBonoSPf3lMPMPK5om5o9c1oTbHaLX
	 Fq9+S5YK5h/z9YyuOOb2ZCg8KeTJuIbOa1OcnEA68cslXSmeIkU2Z4Y7lKlAC3gTaBUYO
	 daf9kWiU8vOuHw5ZaZD3iZJ/+H0miC3x/Kw0v74CKi821KAfltiWw6SpTgEO0ZmQ5pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=/eQ/XppcwzISrseZ5RcFWPSpwGbmbzSYupMPgcj1BFE=;
	b=lJoYiz/uzcoSX16JFth+tiJCg1jiPuIKvXxPXktXz9JfWjJRGFcm+KC+9K3ftLgBhZQP
	 NenwjR9+/ve/+jMnPMfrxyVLT6Vf6TqArAbRJUsojd09Gm+OWGUDNrv0zwBm9C8LHQTG/
	 vvd0o6+hSp89RqAv7i4fip1SN3noHBAbr35dcXSHr4R41QT/ZLq03O3t1exGY+4ono2ot
	 wG7tCPQytMjSNIquKJ4kLdVeETTZfaY8+mvluVZockvLB4S6xtVcSAVQLW+s5McjpKEmq
	 GpVE0bIXIl3BI4S80l6Id53SNeSK+/8rP4t8tDhG2QkG4oMpz4BB1fySNW09rlxpV4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XyHuAhl0;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E15606A31F
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2026 12:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E15606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XyHuAhl0
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2103841f8f.2
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2026 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792498616; x=1793103416; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/eQ/XppcwzISrseZ5RcFWPSpwGbmbzSYupMPgcj1BFE=;
        b=XyHuAhl0Ihg3o9iu+ZV6Mt5r2QN8C7rlBmRSdsYa81fuHYYZSOnxDoWvNIgUGEawb5
         ivqJTz66q91RngbDRNkaw/L6s2z0qhycRZKq/kozmieuzZapGem71jaX7SYHApsfagTz
         4zR2KY99z3O+t8esfmsuWCjBNuGsxl6VUO4nDVrAP8rye7FNOE+vgnPIh50J6KDdzc/k
         Nm89xIfOb0YZqt42r+owb6SzMPvl2ABryPkIwTo0aqTRszI/FBNXH8EQKZJgnPGidLo+
         KWnqS5fdtOfVIkhqnTdhEBTbTZ0aZHJs5bXoFpo7hzyA/qQg/7Ks8sGk3Bgr1nF25rss
         VinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792498616; x=1793103416;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eQ/XppcwzISrseZ5RcFWPSpwGbmbzSYupMPgcj1BFE=;
        b=Lu0LLPPd6/xSYXBt8woLrW1yo3NiWXxaRuZMRGXaQHGyqK6f+prJc8KrRUCbJhJ1TY
         WLx+gNhBMzbMsRgBUBMQfpEi4PZFMQDWalmSHPvrvhttKyMQnaTs0px4ywG6bps+FklK
         pYuU7iobfIKl4fD14yLhJ/tnuHhzMnPcjvxy75i8pP69ZNK1iivvoLU/H3J/udSS6l+j
         LvqItaIyr3uBENLNwfM6qhuZQ1QAWONmtLBK3x7ZPc+TfJdU7Fs98Xv+6tRtwA0zqumA
         uLz4O+jeI2drQQ3ExM33MSw2GYvZCVroev7X1eHE+ao3r1677pibw7Ic1vF7tgBQvBW5
         be9g==
X-Gm-Message-State: AFq9FYJkxOkdQTQhUOifUSfjulin1hcuG98D0z7Deo2/YAi7BoQ1Px7c
	79flTdt2aF5+Blu9sQzKC1DvFwN/aJoJ9J6eMOFvesrz35qWNhdAKT5BuR9vQgo3uYM=
X-Gm-Gg: AYBFou2LwtHmsyqwmSkguUA9x365hz2GG26kO4DrF53JNkeUezcL0AIyBz9/AqYlF2i
	OU9jCC8OHI5puzdzyi/1/ePpCemH+qt3+host3F72EjmzP+E4pnNeb3mplysyoD03oRkhGlgWqn
	uXzELuldU697kOxpikNrHX6lcRBGhc+qjbh+mfLEj7r6ot5mJfYQjfwo7MWSzX5RouqZwzTo8KC
	z+ts+2sVLsBmENe758FUm+KWSPJ95vCpBdvBTcOla0drLx3H73cNs4k2DFXAII9/yLM972m0j9W
	gSn0TWUyobgLP7fPg4LKUQSjh/kToJ4Esh9qzQ4alxofv9+0U7Yn8xP2iG/+0pIyGjyVME+70MS
	lU37KKeM+YiZ+orju+SCuCqWJhn6T25PNn6VtHu2A9kLzukE8qq9Zfq8MZlKHmj6rIkxqOyUH+Q
	eJuISa2UTCAwHcyJZqWj8g0IhO4S6uKgZiBvnI/rnJ2XXuzNmg9tP77rpIb5NiiljhMYIQlepfV
	VnoeAP1T6yXeX61TG4lpOzowNzoUZ4IB5e5NhqvMbnR+P/YQzulZdydSZapq5CKPzgIuVbXWbQ=
X-Received: by 2002:adf:e001:0:10b0:48d:f876:f370 with SMTP id ffacd0b85a97d-48e1bdf80a0mr5011790f8f.48.1792498615536;
        Tue, 20 Oct 2026 05:16:55 -0700 (PDT)
Received: from localhost ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d817d8bsm5130862f8f.24.2026.10.20.05.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 05:16:54 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 14:16:52 +0200
Message-Id: <DM9NQ6MMED9N.3QP4ZDCCAZ85Z@linaro.org>
Cc: <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 02/10] dt-bindings: pinctrl: Add devicetree bindings for
 DM816x SoC Pinctrl
From: "Ettore Chimenti" <ettore.chimenti@linaro.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Ettore Chimenti"
 <ettore.chimenti@linaro.org>, "Paul Walmsley" <paul@pwsan.com>, "Aaro
 Koskinen" <aaro.koskinen@iki.fi>, "Andreas Kemnade" <andreas@kemnade.info>,
 "Kevin Hilman" <khilman@baylibre.com>, "Roger Quadros" <rogerq@kernel.org>,
 "Tony Lindgren" <tony@atomide.com>, "Russell King" <linux@armlinux.org.uk>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Christopher
 Obbard" <chris.obbard@oss.qualcomm.com>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Linus Walleij" <linusw@kernel.org>, "Rouven
 Czerwinski" <rouven.czerwinski@linaro.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
 <20261016-patch-ektor5-dm8168-dts-v1-2-b4ce30217028@linaro.org>
 <ec27fd26-1862-43cf-803a-428846d66663@kernel.org>
 <DM6CUP7TSOMH.31T789KQ3Q6OB@linaro.org>
 <46414ff2-1273-4690-9001-4d1f825d8cf6@kernel.org>
 <DM9L7QLLNMOR.1NHOUWGMQK181@linaro.org>
 <c91b063f-69b9-4e9b-8e1b-af503de672b7@kernel.org>
In-Reply-To: <c91b063f-69b9-4e9b-8e1b-af503de672b7@kernel.org>

Hi Krzyszrof,

On Tue Oct 20, 2026 at 1:22 PM CEST, Krzysztof Kozlowski wrote:
> On 20/10/2026 12:18, Ettore Chimenti wrote:
>> Hi Krzyszrof,
>>=20
>> On Mon Oct 19, 2026 at 8:46 AM CEST, Krzysztof Kozlowski wrote:
>>> On 16/10/2026 17:07, Ettore Chimenti wrote:
>>>> Hi Krzyszrof,
>>>>
>>>> On Fri Oct 16, 2026 at 4:51 PM CEST, Krzysztof Kozlowski wrote:
>>>>> On 16/10/2026 16:41, Ettore Chimenti wrote:
>>>>>> Add devicetree bindings for TI DM816x SoC pinctrl configuration.
>>>>>> Using same definition as OMAP2/3 except pullup/down enable macros, w=
hich
>>>>>> are inverted in this SoC.
>>>>>>
>>>>>> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
>>>>>> ---
>>>>>>  include/dt-bindings/pinctrl/dm816x.h | 20 ++++++++++++++++++++
>>>>>>  1 file changed, 20 insertions(+)
>>>>>>
>>>>>> diff --git a/include/dt-bindings/pinctrl/dm816x.h b/include/dt-bindi=
ngs/pinctrl/dm816x.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..15aa15bca9bd
>>>>>> --- /dev/null
>>>>>> +++ b/include/dt-bindings/pinctrl/dm816x.h
>>>>>> @@ -0,0 +1,20 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>>>> +/*
>>>>>> + * This header provides constants specific to DM816X pinctrl bindin=
gs.
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef _DT_BINDINGS_PINCTRL_DM816X_H
>>>>>> +#define _DT_BINDINGS_PINCTRL_DM816X_H
>>>>>> +
>>>>>> +#include <dt-bindings/pinctrl/omap.h>
>>>>>
>>>>> I do not see this being used here, IWYU.
>>>>>
>>>>>> +
>>>>>> +#undef PULL_UP
>>>>>> +#undef PULL_ENA
>>>>>
>>>>> Why are you undefining other macros? That's not a easy to follow code=
.
>>>>
>>>> Do you prefer to duplicate `omap.h` defines? Only the defines above do=
 not
>>>> apply to DM816x.
>>>
>>> Not sure what you need to duplicate, but if you add header with binding=
s
>>> for this device, then you should not include headers for other devices.
>>=20
>> I basically used dm814x.h as a template which does that, is that not
>> correct?
>>=20
>>>
>>>>
>>>>>
>>>>>
>>>>>> +
>>>>>> +/* DM81xx mux bit defines */
>>>>>> +#define PULL_ENA		(0 << 3)  /* Pullup enabled  =3D> 0 */
>>>>>> +#define PULL_DIS		(1 << 3)  /* Pullup disabled =3D> 1 */
>>>>>> +#define PULL_DN			(0 << 4)
>>>>>> +#define PULL_UP			(1 << 4)
>>>>>
>>>>> I do not see this used by drivers, so why do we need one more header?
>>>>> What part of SW are you binding here?
>>>>>
>>>>
>>>> I added those (DN/UP) because they are not defined in `omap.h`. It may=
 be
>>>> convenient for future board upstreaming. I can drop those if undesired=
.
>>>
>>> Just add the header to proper place - DTS. These are just not looking a=
s
>>> bindings.
>>=20
>> Sorry, does dm814x.h not look as bindings? I'm a bit confused.
>
> I asked  which part of SW are you binding. There was no answer, but
> question. So if you cannot point which part of software you bind, then
> we can assume it is not a binding. I did not do any extensive look,
> because I assume that contributor will bring the argument in favor of
> their patch, not me.
>

Thanks for the clarification, that makes sense. These macros are only
used by the DTS files and not by driver C code, I got confused by an old
header (2015). I will drop the dt-bindings patch and move the
definitions locally into arch/arm/boot/dts/ti/omap/ for v2.

>
>> FWIW, dm8148-evm.dts is not including the header, dm814x.dtsi is.
>> Following=20
>>=20
>> Basically PULL_ENA define in omap.h is wrong for DM8168 SoCs.=20
>>=20
>> For a better solution, you would prefer:
>> - Keep omap.h in dm816x.dtsi
>> - Add a variant like DM816X_PULL_{ENA,DIS} in dm816x.h
>> - Replace defines in dm8168-evm.dts
>> - Add the header in dm8168-evm.dts
>>=20
>> or:
>>=20
>> - Keep omap.h in dm816x.dtsi
>> - Add a variant like DM816X_PULL_{ENA,DIS} in omap.h
>> - Replace defines in dm8168-evm.dts
>
> I gave you one idea, but feel free to implement it in other ways aligned
> with that platform maintainer.
>

I'll do.=20

Thanks for the review,
Ettore
>
> Best regards,
> Krzysztof



