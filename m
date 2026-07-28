Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945EC3A3816;
	Tue, 28 Jul 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230354; cv=none; b=WpF5R90rPK3/fsWwY9bG4SPu6nVN/J49hl6+RHGqyPmLQ+kPgeutJ0rd0o0AgyLyRh0I4YGRx9xB6UY97A0sESvdQoY2h2B+0XT/HDrzJgJz1mPZh88Rb44fxuGs4GF+YocKTocqN36M0m134rjI+kT2UWORPuDwwrzNs+4K45c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230354; c=relaxed/simple;
	bh=oY7bP1WzwWq29akeULvd+C5CTa9KKDbtB54/qLY7/Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHYbq2QLlr9m6bUQRqHqSWwTtKI8SuTFFI1yaY5N6Jy1ZqL4P+J7J6onxCvBse6YwNfAmIMJbezRAOothk376embqwo/j1m9NqNuyrB3S3b+djKJHkeMrD8aWXzfSrK65PSElaR5SkPAb3dLwzpLCQCXVHSmPdc1df6aGwiXZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5ffc6c908a6511f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:67c2ed53-1747-4ac7-a925-159cfb5165c7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c40615f72562e4c462aec21a03c7080e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5ffc6c908a6511f1aa26b74ffac11d73-20260728
X-User: pengcan@kylinos.cn
Received: from lenovo [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 290562595; Tue, 28 Jul 2026 17:19:03 +0800
From: Can Peng <pengcan@kylinos.cn>
To: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com
Cc: linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH] bus: ti-sysc: unregister notifier on driver register failure
Date: Tue, 28 Jul 2026 17:18:58 +0800
Message-ID: <20260728091859.150905-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysc_init() registers the platform bus notifier before registering the
platform driver. If platform_driver_register() fails, the function returns
the error directly and leaves the notifier registered.

Mirror the exit path on this failure by unregistering the notifier before
returning the error. Also check and return the notifier registration error
instead of continuing without the notifier installed.

Fixes: 2c355ff6b6ca ("bus: ti-sysc: Add fck clock alias for children with notifier_block")
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/bus/ti-sysc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e118b900c9ac..f960d29566e5 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3333,9 +3333,17 @@ static struct platform_driver sysc_driver = {
 
 static int __init sysc_init(void)
 {
-	bus_register_notifier(&platform_bus_type, &sysc_nb);
+	int error;
+
+	error = bus_register_notifier(&platform_bus_type, &sysc_nb);
+	if (error)
+		return error;
 
-	return platform_driver_register(&sysc_driver);
+	error = platform_driver_register(&sysc_driver);
+	if (error)
+		bus_unregister_notifier(&platform_bus_type, &sysc_nb);
+
+	return error;
 }
 module_init(sysc_init);
 
-- 
2.53.0

