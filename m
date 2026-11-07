Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794039689;
	b=zuFg9hj2FWWRf9XvYvC+BUmCoEEfRAbzWdT0RRzAZVqUqMScuYKjgdXWxdZmUhuZ7UOE
	 eT1Rhc+vlpoWHkQePcAINKtuLwdgQHQiAY1eGQt1CfJ3+jIJ4Y/mUyjHJCd4Cgdjjd70z
	 9MN2Gw26ZIqh676YB+TPXcU/wAURVJv3BAItNqa8DNKpPU2Rl742On98+xOXM0BxO8qZk
	 rfeVUkdM0uevqupwUDeotgpTaQcJHNVYBLDmEXuRS4gS6BLv5fPNT+Io1m3tK+bQ3Dek5
	 wWi3Md0t3XyJm+yDdkRwTc8CFMf6Atr04MExWcwxP+cdRSX2Chkh4ZK5vpFxeoJIwSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039689;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=yH0ZKpXbB2is/wqyLZtzhG3eciAgBymgipiDGXHEbto=;
	b=bXOQRWqEk6Vz/f2WtyOJif7PWOVSvf+bPFzxfDqJmExAQbmWi4PyaFHMZnABMRu8rn8y
	 z7yhvXCAN2mHknwKtqRN/mvB2wpUMPjMuPRQSupA7KXcIJvxOsdaQm4XZMNW8dijY4lK0
	 EAl/cbIkMgq8EEmfWHfWNj6UCy2tc+YUv7y6L5ikJZZHYMMzQr2QLm3Mdf1vrQEzptK8q
	 8uDfE3lh8ur3zuUnz7I5Vi6j/vKjmy1mRg4IzbJpUyX8n1qw3GohxwHnpn43jyo0OXxaE
	 U94EzzoDXrRQPdVZ3IOJvTa0ORgqiomEqcl+iLCUmgNoozsfyV6lbJYG/Bz8opIh0Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3757C606A32C;
	Sat,  7 Nov 2026 08:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3757C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jM8CC6SBtz8Xrrb;
	Sat, 07 Nov 2026 16:21:27 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A78LKdM029834;
	Sat, 7 Nov 2026 16:21:20 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 16:21:22 +0800 (CST)
X-Zmail-TransId: 2afc6aeedf82c12-907b3
X-Mailer: Zmail v1.0
Message-ID: <20261107162122461AuQ94DzIh_R4gD8FWdVlC@zte.com.cn>
In-Reply-To: <202611071621143491uRwluLhxYsUHx2V3qhm_@zte.com.cn>
References: 202611071621143491uRwluLhxYsUHx2V3qhm_@zte.com.cn
Date: Sat, 7 Nov 2026 16:21:22 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCAzLzVdIG1mZDogYXJpem9uYTogRnJlZSBpbmZvIElSUXMgb24gcHJvYmUgZmFpbHVyZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A78LKdM029834
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 16:21:27 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEEDF87.000/4jM8CC6SBtz8Xrrb

From: Shao Mingyin <shao.mingyin@zte.com.cn>

arizona_dev_init() registers three informational IRQs (CLKGEN error,
Overclocked and Underclocked) with arizona_request_irq() before adding
the sub-devices.  If mfd_add_devices() fails the error path only calls
arizona_irq_exit(), which frees the CTRLIF_ERR/BOOT_DONE IRQs and the
IRQ chip/domain but leaves these three requested IRQs behind; they are
freed only in arizona_dev_exit() on the normal removal path.

As a result the three threaded IRQ handlers stay registered and
irq_dispose_mapping()/irq_domain_remove() in arizona_irq_exit() act on
virtual IRQs that are still in use.  Free them in the probe failure path
too, in the same order as arizona_dev_exit().

Fixes: 3cc729869475 ("mfd: arizona: Core driver")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 91975536d14d..37cba7047d76 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -1373,6 +1373,9 @@ int arizona_dev_init(struct arizona *arizona)
 	return 0;
 
 err_irq:
+	arizona_free_irq(arizona, ARIZONA_IRQ_UNDERCLOCKED, arizona);
+	arizona_free_irq(arizona, ARIZONA_IRQ_OVERCLOCKED, arizona);
+	arizona_free_irq(arizona, ARIZONA_IRQ_CLKGEN_ERR, arizona);
 	arizona_irq_exit(arizona);
 err_pm:
 	pm_runtime_disable(arizona->dev);
-- 
2.47.0
