Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A93E4519
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2026 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392134; cv=none; b=UoHkRbhAteLyH/eAx+y5Oh2BdoBqxvxlc642y36nxkXQaiRjdEFnokrygiWs4rcDjCuitQx9F0VKDP3o7HqH5e/ZeViZN2a3zdXbJT3ez4sawWY1fyHC9sPD17l2vOrWqcMZBUlpfsM/bjHxpwTPFTR/8HfGko9OuaPTIL9Cm1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392134; c=relaxed/simple;
	bh=fhm+aixP5ECDzq8HdzVVNjUbNQs1gCCo767CoYMygZ0=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=LwnNQYaBxTfvlrx3OdYgyVL39Ix7P3Nqgh8WFxxOLEqXlkJW/NXrhGDjNZh6vrDxYxBvdZZ9ajd2ko9AjOc8Wzyo3RuPCKIISc9qRJjVUxXPZBkNxbFEtbDaFaABMJzlT4JoDYE7EooowYRAMxjfU5hLnWcBiU84sZ/vjxDIAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfOdw0ec; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfOdw0ec"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30c52f96f60so4204340eec.1
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2026 05:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782392131; x=1782996931; darn=vger.kernel.org;
        h=mime-version:subject:message-id:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=89Ic5OiQ2TxKlY6JX2s9PoYvegkXRGC8cRDRdVhrKkc=;
        b=nfOdw0ecCLsd/mkwITN2pYvc8YGb1h4TjaZFM6HoiQVbK8CNILZNKzaTWhYyhNzlU7
         QoYrIv/ovNVG6ZzXz9GMSMxzIA8318pEhgffBHWNXnOGKYtQPvtarTap/wlVbRu6Y/da
         Lx9JV+OdCAL794UaapRUiMcXXXcIKJww5DdzypsWCOBaf3ik9siE4ZYJH/YN8gP21P/m
         3AwYvTl1COrd7o+IW7QBHbku/CVu6iZqo2/PA8nNsZ6nW3p+wEGWvpQkYXoiBn+K/br0
         AaV3EXtLzgvHD9VZI1OhQ1yzZpJYgdSaZ3idJf1Ug0eEuAP1eADkyOBW4afCFEqaQinG
         0wBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782392131; x=1782996931;
        h=mime-version:subject:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89Ic5OiQ2TxKlY6JX2s9PoYvegkXRGC8cRDRdVhrKkc=;
        b=GO0KFxPeSjTwhxzJgJbIhxrkmbBLn9F70F25a7Z3UhQKS3Kv53470vk2TR5xQg4bgn
         0XFAWEaI6+sMKAtA7L9jtDXV0U3aG1JTywFymtiutAFL2Yw2yuyByoWXz+2gYJhKnehn
         4XFdIH/AlDQxzqp71uCcYMjIkt22zIBqxT0RvCuSfGhHii96ofMU5JUrb4UVemzMrEfH
         NdnW9Qc4xraQd+CSemjrFFZQnrys96V3rveP4bCn51oAG6c+PN5hsAh9GHuTBW9VGgAE
         rutgKklLV06mfxJTYqQCTx3E8EHSot9kSGhpFqDgQdW5gex/HDYrnpy0XjIdZwRLCRa0
         E3cQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2ho6mNTZwfjZ7It06YlDb5NoEgeIWY/HFNwdgrNs/uLQTwfaLuZ81/HrbLLBvfVd+5wNewwkkojga@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWON0/YAsuJ442uzu8xJEZLuAts1wCi//OGO55CF0JsuMoyFM
	L4fpRZeJR429Xcn02hQP/MSgM9Hlo6RWVIHAdisT4W5gHSMzvX00rJIwQ6mHe6X8
