Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405633B3BFE;
	Sun,  6 Sep 2026 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666138; cv=none; b=lpyHQZuRM/2XnTSl5mU6oetHXwHZdIJ77u5mu1pP1H2+tYCISxRDvwbOMpOPvevgosw315vpQD9+trnHWDzcyEuRNObSafrR9CiU9zROHjGSQvDaLOMz1HqC0yJbred5FtXJT+SEobYk5fuyHDSPWD/S4BswJ9fgOLaMGClFC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666138; c=relaxed/simple;
	bh=TtoBE0ekzWUg5ZylC/t6kXmkAwF97ZLdrVDiyf/13gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUvHeD7NhaHeUvDcQinADFOxfnh0zkFYATIDxw4hyHq+R77CW4oHFUQ79g0+z5ymxHgaJhaTkIaSriCwkWfOCLwBH9y2JyVtat80gCd5iaz9w4eh7a5TpAvTd1uKRZLTsBSExwBn708fZSd58f36QymK307hT0zsnl+lvk5UmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pJOND109; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pJOND109"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=c3
	MxJdl/zTR+Iru957tpQKvUtpAPvpkJDJnwEdACIgs=; b=pJOND109AMdg2kuaS8
	v4qBbOEMfkgyVPSLQeO0ytyfshtQnrppQtDQhRYTJ9o1AwisGqyjJcS9HMApBzd7
	geIaWXTaax6s71k1ahN2is5CszVijswe5vpruXCOqJwvQLNQlvxFtiztmWgBJZ0g
	DjTRVvTEXI61DCWWZDS/xV61M=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXhfz_4JxqO+zERA--.30741S5;
	Sun, 06 Sep 2026 11:41:54 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pengpeng Hou <hppiscas@163.com>,
	Tony Lindgren <tony@atomide.com>,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usb: musb: omap2430: Propagate PHY errors from system resume
Date: Sun,  6 Sep 2026 11:41:49 +0800
Message-ID: <20260906034149.85550-4-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXhfz_4JxqO+zERA--.30741S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF43Cr4kCF1DAr18ZrWUurg_yoW8JF4kpw
	srGayFyrZ7J3s7K3ZIy3W5XFyrG39akFW3C34Ikws3urnxW3y2kryUtFWUKFn5KFyUtFW2
	kF48JayUXr4SkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTbyZUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7gI6A2qc4QKrRQAA3u

omap2430_resume() ignores phy_init() and phy_power_on() failures and
clears phy_suspended even when the PHY is not usable.

Return initialization errors and call phy_exit() when power-on fails
after a successful initialization. Clear phy_suspended only after both
operations succeed.

The issue was found by our static-analysis tool and manually reviewed.

Fixes: 68d9f95d6fd5 ("usb: musb: Fix suspend and resume issues for PHYs on I2C and SPI")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
 drivers/usb/musb/omap2430.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index f881455a1a23..d95ffe7a2bfb 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -585,9 +585,17 @@ static int omap2430_resume(struct device *dev)
 {
 	struct omap2430_glue *glue = dev_get_drvdata(dev);
 	struct musb *musb = glue_to_musb(glue);
+	int ret;
+
+	ret = phy_init(musb->phy);
+	if (ret)
+		return ret;
 
-	phy_init(musb->phy);
-	phy_power_on(musb->phy);
+	ret = phy_power_on(musb->phy);
+	if (ret) {
+		phy_exit(musb->phy);
+		return ret;
+	}
 	glue->phy_suspended = 0;
 
 	return 0;
-- 
2.50.1 (Apple Git-155)

