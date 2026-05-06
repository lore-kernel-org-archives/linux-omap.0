Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BD3603C9
	for <linux-omap@vger.kernel.org>; Wed,  6 May 2026 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102670; cv=none; b=Gr9ynYSj3y6Vow0+TnIKaT/6+zOBSmVd/poEMP7cXQ/7MqlPW1uIKR5l1aDaSt0oO30R7fo/6UPJ2dEmGBcNw/3hjiMH8aNujevYtAI+rIw+7u47nH1UZI+p/ItRGVg1kioSm1YrTfqw+sbOD1wpTOK6qwIc2y1o1R72AHyrO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102670; c=relaxed/simple;
	bh=LYkVKahq53YapfUpu0qbpOHikxCfXJwIJbTvq43xNhY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gGjZSnwrSg/ebxVsa3enUAdVV1TBJYAufSOxWP+ZsckRQ5j3XnaDg0GUgT7pfVaVnc0y4bG4eBYQp0diiz55PisRBk+o48LZv6RsIP7i2fUkHi+5rScaAnwZZRnfrdplnU1GHgYiQ8ZCd8w18UbFbMiqTP0X/idL4GUzlMwMels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=wBLWbCBx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="wBLWbCBx"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82faf871346so49560b3a.0
        for <linux-omap@vger.kernel.org>; Wed, 06 May 2026 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778102668; x=1778707468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HjpaqU+mw9KsrlzGy2BBS92EqahjZUD+cu7IARQAvw=;
        b=wBLWbCBxbq/pGPUTDjdGrpvbV08QPAuK54dnliOtOzJJUIM1oiN/+/D5L/EjfehVuS
         zkedGEZIxx6PVEkbPSP2SCIzHG6kfQ/G4uhwmjcBUbXt7YN8kdOx+4SZR1xPAznT8orL
         +kYyxA0wtS2mwPNYYRfsDd1r8t9zTSRjqhKvA2b6RpcOVJ2FkoVvyEKkU3QfCkJz6AaA
         bG0mVrsSvg+DYgWYpO86h3OTKzC+Rtu1cUYGv8uOume4IrwyIpqwqIVHc1ttyQWgG3xE
         2ZsL5uZ2ePnKY68CjKxFhIqwaPIDjpjj/jxJvBHIu4sKJcDzmpfJZmHlE6iDbZSaF9mI
         rkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778102668; x=1778707468;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HjpaqU+mw9KsrlzGy2BBS92EqahjZUD+cu7IARQAvw=;
        b=GzumeAsp0/fXB/2mjIq4lX8iAAbUrL7EKtAeKDK9kFFPHhIK/wsQuSaYTUEEmvqhA6
         Q1P1EhP/jM1TPvWrZdtYWQ4PQFK4cuSnmZWSj5qr9X8fD6GKnGLr6oVteNtYnK9axDoJ
         +JhDiuQE07KNToCyEuNphIJYfkOfLrje5VWTZvEQAqIBmD1327xK2kcakVeh20zouHhq
         TyLkrvV/vUbQ3zgsI3CaL7Wm0vNbl9cN8Occ6qxXYCsECEFpTT0dRIbfGO3nWSSV9UEq
         09BouqrrQgKyVL9PU9fYBfn++fYMhNy8TKs+e1tHDlQc7HMd7TcNUqovg0+OjKqdWGZ2
         +F6g==
X-Gm-Message-State: AOJu0YzLK1n4BaFjxpkcmMygcr6320RVzhr9qoSaQNvZRviIhufGSuTf
	xV8lVzhAzqFfY566D1TCuenQakTeOSsTtxXUl9vhGrRRuJtFLxP0NEdIYK4xBrIcMp8=
X-Gm-Gg: AeBDieuWfjE0apNxNKzoPRxCLOgwTIIg4M6feWzX8dBcIgu8ZcOWYs3a3KgRasliq7c
	6+nIU039j7ch6fQCiLzLC64G7QNzG/7kB/R4bZyzxYQ3qrem1rIAP6Cq1pPTlZzpFGmUCoyV2rC
	0P9JpSP6wbdKXaZU7TzroBvewgISoUmi+/dnjKub+1wSuChpvXM8NAQeZj1bUxgY1uvjODnw76C
	AOg+FrwQDKQSfXwvyyvrT1IZxrfndryYXw8cJIiXxjsAHpvVSFcyjyOIZaY6KgHNEWQ29i/x7fo
	jf4vAtpWyWVL7HNjBB/aP0ueIceuFA2wEYzuQycLuQX0FC5MJPwjF1ZH9xV8Xfs/GMxTrLEq/TC
	xGXSYBGeN6+VFBirvcMs5lqgR4OXIsgN28JSHn3/wFRXfTK8KlfOuxNdXOR+xeXB8LbnQXGFZDn
	XkIyJkaOGkgQ7Kk5bdhCdiE1sDF/KdZg==
X-Received: by 2002:a05:6a00:6de7:b0:835:443e:4bc7 with SMTP id d2e1a72fcca58-83a5c0c483fmr5052149b3a.13.1778102668521;
        Wed, 06 May 2026 14:24:28 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-839659498f1sm8113521b3a.17.2026.05.06.14.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:24:28 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20260502-wip-obbardc-omap-dm8168-evm-stdout-path-v1-1-d1e69c295c21@linaro.org>
References: <20260502-wip-obbardc-omap-dm8168-evm-stdout-path-v1-1-d1e69c295c21@linaro.org>
Subject: Re: [PATCH] ARM: dts: dm8168-evm: Set stdout-path to uart3
Message-Id: <177810266773.238543.5630091098339148154.b4-ty@b4>
Date: Wed, 06 May 2026 14:24:27 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 02 May 2026 03:13:18 +0100, Christopher Obbard wrote:
> Specify the board's default console UART by setting chosen/stdout-path
> to uart3, so that early console output and /dev/console map to the
> expected serial port by default.

Applied, thanks!

[1/1] ARM: dts: dm8168-evm: Set stdout-path to uart3
      commit: b6aefeea7b4aa9158c1dcec8c050a678af7bf9b0

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

