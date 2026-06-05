Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60A3D3498
	for <linux-omap@vger.kernel.org>; Fri,  5 Jun 2026 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692996; cv=none; b=c+1NvBeKjE8J61OroLAV9YCN3zodi67rHKfhiNmLVUIoFjZHPYbMqaPsVg09rOGofJPP5gFuAs8uSQXjC9k/CVPa5fwsp16LUWr+J7m8ADsaqznqX/d4En3TiLLI/tlD6Ulwwm3MaFQSqqEPEG8uPjeEnk1TWH64ZHYfC5uVHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692996; c=relaxed/simple;
	bh=D/NehaAy+y0UChkX+5Urd3CLYL6nH8BL3LRA38L6uJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7k5YLfULRKg0mt+kIpCiDvNg1UZENUplgvjsl9KOh9w9fyXMtw1Umn9G+LJt5yYF2xlGfWKF7HtRAhn/ebiy7N504nWieq7YPd+wOo3R02UIhkGMwQ3/uAmxcCdcUI0EZ7Rytgrgzv1NyJ4bHHcyJoecd6quIQ26T8ojats22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZo/aScS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZo/aScS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36bb43a58c7so255395a91.1
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2026 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780692993; x=1781297793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8G5tNCGULtnZuv71TgRderFQDJ16M4SiXFMUj8Aa8bI=;
        b=XZo/aScSItuXUfyj47jIe5IK4rLyXc5CApDMyoamFGjVZiqzEdv+u8PoarkMeQwBi9
         zBfY75WGGMbDBZNzE66svsuNvsz00ZkfhX9Jam+yVhFXctX9WEfhGZ4mt7lzHtXuZ6LN
         aPOj7StHnT+slCkj2xE5DjIniuSYyNvSGr6gE6qsP9Jl5Cgf/m4SBbw80G3ond0Djls1
         6E2O8g7Ju179juYAS7hOYeGc1FAKIddAmb2IwZjpScxhWX6zKQHwrfkrZr37VWJcxDnc
         PfXUU+UwWQe+foKppba6N8R6SCDCogbycsinwpXf/OqgViLnYF9mkhA2/vRX8Qksnl9I
         2bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780692993; x=1781297793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8G5tNCGULtnZuv71TgRderFQDJ16M4SiXFMUj8Aa8bI=;
        b=noRkYHcOPRBZHJtI2Ew8WUxFHnmLQS5TkJW5vgDUWrPklwvbczSp4/8SQgybktO6Ce
         1HF2tgsv4fpcKx7khKzMV9S5OFVjmnDF4tj3FVhAMv+GLf9j8gR65WMYezVSFjMNeZCs
         rMpxin90Bjln/OCOW3XMP73VWPSpjoSyC54pWHp5/j6atsW9JgLN/9FE5433wTHDpGHZ
         qElwyiUPHcMo9SBV64PY18FZu77SU38viysR+MPxUK+19u+Mc04kbeUSvHXpqPzMgYNC
         +Bp18VBmyysnO8BsJq833AdGeJ94a5U7qA/cfBVTAngDxZytRrPvU5K8KYcpmKj4+51E
         07bA==
X-Forwarded-Encrypted: i=1; AFNElJ8vyUIUghA0W1+d4NGRlXJZcLftjqbWu0lQSnthRK86jT4Ls9feQU1rW54+gjuvwsA0HxS701SlVUvW@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsedvYG/3P8DMhAcAeOX7FdJh3sKeTxqakjldUYjWuxUKc2kh
	4y5oxazSvC+aG/5Q9Fp2PNfdcadBHQBvQpWnguchSOoIgw4PdMeoO5r6
