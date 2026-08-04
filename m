Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1E494A1B
	for <linux-omap@vger.kernel.org>; Tue,  4 Aug 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863175; cv=none; b=BhUgUaCX74Mj2L+HAx9/Wm/iPPopKeYITQRTCfNmfikzQXl5zBsJ4jJlLoubIu8VajdJkrPibvWZG96OTD+bxBYHB2ZQQ30Phqbk+t7dT3PGSjf5iVC0Xy9WYCy3bTG2OtmvVqtKUoyzVhSwNgov4lLrfozzmLoVA7ILEGyU1i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863175; c=relaxed/simple;
	bh=U+tsQLnWyDRDHVr0CTIeZd5q+U3+1+j8XgyYVIUKJgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjEaAscW9d10b0y/BqP9suFK6/qM6iusS2TKoJ8uWx67N/F6iv3mMDhRadLiZN+RS3CjFBCNXZ4FkwSWuSwOTfno6aL4EXbmT6aWHfdCRrwci9mVGjJEJqUE3muLbo44H8Tb7MUukririBdwqf1tVIVtDCc18/gwf/HD9rPii5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwVUoMqe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwVUoMqe"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84a3323d858so6785b3a.3
        for <linux-omap@vger.kernel.org>; Tue, 04 Aug 2026 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863163; x=1786467963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9LXkLmF0QQK9cYGRfMDJlE9q0WVIrmOfOlOL01nvng=;
        b=XwVUoMqeoo+x8e3n7QBBKL8qiLzrHAm2kfbtKR3BWANn/SJ+Lzm1UaFISTxCngZi4D
         DPtWAENinBZI3WG93XboC0lcUFwcRQzwnzWxauJit3DGyBtJb33m74PqqsHgpxz3jlK0
         5HeSRBAAlAb3wu/YCWIu/Ikpdjmbl1gEN3zXNBkSShdlSXnr4qOHrezSMPqU3uEHt5FI
         nfE895JiiGfIv7mqUfIXb6fFuu4Lo8+O+lj5O9lSfnT/+n949K/9hyM4XpuvDaRB8hmG
         VyFqa/9QuE9zulmg7qGr0BT+H3TqlIK+E4ILI8w0HJCI5OPVTQrlZX3MV6wqan+s8zF3
         4SuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863163; x=1786467963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9LXkLmF0QQK9cYGRfMDJlE9q0WVIrmOfOlOL01nvng=;
        b=mYjXyyW1jKLrxpT33RlGrFbXABLGNI0Hl5sAg5/11D9G5ajEVwsGThbE5I/2mGF3+w
         XS4JMrg4ndfVEnK22c5OXEfNT5rjK4qpHXcq+tZ4nq9/vwrISZbD3Vicf4pfO9rFJNCg
         7OhWHuhsdtmQWZuuHX8qlslT7QYhPHHo5a5QtZTfYX/savFVaEL4tSlD0Jemp/fvTmD8
         XiaAlGnCl6Z+2eCYlQSeqnavaMiHGqk30+K3PezilQYEBbKZWDaxDGmjenjirYF86Dv3
         kFFS3seXlvG3M6D/AosTykw8uRMipP20of39NZZ7uv+azYqcDhah1qbeJcA9TdcH39ql
         cBTQ==
X-Gm-Message-State: AOJu0YwKVvu5k527ajQlH1EyPI9b9N0pLxlQNR9oxxuKXhoX6c23eeJx
	OmkjPgbwESu/11rCITboElHL70MTwCCmBFgBR16QZ0ZqsEff4x5qAOMC
X-Gm-Gg: AR+sD13MFbiG+HL4AuBf2i0P2iOJnk7NZC7bTtUE6VAsztXi7PVe3h/PA5RcJAZWnxS
	4U5WbDSA4tPYVyEZUuLzPfkqliQE3q3iggRm6vRNHMx2F8ABNl5b/XG+CiiVaK9ijf46cbFgagV
	TNxqL29ReQR6vGbPt0hBtXZPqpCiFUHCxxCABli8NxzfmYdQydzByeGWhjT9+WErcv/1mmOLjEN
	JJbS5FQSKIuD9fRK+qweZG1OFvrc4IHIWd9gbnCm4Y/KQAeWcML7yyIafShIFCCHvuJkAKjFqcR
	JGOp8Iw3ju7dwG8VpaviNFVKL4EQgpkD/4kCrIVLVzG1DrO9nhTC7C8ST5wK2EgHRKsld+n/ycI
	V6uyA59cThqtcHy4SY7NQkIkLZqAUrcazg8YPO7E+6mC0vdYXvsDFXYrPyCyh7wuV5W9A5bI4r3
	5H2sCk/z+0bA57JzKqJIdi1nU7osgJ66UopbEvbdF7aO01AMhe8EUXq9DYbEVIEAxJtNcoH0E=
X-Received: by 2002:a17:90b:1651:b0:38e:6a7c:abbc with SMTP id 98e67ed59e1d1-3903c7278f5mr485167a91.3.1785863162872;
        Tue, 04 Aug 2026 10:06:02 -0700 (PDT)
Received: from [10.15.72.252] ([2409:40c2:5423:e712:2aaf:ae79:67c5:476d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca52d329sm5147124c88.4.2026.08.04.10.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:06:02 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 04 Aug 2026 22:35:06 +0530
Subject: [PATCH v3 2/4] ARM: dts: ti: am335x-shc: Remove unused ti,no-init
 property
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-ti-omap-rtc-v3-2-ba3bbd8af570@gmail.com>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
In-Reply-To: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785863118; l=689;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=U+tsQLnWyDRDHVr0CTIeZd5q+U3+1+j8XgyYVIUKJgY=;
 b=d2oaSN2HN8Zp08jvzP1h/JFly/E/A1bZXz8xT7Oc/auJ2ktdbJ1oD80wjusZOUj+ufvlK397Z
 ooo2sDDDyeVCR6cH+M55M9bEOxqRKxtHFy8I3vZfdgva51LLoPBRW84
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

