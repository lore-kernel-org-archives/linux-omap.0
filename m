Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEE368264
	for <linux-omap@vger.kernel.org>; Mon,  9 Mar 2026 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093229; cv=none; b=NlpyIRd6lmxAnrUUVCUKOf/SexesfFuydN8dOO+jkOU7PepsL4DA1fEuk0ChtGwDDg9rtO5P0UtOBVAbneoF/Kl2pqsRcn4H8re+3UYTfkloRiMqK0PYnDsX47dqeAHfUTzfVvpMYOKiDgyViyhdq6h+ZHD1NBaz2it/tEQr71M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093229; c=relaxed/simple;
	bh=hW7oxczAfLOiX1UbKUB2maxX7hRC/oqrpS/3AHkjstg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tZ1BNVkXQV+JYM4SwBwuYCa4R0N970RRN/pHaUlGezJVoF5x29jGgKvlV504POIjG1Pf7cQ5UCzgEekbkDuGTNU3WmNn+LaH52i7WvyO7jELS2KNNGsvfSFf7n5y4mnEfR2KRz07iI/nl+g6rYl5Hw0Tsjxey9FeaYqSF7ZMJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d7CQG9kw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d7CQG9kw"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829759ca646so2926532b3a.2
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 14:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773093226; x=1773698026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oksk2SC8l8gNKVZ+ppxouzhJxiVNngQ5O52QXz7r3AM=;
        b=d7CQG9kw8xeFRUmtNgsgtuHKbXluaLN2aHBMyESWlUCeAp/IC5XRb1IQIAFo2//KHH
         a6tl6p4lKRV+s9pVtFA9LcVxTSenPV+zAZ/vbEvB0pwupbrxgeD3TAbAkiTjkjl7x66P
         1+A0mDXt9J8t7zefAZZG6pXCYCUTjoLJWMqS1IKenlR5sFSpI9K81EK8D0sLGhNGbe9O
         D+r1BDhXTp2MS0jCYNkLww+9FFOJyoo6bEaR1Tyxoau8zar+qj/5ZSXn6hM6nJWvEXcW
         2zGXYPwV8xHpiis5qFZHCG3E+32gdMwxm2yXgn8ySw7htk10PPi1/wYTThf3Ik9qCI5e
         +27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773093226; x=1773698026;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oksk2SC8l8gNKVZ+ppxouzhJxiVNngQ5O52QXz7r3AM=;
        b=mTXYnLfdcyU2MMYELSm6IshoKAicGdpxzvGUxUoIhphD6SPZ0+YrSjQeWUJr6I/Fkt
         Hx8fjqA6xq3NuoAw9DQidJ1NVeMgMvsO70V9zvi2PBaA6BtdriVKxqcmwR1zGyStznVX
         5gFIXeVfQJZiET+DZrcWVi7LObEJ4TRZWhBiLR7w5y0zSDw2A+6BtTGGVY7eKjipOZS2
         uGAj8827Afq+Ghfvfo78pONxKx08iV0YrV5hhcPCiNhWBuE01MGjT95haY0WJmwbXrAB
         Ag05W4gMQscff0NvKKHB9J9StQeS51uzdJPEO5SSshW74Alcu7XJEKKlqkpu8k3bTKXo
         PTmw==
X-Forwarded-Encrypted: i=1; AJvYcCXWJX0odkryC6H9VoPfqGonjcxmdNyIp+Jxv5iPQf241NfSlcDEP+9aHrCAvf8P/SssRvFqfcFiFMBX@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRr/zkhhZwo0gx4zDRclnk4SQg7OVsPPEIKTLDs65CYbZ0mxV
	nFeup8/JKv26csC05z3iRgejGHBtDYJPQPotSOAjbeKPS9V+z2L8Vs7qWtsGIwHYRaoLpH2prPf
	LiHGLNGw=
X-Gm-Gg: ATEYQzyl+Ur+o9Rh8lflDf4pOpNpZ0TZz1RU46brMrM5wWfgTAzUbGeLwvYWhrHZy6p
	3Ovhb/qB1LtP7u8jGv/AO63WRQWqLR+tpxS+3zbC7SoXWIIocinO7TrLMCBKnSM0CjQhT7xi5Au
	It3uvnIawcUfKpBXwAKF9SXJxKfmaSVzTxjzEtNL9cz18JrF9DprcTvNdkwBV1fYnQdhgOMx9Q9
	hSThDgqJmpjNJYroJfGBtGeaTwBDR7IGzYVNJh6q1mlrM+3cBoxeL9tNOTrA1VH/Xk1KlxqyS0G
	c8kNl87VWebaOom05g5rXvJaBpfbFTXAUUs8HjiL2abn+uwgJLLdAW6420e+UZC5zrEaUHvVIx2
	d/YQFkA7QKZAb2yh54Svx4syCcmf8bUgpBlBNfOdGnEnw90pA9QvQRyMAX/0RR/ZB5Jwy1t2uP5
	F0sWdqE7o0Rx/IxLEKMGuw
X-Received: by 2002:a05:6a00:1f10:b0:829:862d:6b46 with SMTP id d2e1a72fcca58-829a2db6622mr11130108b3a.6.1773093226656;
        Mon, 09 Mar 2026 14:53:46 -0700 (PDT)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48de551sm11460977b3a.57.2026.03.09.14.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:53:45 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20260123-ti-phy-v4-1-b557e2c46e6f@gmail.com>
References: <20260123-ti-phy-v4-1-b557e2c46e6f@gmail.com>
Subject: Re: [PATCH v4 1/3] arm: dts: ti: omap: align node patterns with
 established convention
Message-Id: <177309322512.4034405.1932369183802712305.b4-ty@baylibre.com>
Date: Mon, 09 Mar 2026 14:53:45 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773


On Fri, 23 Jan 2026 15:39:02 +0000, Charan Pedumuru wrote:
> Update OMAP DTS node patterns to match established conventions.
> 
> 

Applied, thanks!

[1/3] arm: dts: ti: omap: align node patterns with established convention
      commit: 7adefbf4dff31e016c0edc653b85823afff541fe

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

