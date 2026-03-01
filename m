Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E92727FC;
	Sun,  1 Mar 2026 01:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330372; cv=none; b=AKNec/7nPeUNNP0M37qyREsDpPlzuFugG/hwGQ/Zql/x1w9jAFv3HtKSvr0zQwvRHJD8uUVe12pI3VKVkpQDFRhn1HxT6mLYFZRMYuY2Irkgup0cf7ILctekNqtKsq50d0+sbzBLrdE6gTI0BpWWgKaNBgp+ZS7RX0r4JkFt2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330372; c=relaxed/simple;
	bh=qMgwLUVJTrFifh71Terdlu6lXHy24h1A9/M0ViDBF/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qoWH9Hhs0JnWHNrsPnfsDe+nuLLTh5wl3KLuDltbTqzBvjJzcgS5/dHHQLWQGJVq4k93XIpU8J7NMlL1h9+vD4L/Ut9VeVLfYl9SNCtqHC3SYW48c5KujvrTfrrJLfWWW/gS03cucms0u+QIVhwELKVS2+xMJkCV6/5GJpYaYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0hjCf2s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0hjCf2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C20C19421;
	Sun,  1 Mar 2026 01:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330372;
	bh=qMgwLUVJTrFifh71Terdlu6lXHy24h1A9/M0ViDBF/g=;
	h=From:To:Cc:Subject:Date:From;
	b=d0hjCf2sRkiYrUaiMFIIBaI+dKttJigIjYbt6vOKm8phHeQ2NdlIty0rbVuDZFhwu
	 Jncbuhq/r98nU9cwhhnOuVtL9Yk5IuZHkicZYP6wpxoWi0M0HmUC/bW2O6VTxQltbL
	 KD0qPVBzmMisCazxyCBUHpgZecK+QulftjoVv333yUeQUI3mKbjkhxhP9Vb69FSCBt
	 PCGovJiV/+yi/THSXillFdUt9Grs5GY+pvMIgOEVImTvAbADd3PSi5+uDpzRICrK1M
	 6msx0yjqw1wzjhlY2DNsan7B5AI7cRhv7oW0Yk8d7Nx0xI5KBVV+l6uC1YLMJH40FY
	 6WRefuxz7B6PA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	vulab@iscas.ac.cn
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "ARM: omap2: Fix reference count leaks in omap_control_init()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 20:59:30 -0500
Message-ID: <20260301015930.1725317-1-sashal@kernel.org>
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

From 93a04ab480c8bbcb7d9004be139c538c8a0c1bc8 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 17 Dec 2025 14:21:22 +0000
Subject: [PATCH] ARM: omap2: Fix reference count leaks in omap_control_init()

The of_get_child_by_name() function increments the reference count
of child nodes, causing multiple reference leaks in omap_control_init():

1. scm_conf node never released in normal/error paths
2. clocks node leak when checking existence
3. Missing scm_conf release before np in error paths

Fix these leaks by adding proper of_node_put() calls and separate error
handling.

Fixes: e5b635742e98 ("ARM: OMAP2+: control: add syscon support for register accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://patch.msgid.link/20251217142122.1861292-1-vulab@iscas.ac.cn
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-omap2/control.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 79860b23030de..eb6fc7c61b6e0 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -732,7 +732,7 @@ int __init omap2_control_base_init(void)
  */
 int __init omap_control_init(void)
 {
-	struct device_node *np, *scm_conf;
+	struct device_node *np, *scm_conf, *clocks_node;
 	const struct of_device_id *match;
 	const struct omap_prcm_init_data *data;
 	int ret;
@@ -753,16 +753,19 @@ int __init omap_control_init(void)
 
 			if (IS_ERR(syscon)) {
 				ret = PTR_ERR(syscon);
-				goto of_node_put;
+				goto err_put_scm_conf;
 			}
 
-			if (of_get_child_by_name(scm_conf, "clocks")) {
+			clocks_node = of_get_child_by_name(scm_conf, "clocks");
+			if (clocks_node) {
+				of_node_put(clocks_node);
 				ret = omap2_clk_provider_init(scm_conf,
 							      data->index,
 							      syscon, NULL);
 				if (ret)
-					goto of_node_put;
+					goto err_put_scm_conf;
 			}
+			of_node_put(scm_conf);
 		} else {
 			/* No scm_conf found, direct access */
 			ret = omap2_clk_provider_init(np, data->index, NULL,
@@ -780,6 +783,9 @@ int __init omap_control_init(void)
 
 	return 0;
 
+err_put_scm_conf:
+	if (scm_conf)
+		of_node_put(scm_conf);
 of_node_put:
 	of_node_put(np);
 	return ret;
-- 
2.51.0




