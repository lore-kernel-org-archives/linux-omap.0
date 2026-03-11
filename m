Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B578F2E
	for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2026 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236031; cv=none; b=pyTf79OaSO8+32EOFl/wNiWbd4Ylu7IxZOkw74sLrIkyYGOHYBdn5EZkjuABVbKUwtoXTNURLS/Nbfb8fozD3PedQKvhx81+BInxjsvHnxI+MEdxtZapfTj7aQEmEsh87I0Zmt3GNzUQuMsP8gkXKtI2PodK3usQCHQkeJNKzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236031; c=relaxed/simple;
	bh=B4NIglO/lx1teYb8TZ8+TTENSIMUN8QR54hyfxWWeC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rCs8p6LqG0fINhUO12QvTnE9DqqbgbjKsCHyHdVrkGwU9yeQMxAeDZA079xzb74WfwGwDF1nE1vPxgqMI6gF5BleA5hM1/cPImmBBInd6TXIwx5eoklzY45l0i8B+PV89gbGZYvYC61eJZyHduru5576GdYqIgWy+QBkDJgWJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=qGz2mXHf; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="qGz2mXHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1773236013;
	bh=eq+jiJE3L+qD9tVcR7L8+fk9OVfhD1zsRs9oq1I81DQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=qGz2mXHfRozi2WmnP5xwvrPQH+gA+W2HSUIxh+tVAs4repfFiB5HKgtz2VYbieJh9
	 zAwDjUESO0vmQKjcFk+cKKsIszEqusxWFHhWRG/NaS2gXVtZ7+F/ilw3ZmUjZ3LmlC
	 8OZbVKsUMWmabVfTsEJBlAhcYZrgZI+IixaHC8T4=
X-QQ-mid: esmtpsz16t1773236011td26fbfdc
X-QQ-Originating-IP: GXu6FjxMjZqALR1Rygn7Y7SuqKENS4hIwl3oRuLu2sk=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Mar 2026 21:33:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14291803047286140553
EX-QQ-RecipientCnt: 12
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	Kexin Sun <kexinsun@smail.nju.edu.cn>
Subject: [PATCH] bus: ti-sysc: update outdated comment
Date: Wed, 11 Mar 2026 21:33:25 +0800
Message-Id: <20260311133325.631-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NsZBc+7DoEMQy/Dp9W+1pCWjfJQ2mVLQysKF/NICSp/i8+TtrYmPusc4
	/xiy9Ap4aNnQbNmOZOIgZEQ237K5EvdyZLYEp7d6LBfFP2OspH2xzY4nCxEJ8xyhSjMsTdZ
	O6Wv/nKh+ynhF2RrDTTnAzBR9idikOxyTy2TmSsoT/ErKncfyBjKbNPW3OHAppahY8xJ+RK
	z4AXagaQSOIGWXW1p6F62VrKEqterxC1tp0YNm3A2lwNEyl5tsNh6W7O3Cv1JVzxWNCzOiq
	I9cM10gHKSkMwlu+XF3Ggm1I/TQQR5u28B20WvHSgiPDzFEgGx3ZYXRHn7sylrjteaXZQMP
	X8wsjcYbrL7BZ8tELiUr/caOGfHfUYRj8n3cRw79aQTgOvFppi9cwOGYBi1lLToPKZ0cdt4
	ngJGkfzsKroHQA2ZMn/38ahndhWYl2sNrkFpSMcPM5+VTi2kNBjeAHvJXPNmwZ5FxEpafY3
	GsKIHyg7YEfQes6oGVoNAASIZmt/ZdjlaXydv3BzJQ0X/ji+eeFEmXP9dH4NPL3hleAPkt4
	hRFRh4OSbjjIiAORigQSXpFnR+W7DmeFd7epfKHKXTb+J+wt6Uw4gC0uvEr/6u9CXh3xypm
	v6KuAuB+xMLvGXBmqvN5ltMapVMoTYVGnJ0CyQnwN/iXDeQBJ7ck/2D1rFdXzeRv8dMDoHL
	j6sunpuwVLtMZ5MnON2n/ztykjb5YPNy3B8C3Nlq4DB7A5J8zXT7OzzndDcuudl9bUejdnO
	mdsFS9decbfupgpdsGaen2ZwQd0WG48gDA/Z/W6NMr5feY6xemHyZi/59JzluVttcJMDX2s
	rKL2PurWwjNGiV96YOqgZfWYPjroCl6L0qHIB92LobJq4LkCLihZ3CboSNwl7qibrCTis6n
	WVXLfI9ICmmDEymQkgyI60zZkF5qvR0flmzEk3y10EPGHNbNyQNJI1r2hgDpRnUXuKu/8k+
	BmFRM05MfYVcvYiAyrTvfTHGAecvsPTtlpEIcWHDlv4FJssCCMGcha45WXx9FzRECfxxFiI
	1N3R4eUIq179Z+NbuJGBD/aj6Dpj3qv1IfnnUG8Y+uCBxIj4qlZnhHVtTJzbV8G0p/Q+BmN
	9x84Uxoo8wdYvB1cWr4AkHKicQVRdbRZ+X6yiReoRRNtUnXSFIxhTE55TTBi84LXQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

clkdev_alloc() was removed by commit 5617c9125bb6 ("clkdev: remove
unused clkdev_alloc() interfaces"). Update the comment accordingly.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/bus/ti-sysc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index a5b9507de37c..e3a5241d3186 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -350,9 +350,8 @@ static int sysc_add_named_clock_from_child(struct sysc *ddata,
 		return PTR_ERR(clock);
 
 	/*
-	 * Use clkdev_add() instead of clkdev_alloc() to avoid the MAX_DEV_ID
-	 * limit for clk_get(). If cl ever needs to be freed, it should be done
-	 * with clkdev_drop().
+	 * Use clkdev_add() to avoid the MAX_DEV_ID limit for clk_get().
+	 * If cl ever needs to be freed, it should be done with clkdev_drop().
 	 */
 	cl = kzalloc_obj(*cl);
 	if (!cl)
-- 
2.25.1

