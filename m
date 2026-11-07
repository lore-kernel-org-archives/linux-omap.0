Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794038872;
	b=N7tRetEh/xAKOwfSCii/mfyl9mql1i8cfl1O0BoafMnjpvXyY2eFMS/ySl4Jifq/Nk8w
	 rJaCk7hpPTY8etY3Ezf8oPSOveWwinf6tlSdey3mmqVCOnnpjSX9z/szd6EUUn/GK6BRb
	 ut9+xbo/I4uWipl2honDBHOhi1K+Li4pblIQXMGAhYSpvD9bZkYjOMznmpetQIZ445PmG
	 MkhTnZ3TZoZweGtRWQKxy3tEXNP0D2nvxnUI79SbhbGEnfacYDXBE1vmEZUWLEC6TBae0
	 4NqJFSji+FTrnDsIki4mneDmXiA4iGD2WOGg1oewIfrNTQf5JnQk14VcKd4JXCmF/yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794038872;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=QrZw2WSxIpDSYK8C1u/HDfL++Q0jqY0MAHzBROmU2eQ=;
	b=fnUqpkCEw+KyU/gIFCopFKU5RY/cOBo87OPuGajkYlrjpL6n+c/MCY7daHUrjQ8C0zMm
	 uJTqbqS+Zc8AJlI7a9zwL04yJT3GwlF65jwtWA3U6Tnj65YIUgtpJW9DDH0J9nXSGOB9N
	 VH3BbtmP01HyX4EihTkaTMIUPYWsTvOgu1MNDIknfcL0tgPDE0yNogCtEk+2g4lI69sww
	 rJqTcXSbzdgUK1wd6GvKwWw/fXI6TT0nnqxUACB6CkV56VBCIKraYia+9Pzz7XfVj6UZC
	 ypqc6nC5pwM+lOXOrGSk/1r/JWjQ561773X/a7vJigLunVtbnrlQe+ErL1f1hortyRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53D606D803;
	Sat,  7 Nov 2026 08:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD53D606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jM7vR062mz57HS1;
	Sat, 07 Nov 2026 16:07:47 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A787job096482;
	Sat, 7 Nov 2026 16:07:45 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 16:07:45 +0800 (CST)
X-Zmail-TransId: 2af96aeedc51d40-808f1
X-Mailer: Zmail v1.0
Message-ID: <20261107160745724MOYYTSmCdHXClJi4gEGfn@zte.com.cn>
In-Reply-To: <202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn>
References: 202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn
Date: Sat, 7 Nov 2026 16:07:45 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDMvNV0gbWZkOiBhcml6b25hOiBGcmVlIGluZm8gSVJRcyBvbiBwcm9iZSBmYWlsdXJl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A787job096482
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 16:07:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEEDC53.000/4jM7vR062mz57HS1

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
