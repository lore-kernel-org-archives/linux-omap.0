Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794038872;
	b=N8Zuv+PHZPBSvsZpUrgTKMZ5LUmDTeGEZAQUCpOBdcsCzLTvMNHjW0UCKchsV7T1UUFh
	 TAoz/bGzRxLsghGT8+uAV9A5CqY54E9titoFb0aeIBZayy3Ff0TY/8Esc92JynLNADDVB
	 N7/oghg8HfW+y6dVpiGesWcPOaT7AyIiE2pYrPIDudAJNEEv7sOsVU4pCQCJtd/IzFfIR
	 XBXgp1bsCtUms3scymFaRZwLprzHFQFM0Zm1PpV+lij1imUoNWQxHcmPMT1Vf3+VoWB8c
	 IYrK8bIQFafF9T64JtAqxT72I8AWLrFVIoluiOsp3Kn2bEq9vSSOFHHkZMK+myuP0jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038872;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=oZs3roWAwDTBLE9lO088xle60+3GzTwY9uksTU9Bji8=;
	b=il1Po8s0tIxk6cBLnFmFPMbZ/Q4wH5FLfYDYKyuEAgIDRdzdf1MpAudAQMVRTuA1NpoD
	 Zb6/Eo0VxJsHa59AR+gktBblMEtEEji7ClwFPRwLdlZE7DbmaUunzVP1YbHl8QblFbBs0
	 ukgSKLStWYoFI/ODfloG23ZtbWwV6ApVZXS1uKc4YWe7v4i63vbX9BCOcyWAkVT3+JTuP
	 OUcyX2hTOMm8HfqobJpYuyKfWNqZbqZHU3J4Bkl0UI5QTf/VO0dfdeVXe71ag7t5sARwM
	 m+TUhChDdPsosD48GE3/LbF4Tso7saCofBU8dXFK2d03y4hpa5mbXYtXR+28ahRKaBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0D606A333;
	Sat,  7 Nov 2026 08:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE0D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jM7vS41QJz5BNS0;
	Sat, 07 Nov 2026 16:07:48 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A787efV022675;
	Sat, 7 Nov 2026 16:07:40 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 16:07:43 +0800 (CST)
X-Zmail-TransId: 2afb6aeedc4f9f9-845a6
X-Mailer: Zmail v1.0
Message-ID: <20261107160743097R9VvfD_5S5vK286ZLzPhG@zte.com.cn>
In-Reply-To: <202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn>
References: 202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn
Date: Sat, 7 Nov 2026 16:07:43 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDEvNV0gbWZkOiB0cHM2NTIxOTogRml4IG91dC1vZi1ib3VuZHMgYWNjZXNzIGluIHRwczY1MjE0IElSUSBtYXA=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A787efV022675
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 16:07:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEEDC54.000/4jM7vS41QJz5BNS0

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
