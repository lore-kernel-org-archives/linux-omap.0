Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227118C2C
	for <linux-omap@vger.kernel.org>; Sun, 15 Feb 2026 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771134499; cv=none; b=u0E/TRjNGP+MfmbyIYMxkmSsLRjg9ArhQj2aqyVL9JUaJU8avOiq7SVZ1wWCxLE61yHVOWPZrimlK4nmqY+wOT+SSOS6Mz1EcqvH/HslYjjoRw5KEneIvPg1yLR0w5Q+W3gQJzAe8g/Tu3SljsHcdOsBPiQyjXXwK63p89iXqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771134499; c=relaxed/simple;
	bh=5URDJWoLCpr+Om63hjZ88pppsyVzXpiTCCJDPdvVwpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7B0jwoO4i4frnE1ptxUe57p68OKD+5/p/jKSmd4DY6fkc7yr13gAranzIwBFObcfEsk+TrAnEhf0tZmABkY5zn4Zto7a55zJze1zb8mDS145uJ9LLl3eVIfUcJxd8f352lUpJBpReyL/8WWFVtjSQiKvylIRG9S2Saq0jLEePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZl8Djqg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZl8Djqg"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824af5e5c81so2048732b3a.0
        for <linux-omap@vger.kernel.org>; Sat, 14 Feb 2026 21:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771134497; x=1771739297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B48NNf1YJcuHdmdFyYwGz74LGN+blqEWKGYew4mmQ3Y=;
        b=FZl8Djqgb/OekQ4L6njDWiM4QZ9k8bwLgXkPYpOYzIF899gcPD1rlweYc7wM1up8k2
         208rYBH4yx4tclPxmIS7aHss5TOvaO6TL3knibmeFDqkWXDwl6Ep4pIXFbxnJlv14IeG
         WlBxTI+9C5AhW7WfRr2L9MtWnmsur3u3Gcnu2YwgNF7AQL5Ak5jQk+ZEinf4vL9ZyVqS
         M1TtRGnopDisUs6p+AYIm/lLWV8Di+lHpHpyRTcqL7OZ1TlP48pnNWF1988V0PPFlOyl
         qOAzBNLaNT9TiNGN2kuz1NJ6Fvs26rcG0hDpkEeRGE2WFJcNbjBhhFxstAVTtlp9e9x9
         aCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771134497; x=1771739297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B48NNf1YJcuHdmdFyYwGz74LGN+blqEWKGYew4mmQ3Y=;
        b=NXJU8GvnllYo6nyf7G4e96nREZe85qFaPjCcwOep+5QtIjKIK1fdNOSeL3Z5bVsqAy
         fFNVC8Cewc4ezafZZve4cKU320Kx6XC/KWKgcd1f/ClOt5Zy8oOddixt7Bkz7U322wVe
         EGEcPUO4veT2m7Sf2BBIUsiEMZ40bCE9o+4PMNP6Zmslki26JEqQidTEYOOXToZOuaon
         L8GWxWYSXkqjQqamEx/N8CD0PONiEGg8QPyqJH5JVIqXQRDcwx4du56JOBIPAFyvesj/
         8z1KTSyXlHiDt7Ao7T9X19S76BMOebsZsESfZC14nE+vbIJ+auR0utRRv7GbYTt9peeg
         gNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWApQdJoHFTDxYRHmvgdQLs251z+SDw8Q/iG2AmU+/0Ggq9ojUot19vX7JxEROrMRO7c3TuaT93Xc8r@vger.kernel.org
X-Gm-Message-State: AOJu0YwaePvqsVSs/zL1ZU98V7EsKiRutbOcNKxl/iuM8hLSHW1SJOhD
	WCRmPLXJi1nzVYsd1mduhGRwBLfsZZXx826wu1dMfVBFzVPvtzMufQsc
