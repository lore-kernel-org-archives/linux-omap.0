Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A42F39BE;
	Sun,  1 Mar 2026 01:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329902; cv=none; b=hPDTgQdLa8edcjUpXWrmYR/p2ahA84Jg5npzmr8dg+Ta2fgPcNLsu3qK1EjYKoHnhDJV/Gp4l2HR+5dYXNjVkzWYOjbDb1D9z42zV6cegNIA6z1QoAi0P65fPDETgOVaaEobFW9qZYUESSXy52Rlwo1lQB+7cU//qikvmo5RPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329902; c=relaxed/simple;
	bh=upClWo20FVZIpfqaFNHOc2zt3Q1qTQQDxyXdD8UIW1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n7xIa1o5CeNir3lX9i+8wS76qaA+Xktq6zZWRp94tyg1IvNaFR5euovrSRwwi+Pk//XcIZIZgrvzpj0NKrEnsmXVWTuVseelTseapDzkt3kiKXXF+4uKrc9mAZcASoLEOLmgBbbDvEUV3L3AIEgchpTH2bPvhU+1sz84lhgkrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKkRugTC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKkRugTC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2EFC19421;
	Sun,  1 Mar 2026 01:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329902;
	bh=upClWo20FVZIpfqaFNHOc2zt3Q1qTQQDxyXdD8UIW1g=;
	h=From:To:Cc:Subject:Date:From;
	b=hKkRugTCyuuuUH3A4Tkuyx9WE4pkTsBmaJCF2shSNnozoTB5jfnSF4/l38OJE0xdI
	 PqaUuCjc3G+gQJSoNnhkA6QKfUqWikT3UeSryvGzkpbp8CjxVTZzFA3rEMXVfW3wDh
	 Jk2XbdydhLwYJ5Z4r5vnHLa2OPwG6ZoPF+rtJFCnCzcIlUsVXt4X9gBnYdkvGlBg83
	 fTR6z0xSgpjuIbOswt9nOcwXjTe1PNNzt5IRE3iw95Y7NWRmAV6tWE6/4YYZOqLyCs
	 j1Muvsa2448uhZDnUTmeKKya5JjatZqgFH/QnAh++d87UAYTrbxgKX4XmtHivA0J47
	 ld+3n/fn/fOgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	linux-omap@vger.kernel.org
Subject: FAILED: Patch "mfd: omap-usb-host: Fix OF populate on driver rebind" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:51:40 -0500
Message-ID: <20260301015141.1718071-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 24804ba508a3e240501c521685a1c4eb9f574f8e Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 19 Dec 2025 12:07:14 +0100
Subject: [PATCH] mfd: omap-usb-host: Fix OF populate on driver rebind

Since commit c6e126de43e7 ("of: Keep track of populated platform
devices") child devices will not be created by of_platform_populate()
if the devices had previously been deregistered individually so that the
OF_POPULATED flag is still set in the corresponding OF nodes.

Switch to using of_platform_depopulate() instead of open coding so that
the child devices are created if the driver is rebound.

Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
Cc: stable@vger.kernel.org	# 3.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://patch.msgid.link/20251219110714.23919-1-johan@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/omap-usb-host.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index a77b6fc790f2e..4d29a6e2ed87a 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -819,8 +819,10 @@ static void usbhs_omap_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
-	/* remove children */
-	device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
+	if (pdev->dev.of_node)
+		of_platform_depopulate(&pdev->dev);
+	else
+		device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
 }
 
 static const struct dev_pm_ops usbhsomap_dev_pm_ops = {
-- 
2.51.0




