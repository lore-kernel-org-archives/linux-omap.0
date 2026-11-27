Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795753065;
	b=CxxT5OFXTVOu15OVlCi3Cv0fDYSFBYRk6Xa9DePnWh0kJ6IIEl+NecJ43+tz32+I7LNA
	 QA66xxhAoj7oOakVEnLV7OWhaIj6iuJtBHxDtk5PHJR1M7TQePfWZ6470kPSSrnRFXFKT
	 KioPQvsYuSdkZEULB7BkfTSYlZERhUJUtWQwZAXkciCOOU7UPtd+sSo5tqMJAsvfM4Lxf
	 HHymsJYlUeJCbc80m8dxBJYK7CcXnQSjShp+Y76zdIIYpZuzgVKJV45RzxDgzaWNAFIZ8
	 iFcSB4Wtufzlq765QIGc3BcDibzBpmUpuImIBAnBBVtDq6QGgpxmnNsoBR7mpCIpDyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795753065;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=rlzBBtRZb4snnzHgtrUJH42CZc19gfsTRjkXfZVsTdE=;
	b=uik1k6iEmO+Fhtxh0MERBTWpy7H89zReKwwJJg2k0dujY0wOy1RLm13gdKOCg6zbNJtH
	 MLLruW6Htbl+uc+8f3rqSBHQRdQA8nVgbnKLEDsxRHChFpu6AzV29KtI4zH3ILh2UAg4w
	 iO/tdCNwCKl2RyNkugHejNc0KrFO+UNUQTC5n/DzlB/r0v0VPwiheg6NJvkqTM2pvEEYg
	 d1AffuUsUDI1xryS2S3Aa7iY+6JMi4bkQsHLAd9KG16OYjVxlAQyUEV/gtAbv/fpkIoX/
	 468mFhAoCMmLU77f6TPb3a8QDjGWxVFJ+QZY+MC95A+rBxsR5cIVeiNMkuQaHmOJgVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Gpj4IXEX;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BD606A31E;
	Fri, 27 Nov 2026 04:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 541BD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Gpj4IXEX
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jbKrj0v4Vz5B7RP;
	Fri, 27 Nov 2026 12:17:41 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795753061;
	bh=GsW4TxwTKSwhax6rfFYysLiUD78WAH1pjckpYaz5lHc=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=Gpj4IXEXAYRImuunaahftsogfFFFm+iNnK6VSOKW7NgqV/CUsdruSpXQ0eqGdHihO
	 00cQxzYoFjISIax8GEELXdU26mG4DH7I/5MjySjUnsypZZvSYi03MjW8T0uL2VGFzy
	 CFLaSPl66+9HES5OOVhVGobOVo5w00OVhGKnTiiHLs+O9ZpplPWuYiMJmIOnkoMX4q
	 kzAk8I5X4BJHAGCanCtq8X+d8AvFV9mqG0cPuO5U2+io6Tp3Jzt5TURbbDFdfZprFp
	 XcufUFI9yIg6Feg1qCatLNNFiv5vMo5Bdlh+m89nM/rOPX/7VihOtlQhbo/ujKtpWx
	 8M6f5IcYPQ3gw==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6AR4HdhI048953;
	Fri, 27 Nov 2026 12:17:39 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 27 Nov 2026 12:17:41 +0800 (CST)
X-Zmail-TransId: 2af96b090465ac1-0c3da
X-Mailer: Zmail v1.0
Message-ID: <20261127121741073W2BoV0DVn2BMW3wTrqImO@zte.com.cn>
In-Reply-To: <20261127121734430rp7P_HaHukJyZYs7OMQjx@zte.com.cn>
References: 20261127121734430rp7P_HaHukJyZYs7OMQjx@zte.com.cn
Date: Fri, 27 Nov 2026 12:17:41 +0800 (CST)
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
Cc: <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <support.opensource@diasemi.com>, <patches@opensource.cirrus.com>,
        <ckeepax@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDMvM10gbWZkOiBkYTkwNTI6IEJhbGFuY2UgdGhlIHBhcmVudCBJUlEgd2FrZSByZWZlcmVuY2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AR4HdhI048953
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 27 Nov 2026 12:17:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B090465.000/4jbKrj0v4Vz5B7RP

da9052_irq_init() enables wake on the chip IRQ before requesting ADC_EOM.
The error path and da9052_irq_exit() leave a successful wake enable
unbalanced, so the IRQ retains its wake reference after probe failure
or device removal.

Enable wake after requesting ADC_EOM, and record whether the enable
succeeded. Drop that reference before tearing down the parent IRQ
chip. The device can still probe when wake is unavailable.

Fixes: ed05be56643e ("mfd: da9052: Register ability of device to cause a wake-up interrupt")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Enable wake after requesting ADC_EOM and keep the conditional
  disable for irqchips that reject wake enable.

Previous version: https://lore.kernel.org/all/20261107162123768WcPgulYo-5-EuCbXTrwwH@zte.com.cn/

Build-tested on Linux-next next-20261118 with GCC 13.3.0 for x86_64.

 drivers/mfd/da9052-irq.c          | 7 +++++--
 include/linux/mfd/da9052/da9052.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/da9052-irq.c b/drivers/mfd/da9052-irq.c
index abbdbf0337e2..0fbf274a8fd2 100644
--- a/drivers/mfd/da9052-irq.c
+++ b/drivers/mfd/da9052-irq.c
@@ -259,8 +259,6 @@ int da9052_irq_init(struct da9052 *da9052)
 		goto regmap_err;
 	}
 
-	enable_irq_wake(da9052->chip_irq);
-
 	ret = da9052_request_irq(da9052, DA9052_IRQ_ADC_EOM, "adc-irq",
 			    da9052_auxadc_irq, da9052);
 
@@ -269,6 +267,9 @@ int da9052_irq_init(struct da9052 *da9052)
 		goto request_irq_err;
 	}
 
+	ret = enable_irq_wake(da9052->chip_irq);
+	da9052->irq_wake_enabled = !ret;
+
 	return 0;
 
 request_irq_err:
@@ -281,6 +282,8 @@ int da9052_irq_init(struct da9052 *da9052)
 int da9052_irq_exit(struct da9052 *da9052)
 {
 	da9052_free_irq(da9052, DA9052_IRQ_ADC_EOM, da9052);
+	if (da9052->irq_wake_enabled)
+		disable_irq_wake(da9052->chip_irq);
 	regmap_del_irq_chip(da9052->chip_irq, da9052->irq_data);
 
 	return 0;
diff --git a/include/linux/mfd/da9052/da9052.h b/include/linux/mfd/da9052/da9052.h
index 9cb2fc2938ce..ba155de6bf24 100644
--- a/include/linux/mfd/da9052/da9052.h
+++ b/include/linux/mfd/da9052/da9052.h
@@ -92,6 +92,7 @@ struct da9052 {
 	u8 chip_id;
 
 	int chip_irq;
+	bool irq_wake_enabled;
 
 	int fault_log;
 

base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
-- 
2.43.0
