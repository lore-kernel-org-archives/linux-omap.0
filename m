Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24175364EBF
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2026 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325886; cv=pass; b=gKlPOFCgpd2fsRM6oabIgXUUHFqWlQPHuenIbUp68NtjKZ907Ptt86Qcpx2irKz4QAq5No/r5JlFbqTmg5Kw/DQpIWAcDM+48o/a96rX+FekQ4JovAfzl4LrUnG2bQ1k9f+f9egt+Q5ZKWO8kFho6fKjvVQ4VcCIgL1NMRDZR5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325886; c=relaxed/simple;
	bh=O5wzUHBR+3e64aFZg08UiCLbrD6OQHF1JiFe9rzU+xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nfm10dK4BY7HPVsc0LwYi/VkXNAsJWsryQAHjEDLS6C4IviL1wB3SIhchyCbDqLWgVibdEZQYfYWMr80FzwXrMKI+Mi/FxQgMGOkOM1kqLEJrTNmjdQb9MQYZUhERZgUAFw5p2IPg/T7EEPGQzPFDHENBM0MRgZ0r7xwzFEY4NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wKrOOuO1; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKrOOuO1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48538c5956bso11151635e9.0
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2026 07:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773325883; cv=none;
        d=google.com; s=arc-20240605;
        b=SwUibjmiWnxG35ZffDnHPWqF2NHE4s5/oKQDYBV/vF7KQ61RIEmiU7txB3crAvsl8r
         /40eI6t1BUIWOyesyJ4J/gvMFGM+8PD9ksFR+kPg+PuYxDaUpdsJot1xVI58Pqbq8mAs
         NEwrSJHPlMkWcAMaCTJBq7hDEV5bXBLmSG2MOmE5Ntdi4DxM/5FzsGMEylUzviInXzta
         5cXnJoE1goLs2+FWBVAVNEeYZvMVA4t5m0nusS2pCopteAuLibbb/gir9ZTJFNs9xmux
         uZH+NHlfnSiWhaxb84RnD2QHruaegSpN6kRkXsse4zLaj6fDBmCdD5nqjCY4g0+CYkqx
         SpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O5wzUHBR+3e64aFZg08UiCLbrD6OQHF1JiFe9rzU+xI=;
        fh=DAwXgAFSQUUf8vdPInnwPPU1QJMkXcQAEne2MB3F9WU=;
        b=cGfLHeYVwNa5mJc67/JEopVnx9CgVhAD29hh48XLUzR4OSL8VICRghBxmVgDbGhbe0
         zHH3+9JHFe6ig8r1z/PROpJX7L5JuQaXBf7Hwj4UITnQr2NOHngvwl8pAVg3ckBW8wzC
         bC2IHW6poe+edstkwfmwWq3R4SA1RCH9ysI2xg421O7belDzT2Fm9a0ojVOeGuGHBcCC
         SWKc0EjUpGS4Q02Z02hUx1omFdAM5vq/g7Dt1EVKkFuACylPxLLNb+EplcVO4Z3Z9ITs
         jn5/27zcMSvGEVye93BPEg+sRipD3FDjve7Ikfl7SPvCkO6vA/KYXpBE1RCP2Riz501R
         yZMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773325883; x=1773930683; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O5wzUHBR+3e64aFZg08UiCLbrD6OQHF1JiFe9rzU+xI=;
        b=wKrOOuO1mG55INSNJPYkYuHSsUGO+pAgNx6NLMzQnEoLCqDeGmQ6YWEIE0YOqT60Yk
         HgqpJK9QUhHsQb6ZonNG8NYzAI4n5/nbw04MkMogArpM0RP8oj/0Ar2hylK32lZ93Q31
         U1Qp7Zf0zXoDPeszQh3YrgQowP7d77FgggYutXh/OqtmTJ0WmsObrq1LYbp/0NJZfKD+
         u9MvqVvMSJnHyG4LaiBg9ULrQxJlgyMHzjRS1iczjGjsmcMCOuEbUuJnNu7Sz19WRQPt
         3xbCZsPjcOcal48OaMbAHCCfbZvn2+rNFy47uQyV8R8lJLAiV3cpmZVkUqV/rraJOvjA
         ucBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325883; x=1773930683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5wzUHBR+3e64aFZg08UiCLbrD6OQHF1JiFe9rzU+xI=;
        b=TwNrHQsDaah9FaWoThZTXvWH+iXpGK7boMR2DWa5sdD04x2kT2WS7iV3XahdoixNbz
         ncM+1piVxgUrjSZdehWFNmZrFhPy18vSRJEBfQ2uj9aFqAsvk+sgQKOgERl0aEZXUDHh
         9BQ+2GCVETuuRmNTaul7cV/wTjab3v5U4EPJeTbIYGSf8Ce2PhdKZoB0oxJATY5FBnhQ
         hO93Kv4RWqsa8+eMcKDnq1PeJBQ9k3NN3on32ze5+dyJzjM6e1R2O3OM0DWp2A7hefmK
         O1Bum8n8fQ/oXms07Km6vB6qvDQGiyRI6/+mAF5juOjrnlAnfl8DX5pdPL06PlOkiQUe
         k1mA==
