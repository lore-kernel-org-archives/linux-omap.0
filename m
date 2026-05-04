Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BC23783C7
	for <linux-omap@vger.kernel.org>; Mon,  4 May 2026 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913238; cv=none; b=jQqyX4a60HKJ70SC/0/AJpAaPGInxUr0icKC/BsJg2+6rXP7jwyL7gYYkQ6c8XJ17sErx1flNIzOtNo1enbylXQMEiY/6uLENs7OaIdDXdey6WgY3qNSRR8P/igjcDLO4ctesbSsZ2gde2KI7qpKg3aj5ydm5tyCWAxcLxZQFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913238; c=relaxed/simple;
	bh=QP9M9VaMpWwZUhCp64YLxzdYOROMGp0l2eAmYtoYkEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e17I2BrOQ+kteJC6HNzHSde4j6BupeCX9MxbOMkOkovNhrZjaNSfQD2e2beRPHta7EP5R4XyoyhM3lU1Q4RvFgquUL3z6i8w1mfgUScpyYxGuvTSw5GOO/cCds3fikaT+BDpGPAwj+TlAgxRPxu2Hc6MYSY/blb1eHdme1s7Aqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5Icbus8; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5Icbus8"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ee63e91acfso329037585a.2
        for <linux-omap@vger.kernel.org>; Mon, 04 May 2026 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777913236; x=1778518036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4P5XrME9c3SWpKLIiNC29eNfEaqnPTWRx49nOE3Gwg=;
        b=J5Icbus81UpdAZkrDsKZmDHWfuntdojbC6k1zhRFEutQIQRGslg3gvujcxlIr7UgDY
         8m8nGeDMqhwyleBrYQxIAzWyRZWa5OTIZTsItG3863IMwaaBg7TrVjMHfw5r8ih2I9FU
         CzbrVMJNPuHgdIkj9eUHM3YkHDMGvx0Sr8JZi6R2sG0VA22NwizAyPdzJyjE3EYDponV
         KjWRmGN2tKag9fxwWy3vS9lzx43L/PO4NVukke+261lTnNUGrpK4o1k8S48Ntg0Xbpdz
         HTHNg8tZ054/nHW9Oi4IzbmSltE3M/wfpGKmZvyIDfKK8ST9AUGefIdrbypGZLyPb3N/
         h7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777913236; x=1778518036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4P5XrME9c3SWpKLIiNC29eNfEaqnPTWRx49nOE3Gwg=;
        b=J1C+cdHuL2hKf2OxWcXz+zvyawa67OEpm4GnBQueWp1rvzWniQhp39r3YwDolhakMe
         hlF0qCs7WKZ1G4al3MDEk8w3y8BLwUOUSGj2TTPK1mnMP7vF/BICsRlArZijx6wa+0t0
         hJSEI9Pcn6pxSu4s6ZsveCmuS0UzcIV/9f9l57l8Wr1grMsRBxl6mybhOQb1WXHyL2c3
         wTsR+GOtlYM+lX7UyEuGmJVKBoD7JAzUXgcFy7zJqn9xzsjLJzNnvHjlNGXvHMfkCjw6
         F1C3L3yn9b9ECnOEJve7P4cqrVqzYkN//NlIjYkA8WekHWKazCycZhnrWlA/OUce++76
         gMaQ==
X-Gm-Message-State: AOJu0Ywguy2KxOXA5FgN+IWCgLn/7lnGEWW8/V/UUUkZPMog/1895N7u
	YlImAFbUvyr7ae8IyhWXf9O2vCE4BokZs5KPzwnsuYtFU356P5cRnsYp
