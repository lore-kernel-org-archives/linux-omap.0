Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDED52264AB
	for <linux-omap@vger.kernel.org>; Sat,  3 Oct 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791036581; cv=none; b=rKFtZxYlhUhEtZeGR0ur/JWi5bSctCTm/JWbWwcsMZJWMTSX0DmSqVz/dLNArsojIcYQw4sLNk/cyDbhz7y64kfGtYU1FjSv5LbIFHkLqgl03YiN3d0IBb7qaHyFR4ujzEbrzT8UyXN5Oy6lFbs+BI8rxiLyL8RetL/M7yT8HMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791036581; c=relaxed/simple;
	bh=xdIPzQswUBuO7nIbi11zIqOM1B0LfdavrLeqJbs0KKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZguR/mXBUH2V1WwomQL+u1BsocOR9XK8op/6YQ2XGAWtqJMHLREKk0BP7vrO0O0NiCvK934RZYtyHhJ16eNk86QocM0N5BAEfSUOklVpdkkUzJ3dl8gYh5M6NHG7gADh/OvHjAwMQO2M+ntIR9rVffAWsFIWk/UNyO4QfP4PAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD5hBlJw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD5hBlJw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so3119685e9.0
        for <linux-omap@vger.kernel.org>; Sat, 03 Oct 2026 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791036574; x=1791641374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hVdmfx66Gvub33TevMdmKNS+KKX8lYKVFWSjk8vfkvM=;
        b=JD5hBlJwd/ze8Y8edMzHjAuiuSrnhHMI0HNaL6ZLZOAxOOWOuar8gnuGDU6YPrd2zT
         HjbcLtmDiwRGh1QrmV84lzmz6HWsGaYbbufp0N0xqfyBRRuZ0VWhMj/83dALIYnNRJA+
         COJWtM4UFmZLtXa4hZ71b+Mke90iO0WfRb8PwktxS6WLfSJXkhViFaWR22u4plLdtWzw
         oy6YAM2B30qrQFr3Nq4/VAW+4vyA9NpLxujwEq1sOvxdSL4jI0mAsnT4+2UsH+oCVIUU
         itiHm0Me21/u57uOdJrngI9qh25qbG8CJSCKVtpmoE1KhtFV9ew/6vVL3oyDY5NiR/Ub
         NdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791036574; x=1791641374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hVdmfx66Gvub33TevMdmKNS+KKX8lYKVFWSjk8vfkvM=;
        b=R7FlKTla16ZMU6FrLSDQQs1TYW/yBIsI79aYvl6+6FGMgRpaI82apzjTWf+NXpyOrL
         v5tQX24mPYqAWEkLDICIIEm3AE6+mjLu/508Mqxd2WWeeNdlYhY1x/0mu+T2LV3qkmYg
         BUhsFtZ8txnfKFIpRY1HMsTGk+NDU+Anw2oMRMMXwh8GuxHl6SgqNa3rmoCN0XwpLZpL
         ZG7CCTfA3A0cJt7UL6BmVDI3wsKy5hXpzyj1ZkYz+UyWJUvXURKGHbPpsjJW1f2ONtEn
         hZZkaGw+q/W9x/9FJYYZQlrMiikv4w8taNq2WkyVRSRBjITl63x5HK7PHlfDf6wHCpJg
         EOwA==
X-Forwarded-Encrypted: i=1; AKwUvByWTrH8nuo29/vBe5Go2wmoW62ZryLm4rcM90uhr/IUHRWKxzRWzs2YVaoKENfkxGhCLHTHPC9GAy6k@vger.kernel.org
X-Gm-Message-State: AFuF++kHOiakm75VO/wBvvveWNaNrAtmGkDgQckzF/cxTspGZAwBd7Cg
	s18XNeZftevbimUi1okWonnnBpibapgIzQlGl727XEhoUalRLS3fcxe+
