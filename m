Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D1397944
	for <linux-omap@vger.kernel.org>; Tue,  1 Sep 2026 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298959; cv=none; b=Ugujq2PpGph32InpUQy+6q7u8VypR/U9X9HtmtktLWlLuiPJXXUejqg4jsltwE0/KrJxBei56GB+wO/44I1k4xxUrZzOoa6qZgyDKqvJdowoQhhe+3TIeUlNc6WnGWjgz6HBjlCRnKqR4yOmAuz6CXgQ2oLdLTB/BHcsLIhI0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298959; c=relaxed/simple;
	bh=SsUQNTNv6kHN9VELJ592cUs8KSzWhnVlCcfgO3cKqSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RN6/00MsvcON/2hhWFFEjN/sKByi2sIYv/kLHR/r/hlBgIvTu1t3n1/03PtpaHbJlGCjdQSjZR+kutyWvdwlfOJRHInU8KK9LELVW2PRR6XYRoNm+QxUCoE89cKqb6szCr3mwdDy3e3TrGAWPBcp82BmTCanV7QKCv2vZhh7jiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjOgPHSA; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjOgPHSA"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6b1334a3b16so269743eaf.1
        for <linux-omap@vger.kernel.org>; Tue, 01 Sep 2026 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788298957; x=1788903757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m99J5Fi/T1zvsWEGoRtP+MygE1A2m2xBlRSpWOmMB6k=;
        b=QjOgPHSAtD0gdtxOt8CTOEoGunby68CWn935jT727UDFh5lGnilBC6Xr6UQxPlR/tJ
         w/xPSiUzRpFziXhWc2YqTqBxTN/2SgOXNduCPfc1153zZyW67i/iE85wQeQAWtpy4HJ6
         NFfPAB3SlnrUgbbYJ1qFOmQ+BDfYwz6drJnEkALPBWgylfucGA7qPk5QJ/VEv1APLZda
         JtKIzfb6eYYvqChLViHiXoCCWu8zEpxRDc1pGGggOXJTA6ikB5od6vKMF8Lk16TeDz4i
         CYE+aSB8KZH41qoxtTywAxVL5JANwmgqq155e53o3whrhsvHipV6JJnytja5oVzFZpaY
         bkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298957; x=1788903757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m99J5Fi/T1zvsWEGoRtP+MygE1A2m2xBlRSpWOmMB6k=;
        b=O8L3MNsIU0sfDZfWNVdeDD4LWOqOyNxeacQ7DMyBpIkzyfromJp13M/WvGOtLde1g7
         2KccfLEu2lYSpydBq/8IcY3Juo8Qt3c/pVWRpk1xSejmz+rD2IdJN53N5HWf2Rkmnrcg
         dBOqzEc+YJXmrZStnXRUO4k8GKQk5hCkUY2Y9VTasjTZJYOoOvrju1WwD6AjZw08g1wF
         bUT/8JKESnglDOpeiD5pqT/XzeztP9hAx1vxon6GHUl6ul03d9W9F6OOZeaPUdGCyUkK
         gxpSKcxj6WrzjU+7f01rLhZuMqfdgNaSu7+ZWUfLEz7fcrL1QAx4OlpEtU84YnKEQ1BC
         teww==
X-Gm-Message-State: AFuF++l5d4PoDiGCjw9L7FnJGAqnxQbVfVBVjvLWpgvvxcjwPayTWnQm
	ZusL4ueczJtUT5pU8mcJS8pppaDpaFKMQ+iUJdNNUMphDxjF5KUoDXgoxaT2ai1P
X-Gm-Gg: AR+sD12Rj/R7bWrOSUJ/M/SSQDgEm4TprZkPl2Y0MKKhH57Y2RMV2VpXbKWEocCsGeW
	dQWt0fRAPf1fZldd6DzxJIxqppPzEmivoHjYw5UegJUoDghRQWMPHNqfiTBbetSdkIa+wLVMWt1
	ZVKCP4e/RGnLqiZmFtUtIC9taqKWiZWx9o2NyfulPaREX0F/MHPEjZvp/8t699SOWbYo4Dl8b/a
	uOU5AtSZKh+Q963MvHaOrZ/AUQTVwBmcu4NUzwifqbh/+LFVgYWuW6bYK17XOtHIckuhELsUwdr
	QvTJOot0S4m9O+cw2LwJGY8sVzTb1zdYGZMWTzwX2fNuEgQJ8TublbJzy/yZp+5HbU3Czg8ezRK
	x32FNUik/QLCNdqqvD22H3PqnDki6zWgVOBMG/8KKEbQXdGc6klES4VORvU7yF58Awhp8POvsDE
	0HL6sW/njhXoTIMXBaxcZMd97Vb7oQbwtV9i0kZCzF2kRuRW5IHHjFAk38bn5exNfjBcfnjYeCn
	Rug3+7YvzDGvARh404bL2QLXoY77garogMy6JcxYGcziaQ7cTQfZm7JSjqdoKP3S6LvFaZqIOQs
	VHHLnn0BpXivBgPWEuB1MW5liQwGAfx8SqVMQDdzooDt1g==
X-Received: by 2002:a4a:d749:0:b0:6ae:6484:5f40 with SMTP id 006d021491bc7-6b1c673d01emr27846776eaf.21.1788298956904;
        Tue, 01 Sep 2026 14:42:36 -0700 (PDT)
Received: from [127.0.1.1] (140-186-136-19-dynamic.midco.net. [140.186.136.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40ba648f6sm1094703eaf.2.2026.09.01.14.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:42:36 -0700 (PDT)
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 01 Sep 2026 16:42:23 -0500
Subject: [PATCH 3/3] arm: dts: ti: Enable overlays for BeagleBone Black
 RevD
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-v7-3-rc1-beaglebone-black-revd-v1-3-f521950b777a@gmail.com>
References: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
In-Reply-To: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jason Kridner <jkridner@beagleboard.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, 
 Ayush Singh <ayush@beagleboard.org>, 
 Robert Nelson <robertcnelson@gmail.com>
X-Mailer: b4 0.15.2

Allow overlays to be applied to am335x BeagleBone Black RevD.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/boot/dts/ti/omap/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index 55cab3e8a05c..62de820c9b2a 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -190,6 +190,7 @@ dtb-$(CONFIG_SOC_TI81XX) += \
 # Enable support for device-tree overlays
 DTC_FLAGS_am335x-bone += -@
 DTC_FLAGS_am335x-boneblack += -@
+DTC_FLAGS_am335x-boneblack-revd += -@
 DTC_FLAGS_am335x-boneblack-wireless += -@
 DTC_FLAGS_am335x-bonegreen += -@
 DTC_FLAGS_am335x-bonegreen-wireless += -@

-- 
2.55.0