X-Gm-Gg: AeBDiesMJ8ixeAFV4usL3Mjwn+a4qO/SMk8u3e4E7ndMFBEpA7OayB25KgUPKswB8Wx
	k0BSlc066r8HqWOZMKBvHHL6Vp48ap6bp+YpfhDAfM+Yf+ftLTbnq5HtVbmUTUPc1Sja0xA4MOT
	lvvFt9T0YLDCXdKh2H75IGlZ8zbqg3I1Zggyfz+F4wAY6FLTa8SuPn8+bdjr/CE7TJuggPhjgXb
	dYrlNGeGPxB/4qkwFq4ayOwT7KDWT8FnLD+fyW39zp4pRYT1qP0TAgV8ZC6E1P90SX2n1Y3kIqI
	eVZjqB85WJq/jZMLRjKgC73v5uWc5O8ceBlX3HQhTbtwTIEihi3kj35c6Asegvowa7fUvOf+NwE
	xUcYGUvw/5H0rbPQq22x7r4rU1xqos5vDbDVC/+dqWMrq+fIFx9wpQbdcGKW+t5WZ16t6Fj4A4z
	Dj8XYbIIvD/yd0Am5gD8FrpGc2Al+YkuNFwwNfQTl+OehYc1aJNQE=
X-Received: by 2002:a05:620a:4106:b0:8ef:ca26:dcf8 with SMTP id af79cd13be357-8fd12d929cemr1711202785a.0.1777913236290;
        Mon, 04 May 2026 09:47:16 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04de9sm1116747885a.44.2026.05.04.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:47:15 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Paul Walmsley <paul@pwsan.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] ARM: OMAP2+: Fix OF node reference leaks in omap_hwmod
Date: Mon,  4 May 2026 12:47:11 -0400
Message-ID: <20260504164711.2854116-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OF helpers that return device nodes acquire references that must be
released by the caller.

_init() leaks the "ocp" bus node returned by of_find_node_by_name() on
all paths after lookup, and also leaks the child returned by
of_get_next_child() when parsing module flags. Route the post-lookup
returns through a common cleanup path and release the child after use.

omap_hwmod_setup_earlycon_flags() leaks the /chosen node and the UART
node resolved from stdout-path. Track them separately and drop both
references after use.

Fixes: 1aa8f0cb19e5 ("ARM: OMAP2+: Remove unused legacy code for interconnects")
Fixes: 4f2122473363 ("ARM: OMAP2+: Check also the first dts child for hwmod flags")
Fixes: 8dd6666f4937 ("ARM: OMAP2+: omap_hwmod: Add support for earlycon")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 974107ff18b4..03cd523dff87 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2331,13 +2331,15 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 	if (r < 0) {
 		WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n",
 		     oh->name);
-		return 0;
+		r = 0;
+		goto out_put_node;
 	}
 
 	r = _init_clocks(oh, np);
 	if (r < 0) {
 		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
-		return -EINVAL;
+		r = -EINVAL;
+		goto out_put_node;
 	}
 
 	if (np) {
@@ -2345,13 +2347,19 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 
 		parse_module_flags(oh, np);
 		child = of_get_next_child(np, NULL);
-		if (child)
+		if (child) {
 			parse_module_flags(oh, child);
+			of_node_put(child);
+		}
 	}
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
-	return 0;
+	r = 0;
+
+out_put_node:
+	of_node_put(bus);
+	return r;
 }
 
 /**
@@ -3608,13 +3616,13 @@ int omap_hwmod_init_module(struct device *dev,
 #ifdef CONFIG_SERIAL_EARLYCON
 static void __init omap_hwmod_setup_earlycon_flags(void)
 {
-	struct device_node *np;
+	struct device_node *np, *chosen;
 	struct omap_hwmod *oh;
 	const char *uart;
 
-	np = of_find_node_by_path("/chosen");
-	if (np) {
-		uart = of_get_property(np, "stdout-path", NULL);
+	chosen = of_find_node_by_path("/chosen");
+	if (chosen) {
+		uart = of_get_property(chosen, "stdout-path", NULL);
 		if (uart) {
 			np = of_find_node_by_path(uart);
 			if (np) {
@@ -3629,8 +3637,10 @@ static void __init omap_hwmod_setup_earlycon_flags(void)
 				if (oh)
 					oh->flags |= DEBUG_OMAPUART_FLAGS;
 			}
+			of_node_put(np);
 		}
 	}
+	of_node_put(chosen);
 }
 #endif
 
-- 
2.43.0

