Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509669;
	b=EmK6C+fRT55FYkG5Yo5dVFcyzbd9aOqEvyg/xeRqxlVglxZ9MmHQt+x5oMkZOuloK97j
	 unKYlAyf7EIGmyMnHIBmjWHBpJqyuh4MMgMwcrWsGmzizKCUDhEigvtwZBD3dr0uQRHsn
	 EhBsMUqVc7mUlVc4KdCnmuT1LLo0JXshx2UPxR1nI3YD3FAN/jXUOFZfj8h4LDOSvnjxe
	 CSuP3hcnpHZDGd82OSdACIYHXy24mILTkbqRswSeRTuldiAH/Lzo6pYkcHnEPsCC5vMqO
	 j2vvGH+y7cK3JRCJJK5ZA0JLzuPaJzqyN3BQ9WxXPCK1FxedZ3AuvDQEKMj4osHA18A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=G84wSK0nUUfLUVTY4c0GD6hajZc/iWKJjasXJCCFPjQ=;
	b=IJV5N+Cd+TqOWBpYTeh9YbMXNbK9Fkfu8JvRXA17Bvx5haJkiMVA2JW1su60j2fi8BzN
	 nAjOlzwb4HL1wVw6vNsPpLMGPomUEwBiHtOzx3yklB+eS+yKVwqG/giKR177uAowrhAtA
	 8E4Iq2nGPLWtbQvbuMGV1OF95la/A/nai0lKQcyvQtCYoIhyXdAis37g7LrVSYb2XMYsE
	 Tnyg0ObtnsJ52v/e9nTNMXk1TfbMyrYxTPIsb4aZ2KkW1EvLDvP0xibSLN1rHEKCdes2L
	 +VCwbI3/3fQy9cC7i6LCx6n2YwsIxcKMCVbjAX4o91AqY5C/y8vkztkjewJ0GoY4iPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ika8RJU1;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DB6070F4C
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 18:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD5DB6070F4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ika8RJU1
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36e90071735so34326eec.0
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 10:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794509668; x=1795114468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G84wSK0nUUfLUVTY4c0GD6hajZc/iWKJjasXJCCFPjQ=;
        b=ika8RJU180o7R0uM/ThueU1zLpH83uj4J9/WII8cpnYHL7Pnh5XD13+K/eoscIleR5
         gQMtaESU43b1KiF3Jvu/VcMf21hQ6vFfMldzrEUFEV49bmYLXbdNIX6CrrQ24Fp4w342
         tfbl8ymt7yHWyUu34ERw8PLR89M3l0hRjHRd1e5wnptYykXoLaywqeqaaa7D9wifhO0B
         s4s+0pw5vSi/nGJ0mHveKevjIrEiO0w87gbGsIhzeFykTs8gBI1es4JwhxOMFvSVVe6T
         Y5TOowq1AywZ21LAz+nI3gXHPjIwYrdN2Dn97di7zGJNFbZPq6birXMp+rzKIue8BSFS
         nSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509668; x=1795114468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G84wSK0nUUfLUVTY4c0GD6hajZc/iWKJjasXJCCFPjQ=;
        b=KedE0c0bemYQADQoa3tihm4zLmJngdpAgxe2idOuW3vO0DjpNeMqjMM5P+j4VInIoZ
         +IGYLI9NBlBCWicbVjDWW2U5R8vKQJ37w5lQTV9HDtMUDPr20suAygIbFF9FW3EJZkxl
         he6MtKHr2pPWI9AcvGjYAe7Im47pE+ibynxB5RpN0INMtEiX/JKV20tgSgybdbmuPmuv
         MdhlTlG3oi73BNbFlx59jVveRIz5JeLdjlVg1IyPyKs4sFjmQEp04SOHONkhdnCBGwfb
         a4KCZeqh0IRvQoYGyhly252USZ8ItUojkh9k9ZIKjSXzZW4NNXVL2y/5LH6rirQJfdfb
         9Lcg==
