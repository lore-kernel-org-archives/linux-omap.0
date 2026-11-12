Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504285;
	b=dAAn9HX4WKV32CN4yRkAnLrp3gEr1U0jw4WH90ouvD1v+yJDRcIX5fBzOFy5og2VVGZI
	 LTXCoQNwqEugg5lfmJFMc8CpajjDAtd0ariimCYvx3i8F7Cf+zO12ixaBSXP9urEj6/kn
	 b1fX4fAeQPtCZIGwcqidMnwCF6Sr8SjTAD8BlGp4K5kWqsuCsR0JNCkLU0fj6ADszOA1V
	 ODrhjaBaFi8B0M0bbgS87YSdU7JJHk1ZjcX0YlPtC7GjVrTps6dDV864R4QM+0/BAO7MB
	 KjXw3Q3m58LAIJAO+FxcQVryVfxnU6HZ4M9XEwGxGwwK3gNCQG/9FJsxr6YNQ4QS/mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=63GqtMOoRCSgTES87IYM99FUWTFMCt/NCzNwfnUy7NQ=;
	b=PFZXPHfSllGRWN4wIYN0JG+C4ukAFXHETjxxMQIA5nz3fECxPgRu5y9A15vd3MCT3tXH
	 8QE2L8ZBh1dgFgdDJ2A1/ZwEngQXitgFU3AuNtTJHZ/aTkGKYY2mjUI0do4twUH+WjFGZ
	 rwcyX3no24vekBqpvrbmawSfhjv2TWZ1gbl4z0n/2qhCLM3z23h6cupRWdJF1ghttLrcu
	 KOKPxvGbDb1ABrYwNofGbeeztKUBoW8shiIY4JclgdYOgKs0IAgveiq1RqfTPZTgB3VtR
	 le5Vglb+Omo2ChfZ/IEfeyLJ2PIuzI0bWyi45Ir9PDz25b9VfSdMzBRpLigLSUspvMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Jkq4Sq6O;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F69606A32A
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 17:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97F69606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Jkq4Sq6O
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso384505e9.1
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 09:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794504283; x=1795109083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63GqtMOoRCSgTES87IYM99FUWTFMCt/NCzNwfnUy7NQ=;
        b=Jkq4Sq6OAnX2Pn8crvoZY/dPHwNqhLbPwejc697m552ymFXmCwb8mgSJDNjoHBJSfW
         tIFzq9E9UMQ6Zrz5YL6hqU4SGwxC9vY4m2Q9YTa1cMiceV1fi27oJIy2zDMhS9AXHfr3
         PCUGfo6dENOKRHACcC/dhXJw6byn0SPI3uAmx+PVYV10g3Ht093LpdeyDCRKpKdML7L1
         H49jcbL+vdUyoDN5a5X0cMQMvvSsH42atYkcQekL9cRQf8o03fJXv0bPYUM81xlIFenN
         LILZhm8+RVEO5xBVnA1JR379R1QuIflz96BYL+YRxcfupaJQlf8SQ1pQQe91Nhb42iAQ
         iKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504283; x=1795109083;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=63GqtMOoRCSgTES87IYM99FUWTFMCt/NCzNwfnUy7NQ=;
        b=suu7GC0oaSj9xWJ7wySAItw2M3TYh+Q6A68MIvaxWq27yyiKNalmcHcPh+X8Di5Jor
         njgMKEtHGy8UqooRaekvxzP1j97BuPX24NBSz57bipMTOZPbfDR/9eNFm/FTZhrkberT
         vZ4Nb1pxEtKLRbJAIggCphiT0XDYPKGsAQvaI8L5hNW7oh2YwvaVWEuJ3J9uBmF/mnML
         M/FtyQjwFDTfvHItxxHdcdOa09ZyF5joknViy3TJle0jLe6Sxnj2oV2SE5naugNTjPAS
         iIHEyxa1sJ50Kz2u2wshi8g16TQZk97YIydJon9xRzknXWTjQepNjj9qAg4qJ1cvEhMV
         /XrA==
X-Forwarded-Encrypted: i=1; AL+hErHHifLi5lrAp2IyzGLFbHsuowRsmGSIS7cd86Y4Ul29f99I/BRq3SMTDy5SDHyXTScA2u182i+VvOHe@vger.kernel.org
X-Gm-Message-State: APuU4Z+79zSvnzwNERkR+ECcPwvOJ9Ptva07MYF26v+d4+3s0nR6QuAA
	WDisUmaoi7OdU93cvVNjqDtDVCc1dFnTaH/Fpyy0e0VFNEu8ZGXOGI767dPDunftUZw=
