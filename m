Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688635;
	b=0U8wRN+AbZLTuScxM+uAGW4phy4fMdKcP+iV/CGtnGSe0occYZSP44mGHL/cTL+dxwbh
	 cIyOffucJ6VvATbD5JnCb/ZJSVjKUzxgrdES3MStxxtYdJZWaOgGMjND1kI6mdrUwDRdS
	 DjcTrTnLrCw+9yqs1mCykGFLBt/eQdHhRcsBgfkqiZhMlKMMH+ol59BQE63IA1KpippUs
	 04g6PLuJlen5dzEghO9guFEFRsTKw5Fe/vdMRGivt6W2ypYhzAnPHYHeP/faTYGE9nPS7
	 yDVjCQaXXYcmKaP7jYGMy4FPbHaM0i23yU+SD/lWLpTUhW0YHMi7bPsmEgtpHOEf1DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rMMXxpimWD9ofCyboRprDPWf9DrBJJ1w7n/6Xi+aArM=;
	b=tSpRO6gjYD1/fkOI6BpfwDpI2lSDxdrEM7mFE4cA997PWJXeptPa/YcdbM5s1nkuo8q4
	 Hb3JX8yhFuW5QXIWZV7ggAGSkS6hSMQPfIbnXiljDPKlLQU6y6D+9bKxR6OxFnSckT0Gt
	 gbyE3MebNA5ojw/h8MRnvOwASZmVp7qxdl8ViUPlVAVFWGIkd+BqCfEeeOpqWfo/wE149
	 aVPp+xPXGGhDa1ZWKoIpanFzEox7Gxs5b228EBLRdsLiT27nBBqOtQ6LkZozdm0GdoPha
	 pLFlwgBB17SzD0sylDdEZsujnUTxmm/QU6tPZCoBuWjokgmDLTVGFex3dD57XqzMdqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SJ94yukw;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3125E606A31C
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2026 10:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3125E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SJ94yukw
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a440c9e13aso429341f8f.3
        for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2026 02:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795688633; x=1796293433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rMMXxpimWD9ofCyboRprDPWf9DrBJJ1w7n/6Xi+aArM=;
        b=SJ94yukwkU6sMA6rz0bgsiXlOP+iVPbAn46JDIJ91amM6cugBTCk2bllt6+Pm6/3a+
         it9nJPOQ+6mxCSq+mSdDEv8CuNV8Q/pUQVCFpmSs43SHUMj7nrkgytTue+U8ML059Ges
         ADsNwD/2Ka4qopeoFdPpEdGZmThAtESHCzppDfZS3TFEQpfWe+UwjNXZ6PnFinlsxTAZ
         ERiOykkRLnXghsiatReIZYKx6Uugk0XYcKOb85xOzCmqIv/UoSE++P2WJSIcxhc6EA1L
         nnWrFYccFgl8WqzRU9BS41jUClwJbVuVY1ASuN4Kxqh/0krZ5PCxylY+Mj3WIz0A8DB8
         b1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688633; x=1796293433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rMMXxpimWD9ofCyboRprDPWf9DrBJJ1w7n/6Xi+aArM=;
        b=DPKJZ4zcBOuoDc2+l+spPDZlHo4nxmafhCAvB6rKhlM4RE3TlMxL74MzAhtH7Yza32
         4okXRe1zhsijDS+cVrrR5CkKpo9ZbJh34H6RYarWdxcJvqYa2mlFuRSSx7AM2DrBqZbh
         k8B23XqOQkzuQkcRm8lj5aFEvW9WWYjMYenUfQtkR1o4eQr3mkmAJg+PGoStTWqDzrae
         0ePlgqlYtJU1td71jJZDXdG4O8f6bOZu/YWR5jFh01f0CVgajiKZyYtvrcrXJZEzybed
         26U919BfZDhUoXWff83CR81YPwZ9KLgl63Sam3T9Lo0ZJwLamqSGxAN5v6Yw5gJpyNHh
         njZA==
X-Forwarded-Encrypted: i=1; AL+hErErsfuV3m2VNZs4ENCIAFNgZo0SUP2Gr0pgwnMDiW/A/5ZljupjraPBC2SfCao9ERbwMiudgz2KBXrS@vger.kernel.org
X-Gm-Message-State: APuU4Z/FsKzvNFl/6ohOBE02lPDbnwijE2LYNzoc448gLQyacGIIHkPA
	EBwjPHoPDX5r4vgNBYfRlmBxHc0bJ/Kv4iw4giXM8Q86Y3n7Egn9ES90