X-Gm-Gg: Acq92OFjVz3EOW2Rbgr2gwZqBKX0p2IADDf8jo6ddj/SxD1oO97ilfQ/9nLL2SIuLTg
	L/gVX0mH1y7zKrq9xdmPXKLUC3gfYKP/9ZmDtRkDnkBhB5WfgtR+vGvMLxEhTja6IGei9jNBKW5
	BnM88xGKGHUzoiRCU8VeC04s/+ZQ2fL28Rou3UXlK3vnck833bvoJBJf7k1dCxYoywYPNg6FmIn
	CfgNLN3kgO/WZDdCgTBNm0nMoSnJhkSbW4Z5puth4tYMPoavuhtqqcPe+/794QpWHJRtUQUcmnI
	B4XbYAHGESCy7b0SxU0Tgl7AkwgGXMuwAhU9uHodnFQX4JPy02ExazL8hXuRVFWDZ31pEJyMEGa
	bSyWswJuRaVL15hYkviVlnTu3uzSRawcUnGdZs2XaeP/IloAdo5CGqAQzC7OBrEhTkxK2Ftk14b
	tFe6x+ufpRj/8yNu/SUK6wxRIwbOYAMoAXBZaLN4vfuw==
X-Received: by 2002:a17:90a:e70f:b0:364:be8f:1d86 with SMTP id 98e67ed59e1d1-370f0e4b6ecmr3103829a91.8.1780692993313;
        Fri, 05 Jun 2026 13:56:33 -0700 (PDT)
Received: from [192.168.1.3] ([2401:4900:881c:baba:b3d5:d6d:608b:987f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3712fcb2607sm2197036a91.0.2026.06.05.13.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:56:32 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Sat, 06 Jun 2026 02:26:11 +0530
Subject: [PATCH 2/3] irqchip: irq-crossbar: Handle renamed irqs-reserved
 property
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-crossbar-v1-2-f67f7cb9ee50@gmail.com>
References: <20260606-crossbar-v1-0-f67f7cb9ee50@gmail.com>
In-Reply-To: <20260606-crossbar-v1-0-f67f7cb9ee50@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Sricharan R <r.sricharan@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
 daniel.baluta@gmail.com, simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780692975; l=2064;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=D/NehaAy+y0UChkX+5Urd3CLYL6nH8BL3LRA38L6uJY=;
 b=N+uc/uaK6/z0ZtSi78zcV8A/8ppuMi7cAioXppdZfRkMlCsr6KA4moSD+0m+B6zHKd9XRVNZ7
 rsZ7B1vuw7IA0xT+qQJZZRmswPObkNu/lBjXwe5GnRqfouQpWBfZd5g
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

The DT binding for the TI IRQ Crossbar has been converted from text to
YAML schema. As part of that conversion, 'ti,irqs-reserved' was renamed
to 'ti,crossbar-irqs-reserved' to avoid a property name collision with
ti,pruss-intc.yaml

Update the driver to try the new property name first and fall back to
the old name ensuring compatibility with older device trees.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 drivers/irqchip/irq-crossbar.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index cd1134101ace..64b042ce11a9 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
  *  Author: Sricharan R <r.sricharan@ti.com>
  */
+#include "linux/of.h"
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
@@ -197,6 +198,7 @@ static int __init crossbar_of_init(struct device_node *node)
 	u32 max = 0, entry, reg_size;
 	int i, size, reserved = 0;
 	const __be32 *irqsr;
+	const char *pname;
 	int ret = -ENOMEM;
 
 	cb = kzalloc_obj(*cb);
@@ -231,14 +233,21 @@ static int __init crossbar_of_init(struct device_node *node)
 	for (i = 0; i < max; i++)
 		cb->irq_map[i] = IRQ_FREE;
 
-	/* Get and mark reserved irqs */
-	irqsr = of_get_property(node, "ti,irqs-reserved", &size);
+	/*
+	 * Get and mark reserved irqs
+	 * try new property name first, fall back to old name for compatibility
+	 * on older device trees.
+	 */
+	pname = of_property_present(node, "ti,crossbar-irqs-reserved") ?
+		"ti,crossbar-irqs-reserved" : "ti,irqs-reserved";
+
+	irqsr = of_get_property(node, pname, &size);
 	if (irqsr) {
 		size /= sizeof(__be32);
 
 		for (i = 0; i < size; i++) {
 			of_property_read_u32_index(node,
-						   "ti,irqs-reserved",
+						   pname,
 						   i, &entry);
 			if (entry >= max) {
 				pr_err("Invalid reserved entry\n");

-- 
2.54.0

