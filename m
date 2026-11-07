Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794039686;
	b=eF6/6kDFgInKz4ZJNYBj3R60W/MGhpfGVXF/4KdCY49fVlM5b+OhyF4kFquN3LRwOcCB
	 Fb7jmLtr9KALZhUtdSYXA8xI0yW3L0TBLilJzkNZj+U/YZK1QXsnDCWKfgh7/MV3kJkdk
	 FkCwFRniOQmm/XVY3/P+R7y7xNluw7o4xkntLeDgz5lhQny/OFpF/GcD318aB55AhALnR
	 xVAtSqQq11q8z+HPJ8qtxst2ZN9ZdCoezrRjFGEVMk6Kfqw/sUN0ihi2QC4Me/s9lLIV8
	 2fc5ojQAhMwxIXui+8USfFbCtYl8YRxIqyvL4c8A9aCckwiYRWqEksK1NVyDY6ojqzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039686;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Wn3OypTVFQ8KIckSKHmhgectqFgnEYMzQS8CtZVgYp8=;
	b=dXKg9Q9i4OgHy/+O3fV+q1OF3AtRIF8qz8hSt06KdlEPuS6N6LRyW4mFcS6Y56uk9ACO
	 fu8x5QD/eXmd7HeIY6XOudWhSWCoYwgusiQPLX4EdGhcA9PqXflNoxPvYCMEDyaai5k/b
	 RNPi2JVRUGBhHXm5ci4BUMQH4tHApvqBwZjzTau4QhWBjxyX8XadgHUpaA3n8csGOW2L4
	 9xa7GWrjq8moBgEsiJ+b9+NXU9Ly9uITLtLnEbvLL/BBNX0TDl0Ht3YFqi2ZAfpjf6rZl
	 tmLkveCiYbkelCLDaLVq7BMnyH+8dK3SsbUxAOT7WLMKWlHbSkWAmrcs+Y0eoWBlF6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A20606A33A;
	Sat,  7 Nov 2026 08:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25A20606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jM8C84T8vz8XrrZ;
	Sat, 07 Nov 2026 16:21:24 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A78LJH9003100;
	Sat, 7 Nov 2026 16:21:19 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 16:21:21 +0800 (CST)
X-Zmail-TransId: 2afa6aeedf810f4-a2c82
X-Mailer: Zmail v1.0
Message-ID: <20261107162121178QffEnlezkInAnSMsrwQzA@zte.com.cn>
In-Reply-To: <202611071621143491uRwluLhxYsUHx2V3qhm_@zte.com.cn>
References: 202611071621143491uRwluLhxYsUHx2V3qhm_@zte.com.cn
Date: Sat, 7 Nov 2026 16:21:21 +0800 (CST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <lee@kernel.org>, <mfd@lists.linux.dev>
Cc: <tony@atomide.com>, <linux-omap@vger.kernel.org>, <tharvey@gateworks.com>,
        <support.opensource@diasemi.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCAyLzVdIG1mZDogdHdsNjAzMC1pcnE6IERvbid0IHdyaXRlIGdhcmJhZ2UgdG8gaW50ZXJydXB0IG1hc2sgb24gcmVhZCBmYWlsdXJl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A78LJH9003100
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 16:21:24 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEEDF84.000/4jM8C84T8vz8XrrZ

From: Shao Mingyin <shao.mingyin@zte.com.cn>

twl6030_interrupt_unmask() and twl6030_interrupt_mask() ignore the return
value of the twl_i2c_read_u8() that fetches the current mask value.  When
the read fails, "unmask_value"/"mask_value" hold uninitialized stack data
which is then masked/unmasked and written back to the INT_MSK_A/B/C
registers, corrupting the interrupt mask configuration of the whole PMIC.

Bail out with the read error before touching the value or writing it back.

Fixes: e8deb28ca8e2 ("mfd: Add support for twl6030 irq framework")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
---
Resend: the first copy of this patch lost its final empty context
line in transit; the diff below is unchanged.
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 0ca00f618d4d..1333c4e9cdd7 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -235,10 +235,11 @@ int twl6030_interrupt_unmask(u8 bit_mask, u8 offset)
 
 	ret = twl_i2c_read_u8(TWL_MODULE_PIH, &unmask_value,
 			REG_INT_STS_A + offset);
+	if (ret)
+		return ret;
 	unmask_value &= (~(bit_mask));
-	ret |= twl_i2c_write_u8(TWL_MODULE_PIH, unmask_value,
+	return twl_i2c_write_u8(TWL_MODULE_PIH, unmask_value,
 			REG_INT_STS_A + offset); /* unmask INT_MSK_A/B/C */
-	return ret;
 }
 EXPORT_SYMBOL(twl6030_interrupt_unmask);
 
@@ -249,10 +250,11 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset)
 
 	ret = twl_i2c_read_u8(TWL_MODULE_PIH, &mask_value,
 			REG_INT_STS_A + offset);
+	if (ret)
+		return ret;
 	mask_value |= (bit_mask);
-	ret |= twl_i2c_write_u8(TWL_MODULE_PIH, mask_value,
+	return twl_i2c_write_u8(TWL_MODULE_PIH, mask_value,
 			REG_INT_STS_A + offset); /* mask INT_MSK_A/B/C */
-	return ret;
 }
 EXPORT_SYMBOL(twl6030_interrupt_mask);
 
-- 
2.47.0
-- 
2.47.0
