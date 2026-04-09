Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09DC3BD63C;
	Thu,  9 Apr 2026 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729475; cv=none; b=VpeCWMoYv2xdBA9L9IpnTeBPl3lqx9YwTuhkE2RNkUpuLHkY5AlD54xTg00tDFrn0Fp0YFls6Sk+0GEVyrn/wpiIjA5TKIRX4G76mabsDgq+tzubNiDKJ8+2cJdGY1MthBNrvYiywdTulD91GXZmJz87T0iTeg213i8nuD6jwqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729475; c=relaxed/simple;
	bh=RCmjAxaoX2mTobcPwqsXrmrHBUl6HvMDiMnPej9lPLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SGakT3MBVZnQm2FAdCT8JW6JlR9LE6AQ3ChUQ7dNbo3309IZIfC0Qhunun7WqPKKZ+bka1qJgIpgvcr8WclQDW+foKt/m06Ev4FURPbZsNxyWDIH/cwEovfNfzxogD5Vcigfh2YCKk/CCkkXBUd8vGaftCA1h/SwaMdzt+D0P1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowADXfmo6e9dpWJC6DA--.7938S2;
	Thu, 09 Apr 2026 18:11:06 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: b-liu@ti.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: musb: omap2430: Fix use-after-free in omap2430_probe()
Date: Thu,  9 Apr 2026 10:11:04 +0000
Message-Id: <20260409101104.480623-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXfmo6e9dpWJC6DA--.7938S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1rArWDZryUXw47KF1xXwb_yoW8GF1kpw
	s8GFWSyrW8Gr47Ka4kt34rXayktan3t3yFkr92kwn3u39xG347AryfXay0yF18KF95Ga15
	tr4UtFW8ZayFk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUBnQUUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4MA2nXPaPz4AAAs7

In omap2430_probe(), of_node_put(np) is called prematurely before the
last access to np, leading to a use-after-free if the node's reference
count drops to zero. Move the of_node_put() calls after the last use of
np in both the success and error paths.

Fixes: ffbe2feac59b ("usb: musb: omap2430: Fix probe regression for missing resources")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/musb/omap2430.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 48bb9bfb2204..333ab79f0ca9 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -337,7 +337,6 @@ static int omap2430_probe(struct platform_device *pdev)
 	} else {
 		device_set_of_node_from_dev(&musb->dev, &pdev->dev);
 	}
-	of_node_put(np);
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
@@ -455,6 +454,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register musb device\n");
 		goto err_disable_rpm;
 	}
+	of_node_put(np);
 
 	return 0;
 
@@ -464,6 +464,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
 err_put_musb:
+	of_node_put(np);
 	platform_device_put(musb);
 
 	return ret;
-- 
2.34.1

