Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C338E106
	for <linux-omap@vger.kernel.org>; Tue,  1 Sep 2026 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298954; cv=none; b=oZSmWOVDH4qZTv8l1K/8nbbovSi1JRugGpQ8nLgvgfcm5Fa50IBD5JdlAsDWMuPT6giNDSGso8q0rEMm6tuOrDeGJXR1lPnh2e1Ij4KmPG6eG6Xv8B7UVl1y7Jrl8XeAgBq8UHmRWshKM5MPUZHua/dcUwWIuFzBTRmpT+oSt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298954; c=relaxed/simple;
	bh=81GtuhM8WPaQORq30yLJ9T7RnVg1D0CM09jTFAW6Whg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DPusgpdvwuXZ86PCNfwfNHUOrw99+d7XW8ly7pF5RMvo/wl+Nz1IqEEyl0UztjMA809rgbDnI4uPLvpdBWx/fVE7ZUyiroNkjKgVwRnIpT+O/pZgkwzovlBE6YAV6s78SEMKi6XBlqsASPJ5m0bBvcUIAhhpc+PvHKAML+1OiF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOaowlb2; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOaowlb2"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso200274a34.1
        for <linux-omap@vger.kernel.org>; Tue, 01 Sep 2026 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788298951; x=1788903751; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y249H53XhLZ2onZan6XPWtvu2gNoxIJKlrKV115uQNw=;
        b=mOaowlb2nBqpA2MI2X9Q+0Oy7O0HGn49oi6X/L32JIQ8IB9uXwckHU+rdRSJbtfM13
         ewJfJvInM+eDOnpta/LlkkqZJfN5qpd790gj7UrVDuCmS5PDNKErvjBhDkxcSngNTtgO
         bYAjgbqoEfQ8KVvdY4EARjiLQsIFXVpku+geSOdsrcAbdjH8gOMXZYCf2wUGMfZtu8pa
         GZ7A9CKJhYVnygNSyli+iEKnJ4fGbHxo5/nctCjQDw+mmuu5deRZ7WyIfDCob9Lu19dA
         dRtmXMgk2EbAtm4AEnlZl4h3mfVd5yH0tuMXrfFEbmQn7PIOLd5WqOR01XYsDnlrTAdE
         S7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298951; x=1788903751;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y249H53XhLZ2onZan6XPWtvu2gNoxIJKlrKV115uQNw=;
        b=fn0dE7fUKuEmmOoRlnWFq0XMBaLcqeb5xxLa7i4phj88g6i1QfQ+fJ85d9/eWtUolg
         FuATwwi5h4G9H0+12+VFVCadRxmn5glWQzg27Olt0eRMDTGTjGzqaxLm4+4BvpcQY5XN
         pw99H/Tanega2oxhuorzljaW0ctS6oJ6Xv9w3q75eECHa6Za85uQFidjQFVfR4nbL2Lb
         /zljzXTOAyz3xBl5Aj/RMjtsiEbp1MdlpPqp4EzaWl0XUIvEseJgKgL1pjmyUNz79MWR
         N1DYRGHMdd6QMVKzsRUke+VB9XWJWDACSPT+vW+mVy+qD2L0o+smCPCydfc87Ztyfj/m
         Zb1A==
X-Gm-Message-State: AFuF++lisRpD+nq8wlTJWB+GYOJHWNdmj0i6M4HVboBwIdgTRu7iAns1
	Vj/jszdsRk21f40U5PP2VgPjj+AqEq9ahkDa5OSdXuNhUrkNc9MaSazE
X-Gm-Gg: AR+sD10TFsSJHcvDfhWKcD8gX5UtQBKVHoONzHr+rqOjx04LyZfTfAydEakJmtjKZB1
	zHjvC881P4jmC0Q2mE/gFfJYvkpO5kJ00aD9CdE5QdBKfc+j0p0q6NoFy9bxbuZ7nK2T3NoxVlF
	l7iDILXlOCOykarwb4VEe9N/VEGjjy+DcY6F90voGfoTCG87vU+4OOd7S3p/+97jXybcmPYTGIf
	azVT2ZR/vamzm7+pCL6N0M4faI69zOQjxtSZNL3+mGKWDxpcqj0ii6DsC5S32f2R6pQ/l8xvfmW
	SgW84ER7kq1ZweQpTb12PJcafwAse0TuTIZs09krVq4l8XJ0LnmYyNgaKwOS+5f0O7mLjCPl7VL
	LfxQ6iWuvbkGJpAevMeXHs5k44wDfbN7/DOJUaPhdOZ0zbOmuug7nf3p8gKQlJn0BD4mjZFH0pb
	WA9JRn3bdFO137Xs465R9zY1mAAhJS3RWk7Kpn62vvn8cJFRU9gWNEUnWs8JYRUf4ay70B5b0ln
	+v7Xqkv2jpdzt7lzTbA0rfX4HvmZyWz5RzE3BHiTlDMvzNBZkBNIXPe5esZu0Dt4hxpla7qOmeK
	LRYDqCuQm4RMK/TLptTamJz/kfhBj2wH1PYGbcgjjgWDdA==
X-Received: by 2002:a05:6820:824:b0:6b3:6bc7:2ea7 with SMTP id 006d021491bc7-6b36bc73476mr11612524eaf.7.1788298951280;
        Tue, 01 Sep 2026 14:42:31 -0700 (PDT)
Received: from [127.0.1.1] (140-186-136-19-dynamic.midco.net. [140.186.136.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40ba648f6sm1094703eaf.2.2026.09.01.14.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:42:30 -0700 (PDT)
From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH 0/3] Add support for BeagleBone Black RevD
Date: Tue, 01 Sep 2026 16:42:20 -0500
Message-Id: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALxGl2oC/yXNQQ6CMBCF4auQWTtJS2OJXsW4mBkGHCXFtEhMC
 He36vJbvP9tUDSbFjg3G2RdrdicKvyhAblRGhWtr4bWtdGdnMe1w4BZPLLSOCnPSZEnkgfWeY+
 dEIfBUzzGADXyzDrY+3dwuf5dXnxXWb5V2PcPzG7msoIAAAA=
X-Change-ID: 20260901-v7-3-rc1-beaglebone-black-revd-7cab3f1a6563
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

The BeagleBoard.org BeagleBone Black RevD and Industrial (00D0/EID0) are
redesigns of the BeagleBone Black Rev C3. They feature an IT66122 HDMI
PHY to replace the EOL NXP TDA19988.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
Robert Nelson (3):
      dt-bindings: omap: Add BeagleBone Black RevD
      arm: dts: omap: Add support for BeagleBone Black RevD
      arm: dts: ti: Enable overlays for BeagleBone Black RevD

 Documentation/devicetree/bindings/arm/ti/omap.yaml |   1 +
 arch/arm/boot/dts/ti/omap/Makefile                 |   2 +
 .../dts/ti/omap/am335x-boneblack-ite-hdmi.dtsi     | 184 +++++++++++++++++++++
 .../arm/boot/dts/ti/omap/am335x-boneblack-revd.dts | 166 +++++++++++++++++++
 4 files changed, 353 insertions(+)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260901-v7-3-rc1-beaglebone-black-revd-7cab3f1a6563

Best regards,
--  
Robert Nelson <robertcnelson@gmail.com>

