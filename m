Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA563214812
	for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2026 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363577; cv=none; b=I994M53xH/3ofamJaB6D+Y7IjfvubyBPb7cqu7TeCA/RGtKwXlJ+KrulGqahxQiIkxxqkxqEYby4YLOFncDy6OO2coXMo/xADaa78x1lXSUC9lUbv1C29jaAJC+IebKMa5ilSdi1HhcWEiZERf+tMU2NB/nHkImJZtCMsgVGGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363577; c=relaxed/simple;
	bh=chhWq4uAe4OrP14p1imZ695PtBBTM9X4vzfnax+6qeE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=at7cy7YayoWybPtRPtKn9GPAaSzNN6VisT0FasG/qylYWEvacdXJm8zNsIwsRQhtyU1AX0WuKFrbfSNwAYp4xriUqAzWkr+HfysOD7+7NlnU2leCzPwUSFSuym5b4clEHqGdkYPxoV3dwHphkyRpZSGu2ZsFdaLJ8EUyQEonAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WtppX4aw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WtppX4aw"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c739561f0d3so1001521a12.3
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2026 17:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773363576; x=1773968376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6o6ff7eVbfuDrJqEdyLStBhlwqEmt2Z90eYP9YlVxs=;
        b=WtppX4awIp9j466rzQUPVHO+eY5HUMfhNKjfqAtm3yXLyK4cWW7V7DCvqHyIBzBLKc
         9G8t3+iAM3q3pLCGzkUWODlQvMxvatvY3L01U9WP2eza3PV197TqUAWWi9hSsD6GyaGY
         9Krafu3W4tzj2pVoDfyLJXXGdbtZpdLgOqtyZAFa+bj+iYRCNQPUX/ymipInc2uy1PHO
         y6YfOkNZUaZiJaXfSjhUYQF8nbKi6MjPK6Olf0QqO3Ii1zUZM2DkvvGrcSf821JlzydQ
         HuDa5aM10w6Ks1444/XEOOohYxhR7cEGd6+8kmhrvyWElW6J0EmASXYSB3UH8g62+6q9
         dCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773363576; x=1773968376;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6o6ff7eVbfuDrJqEdyLStBhlwqEmt2Z90eYP9YlVxs=;
        b=NnKPbsyxBJV8UcLa4vkWsMs4C5G12OrFIRDoo/m2vFEgyAcSnrH84g3GnB25iO6+Z9
         ly5CeaZMYBeCSoRSNa8IFqidqgNMZ57AzI9S/msdU9JopKslgQAiU/UAM2IBSh+0vUm8
         p2/wpzZAG7pbUaYSFYNK1RAMze4/gAmIdtnhLk8v41voLa2CMqbN9VSctlQaSBz9GaMq
         P0GOYv99fTMm+iro4zDhewikDOZ+UsLvH/zWN/31sakUf8MRI5SovJ1dUjbGGIR1REi7
         yN7T56bqUFQvc2peTMV0n15j5PI2ddp2EXqp3Qb2SHTOl1YHf/809aqYe1SAOPPMUjWt
         TrSg==
X-Gm-Message-State: AOJu0Yx3qOc7mKIAZgPTLcaXeTusDOyACbEkEIGFAnJA0N9WngvVBobF
	BlfJjPiIDL+CiOpVL/NnwhHEdfn87tNa/sTVzkHjt87TPTn/44CUWQpHO4wMVngkqQ0=
X-Gm-Gg: ATEYQzxFDKmSBiwNWn/hwCbGMqCe3zLxgHyhY5qMplCmyQpeZ3hRK4JujrzVYXeprl/
	yNJIVnOoKzNTeUSHcIpLGo2Oj0Wrc6jDPHSQfbWiAF7rSDSfr27TzCWRlbmDq2Z5TPjdVNivJsl
	87tnmSa53Vr2L3WEr2TZw4wNohL7VDYQXx6ryZe2afsazkm6/gs7zmnxZ9MWq5hrjTJ7jb88TKW
	NBRiY2gYowxgA/KmpJfuvm39bWDP4kdhlq80M2alJTSNNl1iXEdh4DS5kb+rcJqhQrQe5EzjNz/
	I1AIjDzB8N/79x826psGdVFznrGN6lzl0JXk9MR33yqx+NqV7uqscs+ZS3bZ4A/xJhyh03OOMkX
	D4Rs5Pbjlg7hDJDTwqQVg+I0nL9m7ZLDeuECqP4G7oZo8sEMrteCCI/OKxdyPISFEEYP0HON3xB
	fggqx96qu7HVQ75kcgaQI=
X-Received: by 2002:a05:6a21:1fc4:b0:398:a864:2bdb with SMTP id adf61e73a8af0-398ec9f0a10mr1109335637.1.1773363576079;
        Thu, 12 Mar 2026 17:59:36 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb998e42sm206862a12.12.2026.03.12.17.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:59:35 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Christopher Obbard <christopher.obbard@linaro.org>
In-Reply-To: <20260312-dm816x_dt-v1-1-ed3370b20799@linaro.org>
References: <20260312-dm816x_dt-v1-1-ed3370b20799@linaro.org>
Subject: Re: [PATCH] ARM: dts: omap: dm816x: Correct pinctrl register
Message-Id: <177336357525.480825.4683516533835453139.b4-ty@baylibre.com>
Date: Thu, 12 Mar 2026 17:59:35 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Thu, 12 Mar 2026 14:16:57 +0000, Andrew Goodbody wrote:
> The delcaration in the pinmux device for the pinctrl registers is not
> correct. These registers are actually 32 bits wide, not 16. Also the
> mask for functional bits is also wrong. Functional bits are 0-4, not
> 0-3. So the mask needs to changed to 0x1f.
> 
> This information is taken from the TMS320DM816x DaVinci
> Digital Media Processors Technical Reference Manual.
> SPRUGX8C March 2015
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: omap: dm816x: Correct pinctrl register
      (no commit info)

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

