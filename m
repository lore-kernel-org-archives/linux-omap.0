Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D84582E0;
	Thu,  3 Sep 2026 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437215; cv=none; b=mxsCs9MJmeTkoy0ZmijdWJx6BlxS/CNRdNdktQG5iDzvLEy71DTZ+UEYKbX52br+3vjWzhipHI3/86sSex8ENKqhCHgpGC1duyBmr2j6ETyX+Rjb+kLONaVQAhiUv1CjUKOuTqPTsBTUHGV+E+oaj8XY3Y6jAvM6YD1EwkHbPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437215; c=relaxed/simple;
	bh=ZHJGllSPb+7CGXYNvGmaEtI8msRdqf2h21hUq/XnrSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hgP6rEA7R3ZoDbAh+UGx/36fuVPdzfSz0Dg4TvGr/2mp12hq2xIe4n0YUVx78ssuLPtGq7/N0YR0Lf/IPSCej8xZANrxVI1IX0Ynb/UcbZZh3hwJ5DBSfwwq3w9uhFcsMUEj2lZiDboTN5HOOtQY4aoNFMSvAzKjkP0X1WSYo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B809E1F00A3A;
	Thu,  3 Sep 2026 12:06:51 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] net: ethernet: ti: davinci_mdio: Drop commas after match table sentinels
Date: Thu,  3 Sep 2026 14:06:47 +0200
Message-ID: <e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It does not make sense to have a comma after a sentinel, as any new
elements must be added before the sentinel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 48f85a3649b26548..5bec72f2f51dc548 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -510,7 +510,7 @@ static const struct soc_device_attribute k3_mdio_socinfo[] = {
 	{ .family = "J7200", .data = &am65_mdio_soc_data },
 	{ .family = "J721E", .data = &am65_mdio_soc_data },
 	{ .family = "J721S2", .data = &am65_mdio_soc_data },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 #if IS_ENABLED(CONFIG_OF)
@@ -521,7 +521,7 @@ static const struct davinci_mdio_of_param of_cpsw_mdio_data = {
 static const struct of_device_id davinci_mdio_of_mtable[] = {
 	{ .compatible = "ti,davinci_mdio", },
 	{ .compatible = "ti,cpsw-mdio", .data = &of_cpsw_mdio_data},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, davinci_mdio_of_mtable);
 #endif
-- 
2.43.0

