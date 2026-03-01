Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90C1EDA0F;
	Sun,  1 Mar 2026 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328768; cv=none; b=iU6Ra0H3a/8qh5sUmlak7epyStX2riGAo0J4YSjd1v+9CcrQC14tZlDp+R0wiCAKy3NX+GsKmT3sRBwpqBZkVM8wwOWcblnPZMLzT5+37SUa0v+JPXA91J7MWSLn226WuOT+XmPiycWy9aAqOe+9ceBWCvQgcc/2/XUe34xLr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328768; c=relaxed/simple;
	bh=pQ42qVVfpEdDx78lBiJv4+SbIBADwbKS7t2sX1XubYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V78iB8YusRJUVUKqzcGUibP8f5860zSwYaN5ISKksn5XwmbWB91mF4Fc5AlUaNo/L3oPbgZqeIAIQTFzdjPzXSaGdq4HAJrnV5PTkdNHzgRt0OwF1yoo/TPKpEIRKgvDUxoYDFio8Si0Fm8Sde+JKC0bJuajb7zFhCkRsYU4PU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSFmv45m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSFmv45m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682CBC19424;
	Sun,  1 Mar 2026 01:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328767;
	bh=pQ42qVVfpEdDx78lBiJv4+SbIBADwbKS7t2sX1XubYQ=;
	h=From:To:Cc:Subject:Date:From;
	b=YSFmv45mNq6/wCVe2ELP9WjmogJpefq5DEnCkC2w1Gv7Xv/qg9aoioSfGXu48XVZ4
	 m/TVwCCUBB73/D5xAkh7iifF3naVj3WYDFvXHzfd2fC268u5jScp8KRJ8hwUyWHYDe
	 jhEiEtrpB9M4QuNnOBUZOBTAbkLXxPKSb3zGW/LNVK0DLiNknnrEwJfjgzw3GDi1gu
	 gfWOxtzuy9u7BBF6UJd8X1kZ9TEFS3pOcHgRglMi0u8wOXU6RB5IbLRKIXO4VGJw+R
	 N217Uj4J8ObqFnKwiT0DVxfsQTsLHNMFa7GmXu0tDM84JMQ4cjv6GunzZGyFHn7MG3
	 9khhYdpwGKSSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org
Subject: FAILED: Patch "bus: omap-ocp2scp: fix OF populate on driver rebind" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:32:45 -0500
Message-ID: <20260301013246.1691844-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5eb63e9bb65d88abde647ced50fe6ad40c11de1a Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 19 Dec 2025 12:01:19 +0100
Subject: [PATCH] bus: omap-ocp2scp: fix OF populate on driver rebind

Since commit c6e126de43e7 ("of: Keep track of populated platform
devices") child devices will not be created by of_platform_populate()
if the devices had previously been deregistered individually so that the
OF_POPULATED flag is still set in the corresponding OF nodes.

Switch to using of_platform_depopulate() instead of open coding so that
the child devices are created if the driver is rebound.

Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
Cc: stable@vger.kernel.org      # 3.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251219110119.23507-1-johan@kernel.org
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/bus/omap-ocp2scp.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
index e4dfda7b3b102..eee5ad191ea9c 100644
--- a/drivers/bus/omap-ocp2scp.c
+++ b/drivers/bus/omap-ocp2scp.c
@@ -17,15 +17,6 @@
 #define OCP2SCP_TIMING 0x18
 #define SYNC2_MASK 0xf
 
-static int ocp2scp_remove_devices(struct device *dev, void *c)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-
-	return 0;
-}
-
 static int omap_ocp2scp_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -79,7 +70,7 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 err0:
-	device_for_each_child(&pdev->dev, NULL, ocp2scp_remove_devices);
+	of_platform_depopulate(&pdev->dev);
 
 	return ret;
 }
@@ -87,7 +78,7 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 static void omap_ocp2scp_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
-	device_for_each_child(&pdev->dev, NULL, ocp2scp_remove_devices);
+	of_platform_depopulate(&pdev->dev);
 }
 
 #ifdef CONFIG_OF
-- 
2.51.0




