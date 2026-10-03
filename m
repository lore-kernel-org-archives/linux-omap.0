Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2805358360
	for <linux-omap@vger.kernel.org>; Sat,  3 Oct 2026 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791036577; cv=none; b=KH+Go37VU4FlSR3JGK4TpyyqMUgeC/T22MXOYnRTV8Yj0IiThe0VJV7rXWgiUEPx5hMf6UMZnbTsJg1Zhadn434WcqeSZQoLo81MZvJW5bUkE76uyWCAFbjsDK16iDHlj3PlnSW69vcsS2Nuw7Ps5y4n5lPgSPLQjC446Y0IyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791036577; c=relaxed/simple;
	bh=YbyQY7JoE6UOw92mTJzHWd+BaqMC9pONrFNAMHRtJ5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bN1QDq6N+mxrCVKysCAjst2L2yQ+Rl5kqCgoWIbnjfh5Oz+rwBvS6auQbvvcxQsa7DUAEJAwubWwz6NxM0jdvKz39NeIzvaWlLEYnOnBEQEarU/1+7uuhhqnU/4A9ioQ43RguIaeIe/ZtLFNX63gCV5LCOGkzqPQV0kKJczvs9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGCRv4w+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGCRv4w+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso5229045e9.2
        for <linux-omap@vger.kernel.org>; Sat, 03 Oct 2026 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791036572; x=1791641372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rG4jTd4nM+pkECs4oXcMHGsR3oQ3Ii3v3Uq1Mfg9zkc=;
        b=NGCRv4w+emBtEM2pyi1sPC6sQnAPbo63O1BbXiMnUFsqnYmydzQkRg33rqQ/W61KIT
         jYSKHiM8EUUR77NIfW1MMz0J1To3mAvJZz91/FZ/jbg5PRtTP8WJsjA+bjIV+FW3nNpP
         1QYn4w/gxSrNpwUeOw/wvaEtFiq/vxym0Tp24m3Qg4kIS4/eWJSiF+I5QdxesvpcJF1K
         FxNmY3shlVJ43q0g1JG7B2HyIJdwfmgFOl6in7xohvW2AHMHORunDoX+gBkN3vFciGLS
         wt0jZ3wcB6xVvKJp8BmQLxjChr2QTzzL9BkeYzCQfyQi2oxOWkKzqsLZqk0EORxvD+EU
         AWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791036572; x=1791641372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rG4jTd4nM+pkECs4oXcMHGsR3oQ3Ii3v3Uq1Mfg9zkc=;
        b=1ovlAwcsGLQRF+5WazUHSsAZYl2KmO26EEkc151FUU/X4heWmYo/gqVs98dRzumxeh
         DbioTNGteTxQ/1+/znv77I8jydRmYsox3g5/spw6rdx4wS/N8gixKTEZTFBv1dA8Fp8z
         h+N5NxJKo8mE/254k8P/rpLDlTICqxmFipEkQKMlUAC0m8f9Q9N7VMsd/eJOBytztMPX
         9Fb2aFI/6/FrPKMkyZLj2EjsFmPX/A0Pewav1akpyz0P62wLkeRt7EtBISnPV2v71kt3
         XZa59daOCbysTUZatX0ErUC13KdrtYkyCfSIoQ88RLsYbseYXowtBFJ+NPdw7a9nngRs
         Nvlg==
X-Forwarded-Encrypted: i=1; AKwUvByNlMOdGC5h+gLCK5xHAeLsy64N+Zxn9hWR1vJpcSWmXMfQsAqNQFLJDDAimZ8kVl9GHGP6Z55CVqze@vger.kernel.org
X-Gm-Message-State: AFuF++mOKuddJUfj1prQIej6yNq8rDpD3+sYG4mc0Sz36ENzQ2uDKQrB
	PFZJo7vttoRsPkzsut25UJMKk0rg8ThFMurNYT1gkmfPIQaAIzXylpug
