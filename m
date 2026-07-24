Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E130353A6C
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926956; cv=none; b=kbH8Nn4X6EB4Zq55YWYDJd71g8Oj8p3+6mBlvZ/2aM1ZyrwMCDEdalCRbva88Ydc37L5EM0OhylUwcv2FTeVdZ/ebEipZoRvTqXG/JwYrReY3LAzbUTMotyiW+wwFEqVoxSQIxdkib91KCYiHO2e5WJaIFCjmHTaQXv69Dp5Sd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926956; c=relaxed/simple;
	bh=U+tsQLnWyDRDHVr0CTIeZd5q+U3+1+j8XgyYVIUKJgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8gS4v8UAYOWvoGnYJPmeRfjuBcIl6poZh55ulPbqucAXprsl0lKYcbkH7dU7oHXWa+wlH7bdbxNDfybPp5W826IIuj0tD03ShT1PU1XvPDzHTKiRso3YDmp9nEeIFvkCDao78LDzKT9/efayzy6GcYj25ROe5jSz6VFhUdzWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfiW1P8Z; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfiW1P8Z"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381d656c36eso58824a91.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784926955; x=1785531755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9LXkLmF0QQK9cYGRfMDJlE9q0WVIrmOfOlOL01nvng=;
        b=LfiW1P8ZS/ZESMgWDvDXF3Du/XRUg/2lLHGnWeOlRofkS4hRgKu+cxSLluflt3CyjT
         PXEclwGiL4+4AVUbaYv5kki/OrDEpiJD/w0kCGb7hJ8dtg4v892MImyvSLMPqmvyxYPK
         FzK4225qvhL3X+hAOmorqfWQX3XPm+Go6HMNPTYexVtQNVU22ESeqttjRo+f7C9TcRmE
         hBb6CDcLJqTrO4eOaer+XVYz5+LXZwIzeeoiXX7JbTy8XiRRTe3u0ujrMVraUgxcNVMU
         U/uCV86Pgjtux2Jit/Op/es9t5iPWBTk2U7ti+zWjx8d0YGvkFVF+iAlfhldN/EfGSKk
         vYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784926955; x=1785531755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9LXkLmF0QQK9cYGRfMDJlE9q0WVIrmOfOlOL01nvng=;
        b=CYy9Fp12SUf65Mk1i0rMsnA18Wkt7X4l1bcSGaLWmtopHhwzWCW77W0fjbiUNVVP71
         zz+YaPafbgZ7bEds0ZJucaNyzn5o01Pk+Sc0v5Bkcgbts9ghBwCPHHyC9rpu1NuKuyd4
         zHJE2cuqesvIMjnm1NdNcVgctOXXTKo7fnUXMai7kWlAMkGWp+xJvW4n7HRqDdObKjSP
         jK4D1SSwPJwyIXv05aliae3FvWPS44mjkZ5kRNdFCeBpZFHp7691/wBhaOjXtY+C9Bd1
         S598P4GrmbuvQJKQqNFzzwrEsaH1TmQutKPjEi8DKxavSIXWb532w+G4FyKLj2Xp4NVQ
         iAbA==
X-Gm-Message-State: AOJu0YzvDsLmvQr4vJs9FHPLGPX+Q6as0oo/AusMP5vMQAFYTvSwD2cE
	lHAegJYn+TNVblsGRyYRMYkAQKZMlOvFKsrj3ZWySKuEK4WaTZxJ7HPh
X-Gm-Gg: AR+sD13b3lLGTaAkLcA38f0doFxOqHoKMWr4G6UAvDycWpBTdHkTH+D5SniMO0TkxS7
	g6pTS8tb9juAdaD4CNIh6hTINrCKjPSv9P9bA0716kTyXFl9w9OLhfduiNRRRTaoDBbtYpOXdKu
	vQAHtiNCO4WpzVNBgEZzU2GxOEEC10CM8MFWWaLbys9ctOyrpEnaUkl4t5ejcsXyGJBsii0UxUN
	wMLKD26z5wtulQZgsCr2FdD8xIeK+FnjYaGY60cTRZyySzFxk2RBXP10aquLEkcH+MMzJO0edZZ
	A5fFLtCnEwzczwvnJfvKachyHbgD0OmI5nhdJPPohlt0maydF7U+UmHzLJANNbHpjOLCR8piMjd
	L1M0rH245L/NmpMEXyKCeID2/9d42Kf3OHOlWFRPQ1DR3nm6ocfFON7Q7AMHnnmbYSC1NELAPOx
	rkAZi5YzlphAswUZg=
X-Received: by 2002:a17:90b:2f05:b0:36d:b30b:14ed with SMTP id 98e67ed59e1d1-38f293c6044mr58730a91.2.1784926954876;
        Fri, 24 Jul 2026 14:02:34 -0700 (PDT)
Received: from [172.28.140.252] ([2409:40c2:505f:3320:3d54:c6f0:368a:d94b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e63sm2485324eec.19.2026.07.24.14.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:02:34 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Sat, 25 Jul 2026 02:31:57 +0530
Subject: [PATCH v2 2/3] ARM: dts: ti: am335x-shc: Remove unused ti,no-init
 property
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-ti-omap-rtc-v2-2-13f765ca96b3@gmail.com>
References: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
In-Reply-To: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Keerthy <j-keerthy@ti.com>, Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784926923; l=689;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=U+tsQLnWyDRDHVr0CTIeZd5q+U3+1+j8XgyYVIUKJgY=;
 b=KOMlrWJBSgCQ58z4hGD0KndOSJu3JPpG7wvEFOkTt91LKenGQVK+yI1DudVtQt05AbabXzjN4
 cdp+7KH6ldtCOOP0anv94T/cqy3gRDKiyAvuwTZrReIeYmz0DMLGIfy
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

The 'ti,no-init' property is a legacy, undocumented boolean property
that is entirely unhandled by the rtc-omap driver.
Remove this unnecessary property from dts.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-shc.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-shc.dts b/arch/arm/boot/dts/ti/omap/am335x-shc.dts
index 597482822608..2b946823928f 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-shc.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-shc.dts
@@ -241,10 +241,6 @@ &mmc3 {
 	status = "okay";
 };
 
-&rtc {
-	ti,no-init;
-};
-
 &sham {
 	status = "okay";
 };

-- 
2.55.0

