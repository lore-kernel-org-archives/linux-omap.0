Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795753069;
	b=Cf8S/eggDV9bYRX3pi7VO+1gEhCMCmepiYp2fiNXmX70l/RDQixc4hCx++aZ/vZgeYLF
	 BiCNlS/mrFBcHbsshHx2xfQ4No7RvInHtunVqKrnBp+WjMMgh+WaZ5tS9cCQLR9BQBmEh
	 XGXd51CKzwLeRQ2TftBgjKbQACu6JYTU3tleZghtFHa6DWm+weXaAOZbXSE5Pq4Z9WACs
	 JnOLV9Mz/eHUYJiWStmLHPV3czQlrm2SlbkOJ1oWTtxAxpAt3UM9Iy+troKj9Eq+fCaD+
	 mCx9uF2MopIRNRp6CIB0WksspkbWmCMqNrutKibgMh8er6YQ7dP8lXWVXXAWVZzE4MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795753069;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=m2dfFTLyJDnuut/kSgGNburJKYEkRooFBwozoeDUcTg=;
	b=uwJ9uvlL86aG/muFq4UzbJw0UyRPuhvziCgEy5EyS442sXyTxVHIsmhiBUGJglLuXBml
	 roBWFkos9BYSUkVcNsNYE7P0lKRT7U6EhX0Y19dTUYb8ELRaAg8CX7+AMCiy1/eLYsdfJ
	 4DgX1hmiIhcp64o0UKpv8nZdXej1HObMrWIA4R9RbYbrA1+1Yy8GBC5CFHuJQWYSEsusf
	 ir5cpwJxhR+ese/NmUXw82YVO3aBVtfj7TYOJrLbfDf2jx24X6v2JmDg9KZ+Zevm60f+c
	 WNZsR+/F1WEgHFARvVIWoNOGtHLyMDN2KvJ6Cl2KCHNNeEiss0KMJWvSq2eKSIRUGZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="oS/bzFpP";
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B7606A32E;
	Fri, 27 Nov 2026 04:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF0B7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=oS/bzFpP
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jbKrq2cRKz4yjjB;
	Fri, 27 Nov 2026 12:17:47 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795753067;
	bh=08f/pkkFDOG0F17eQvtO+Ri+d2aRnQL9K1pmC5PEQdM=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=oS/bzFpPKIl3JunA1hxMLAalr/0tpzfA0q6IuO6dE1ROcrd1gcH/o5shGuZtBDKNI
	 F/gc9KuEw7ED3ux4VmvMIlNayyIQu9G1pZGzgYegtEePS/MqlqLwr3qaW/RsSGWy6p
	 M7VyhDKbJRhzBY8CYBZgt7Fb5zT3F6ASW0VcpSzj1mHuiYjRZZI4bCRGdcDSubfP2w
	 qNpAqrc9DATtyeC9lPV7siV01Os/CpAkP5dYbROgSlN2tpEBIZOZgu52VBTX2LUdJO
	 m67D9Xv4SiM5D6M2eplUSIbAUx/Ha/c5sjLpDJzyNDwQFYhy82hmGIqskXhSC3INHW
	 UmDtQlFs1axDA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6AR4HbL9090958;
	Fri, 27 Nov 2026 12:17:37 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 27 Nov 2026 12:17:38 +0800 (CST)
X-Zmail-TransId: 2afb6b090462276-08b92
X-Mailer: Zmail v1.0
Message-ID: <20261127121738923LHjBUaCxdDRPGTYPDZBDV@zte.com.cn>
In-Reply-To: <20261127121734430rp7P_HaHukJyZYs7OMQjx@zte.com.cn>
References: 20261127121734430rp7P_HaHukJyZYs7OMQjx@zte.com.cn
Date: Fri, 27 Nov 2026 12:17:38 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvM10gbWZkOiBhcml6b25hOiBGcmVlIG9ubHkgcmVnaXN0ZXJlZCBkaWFnbm9zdGljIElSUXM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AR4HbL9090958
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 27 Nov 2026 12:17:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B09046B.000/4jbKrq2cRKz4yjjB

arizona_dev_init() requests three diagnostic IRQs before adding MFD
children. If adding the children fails after any of those requests
succeed, the probe error path tears down the IRQ mappings while the
diagnostic IRQ actions are still registered.

Record which requests succeed and free those IRQs before IRQ teardown
on probe failure and on removal. Diagnostic IRQs remain optional, and
a failed request never leads to a call to free its action.