X-Gm-Gg: AZuq6aIPvNRaQgJT6IixH2IG0Xa+kF879byFQSiloHlE4v+JM7XXeaio9TiSewuJ/jW
	7TV82le18n+PEOq+bm95cDC1Jji4cMdWmVPeFEiRjvYGw6NcJqqmPcvZTNr1lJeaKm/TvKhUZou
	JQFEhFz23ZU7wX3mAUAePwRQ/x+or5+u3kcuRuChegEFB2oJmG+e5r7DzOAu8Y+v3OZKvlfGwAL
	Cu5yYqBczfc1Ing7apXu4JBl9dG5ESq0O/EEe+0ymMXBllXsn8k+gGoq9a9rh69YtbpI46IQ4+F
	0eTRsndLT29hsMjt+RD6cjmGCYGFOZB7WI+B1Mpq3HAfLEz3RpxQ5p7Hj0qCgJoPzeF7Sdxc25/
	SuPbvBwttlGfxxJTBZ56m0TYhVFKXdR6toZcyJQazLja1tRvVPxYYKvZGXghwmN8mTy/ckWIBWb
	lC45R9ucy7VIfVtatxN4G9vEHZ9ZJCXI7eBBED2kwcsCY=
X-Received: by 2002:a05:6a00:a883:b0:81f:22ca:257 with SMTP id d2e1a72fcca58-824c5ef0916mr7245870b3a.20.1771134497374;
        Sat, 14 Feb 2026 21:48:17 -0800 (PST)
Received: from [192.168.1.4] ([27.7.171.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b6a17fsm8677833b3a.34.2026.02.14.21.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 21:48:16 -0800 (PST)
Message-ID: <26b05fa5-b985-4e21-b848-7427044b04c0@gmail.com>
Date: Sun, 15 Feb 2026 11:18:09 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v4 0/3] dt-bindings: phy: Convert TI OMAP control
 and PIPE3 PHY to DT schema
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20260123-ti-phy-v4-0-b557e2c46e6f@gmail.com>
 <177021985530.133434.13436195442562231016.b4-ty@kernel.org>
 <f60156a6-58af-4548-9dc3-71c71b822343@gmail.com>
 <20260213190054.ezblztj3blmhtywr@skbuf>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20260213190054.ezblztj3blmhtywr@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14-02-2026 00:30, Vladimir Oltean wrote:
> Hi Charan,
> 
> On Fri, Feb 13, 2026 at 10:06:16PM +0530, Charan Pedumuru wrote:
>> On 04-02-2026 21:14, Vinod Koul wrote:
>>>
>>> On Fri, 23 Jan 2026 15:39:01 +0000, Charan Pedumuru wrote:
>>>> This series converts the old text-based DeviceTree bindings for TI OMAP
>>>> Control PHY and TI PIPE3 PHY to modern JSON-schema (YAML) format.
>>>>
>>>>
>>>
>>> Applied, thanks!
>>>
>>> [2/3] dt-bindings: phy: ti,phy-usb3: convert to DT schema
>>>       commit: 62c9ff8fc20d23c0dc36be1330734fdafb3e8585
>>> [3/3] dt-bindings: phy: ti,control-phy-otghs: convert to DT schema
>>>       commit: 7878306d182a1750583a325a29e5ccab9ce0235b
>>
>> Hi Vinod,
>>
>> You missed to apply the first patch which has DT node pattern changes
>> and now this dtb check fails in linux-next as these YAML patches use
>> the updated node pattern. I got a report of errors from kernel test
>> robot.
> 
> If there was any request formulated to Vinod to pick up patch 1, then I
> also missed it while reading this series.
> 
> Usually, dt-bindings patches are picked up by the subsystem maintainer
> while DTS patches are picked up by the platform maintainer. If you know
> that there is any dependency then it would greatly help if you could
> mention that upfront, or even specify how you expect the patches to be
> merged.
> 
> In this case, I expect the warnings will get eventually resolved when
> Kevin picks up patch 1.

Yes.

> 
> To avoid warnings from being introduced in the first place, you could
> have
> - requested all patches to be taken through a single tree (requires
>   maintainer coordination with ACK from the other one, more complicated
>   if the files touched are under heavy development)
> - requested a stable tag from the first maintainer, to be pulled in the
>   second tree
> - send patch 1, wait for a merge window to pass, send patches 2-3

Sure, next time I will follow this procedure. Thanks.

-- 
Best Regards,
Charan.

