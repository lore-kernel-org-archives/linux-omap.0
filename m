Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794039695;
	b=A9Hrj/0J/JRFWCRr3z4qfXzFTce87ASt7G7wwun3QbbU9fgt5w6HmL/iDuenXw/IUDgX
	 5NXbw49TNx57yvZwrD2w+B5AQO/VNTUy71E6VhZsCgKmXnc8mpkOUSxF1Ax9l7INUPqXh
	 0WiqmQMAonsHFXdnzCrXf/MmoE0U0PVNcfKmxCSrKarHBBw8sr9VdkayNQrtgEp8GUK/T
	 8w3UAOMlJAhDkCLlZplMfYGHR/yE1kaGEbmY9ijY9MaqfIUYkcqWB5b8sK23GVsK5NX35
	 Q6YqCUP2ZfoKBGuO24xwSe1FiaVEoAFpe/6NcE/eCdG+aN70RNGk3uxrS/lu27b2IGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039695;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Da7EkwAu6eWzKaaPHtEuhjwDATbEpwvSZ1bs0M9ZsKM=;
	b=fwD64557lawF8Cqd/Nqw+mIjCCa8TCzDn6qOARXsVSSlK8tavoUaE7utOXNlcJjY/y2y
	 d8zesv4FloigYAV0t3d/ISalCfX0++i2MrxdzWHiSVHQT/K83KzOSJnNg6wZf+Yt0MvrH
	 fxcyMqteQRSRI+s7hDrjCbruOxK2hL3H/vzug8aPF8Db62KE9b1XvJ90/qve+bdSn8Zx6
	 m2aezIO5MbULLzd6dZQSeH/kGEF7aw1IDxxHJFZ9CUGuP+1uzFD3N2x/FSz1Fr57Wuh6V
	 kM4F9CnughTL5Y57VYLRrTzt2ZKgl40JPBo/P9sR0eGG2SwldgPYbnDayhDkpfZSUzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5226606A32D;
	Sat,  7 Nov 2026 08:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5226606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jM8CD2YLGz5B12l;
	Sat, 07 Nov 2026 16:21:28 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6A78LLVV029911;
	Sat, 7 Nov 2026 16:21:21 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 16:21:23 +0800 (CST)
X-Zmail-TransId: 2afa6aeedf831c1-a2d4f
X-Mailer: Zmail v1.0
Message-ID: <20261107162123768WcPgulYo-5-EuCbXTrwwH@zte.com.cn>
In-Reply-To: <202611071621143491uRwluLhxYsUHx2V3qhm_@zte.com.cn>
References: 202611071621143491uRwluLhxYsUHx2V3qhm_@zte.com.cn
Date: Sat, 7 Nov 2026 16:21:23 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCA0LzVdIG1mZDogZGE5MDUyOiBEaXNhYmxlIElSUSB3YWtlIG9uIGRldmljZSByZW1vdmFs?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A78LLVV029911
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 16:21:28 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEEDF88.000/4jM8CD2YLGz5B12l

From: Shao Mingyin <shao.mingyin@zte.com.cn>

da9052_irq_init() calls enable_irq_wake() on the chip IRQ but neither the
error path (when requesting the ADC_EOM IRQ fails) nor da9052_irq_exit()
(the removal path reached from da9052_i2c_remove()/da9052_spi_remove())
ever calls disable_irq_wake().  The wakeup configuration is therefore left
behind when the device is unbound; the IRQ line keeps being treated as a
wakeup source and, should the descriptor be reused by another device later,
the stale wake setting persists.

Track whether the wake source was successfully enabled and disable it
symmetrically on both the probe failure path and in da9052_irq_exit().

Fixes: ed05be56643e ("mfd: da9052: Register ability of device to cause a wake-up interrupt")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/mfd/da9052-irq.c b/drivers/mfd/da9052-irq.c
index abbdbf0337e2..da5bac424efc 100644
--- a/drivers/mfd/da9052-irq.c
+++ b/drivers/mfd/da9052-irq.c
@@ -259,7 +259,8 @@ int da9052_irq_init(struct da9052 *da9052)
 		goto regmap_err;
 	}
 
-	enable_irq_wake(da9052->chip_irq);
+	if (!enable_irq_wake(da9052->chip_irq))
+		da9052->irq_wake_enabled = true;
 
 	ret = da9052_request_irq(da9052, DA9052_IRQ_ADC_EOM, "adc-irq",
 			    da9052_auxadc_irq, da9052);
@@ -272,6 +273,10 @@ int da9052_irq_init(struct da9052 *da9052)
 	return 0;
 
 request_irq_err:
+	if (da9052->irq_wake_enabled) {
+		disable_irq_wake(da9052->chip_irq);
+		da9052->irq_wake_enabled = false;
+	}
 	regmap_del_irq_chip(da9052->chip_irq, da9052->irq_data);
 regmap_err:
 	return ret;
@@ -281,6 +286,10 @@ int da9052_irq_init(struct da9052 *da9052)
 int da9052_irq_exit(struct da9052 *da9052)
 {
 	da9052_free_irq(da9052, DA9052_IRQ_ADC_EOM, da9052);
+	if (da9052->irq_wake_enabled) {
+		disable_irq_wake(da9052->chip_irq);
+		da9052->irq_wake_enabled = false;
+	}
 	regmap_del_irq_chip(da9052->chip_irq, da9052->irq_data);
 
 	return 0;
diff --git a/include/linux/mfd/da9052/da9052.h b/include/linux/mfd/da9052/da9052.h
index 9cb2fc2938ce..d7dd36891539 100644
--- a/include/linux/mfd/da9052/da9052.h
+++ b/include/linux/mfd/da9052/da9052.h
@@ -93,6 +93,8 @@ struct da9052 {
 
 	int chip_irq;
 
+	bool irq_wake_enabled;
+
 	int fault_log;
 
 	/* SOC I/O transfer related fixes for DA9052/53 */
-- 
2.47.0
