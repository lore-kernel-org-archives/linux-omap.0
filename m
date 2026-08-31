Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E21406261
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199879; cv=none; b=JY55zsEy+xGocU8AIUIk37sbaFPWGDLHQvQm29yK9NmqcjVT7WNNfHDaL3kf5NjHzrBz3RsBxs1vD51dyOTeFux64jzike4Vws9Z5uD5vuVdC5WTT72evciL8gOPcLOsfpbpKnGyy8h/prib650X4G6Dz1gozNhm8GwwlRW08qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199879; c=relaxed/simple;
	bh=bFwA0sriWkTlKXRDjn9IKo6h/KLj+VklQAPyEN2y9fw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SP6whkg7boBCdfBq5vrVQ6cbda3XtYHXdM4bHYrCW2uxjicCEU4NzTTA4gykqKW5U3oWnCrwSyaCByqCexOio/uLwloc73nX2P94P0uT1wl7pBkzjCIwt3mVOXy55YXre814vUPvY2GEBkKdw60bHjdypuIVAPLg58T67qlA9kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YXX+AqM1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YXX+AqM1"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8534d507f59so4213272b3a.0
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199877; x=1788804677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPRLJsmBIOe0A/ppcX8+UUJeiiOHfTZv4IvoKZ5g4Q8=;
        b=YXX+AqM1DIvN/VJGXXE+xbzosC/g9aU1PuKZFMZcqT5veZpSLaZDLma2P4IjEXsM4s
         aSeojHdFdc21MIGB795dL9VLuXYXjzrpqwGTivic4J1ufbeBjaXQfVfnC3iThmX4rJYK
         Xk+96FTfYz3WjpJxEB99Q0GTCtAwC9LMKpusJNug8MDMu4+V3QhKoQ1m/fPy6eL4ZwR0
         xXs2YriHfyl3JsJARWvfMQiG9WHVYLJrc6UWF2oubjQFR5nMdEXbOhmNBpcgprGXiqdk
         Ek7qyAI16VS+YaCqu1NfovXxzSNPIDWNXFD8SvT+OhAntxYitvcGNmGe6xAuXj/imijI
         LJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199877; x=1788804677;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qPRLJsmBIOe0A/ppcX8+UUJeiiOHfTZv4IvoKZ5g4Q8=;
        b=UmsVKdVnRBZq3aQTCaciMU70cwXLKWDbvqdMPDcnnV8k4wZ0kLlnTCuVb2E+XpFR0e
         SHUi6D9VhWXtiRtdxknf9dmUVimASafp5yfpwTnFreKrwUP30CQq1SKr2U/Aj+T+XSI2
         AD3IXs2mM7JQYbwQzlqQF9btUksSuFPwJcRFNKMzXIJJYXYWebxK4oh2kvFqoRLe5dI2
         BIKH2bjYhvis9suYpWVeHS6S9fa7VEjENA4sR7U6Q/P0IVwqGdJGZh7dOktstdunHqal
         yh+tp22sdkMkSjwQK6lc7BNr54EvXZiNu9w4q6ncne9+V89RwspER4rOYrqENOBUtrxa
         16Hg==
X-Forwarded-Encrypted: i=1; AHgh+RoXw/ALSsoCfVOMsMTjYn/dIK0GObCDHvDihSQNbIGbVMK9Ooq3lw/4H97BzdeQW+oAyCFmMgwzE4rq@vger.kernel.org
X-Gm-Message-State: AFuF++lGDBwZIHhod5Is3PbA3Kon3NexIO5Y0DqolxaiQgwEjD7KXmgB
	PXXUfZ2Pb/6QIgENYX0edqhn2GhwvAQFXpNdIYXqtIvbB3etKTPeYywkdgKM5PRcYT0=
X-Gm-Gg: AR+sD13y6T6dDIRljSONnxobRgIH9AKicT/d3GGZWMP0SzzEWDAt1id4Dp9kUxFm6Dt
	v0qARZDzLnkZ04201GVS8CfzAPaSj/iRCA+74sGGjGaxRQ/VRPMZRmCwlT9EJWQj34pGf/K3L8D
	ylS4FyqTP65uJ86ylEhnr8eR7/XhuIeLxxQE7d7fzqShfcFCFAnvPnL3gkxtNbn2cxcmABIvibM
	tuWdhuI1QzpnMxGwMUYBMPwxup4K123pU2cSl00Maa3DijJBnkIAGTVU2pyhO5C2lkKM1rJx8fh
	mRwl21ofe7pQjVF4o9yszNASCcP+rwSpqaGbn9mFR/miAFmr9er/6M30Ayp0U+SMQBQlGooaGm7
	7bNFGNy5/1viy+J6vsugOIJu2ybxx1CuVCDGYbq7a+mm9+s5g8RWq2dInxZXMQsJz3g0Zb5DvAr
	Mc9Kig7g868rLw0ZnyZ77d16zT7c05welpTGdZa9s9vu3Cgqm4/6w/r36zUg==
X-Received: by 2002:a05:6a00:348d:b0:857:7337:5dbb with SMTP id d2e1a72fcca58-85773375f79mr30960283b3a.25.1788199876932;
        Mon, 31 Aug 2026 11:11:16 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8569fa79d0asm4201641b3a.14.2026.08.31.11.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:16 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260806070306.40285-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260806070306.40285-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3] ARM: dts: ti: omap: Correct white-space style
Message-Id: <178819987124.2869653.12350593238892028766.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:11 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Thu, 06 Aug 2026 09:03:07 +0200, Krzysztof Kozlowski wrote:
> Correct a few white-space issues, like missing space before bracket '{'
> character or spurious space, which will be flagged by dt-check-style
> ("redundant-whitespace" warning).  No functional changes.

Applied, thanks!

[1/1] ARM: dts: ti: omap: Correct white-space style
      commit: 0fe80eafa36a20fec620ba16992016137bbf3d6a

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

