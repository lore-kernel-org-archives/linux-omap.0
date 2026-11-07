Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794038871;
	b=eeybR5Am/Qak/113Wv26Hlg771PsB/Yn6LSd31O5SIG/3cHgLd8hpiwTq//M2FFvnlbC
	 +q/ZOBbB4tbZFMkcTWtojdO17kATcIAGiCtQf7vNp+Itmpkz9ucs9t94EOVAf7vv+Fig9
	 FAzHLSnj+do2p8hK8FpJJP+GQFmoD2i1pzQJ8uJ/dlDuLd1xdZgg07vUQ5RBWEvMWJ+Os
	 A9ZSTGeoYLG3jIN+YoZ3q19gAd1wa0otH500yhhG0bGhpuhKn139Oxx5e8CjQKO6ft45v
	 t53lGlsqOsRh0DuSsFHnjIZXNMx0SjOZh7VlAo+monAJxUlDBon0h7JnGhOMkFrooxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038871;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=a5rrNqAvPt8A3MZOoF9G+4MCDobAm8r2YjaZ5wARAwg=;
	b=GeCCdsrMIPd/xc2q9LxmgTJur6rhB79M+4kjY7TpSDliKctlrU9b3gTsVjltzRCeHWTD
	 Q/qN2ZwTW8ktvi+Rby1QErmPlXiaVG+zEGYSRz7F6Y6Hhex48c4GcYHZTYLnmaWOfo3a6
	 oqztAIfeE3Ov5ooJ0YaYVmMeyXZR2d/7JoDfZati8KnZjNKXm1I4kQ4iO9WSgIeKgSras
	 L4cdjxHJ9H08MtbDbtN9sD7sX7diuZsfJ4OX2/HVqj2wPrnVYbysR2XUTrC7MWC5I//HR
	 EmopEHAmKXlidvI5vBPugihjX7sEmKplMaSgB0sDjEl8UELbWO0c7CPn4DwNLMA6K3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CEB606A332;
	Sat,  7 Nov 2026 08:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2CEB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jM7vS6BHdz8Xrr9;
	Sat, 07 Nov 2026 16:07:48 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A787gCB096477;
	Sat, 7 Nov 2026 16:07:42 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 16:07:44 +0800 (CST)
X-Zmail-TransId: 2afa6aeedc50a1c-925bb
X-Mailer: Zmail v1.0
Message-ID: <20261107160744422AQlKKm8Uu2w31Z1_EGsT8@zte.com.cn>
In-Reply-To: <202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn>
References: 202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn
Date: Sat, 7 Nov 2026 16:07:44 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvNV0gbWZkOiB0d2w2MDMwLWlycTogRG9uJ3Qgd3JpdGUgZ2FyYmFnZSB0byBpbnRlcnJ1cHQgbWFzayBvbiByZWFkIGZhaWx1cmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A787gCB096477
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 16:07:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEEDC54.000/4jM7vS6BHdz8Xrr9

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
