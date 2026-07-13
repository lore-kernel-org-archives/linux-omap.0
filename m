Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F363DEFFA;
	Mon, 13 Jul 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934412; cv=none; b=fpjAFXdxSUNEhy3fVAJzVw1xing4XrLmVVm6Ai2Ug8ezzbv8d+4Bq4sQBmGe7up4Ukx6lg5dzYZ0V4IORzIjQnmcpHuhfgsM1Lq8ocFVIU3mtOC5EoazGim48wzN1ICZWMyoa6ghgv62/36NbN5u1nbx1cAyVqWcyv5m3xZKHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934412; c=relaxed/simple;
	bh=56ECmLCWIwuFRjqIshq8+MEA2uwaWWj8NR6L+hjVXLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCZdb81y5dfBL1HmRtRROz5a3cRHdMFih3XQ5JaxW2KQ6US2/w+pm1XbQSVZ9x20C3l9EdOuLoaIXKNHrcKg2oDMiOEz48o3TltS8iXf0ZBaCnIoWQwsWjtXjysrX5BMlTdv0nLraTpeexcqh8Wwgaj6r+GIHsxOKbC8PB+sQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkkbTShW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkkbTShW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3911B1F000E9;
	Mon, 13 Jul 2026 09:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783934406;
	bh=KPn/0kVgFXc2JWBOxwYgPrEhEXzzno6JbbLqrG3d9Rg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QkkbTShWayZC/3S1cAmazn3mBVL0/FckQSgwfNDI9s3pWVxbPyiDw+/eYyCbvkg2f
	 gmOdrozdDCKP4fyKKyrmRgCqAmf4y6jGLRIFnCc4hqyqUJly9fczBooVYmzQ4QdlOR
	 2+4MmaH6FtOk6be73jHItrsAHrdUXLSntNM8SdqYkzpH1Au9jMJokajOKlRDbG7FE8
	 TKdwWoofiVVWIHgfA97gMGRb5UKayPJqGPfCOCr0z4GV8q0To7qQp81tarJA7FYp5u
	 Llv4EVzX1ExaVM+t3oaqUESVqfP/jHClnVW7MrNziUtAv5ChnIFap/2syT5bbMITXs
	 b7wvWEX9I9WUA==
Message-ID: <17497012-97d8-4c52-89b8-f433179f1eda@kernel.org>
Date: Mon, 13 Jul 2026 11:19:52 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] dt-bindings: twl-regulator: Add bindings for
 exposing ti,twl4030-regen
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Grond <grond66@riseup.net>
Cc: Stefan Leichter <sle85276@gmx.de>, Grazvydas Ignotas <notasas@gmail.com>,
 Tony Lindgren <tony@atomide.com>, Ethan Nelson-Moore
 <enelsonmoore@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Andreas Kemnade
 <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>, Richard Fitzgerald <rf@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Niranjan H Y <niranjan.hy@ti.com>, letux-kernel@openphoenux.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, kernel@pyra-handheld.com, mfd@lists.linux.dev
References: <cover.1783749722.git.hns@goldelico.com>
 <00718b18253a764c2a7c9a2b95c3b8c411796583.1783749722.git.hns@goldelico.com>
 <20260713-aquatic-memorable-griffin-cf9e46@quoll>
 <3D58F644-3EAA-4BE7-88FB-1DCEAE7D5768@goldelico.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <3D58F644-3EAA-4BE7-88FB-1DCEAE7D5768@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/07/2026 10:26, H. Nikolaus Schaller wrote:
> Hi Krzysztof,
> 
> Thank you for the feedback.
> 
>> Am 13.07.2026 um 09:39 schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>>
>> On Sat, Jul 11, 2026 at 08:01:48AM +0200, H. Nikolaus Schaller wrote:
>>> From: Grond <grond66@riseup.net>
>>>
>>> FIXME: not reflected in the bindings
>>>
>>> +Reguired properties:
>>> +For twl3040 REGEN signal:
>>> + - regulator-min-microvolt:
>>> +  - Same meaning as in bindings/regulator/regulator.yaml, but must match
>>> +    regulator-max-microvolt.
>>> + - regulator-max-microvolt:
>>> +  - Same meaning as in bindings/regulator/regulator.yaml, but must match
>>> +    regulator-min-microvolt.
>>> + - startup-delay-us:
>>> +  - Same meaning as in bindings/regulator/fixed-regulator.yaml.
>>
>> I don't know what that means.
>>
>>>
>>> Signed-off-by: Grond <grond66@riseup.net>
>>
>> As explicitly written in submitting patches: we do not take anonymous
>> contributions.
> 
> Thanks for pointing this out. In more than 10 years of contributing, I actually have never run into this specific issue before.
> 
> To give some context: this is a contribution we received on our mailing list about 5 years ago. We do not know the author personally, but the code looks good and has been thoroughly tested by us. I kept their Signed-off-by because I didn't want to falsely claim authorship.

Take the authorship. You are allowed to do that by both DCO and common
sense (you are not doing something immoral, unless author shows
interest/hints to fix it by themself).

Commit msg also needs fixing/rewriting.

Beside, one more nit since there will be a new version:

A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

Also, please wrap your replies to mailing list wrapping style.

Best regards,
Krzysztof
