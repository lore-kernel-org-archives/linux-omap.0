Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36743AC0EB
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884617; cv=none; b=lg6yTU8rF0dGi7DGR6bev5Il+qtAUjj8lySHtTtX2xFQA2K0ql45qDD9lysAHqn7teVtO6wnPeBETt2pVXM9F6y63xhWpuZIjMfri53QU1QIAncC0xCSJP5CuMEXoDfsmYYZfruoZVR+YxH4EKJ/+nozjUjIw3xFUddEk9aYEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884617; c=relaxed/simple;
	bh=U+tsQLnWyDRDHVr0CTIeZd5q+U3+1+j8XgyYVIUKJgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GuuzVHYGfcOgjObcWTEGfYmpEhVfGR23padEJL1ih+Phpmode5KWXZQFG+JdPQeRzrI4DgckaJkrkmXOWWHnReAaVVBB/hIFyB2mKyZpFM80VcYq0rdW3g5MoWmYyyfu+PKelNndqn4b5rvNFM1vmp5aC+szdBoN79O5XWRXdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiHKqu4E; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiHKqu4E"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7a269ca1so465495ad.3
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 02:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784884612; x=1785489412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9LXkLmF0QQK9cYGRfMDJlE9q0WVIrmOfOlOL01nvng=;
        b=fiHKqu4EJGgMHXnXp6L184mZxNrGM529+npVMBSwneTqJs3z5ODgKim4QbW3zL/J+Q
         fLu5DSa/BY1tYyp4/ewjN7zLbhNefqQAoeVT0YaA6Y5z2qa0J1D2teCn6ugkHO8IGibn
         XfVKtQTQc/Zw4oVuE/DA1OpZHcaxo0anDP7rjPOu4rx4+AsvYiMecd5uGHYfmvwRM/Bt
         gW8QJJaxe3b2qbIKJ1JUH7HiD2tpSOkkNC+mPOWX9k6jEqi0LFrLhznGhEwAUFncWAJp
         6g5eap/lOkveQyAZXo8K3O03onKmCwjBR3bhVbR0324oSeO5YAh/5kbGlsnhJ1VsDVQ3
         a5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884612; x=1785489412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9LXkLmF0QQK9cYGRfMDJlE9q0WVIrmOfOlOL01nvng=;
        b=dGN85eTzWWEph1im+UaXfzi+kcWZ7MvO40klJiEUmgbOMpGa9FjaAvtxMPd9KEGwkl
         7Cyfe3Wz2Z/5susS0VMVnfSZO2GeIk858i1MFPGdYuCyBZ8zDRQgBvI8279y0cbNnI1v
         tDx4naJhYxlm0hVqMgwOBmXEg1XtZjnZaLDiRMEMeczv7QKFgZOY7BIKdjW3xGQiGzt9
         eMewhd0XxLKi7vdY2h+bsBG466Ve9Y5xuEjAssFwpjea1J/ijQdUA2ASeVxTunshJclU
         ixqoxMfMnLHdKtMa9khnxn9KywE5ZHU/sKKAKJLtxUb/2UdGm8ayc21bUyjKzfjFbDB+
         EjzQ==
X-Gm-Message-State: AOJu0YxB8S6kkXP7a+x5M0YG2gh41cUOj3ymM/7TkK25gzTahTdNpFVP
	Wjk0INZrZPKN6uqWsQs68YhIljuFVfqNcueGE9XYVFGbjRU6bCKwIi/2
X-Gm-Gg: AR+sD10mipYuC/NkZBgPMe9zKQbqwNK/5OEtUVG0qDVAVIcVhX8u/f5hEBBdjbT080d
	1lC/0vLGyWd5hQLoHWs9RaByYOIiGQFkf+I3jZNvqX1SubMeLl88x38Gev4QqSqi0PVxa+JcyE8
	eNxMTlaf3uqYWimJQiauw/jsnbXWsKGS2zg5RVzuAZvMxEjomtdmkeUtT9fWfXzuiNRU+olDuT3
	H7Am5pHPAe/qu+AXO7v2k1mcuSXVUtGxZV8bSJ3rkw0yi/U58/rHLfOJi8GauzumY1ri/6Xz6hW
	CLQjkMq8yWqfGKBBSyrJsK+hkSMFWbAi+z5jAsVqQK2hgnln9FHJpVqafXBrMGVnnb0bCzSSjzQ
	9SeX9lZPdYAHpJLvut36YiMmNahzmCjf9F4Xi77wVn39mV/a6FL4G1TaQRCIL9Q3UdKBeRItcz3
	b5uiLxNpmKJCKjt0Q=
X-Received: by 2002:a17:902:c407:b0:2cc:9d9:b8df with SMTP id d9443c01a7336-2cfbd6c2190mr26012725ad.5.1784884612321;
        Fri, 24 Jul 2026 02:16:52 -0700 (PDT)
Received: from [172.28.140.252] ([2409:40c2:5420:f772:24a9:f23f:ed43:a5ce])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm29005610eec.17.2026.07.24.02.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:16:51 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Fri, 24 Jul 2026 14:45:53 +0530
Subject: [PATCH 2/3] ARM: dts: ti: am335x-shc: Remove unused ti,no-init
 property
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ti-omap-rtc-v1-2-ffef78853cd6@gmail.com>
References: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
In-Reply-To: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784884567; l=689;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=U+tsQLnWyDRDHVr0CTIeZd5q+U3+1+j8XgyYVIUKJgY=;
 b=qgIljkvJo8Pw538QpYi38SdB2bfoEKRFcMhduFDIDBZgFEnXbar8/uhoB9qVZXaWC4gEZQ4bS
 9/A5kB5cGYjCb4pI0AgRPXoaGYRJCRcr/1P7JoTKap1wx1zm0tqUH62
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