Fixes: 3cc729869475 ("mfd: arizona: Core driver")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Record successful IRQ requests and share cleanup between probe
  failure and removal.

Previous version: https://lore.kernel.org/all/20261107162122461AuQ94DzIh_R4gD8FWdVlC@zte.com.cn/

Build-tested on Linux-next next-20261118 with GCC 13.3.0 for x86_64.

 drivers/mfd/arizona-core.c       | 49 ++++++++++++++++++++++++++------
 include/linux/mfd/arizona/core.h |  1 +
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 91975536d14d..8e5b8a75e773 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -231,6 +231,43 @@ static irqreturn_t arizona_overclocked(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static const struct {
+	int irq;
+	char *name;
+	irq_handler_t handler;
+} arizona_info_irqs[] = {
+	{ ARIZONA_IRQ_CLKGEN_ERR, "CLKGEN error", arizona_clkgen_err },
+	{ ARIZONA_IRQ_OVERCLOCKED, "Overclocked", arizona_overclocked },
+	{ ARIZONA_IRQ_UNDERCLOCKED, "Underclocked", arizona_underclocked },
+};
+
+static void arizona_request_info_irqs(struct arizona *arizona)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(arizona_info_irqs); i++) {
+		ret = arizona_request_irq(arizona, arizona_info_irqs[i].irq,
+					  arizona_info_irqs[i].name,
+					  arizona_info_irqs[i].handler,
+					  arizona);
+		if (!ret)
+			arizona->info_irq_mask |= BIT(i);
+	}
+}
+
+static void arizona_free_info_irqs(struct arizona *arizona)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(arizona_info_irqs) - 1; i >= 0; i--)
+		if (arizona->info_irq_mask & BIT(i))
+			arizona_free_irq(arizona, arizona_info_irqs[i].irq,
+					 arizona);
+
+	arizona->info_irq_mask = 0;
+}
+
 #define ARIZONA_REG_POLL_DELAY_US 7500
 
 static inline bool arizona_poll_reg_delay(ktime_t timeout)
@@ -1355,12 +1392,7 @@ int arizona_dev_init(struct arizona *arizona)
 	pm_runtime_set_autosuspend_delay(arizona->dev, 100);
 	pm_runtime_use_autosuspend(arizona->dev);
 
-	arizona_request_irq(arizona, ARIZONA_IRQ_CLKGEN_ERR, "CLKGEN error",
-			    arizona_clkgen_err, arizona);
-	arizona_request_irq(arizona, ARIZONA_IRQ_OVERCLOCKED, "Overclocked",
-			    arizona_overclocked, arizona);
-	arizona_request_irq(arizona, ARIZONA_IRQ_UNDERCLOCKED, "Underclocked",
-			    arizona_underclocked, arizona);
+	arizona_request_info_irqs(arizona);
 
 	ret = mfd_add_devices(arizona->dev, PLATFORM_DEVID_NONE,
 			      subdevs, n_subdevs, NULL, 0, NULL);
@@ -1373,6 +1405,7 @@ int arizona_dev_init(struct arizona *arizona)
 	return 0;
 
 err_irq:
+	arizona_free_info_irqs(arizona);
 	arizona_irq_exit(arizona);
 err_pm:
 	pm_runtime_disable(arizona->dev);
@@ -1417,9 +1450,7 @@ int arizona_dev_exit(struct arizona *arizona)
 	}
 
 	mfd_remove_devices(arizona->dev);
-	arizona_free_irq(arizona, ARIZONA_IRQ_UNDERCLOCKED, arizona);
-	arizona_free_irq(arizona, ARIZONA_IRQ_OVERCLOCKED, arizona);
-	arizona_free_irq(arizona, ARIZONA_IRQ_CLKGEN_ERR, arizona);
+	arizona_free_info_irqs(arizona);
 	arizona_irq_exit(arizona);
 	arizona_enable_reset(arizona);
 
diff --git a/include/linux/mfd/arizona/core.h b/include/linux/mfd/arizona/core.h
index 6d6f96b2b29f..3a9881a1c0c9 100644
--- a/include/linux/mfd/arizona/core.h
+++ b/include/linux/mfd/arizona/core.h
@@ -136,6 +136,7 @@ struct arizona {
 	struct irq_domain *virq;
 	struct regmap_irq_chip_data *aod_irq_chip;
 	struct regmap_irq_chip_data *irq_chip;
+	unsigned int info_irq_mask;
 
 	bool hpdet_clamp;
 	unsigned int hp_ena;

base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
-- 
2.43.0