X-Gm-Gg: AZFdTZdji4KJ04m6gs+zLveb9FYAjp2DnNd1ukzbkop8T6DaQZXfKrDYMigb5i7dtG8
	11FJjqlaBcq+7Hj+VsQPFNC5ppAphym3atk2VEty1lVUjbZAcqC3On2pcgnaFJVtx/L8jpX2wXn
	EU0hWUNqz6bFBp+iiIug86NtvP/nRtJdU5YvjJcFSZhUJUSO9j16X5t14EPWNCCehgw0TAJoCDf
	Zwr7kDR5k0wp6AxUgHOH0DPUk11kQ+Te9nV18RlDjsHU9pzDF6jStNzCBeFiydqUfXpOW9qDGEo
	JZSvcseLlsFw94kMDk3W3txdinxeDGoCb0UoHUew5sIwT2zWu6grPLts6sn8gMIpQeyAeOco5y3
	Lb7wfFLdU76LceYfcSysnT9azAwHMn65H27HAAt2+3aoNr2ZhQDgUCjeaHkVsKN7DTUG7ROjN1j
	PZGwvM8MorFiEwOMcbD5lmqXo4onnpgdb6rXx+p3ese7PnCD9ielvLpj8ldLI5YBszybvlUjO8Z
	cu/deUcpEBFZFLI7LFZZ7vun7pg7XR0RN/O00JZuq/ER9KlsbNlDnJd03RjPIC1RZUfMQKfrD1N
	VUwDgU5sQwKA4OiJI8GJM9Qqkm2cJeObVpEf+TSjf02ApkWd/yOG6FhY5e6Qye3Eh1RHim9jqDa
	PObyvyIBkBGU04zDOWKI=
X-Received: by 2002:a05:6000:2f87:b0:48f:bb47:3d68 with SMTP id ffacd0b85a97d-4abaae41e22mr39403565f8f.1.1795688633319;
        Thu, 26 Nov 2026 02:23:53 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-006.paris.inria.fr. [128.93.83.6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989e3sm39802210f8f.52.2026.11.26.02.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:23:52 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	"G, Manjunath Kondaiah" <manjugk@ti.com>,
	linux-omap@vger.kernel.org (open list:OMAP1 SUPPORT),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: omap1: Fix request_irq() leak
Date: Thu, 26 Nov 2026 11:19:44 +0100
Message-ID: <20261126101947.28547-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_system_dma_probe() requests one IRQ per channel with request_irq().
If an error occurs afterwards, probe returns without freeing the
requested IRQs. As dma_chan is allocated with devm_kcalloc, it is freed
if probe() fails. If one of the allocated IRQ is called, it dereferences
dma_chan causing a use after free.

Use devm_request_irq() to make cleanup automatic.

Fixes: f31cc9622d75 ("OMAP: DMA: Convert DMA library into platform driver")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 arch/arm/mach-omap1/omap-dma.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/omap-dma.c b/arch/arm/mach-omap1/omap-dma.c
index aebe5e55ff60..b0b46e7ec6b7 100644
--- a/arch/arm/mach-omap1/omap-dma.c
+++ b/arch/arm/mach-omap1/omap-dma.c
@@ -800,9 +800,9 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 		if (dma_irq == INT_DMA_LCD)
 			continue;
 
-		ret = request_irq(dma_irq,
-				omap1_dma_irq_handler, 0, "DMA",
-				(void *) (ch + 1));
+		ret = devm_request_irq(&pdev->dev, dma_irq,
+				       omap1_dma_irq_handler, 0, "DMA",
+				       (void *) (ch + 1));
 		if (ret != 0)
 			goto exit_dma_irq_fail;
 	}
@@ -820,19 +820,8 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void omap_system_dma_remove(struct platform_device *pdev)
-{
-	int dma_irq, irq_rel = 0;
-
-	for ( ; irq_rel < dma_chan_count; irq_rel++) {
-		dma_irq = platform_get_irq(pdev, irq_rel);
-		free_irq(dma_irq, (void *)(irq_rel + 1));
-	}
-}
-
 static struct platform_driver omap_system_dma_driver = {
 	.probe		= omap_system_dma_probe,
-	.remove		= omap_system_dma_remove,
 	.driver		= {
 		.name	= "omap_dma_system"
 	},
-- 
2.53.0

