Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36C33E360;
	Sun,  6 Sep 2026 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666137; cv=none; b=asjitP/wZnCM0YEtsgS3fh9OFY2gUQQqtAX6CCACZ1uw+p4SA4bWjQAJwyqHskm5IXbgBQ08jtnnFg1Ru7ih/gAvs/UYDI454mm5LiExk0tgcK9AbVDAZHkiUcjPcu/7lcyRMLDifVQVBWJgAAzzdxWfwsorXJMgAWm9jt2Gy0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666137; c=relaxed/simple;
	bh=z+I4zAxIb+/0nEXzsAF9oU3Gf2EV3Il6oaXYlIRIzek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhvHp3/uQGv7XZuj+Xh43dCaWMTllbE34tuL24u1JlW+zsGo2A3rjXXPeMWS+pdHaTNNdrWArGy2NqOQ6TDJa7xrBNdQZ33mTBkC2OYUxYDonYwcgQHoBj+zzK0zWdjkHkwL33q59kn/SPtjwX+VFL9SpjAVZHv5fdL4DDm8feE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SvLF3D16; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SvLF3D16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xt
	acXvrktn66L3QWU8uVsmniCDM9OQcM9WReuJ0Hgp4=; b=SvLF3D16VJD9KQOfhn
	SIY6U8tgGqetpOh3gauC1sxLWHrU2H7g2D/mOHwNvMVh0a0y5EzrXNTcEl6eng8y
	F4iR/OwW0F1uaOtRUwipk4gKtddWLM1FVKYN69WMqCTTzDc0/4Am8SeeoujXhFuA
	7vEgNvMYoyeI36f2oEZo4ET80=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXhfz_4JxqO+zERA--.30741S4;
	Sun, 06 Sep 2026 11:41:53 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pengpeng Hou <hppiscas@163.com>,
	Tony Lindgren <tony@atomide.com>,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: musb: omap2430: Propagate PHY errors from runtime resume
Date: Sun,  6 Sep 2026 11:41:48 +0800
Message-ID: <20260906034149.85550-3-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXhfz_4JxqO+zERA--.30741S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4DGFW7Kw1xGrW3ur4kWFg_yoW8GF1kpa
	nrWayFyrWkJ39rK3Zxt3W5XFn5G397trW3C34I9ws3ur17GwnFkryUtFWjyF1YgF18tFW2
	yF40ya1Uur4fKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYE_NUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7QE6A2qc4QGuTQAA3g

omap2430_runtime_resume() ignores phy_init() and phy_power_on()
failures and continues to initialize the glue state without a usable PHY.

Return initialization errors and call phy_exit() when power-on fails
after a successful initialization. Keep is_runtime_suspended set until the
PHY and glue state have both been restored.

The issue was found by our static-analysis tool and manually reviewed.

Fixes: 10ac7e7757f5 ("usb: musb: omap2430: Add support for idling phy when musb is idle")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
 drivers/usb/musb/omap2430.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 52fcbd209c66..f881455a1a23 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -514,13 +514,21 @@ static int omap2430_runtime_resume(struct device *dev)
 {
 	struct omap2430_glue		*glue = dev_get_drvdata(dev);
 	struct musb			*musb = glue_to_musb(glue);
+	int ret;
 
 	if (!musb)
 		return 0;
 
 	if (!glue->phy_suspended) {
-		phy_init(musb->phy);
-		phy_power_on(musb->phy);
+		ret = phy_init(musb->phy);
+		if (ret)
+			return ret;
+
+		ret = phy_power_on(musb->phy);
+		if (ret) {
+			phy_exit(musb->phy);
+			return ret;
+		}
 	}
 
 	omap2430_low_level_init(musb);
-- 
2.50.1 (Apple Git-155)