X-Gm-Gg: AYBFou3wEtfQ8ryKCs4dcUtS5Yu81q2zefYc64Yp+EuPrb6rdd65rhvLaooza3Y8e2w
	P/U+YCirt+4+guS1GFvTINeY3wL8wHV9ZJlU/HfiREyFAQnd/yxDB5uRqS7rhsoXimUnDYkRLhh
	bbTZrsGtggX59O84ocH0wLjLAxLEEN9b2+bbbKQoow9EWPwABNT56I2oxDxtSGOl2/mrJON8ha0
	wmz4JJdoyHDcx+VlVtOoAzgtinhH8FFCGpFdv/osZz3YGYpcnpQLmZnovq3j4PxP0lDGRBtEm4s
	0iE51e8b7n3HjXJ4HRy4fYrjc9nBWBclUgwg4yk6Sf8dlkeu6hwvJM49Ut8LTczciBesb7Oai4t
	d9hyTKp1zoHPOtm1xwHZ7xRxjnBahUF+pOYQGhGRuRaF2t9unnBWh+iSzn+I2SbNToxhlEEcujA
	KrPuYODINB2gf5Y7kJrirlkbHibCaLcLCAAe0ud5fxFGF8gn2hEhunmi73G9DuHvvf4LWhz0eCb
	+rcixU1w5q+Y3kAdvWyvJsf06urNC5BiIjT1ADiRAouD6L2HOCEyYksyWGWSUo+dJwOGCVvoAPt
	a0GrHpIBJo+xuSNJvi/wUImd2ay16nC3nN90vta3kkvHg2w/hZrL/oMI79Vm3tv+JGKl+kGp9HC
	v1Q==
X-Received: by 2002:a05:600c:c091:b0:4a0:1f90:594b with SMTP id 5b1f17b1804b1-4a1680fd78fmr28665235e9.22.1791036573949;
        Sat, 03 Oct 2026 07:09:33 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bfafasm184098025e9.8.2026.10.03.07.09.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 07:09:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Keerthy <j-keerthy@ti.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alex@sverdlin.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: cpsw: cancel RX mode work on probe failure
Date: Sat,  3 Oct 2026 16:09:15 +0200
Message-Id: <b8146e89e0a17e6ee8d2924f64b9568402afd62d.1791035789.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1791035789.git.kmehltretter@gmail.com>
References: <cover.1791035789.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy CPSW driver registers its netdevs before requesting their IRQs.
Once registered, an interface can be opened and dev_set_rx_mode() can queue
its rx_mode_work. If a later IRQ request fails, the probe error path
unregisters the interfaces but does not drain their work before returning.
Driver core then releases the devm-allocated netdevs and private data,
allowing a worker to dereference freed memory.

Call disable_work_sync() after unregistering each registered netdev. This
matches cpsw_remove(). It drains the work before the error path releases
the remaining resources.

Without this change, a QEMU stub test reproduced a use-after-free
after an IRQ request failure with rx_mode_work pending. KASAN reported:

  BUG: KASAN: slab-use-after-free in cpsw_ndo_set_rx_mode_work+0x28/0x174
  Workqueue: events cpsw_ndo_set_rx_mode_work
  Call trace:
   kasan_report from cpsw_ndo_set_rx_mode_work+0x28/0x174
   cpsw_ndo_set_rx_mode_work from process_scheduled_works+0x4ac/0x790
   process_scheduled_works from worker_thread+0x49c/0x5b0

Real hardware was not tested.

Fixes: 0b8c878d1173 ("net: cpsw: Execute ndo_set_rx_mode callback in a work queue")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/ti/cpsw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 4fc59f9f23fc..d93d94eaac2d 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1766,9 +1766,15 @@ static int cpsw_probe(struct platform_device *pdev)
 	return 0;
 
 clean_unregister_netdev_ret:
-	if (secondary_registered)
+	if (secondary_registered) {
+		struct cpsw_priv *priv_sl2;
+
+		priv_sl2 = netdev_priv(cpsw->slaves[1].ndev);
 		unregister_netdev(cpsw->slaves[1].ndev);
+		disable_work_sync(&priv_sl2->rx_mode_work);
+	}
 	unregister_netdev(ndev);
+	disable_work_sync(&priv->rx_mode_work);
 clean_cpts:
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);
-- 
2.53.0