X-Forwarded-Encrypted: i=1; AJvYcCX+j0EzfC/i8Ef2bdju5Tp6U4dVXr6ho//XSbg7MHRBj4F7wREgw1qJY8rLKAGKc5A3/byn2MwqVUjK@vger.kernel.org
X-Gm-Message-State: AOJu0YxL75OXNrwi1IDk6Lw1Gsdl1tfEfrNwgdpoGp+XNemDwteOwvQl
	TTTVUbuUBdfDcIe0YT9gkGwfy5sND5w6oDf0Ll/iOKFsVFadvoeM0Xf+l8qEwJCWKqUA+PzeYI3
	UHCR6G37fKK845LI3zrzjfQn3uOnVUPC0XR+PJYtzSQ==
X-Gm-Gg: ATEYQzxT7Hut04xElDR16CuEUpwRFliji+FZ7TQf+My3vNeOKqzidF34TzOCDRWWFu5
	v+TXonh7jgrOmn4S9H4La+30wC5MgYXnucqU96rqyhlSAsjps8acu/we6IPvRklfB3qTwUsx9gK
	XiY5t7I01uN+L4GZZwA08AYwnIc096kP6MyEHHpNecuiXCosL7oFaoTa24ZPvGsykENwBLIc8nl
	hJXdCEvRUscxvabYbDH70/dvUxHxZjMKlPvCUY+xG6E5NwYmLLHsXQARqgvsuBNgOS0YzS/rwA3
	amSbw6oREQ==
X-Received: by 2002:a05:600c:699b:b0:485:3b4a:f707 with SMTP id
 5b1f17b1804b1-4854f58ab9dmr57263335e9.10.1773325883251; Thu, 12 Mar 2026
 07:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312-dm816x_dt-v1-1-ed3370b20799@linaro.org>
In-Reply-To: <20260312-dm816x_dt-v1-1-ed3370b20799@linaro.org>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Thu, 12 Mar 2026 14:31:11 +0000
X-Gm-Features: AaiRm50OisYRLOPDejDC5cFdFmSwOUMKBVpwbng_4BfDEKjcXerkyFxKATsAcAE
Message-ID: <CACr-zFD6jiDJH4i6m0fdEimT84ZPJYi-=ENUzAsavqE9gkpQxQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: omap: dm816x: Correct pinctrl register
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Thu, 12 Mar 2026 at 14:17, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> The delcaration in the pinmux device for the pinctrl registers is not
> correct. These registers are actually 32 bits wide, not 16. Also the
> mask for functional bits is also wrong. Functional bits are 0-4, not
> 0-3. So the mask needs to changed to 0x1f.
>
> This information is taken from the TMS320DM816x DaVinci
> Digital Media Processors Technical Reference Manual.
> SPRUGX8C March 2015
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org>


Cheers!

Chris