X-Forwarded-Encrypted: i=1; AL+hErHEp2EsOSC7ux4YMOoJWH7cyLUxnpBiMRWLztVQHelwRvqNQRB/DWoNkp7ZLpS22zYT2I/EvJEkA1Vr@vger.kernel.org
X-Gm-Message-State: APuU4Z+b6rMdBP2chVW0os9ATrIfpTYpZ9iDeRUsGZrvTlkO5NvTiO/p
	5BooJvj40aVUxG9CopyuoemE62YhjpdW09RJ9NJ+4hXW/3rlCoYHW3j1OMgzZA==
X-Gm-Gg: AYBFou3qjuzfxm/MI0EpvaZbIpX/1qZ0LMFz7GTifo2vEwwsTFIgeKlFu7mX6F/0dw6
	9YhUCW3afrtTKCDiJ5qDwkXqaGzLqjeJjXpy8d1zYkKcI5bgNPbxIkZ2gL2IBlDp4CcZbxFkpvz
	acJOJygIW0k7ogPb8DksHElYxs+12MfFFaAh62e7yCuWdlPFbEL2YsHsGGzRn60TglzCz/PMwqf
	CrlxUNQVN2AKS2iAckXeO6q+6Cbc7deMblSSYJFKH6iy6+foRCEyPm2lnNq0OZaixcEc5HAo8+t
	H1PEHI6UPZ87FDGr5O4d2Kl8G+zCsyQvkfn4m7RvU05NlmJgbJB2ZWE5XB7UXk3XrylHhM726uo
	44JL0PUReCee4D/9y4MXfdXfLqvmAbAqUmhBAs4QlsJK4aOCZ2NTVNygV41YA6NVrHLukQqjt4d
	khqU/d51DZBGFqW/X89bMhi99ragOPh3OEE/Ivcz7rAEh+cTLj19cQ+y/V0DFKPVlHShbkvv2p1
	lHsTfst13fKMeSPuOH2qKH9IY6nRw0K5cgbDa/T7OxWG+ToXYVfq9aO82+qJanufDkMkf4H/V4/
	GkAPzcTD1wi8wOoow3/5+byROq4JY2m1FGl44AFeA3z1AY62fLOz6K/Qj7Y=
X-Received: by 2002:a05:7301:a0a:b0:375:f846:5b3f with SMTP id 5a478bee46e88-3796057e734mr124077eec.0.1794509667847;
        Thu, 12 Nov 2026 10:54:27 -0800 (PST)
Received: from [192.168.1.4] ([2401:4900:881d:321d:eb39:71d3:15f6:5fe0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm339008eec.22.2026.11.12.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:54:27 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Fri, 13 Nov 2026 00:24:02 +0530
Subject: [PATCH v4 1/3] ARM: dts: omap36xx: Add unit address to ABB
 regulator node
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-ti-l3-noc-v4-1-5084dcf4ffb4@gmail.com>
References: <20261113-ti-l3-noc-v4-0-5084dcf4ffb4@gmail.com>
In-Reply-To: <20261113-ti-l3-noc-v4-0-5084dcf4ffb4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Santosh Shilimkar <santosh.shilimkar@ti.com>, 
 Sricharan R <r.sricharan@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com, linux-omap@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794509656; l=884;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=mRJd2FscObSZq+5xKtM7LxfhPVQc620l8Gz6i2pWC0w=;
 b=pexz5pY2dcZ6Hx+y6xEeA6ThGdmSU7B3tZuKGyzj8Z85JLBcsN+Djlp1EMwATCKVc8aLWOC2l
 C5Kq5VQzmfxDXCz609R7FvC00IS+VDvOdRXURFrGLIYF1CkcmU3GynC
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

The ti,abb-v1 node abb_mpu_iva has a reg property but no unit address,
which violates the devicetree rule that the unit address must match
the first reg entry.

Add unit address to the ABB node in omap3.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/omap36xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
index c217094b50abc..6df66eb7e7eeb 100644
--- a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
@@ -92,7 +92,7 @@ uart4: serial@49042000 {
 			clock-frequency = <48000000>;
 		};
 
-		abb_mpu_iva: regulator-abb-mpu {
+		abb_mpu_iva: regulator-abb-mpu@483072f0 {
 			compatible = "ti,abb-v1";
 			regulator-name = "abb_mpu_iva";
 			#address-cells = <0>;

-- 
2.56.0

