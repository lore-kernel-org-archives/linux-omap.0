Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB861CD2C;
	Sun,  1 Mar 2026 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329014; cv=none; b=g1/rd9ZPzNlDs8sahl8m9YWGGeGzD/GSbsLYjcN8JRZU7+4UlnYEKWzqFGukMuFx2bc7QQmTJwrUV41DUaqQAXigSi+knoKjYtzJLtp1o+FZf+ouV9v387l1YBWjwZ1xdAf6hIPiZKXJ8XPRK6/r81/wcFDt40XkhVvuT3iYdxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329014; c=relaxed/simple;
	bh=51Q3/qQ4aMZBIGmtmdKfJoBNAVKij27ZlN6PiXoe6mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUQJXMNsTElSf/QX2aNWpQeDLtPHiKYJqa8SN0q9zwlLv8CpRnSy/iIbZPg4ZBoqUds43U6uYwdspQZu4aV6pu9+Y6JWMoFMjiI8zdWSqRE9ZXBwWIaTqM6BcRrGz+PY9HClMWQoCpO4ePdRQiQlA9W60jOg2+rSYarvNMFqdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJHKAoOv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJHKAoOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763DDC19425;
	Sun,  1 Mar 2026 01:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329014;
	bh=51Q3/qQ4aMZBIGmtmdKfJoBNAVKij27ZlN6PiXoe6mE=;
	h=From:To:Cc:Subject:Date:From;
	b=TJHKAoOv4VReav8AXLkM0CIt98LAK/eNhe9vV+0C1yH4y7GAMsVUVEyg/Z53VJTyR
	 p3MDcUJXeznm4MEy+wh/1MxY/ptwOkufH9fGmpFPqODH3AEULalUfzn/xy3GOqbZXY
	 qDlJ/2giEQDosQrJclO9B1C2S9LH3RVQplAOsIt2Hyy13LK2eOh0GTnfl/JwpEwwrO
	 3XEy2BWkpsgJLQZRmgkVjm3SLfmaJE4d4Ls+gitS1cw/qV0uWo5EcmvcyBR5+1TE6F
	 kxU3h8wrldioORLInZV4wvZcGEInVuNPYfamiIGEMzjTJyRKC4mlE06o7JAdkJG4SU
	 QeIqTiyMRN3YQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	haokexin@gmail.com
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: cpsw_new: Fix potential unregister of netdev that has not been registered yet" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:36:52 -0500
Message-ID: <20260301013652.1696967-1-sashal@kernel.org>
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

From 9d724b34fbe13b71865ad0906a4be97571f19cf5 Mon Sep 17 00:00:00 2001
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 5 Feb 2026 10:47:03 +0800
Subject: [PATCH] net: cpsw_new: Fix potential unregister of netdev that has
 not been registered yet

If an error occurs during register_netdev() for the first MAC in
cpsw_register_ports(), even though cpsw->slaves[0].ndev is set to NULL,
cpsw->slaves[1].ndev would remain unchanged. This could later cause
cpsw_unregister_ports() to attempt unregistering the second MAC.
To address this, add a check for ndev->reg_state before calling
unregister_netdev(). With this change, setting cpsw->slaves[i].ndev
to NULL becomes unnecessary and can be removed accordingly.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://patch.msgid.link/20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_new.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index b9fc31eb06134..7f42f58a4b031 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1472,7 +1472,7 @@ static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
 		ndev = cpsw->slaves[i].ndev;
-		if (!ndev)
+		if (!ndev || ndev->reg_state != NETREG_REGISTERED)
 			continue;
 
 		priv = netdev_priv(ndev);
@@ -1494,7 +1494,6 @@ static int cpsw_register_ports(struct cpsw_common *cpsw)
 		if (ret) {
 			dev_err(cpsw->dev,
 				"cpsw: err registering net device%d\n", i);
-			cpsw->slaves[i].ndev = NULL;
 			break;
 		}
 	}
-- 
2.51.0




