Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794038872;
	b=jU7TpckHOd8AJzSe7zx4iYOevfFoBAKs+0BM0DLgfxpNjmxECL4UJziEEsowQGPdPDaS
	 mhUMxL6w/N32MwMDrubktOpc/H3iMs8n6XGRICd59BaEB78QAKX4y27dBma4gjxtP8M/W
	 4rLJL7EW3Rfv4oCeKs875Yn3uxpY3OjCgPq6cnH3WgmKqmw01ZZK6RY7jf43CjNCcWl8r
	 KrVk3A0qDROYsF22S2rk93A4OAQeDCeKvf0fTUfa1oSCRHbFH9Frol07u2hCcJS7dNt8Q
	 xSJE6s/+kk+qtA+/9uekI8lpG56LYfeOr3a75YYF3EcpxTynPJ5fMkK1Bcx75MR4pqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038872;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=jx7F6w/juDlrYyALaYD2lutJjUTAxqwLUj+M4ydfDYQ=;
	b=U21iVLQmQWK79VR4ZPvxd3qOMg3zWiD8yx43O+a85+RtfggrCHUeO6uNE5geOgukB/Ir
	 XUkehUvn+ZK3BO6WfRMWbgDcUIW7j44rfkN1SCx53+biPGO2uKRIXs87+Dsaj6k8e1G3D
	 o+/1cAYLsBWWqMaKLEw4d+3xarf0W7mMMJj79Aw3XcX4kFeIR3geMpuSeUWLDyMEwCpk7
	 PXlcTYv41cTUCUJvxfzLskEiC04rdlosA5S96WFAdgpROn9MYI2bGrB92gdm02WQuEAVo
	 MKw7jVr9j4ubb91Rqu4z9tpeLP+i/hkrJJUcK0CWwQIM1dOmYtsVLcuiE4ZSoK90jCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775E606A33A;
	Sat,  7 Nov 2026 08:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4775E606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jM7vQ3gfFz57HS0;
	Sat, 07 Nov 2026 16:07:46 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A787jHJ096481;
	Sat, 7 Nov 2026 16:07:45 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 16:07:47 +0800 (CST)
X-Zmail-TransId: 2afa6aeedc53af5-92694
X-Mailer: Zmail v1.0
Message-ID: <20261107160747079LomNfOJeeu6knwkNqJYTx@zte.com.cn>
In-Reply-To: <202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn>
References: 202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn
Date: Sat, 7 Nov 2026 16:07:47 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDQvNV0gbWZkOiBkYTkwNTI6IERpc2FibGUgSVJRIHdha2Ugb24gZGV2aWNlIHJlbW92YWw=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A787jHJ096481
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 16:07:46 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEEDC52.000/4jM7vQ3gfFz57HS0

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