X-Gm-Gg: AYBFou2MrGFLTYaWu+n76LM+SUxHYHAxtKTPyxjsG0XQrcQzwSGq42uwpBfm280m3Br
	3o6TqpZe/0IsRpGcZTGI4yviEjy8/P9SqmZukV5S6/HaQM5bk5OhIFrngO+uvb73JYz/MKztJn0
	jk12eQ2Nghk6QGF4GoROdQ5vC1PIPRcUUk5r6XC7axvS79+zIopNExDd8DJVTz1rl5II5mEP0cP
	OA/u2RmaOSaD3gescdFBqtOv8ybSyFrItIUPRVnryQ33BZ/cv73OBJ1rW0qS3Xy86gu5O4VkzbV
	nBmSkAQVptL470rm5S6tF/pK/STxfBxD3fJ8FHanm7TltuGQFKqYoyhSkzLbMlbiLnaSeJHUeBS
	dKdodbuRDmJ7pHHbJGSckg/2iZSD/qMSuyJpSG5Np7CFbdCbTWkOmRbunoRbp0mWNRm9kqQXJ1d
	2Pba2emfJRuuZ2mcYR5Y2AHqA8I/E7wX+blDR36Bh5lL5RA6mRaOP7PPYK31w5tskHrfnHaSDkj
	/o57hAkPG3Jo7lvPWXH97aM9mkWuEx4UiBHSpS3v5nXV0uy+jaYkTlHpeZhq0yMpI/WmoptkSii
	TRwoK27PZBeQwATynecvS+Vc5L90+4pP2KuDDav04zCh2yYpQ6v/Z7CQw7m2A5gxHfKTbYiSwZ+
	bpM3UedPh
X-Received: by 2002:a05:600c:a46:b0:4a1:f625:2108 with SMTP id 5b1f17b1804b1-4ba093940c2mr116502295e9.33.1794504282924;
        Thu, 12 Nov 2026 09:24:42 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:b442:1e4f:d5a4:2a21? ([2a0a:ef40:e16:1f01:b442:1e4f:d5a4:2a21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60d9fff8sm345018f8f.52.2026.11.12.09.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:24:42 -0800 (PST)
Message-ID: <38a09248-032a-4144-9e56-6d52eef8c077@linaro.org>
Date: Thu, 12 Nov 2026 17:24:41 +0000
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] clk: ti: fapll: Fix clock speed calculation
To: Brian Masney <masneyb@kernel.org>,
 Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>,
 Michael Turquette <mturquette@linaro.org>,
 Rouven Czerwinski <rouven.czerwinski@linaro.org>,
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
 <20261028-patch-ektor5-dm8168-clk-v2-2-dc6bf0fabae4@linaro.org>
 <179444595968.1126566.8596406047613157255.b4-review@b4>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <179444595968.1126566.8596406047613157255.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2026 01:12, Brian Masney wrote:
> Hi Ettore,
> 
>> The fractional part of the divider was being treated as 1/10000000
>> whereas it is in fact 1/2^24 (1/16777216). This led to incorrect clock
>> speeds being reported when a fractional divider was in use. Correct it.
>> As well as fixing the clock speed calculation when read, also update the
>> calculation on set in a similar manner.
>>
>> Fixes: 163152cbbe32 ("clk: ti: Add support for FAPLL on dm816x")
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> Should there be a Co-Developed-By here and on the other patches?

Not sure about that. This is my patch but is being submitted by Ettore 
in a series of patches that affect the clk system. We were working 
together on a project and at times each produced patches. Ettore has 
collected together this series for submission.

>> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
>> ---
>>   drivers/clk/ti/fapll.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
>> index ae2f6fed10f6..8ab9acd57b60 100644
>> --- a/drivers/clk/ti/fapll.c
>> +++ b/drivers/clk/ti/fapll.c
>> @@ -336,8 +336,8 @@ static unsigned long ti_fapll_synth_recalc_rate(struct clk_hw *hw,
>>   		v = readl_relaxed(synth->freq);
>>   		synth_int_div = (v >> 24) & 0xf;
>>   		synth_frac_div = v & 0xffffff;
>> -		synth_div_freq = (synth_int_div * 10000000) + synth_frac_div;
>> -		rate *= 10000000;
>> +		synth_div_freq = (synth_int_div * 16777216) + synth_frac_div;
>> +		rate *= 16777216;
> 
> The 16777216 magic number appears multiple times. Plugging this into my
> calculator, I see it's 1 << 24. How about adding some defines:
> 
> #define SYNTH_FRAC_DIV_BITS	24
> #define SYNTH_FRAC_DIV_SCALE	BIT(SYNTH_FRAC_DIV_BITS)

Sure, can do.

Andrew

> Brian
> 