X-Gm-Gg: AfdE7ckG6J2NyXbqfghPQ/AOr9p8htYVk40POSKYrazyeN+tOjVm8nCKqxZK1IJFbt+
	adIJvHwwQsSUtRpCvAE3j5dRRiOkq4lXuCbN8r25ItURms53Tx88uYg5XHkYA1nuFbZWpQIbQmQ
	44fCBiT3ifBYvcdCOJ9Q+dEiLIROnZQ8KuzzEQXCiyFAA4WL1roX8atDMfR+Nlfcjows5aBl+WY
	CF2b44VrlJmYYDnvmdPAaT2F/xnBkXwMnVeMulAqOFg+dPWoY1+skkubTtxNYnJ4QMZ5yZMTkMS
	K98kgdq7jA75bmo0F/PYLifEieZitUswHxqo+LnXdZhWlhv5FWy/MoEBdLU10dG4Pe7KayJBXCj
	AMdC3by/EZfas/+KGH2or9L8+DHi66G6CwsKHGLmhyL0t+lm0Cz3Urv64te/mpCzTSB+IfG5JJf
	Dbc6DhY/iMjTXRHOwOXsk=
X-Received: by 2002:a05:7301:600a:b0:305:56a:c38f with SMTP id 5a478bee46e88-30c84d8c4e8mr2777422eec.26.1782392131106;
        Thu, 25 Jun 2026 05:55:31 -0700 (PDT)
Received: from [127.0.0.1] ([177.174.222.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca87caasm8136463eec.27.2026.06.25.05.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 05:55:30 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:55:22 -0300
From: Wagner Popov dos Santos <wpopov@gmail.com>
To: AaroKoskinenaaro.koskinen@iki.fi
Cc: AndreasKemnadeandreas@kemnade.info, KevinHilmankhilman@baylibre.com,
	RogerQuadrosrogerq@kernel.org, TonyLindgrentony@atomide.com,
	RobHerringrobh@kernel.org, KrzysztofKozlowskikrzk+dt@kernel.org,
	ConorDooleyconor+dt@kernel.org, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <fec5175f-8533-494e-af5b-1abe26f6d83b@gmail.com>
Subject: [PATCH] ARM: dts: am33xx: avoid invalid OCP device-link for timers
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_19_261743831.1782392122149"
X-Correlation-ID: <fec5175f-8533-494e-af5b-1abe26f6d83b@gmail.com>

------=_Part_19_261743831.1782392122149
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


------=_Part_19_261743831.1782392122149
Content-Type: text/x-diff; charset=us-ascii; 
	name*0=0001-ARM-dts-am33xx-avoid-invalid-OCP-device-link-for-tim.pa; 
	name*1=tch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; 
	filename*0=0001-ARM-dts-am33xx-avoid-invalid-OCP-device-link-for-tim.pa; 
	filename*1=tch

From 6d482ff72d1a11a5851602717a48eb3e059946d4 Mon Sep 17 00:00:00 2001
From: Wagner Popov dos Santos <wpopov@gmail.com>
Date: Wed, 24 Jun 2026 13:28:02 -0300
Subject: [PATCH] ARM: dts: am33xx: avoid invalid OCP device-link for timers

This patch fixes boot-time fw_devlink errors on AM335x/UCC3 caused
by invalid device-link creation attempts involving timer1/timer2
and supplier ocp.

Observed kernel log messages:

  ti-sysc 44e31000.target-module: Failed to create device link (0x180)
  with supplier ocp for
  /ocp/interconnect@44c00000/segment@200000/target-module@31000/timer@0

  ti-sysc 48040000.target-module: Failed to create device link (0x180)
  with supplier ocp for
  /ocp/interconnect@48000000/segment@0/target-module@40000/timer@0

The change updates dependency handling for timer1 and timer2 so the
kernel no longer attempts this invalid link-creation path during
initialization of supplier ocp.

Impact:

- Removes the two ti-sysc/fw_devlink error messages at boot
- Preserves current timer and clock assignment behavior
- No functional regression observed in boot and timer operation tests

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am33xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx.dtsi b/arch/arm/boot/dts/ti/omap/am33xx.dtsi
index ca3e7f5d7d0d..760598d5ae1c 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx.dtsi
@@ -708,6 +708,7 @@ &timer1_target {
 	timer@0 {
 		assigned-clocks = <&timer1_fck>;
 		assigned-clock-parents = <&sys_clkin_ck>;
+		post-init-providers = <&ocp>;
 	};
 };
 
@@ -721,5 +722,6 @@ &timer2_target {
 	timer@0 {
 		assigned-clocks = <&timer2_fck>;
 		assigned-clock-parents = <&sys_clkin_ck>;
+		post-init-providers = <&ocp>;
 	};
 };
-- 
2.43.0


------=_Part_19_261743831.1782392122149--
