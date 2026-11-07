Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794039686;
	b=lUGWMb8ve5aRSQEt6EQM/ZgoKqOL57LMJL2CC8e7zEiWHr2zBhbDluo2j2AyPDvYIpqG
	 FO3mgMxFwZjlKhJeMcWjkOv/65fURunWPYr2WzD0mhtEr/op4w6AdZ9aAA602SLSvLd+W
	 DQSCAFvD00vOlbvPLFv0TuUCNIOVjkfLlTRYkefRGEcinvd8ifTRh/asaxEixHaopxf5R
	 c19qjYI7tP2tnqTGP2ROx59A8rYnfP00drxxIWZDZOihXQCbs7Gpx2MEqn6vI2jtvD66e
	 HyqxfTyW1ZppNWy/t1ouvinRPb7arxuXRWDqE68LUxTjPXu3ZbrHuDgixWJIy90pGJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039686;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=ipmSXacYEaqmPoM68DDULB2QJSY2Wn8jrOGObyWE4vk=;
	b=Q832z7YyI31vRrio3fn9g/uC8R5StUAtlY9pwChlWTE0ODUZBifkKVA1vkQvPZP+msq1
	 yBaOHyGx4PtYS2qcGgqFafA7jxrBeDwObHjoTfipZZK5CmQQ2KVF+7NZxx7StL5EWpusQ
	 9lGdf518wMadg6//Y0rotZ2XlVxMnXro54ODGI8M9tFdCTrneoDFId+U1ngtkZI0ZoqQV
	 yTrMW1Qhh/pbO7iSO6ikE+ZIMqrNNO1X6Skw9S6kzao8l5iBZALqsheUXNHG4VO689D0P
	 eJibDPlJHSWHOVC6pX11PLN5gdtX9rCT23OCCCrZh33K62L8FB81UGKW0hxFh5nWOCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663CB606A330;
	Sat,  7 Nov 2026 08:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 663CB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jM8C81Gs5z5B136;
	Sat, 07 Nov 2026 16:21:24 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A78LHVR003095;
	Sat, 7 Nov 2026 16:21:17 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 16:21:19 +0800 (CST)
X-Zmail-TransId: 2af96aeedf7f3c0-90f60
X-Mailer: Zmail v1.0
Message-ID: <20261107162119836VR3jHjgaOF-Np7Cmm0nl3@zte.com.cn>
In-Reply-To: <202611071621143491uRwluLhxYsUHx2V3qhm_@zte.com.cn>
References: 202611071621143491uRwluLhxYsUHx2V3qhm_@zte.com.cn
Date: Sat, 7 Nov 2026 16:21:19 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCAxLzVdIG1mZDogdHBzNjUyMTk6IEZpeCBvdXQtb2YtYm91bmRzIGFjY2VzcyBpbiB0cHM2NTIxNCBJUlEgbWFw?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A78LHVR003095
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 16:21:24 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEEDF84.000/4jM8C81Gs5z5B136

From: Shao Mingyin <shao.mingyin@zte.com.cn>

The tps65214_sub_irq_offsets[] array has only seven entries (bits 0-5
and 7; INT_SOURCE bit 6 is reserved) while the corresponding IRQ chip
advertises num_main_status_bits = 8.  regmap-irq's read_irq_data()
indexes sub_reg_offsets with the main-status bit number, so whenever
bit 7 of INT_SOURCE is set (the power-button interrupt) it reads past
the end of the seven-element array and uses garbage offset/num_regs
values to compute status_buf indices, which can also lead to an
out-of-bounds status_buf access.

Add an empty placeholder entry for the reserved bit 6 so that the array
lines up with the bit numbering and bit 7 hits the power-button entry.

Fixes: 7947219ab1a2 ("mfd: tps65219: Add support for TI TPS65214 PMIC")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
---
Resend: the first copy of this patch lost its final empty context
line in transit; the diff below is unchanged.
diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index f8c08dd86618..4f4bfc49542c 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -268,6 +268,7 @@ static const struct regmap_irq_sub_irq_map tps65214_sub_irq_offsets[] = {
 	REGMAP_IRQ_MAIN_REG_OFFSET(tps65214_bit3_offsets),
 	REGMAP_IRQ_MAIN_REG_OFFSET(tps65214_bit4_offsets),
 	REGMAP_IRQ_MAIN_REG_OFFSET(tps65214_bit5_offsets),
+	{ .num_regs = 0 },	/* INT_SOURCE bit 6 is reserved */
 	REGMAP_IRQ_MAIN_REG_OFFSET(tps65214_bit7_offsets),
 };
 
-- 
2.47.0
-- 
2.47.0
