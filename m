Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F82190664;
	Sun,  1 Mar 2026 02:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330502; cv=none; b=c+SW9aPQnFbjLw4umxaYXpi4hgtmUIR/oUvva/VIwEwTtVukQ/9ZYp/aEYqxuUDp3DXBLAatTZSVdISP3zay1gm5TssZKnY9T4bHS4WSr7MA/U8nez0PDExpoqvcXfR2GZquwtySUWn8Q8Y0D6/YBwaHwsB0L1fOT3f+Tb8y5t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330502; c=relaxed/simple;
	bh=2m5onBhn9eqSmDwMa32YrYK0vBGQc7R6OUCZK7fSNiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGBPRAR8IHubqDttkkFX5BsZFW93a6YLkZXNNsZbks7MYkwIYx2BoNzwU/Z/etsaRfG9FHI0IYKICeH3fl28q0KUCoxDFx9K9LuLsnqURV89fgVmEzJzpQnETOGhEDLLMyAdMfkcOK08RTPa+VUXMl1HKxRXB8K5PUrE3yRGYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKxYWgQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKxYWgQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09C3C19421;
	Sun,  1 Mar 2026 02:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330502;
	bh=2m5onBhn9eqSmDwMa32YrYK0vBGQc7R6OUCZK7fSNiQ=;
	h=From:To:Cc:Subject:Date:From;
	b=JKxYWgQ10SOzplKdboGWdrogLa73saRL6prAbzI5pUd9gdG9SkL26iepI4dnJR6mr
	 qDz/f0oQeIUmds3kZgjKZiqu5DSFSYHsH7gSlmuY9AKoiJnzaITvKUvqDdktwkioTd
	 1KBojJiOv8k9ZBRw65V8er3u815Mf0b4JdN5Km8z3b1S89DcV7PQqxE8IqpS/PgSP+
	 8/L9a1VlqsIGW8YRfZqcUqZYD3ZlLoZQDRP11cPZsmS5vlvXzoiixi43nlbHXGAMYs
	 ee7QfJeCxsEeru5+rjEsgA8Qwdwo91SQ0K5YgjlYCMQ58KxNvNyYMPrWrqm9aQi2XK
	 fO+JFhOuGPlmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	linux-omap@vger.kernel.org
Subject: FAILED: Patch "mfd: omap-usb-host: Fix OF populate on driver rebind" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:01:40 -0500
Message-ID: <20260301020140.1729046-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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




