Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB943E1D02
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161694; cv=none; b=DcTCC3VKUXoBitb/UFTIOUNccDmffjZ0zGf9gemMPbiF1gJz3rmu2EI7RF3o/yv3fsssJN9CKEuTfYM+C7+Ly2RNzfinjsavzBKAEN+xyY4v2mYjcmq2Zd4byD5UOWAkyKevBqd7BkvTDT8B2Xg1wARhQQ1InTinZPuRtB/txxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161694; c=relaxed/simple;
	bh=SXE7EM9go44I82+wxylQyrQfmfe50KLKxHsMKbxaVM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzdXmnNVrBTe7jE4HXSOa7YiBu4rFCDf8tG+2OBjGg/IVEk5mHDGJ/zV9rFbKOTmqU1s1bNJpRfpEkTkfKmzSzUJLx0lqJXTBIH6e+0gM5QAMCgq2NFlgd3ZXYWwV+69Yht6Il1TfmR9LpPTfD9YB23qCZWhhdUxqdv036e+vdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dFDqHDiI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFDqHDiI"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d870d54so4164096f8f.2
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 07:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792161690; x=1792766490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUR/YLwF1kCyO5ZC5rt7tI7UKtYf9pEFcXU9Gk48s2A=;
        b=dFDqHDiIWjyDoR3PN1KHfJlAXxKmEvdHOCz8YtWK0shtdpOOFjdxi2FXPecluJsETK
         7kKvan2axXdY5j0CN2hZ2GCi3UoshYcNmLDKbqNl4hrxe5SBVw9DupIEkUjY+sD/nT81
         7n+/+5yJwIaWFb8qn7bO+CPTP0urbnX59qa1ZiQi+6NQvIBZBAva870GmSoqX9/dN1zH
         vYAM6qYJnIRebM1ibMb+4lJFvcCHR6Vfsebecdp6mWe7M8cjF/IJfTc9knXjNEWRv48b
         SPTjqYhgQoPvgaRam+qwe5Jrd0j/bfADlqq1or6RjQmuYhCsW3PELagbLibWkgetMN5v
         +sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161690; x=1792766490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aUR/YLwF1kCyO5ZC5rt7tI7UKtYf9pEFcXU9Gk48s2A=;
        b=TrZPiJoTKcn8TpEY3x3vHLeYigz95aJDfutDsTor1blno0C3liuUehGZ/7/6U3U5iD
         3T2YaCIDtFVKy2A3Wd/wpxFV9nyOxsMdUB75wAB1H2jkrzrXkYZEkz51d8debv84nm3G
         Y6FXcW6xBA0ViPDoFPG3WK+ZwAGiW28Ef4k7KphTMkAwHJ6Wvjm+Sq0/luFlStqbHbZ5
         Lh2Ss0hBlEVMxLfh1C1DtHBWDwoat/q9Vd/WZKe8o4ngs6ufz7qlXbx0NzwbsDxZNKdi
         elmSGEXDHBy9gVihGSJDD/bEpBZsWibIB0lPHtDw6UA13Qq783cGu5w5LSkjxEyqXiE6
         cUDw==
X-Gm-Message-State: AFq9FYIquD+nKf9m7O5KFon7SjA1r3sHSpvp7PjnNMFbLBxLQuDGc+1j
	a3BOBQ91DBwJVjy/KJPNVoIC2BrG+0NUm0zHZyKkOHRGP85qszWeADPkCf4kj4ygLLw=
X-Gm-Gg: AYBFou2jq/2J5gteGeKTb8NVxlgR24GwrljauSsuxqmNXlSWmIY5iMkVxjl4jvJdxiD
	L85BuiVuYSw+F/U2bD4S8Ix0Azug2mmig0B77FsSiZJ35TzziGkMg4x8Xpvi1+FsNiQA0AgxeHu
	wRMpdhdU9tBd3N6jmgaG0XCov6VNUP5yYivlGbntDCqdEUQo3KDx4/+ceF6oxvVwxnNKXsUn5FO
	hRlfj3Nol/+qMeYEx2HVYIV44L8SPLpxWy7/hGFUQYzMSVciGtjEZXZlvPa34++LPqyNSe9gFIC
	t5SBu5GzooCYH9FzeOSBn5ksMy9eSoZaQRegXeTRPI83yVkP9e2zsBkrENMb1Ri856/0Dy42pLD
	KueCJ5iDszP6OJXF4AEuOVLjhSxEc/cHGKZRlkgkDhPx4HyyxeW37/MWfYSjfZd9oHWJVyd2+vP
	gNLwSBqmsygJ7yuZo8U/IHZjdd41Ob9Sl4ZLlEuSkgOjPyp5cQUb2OKIZiul1yev+ILP32sPjoo
	sXlvjD5QVtEf+vv7R5wDPmiX1YncH7hyDvvUyeI8A8nl6//BPXAiffbewbCAGWSolepxA==
X-Received: by 2002:adf:e001:0:20b0:48b:efb:4a66 with SMTP id ffacd0b85a97d-48dba7b405bmr33972874f8f.6.1792161690556;
        Fri, 16 Oct 2026 07:41:30 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4ecac3sm5949648f8f.27.2026.10.16.07.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:41:30 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Fri, 16 Oct 2026 16:41:22 +0200
Subject: [PATCH 07/10] ARM: omap: dm816x: Match up capability flags for USB
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-patch-ektor5-dm8168-dts-v1-7-b4ce30217028@linaro.org>
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
In-Reply-To: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
To: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792161680; l=1043;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=CFF/I+D31PVrHYKqsweOt6vSe2R5OqOPYaNCWBw37UY=;
 b=LP5fDZPwM7CVSE3wLSXa89nNj26IEaZ31pwORyTzdSsNC6k2TVwNfT2MMN8qAxmunIxVtM5C4
 gkH5DkC8cTODb8Sw0gMjv5I82BbIYKo1g5/JP8vQzI06VB+kG8hskYd
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

Fix a warning about flags and idle modes not being as expected
for the USB driver. Updating the capability flags for the USB controller
after updating the USB devicetree node.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 2f55dc32e150..d2c20719c100 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -616,7 +616,7 @@ static struct omap_hwmod_class_sysconfig dm81xx_usbhsotg_sysc = {
 	.sysc_offs	= 0x10,
 	.srst_udelay	= 2,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
-				SYSC_HAS_SOFTRESET,
+				SYSC_HAS_SOFTRESET | SYSC_HAS_RESET_STATUS,
 	.idlemodes	= SIDLE_SMART | MSTANDBY_FORCE | MSTANDBY_SMART,
 	.sysc_fields	= &omap_hwmod_sysc_type2,
 };

-- 
2.56.0