X-Gm-Gg: AYBFou3zbR97KKFETdGzQq0vii0bxb/Qw03QbBNwVLQYPxm28s+stew6tgF6l/wJHs8
	e1RGjZiu72fCnOxSSp2TmwM1+TSjL9I/5rk/EhqM6Bw78b2qgP8pT/+GwIMs5NWsPhuv/DUFdEr
	OnhSZwseqzxPeZJTaJVdtXfNbmyk41+zRd0sOYCynPOkIUaadpgo4sLw/8b5xLwjyITQ/fF0v5S
	tMlJbPXJ7P42kq8T9+M5w1AWkBckEB/FR0OD32YdEgiOUoJbdWh16EkKU8JOcpcO8NN1qj45nho
	hmXV32InpSqKTV/eE9/EWhQWP7lakECAkZzcu6txzPL+Atrk2Blmdp12jlX9yrLuhBYqyxLwDiY
	4ESnE3YqCfUzJVE6NXKTAcf+5+zl9FgMpuWRFtLqxvriKpKjyTAgRP1ry7xROIyShTYvURKQ2Xl
	LYUr4TbyAVLyUEfQdqf5Ks66sId2B5fDXFk5qoLphGe9N+iDytVCKPdRfyQcM1cgpKdRWG7n2MA
	W/KZJZdnRKFB/MAjj/VIWCXFV91dfeiP1czAeDBMg45niKKSzyNRobovkeXN9KLpeqqXseO5AIq
	aECAtjPhOS0Thz7S8JCA1PGVHCXnOdUEz+3UdEwW6qyMdC2l/JCQhyNBeWfj27ShgljNiM9/O4E
	IrA==
X-Received: by 2002:a05:600c:6208:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-4a0278d021bmr94872445e9.22.1791036572164;
        Sat, 03 Oct 2026 07:09:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bfafasm184098025e9.8.2026.10.03.07.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 07:09:31 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Keerthy <j-keerthy@ti.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alex@sverdlin.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: cpsw: unregister secondary netdev on probe failure
Date: Sat,  3 Oct 2026 16:09:14 +0200
Message-Id: <2f459154f5bca89a07dc978c834e98198c08c331.1791035789.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1791035789.git.kmehltretter@gmail.com>
References: <cover.1791035789.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy CPSW driver registers both netdevs in dual-EMAC mode before
requesting its IRQs. If a later IRQ request fails, the probe error path
unregisters only the primary netdev. Driver-core devres cleanup then calls
free_netdev() for the still-registered secondary netdev, triggering the
reg_state BUG_ON.

Track successful secondary registration and unregister that netdev before
the primary on this error path. The pointer cannot indicate registration:
cpsw_probe_dual_emac() sets cpsw->slaves[1].ndev before it calls
register_netdev().

Reproduced with QEMU fault injection by forcing the TX IRQ request to fail
with -EBUSY in dual-EMAC mode; real hardware was not tested.

Fixes: 070f9c658a59 ("net: ethernet: ti: cpsw: Push the request_irq function to the end of probe")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/ti/cpsw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index aa3531e844e8..4fc59f9f23fc 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1550,6 +1550,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	struct gpio_descs		*mode;
 	const struct soc_device_attribute *soc;
 	struct cpsw_common		*cpsw;
+	bool secondary_registered = false;
 	int ret = 0, ch;
 	int irq;
 
@@ -1717,6 +1718,7 @@ static int cpsw_probe(struct platform_device *pdev)
 			cpsw_err(priv, probe, "error probe slave 2 emac interface\n");
 			goto clean_unregister_netdev_ret;
 		}
+		secondary_registered = true;
 	}
 
 	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
@@ -1764,6 +1766,8 @@ static int cpsw_probe(struct platform_device *pdev)
 	return 0;
 
 clean_unregister_netdev_ret:
+	if (secondary_registered)
+		unregister_netdev(cpsw->slaves[1].ndev);
 	unregister_netdev(ndev);
 clean_cpts:
 	cpts_release(cpsw->cpts);
-- 
2.53.0

