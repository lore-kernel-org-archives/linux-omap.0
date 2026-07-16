Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97F421A07
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784229938; cv=none; b=t9xagFUAKWtntqESjuCCjqYasynePL+1u3j1CGA0VeMUWARbnZFD69oJFQ8Be5iLczHtz/At+t9tnM5Bo5ilmoARlCUVCZorKIHOaxcrPQpaAFyaaFs9Tbk2Ab/YWwUh0jYbF6O/nIiOs0zl2+kE+7Cge2e57M7JTqMoJrFTQ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784229938; c=relaxed/simple;
	bh=UfIEc8aikJ1M4bIzqCGo5pTJFc1acZzEWA/aeiDqyxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fBkmhI08MyToHVlBr3glcJVzadu01poYW2FL5wD1O7+0ht+NYG9F9OefcDBChGJ47fhOVUmyN5oGstyJeCS8r2DGsBYBtIKs5/VbSH9pPaZwYftQExeQbCG6Gf1Rc6/NpMZl3wx/k+k8Xv6Td3Vbsj37nkqF+CVPmMTr9xCDgvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Yz+vLs3i; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Yz+vLs3i"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493f431e317so26481485e9.0
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784229931; x=1784834731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EnDpN9/EzuQRL2oL3rRietJSPrPHbp0gZrBiyubbNo=;
        b=Yz+vLs3iT8XAHLTomgoSNUA9fVGL0/aq/SJOa7mcpRi8dDiV92Uzz/cYk8h6Fl9hAk
         nCjUJDLjuDO5OtaTzJI5mG6nqYl0tkB0wmjX7nfRLmIVtno8WC0ueFUoGAayO486ZBVc
         wxf+VSOWO1aLVP4+X8XYrmKjeY+f1Oy06ENngxnYgqcDAmjEoMDbowPh204QH7Ce3GGI
         Mn9OLL33JNgM3DPGLy786y3ocviirkr6C2tSqRb4S0yBfM1OaeANmxeEcuLh+r3d4rxk
         D813hqZo6zCL7HDuzu79QhtyamENEOkh9t2QPx3kzZlIHKW5jNDSpn3TJk8uwlBINSGh
         o93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784229931; x=1784834731;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2EnDpN9/EzuQRL2oL3rRietJSPrPHbp0gZrBiyubbNo=;
        b=lURluXjDXgTne79zI38MYblg36myyo5vaYt3ve6vZCu2LaEh+Qos3b3zm0cwQNJMI7
         r10GsNX8hGiaMPX1rPkIdEUxKR2Y1C+wHVNDtBahVLEHIOoW8jWSNQMLLWvv7j2sTFAM
         OHjpGFOfIE+m8auvXy84S0x1MhBzOCf+nLAAL3Uq7nPZercsBrDbSQA3NJ5+JnZW1ee7
         sTWX0L9H62wzI4t0J3HA3j+K35cYk/qbPD/KLdLBEk0yOhlZYa06XvMbPUItx/x8wW4i
         1BZ25kp6zCj+bj3uvYklKEn4a90VQY3wTmXeyyrZzEfdXOadsWLUWw0sEmbCzGdaHbuE
         dIKA==
X-Forwarded-Encrypted: i=1; AHgh+RrieDCAUNRjd3gDpyr9pg8kDxXG3bOJ/9yBH2zQNE2zpv8XaoYuSPMOeUvIrCxiypJQ6X6m0LkhQ5sq@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRLhr36CnkP9HM6H0hLKM5PSYZ9AlFeqetoDzIyfgI0y76XLj
	nqkcssDdiU2dcHc3wdcHX31eY7YLd9OUZbv6TGcOinJ++q2HxXJ5S1bzNqQidW8QcE8=
X-Gm-Gg: AfdE7cmN8MuoOeeJDXoLEBm5fiu1Ye4T55dkkuOn+vtP6cOVofL/Tn0Qi819WgjmF5P
	MXaQPIQ0tu/h6iqNA+54ww1Cl8nyYY5PQMIiBh+aKNmscN2UmtwM34JAdXF2mvbefgyjwSJM20v
	VCPSif4WAIwxjX+pcY0v24ryJiR5EoQEyY1LRi0xsY6gU7m68MwMAUm2YNFFNrKvhQPuDlp7PGt
	adhX2SLZY/vIKPRlyhtky5TZ0BjlzSKYwtmhQilpi3hifa+NA6sBUd5OE+EuG/Tt55J4GaZgWhN
	blPip5ee8p43gVMOoGeTkLeBNDnLu4gas8ZJXbIAPoPEHxqOEROop7/MjNk8vf2dw7kWzqhVcJp
	k/t5jPFD+4upgg+uU9Ki08gZZdMXVCey8+7SOv+yaZihtc37onX1KNTOaTDcZod+u1I9O9fmr+A
	rrR04j4kswQdcHLuLUOw==
X-Received: by 2002:a05:600c:c492:b0:495:4589:cea6 with SMTP id 5b1f17b1804b1-495483c7c53mr7923575e9.34.1784229931237;
        Thu, 16 Jul 2026 12:25:31 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49541e51f47sm71110295e9.0.2026.07.16.12.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:25:30 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Johan Hovold <johan@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: nand-omap2: Move omap_nand_ids[] to raw nand driver
Date: Thu, 16 Jul 2026 21:25:23 +0200
Message-ID:  <901ca5f67bc57219a9222115fabe1a1729b87e25.1784229863.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4041; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=UfIEc8aikJ1M4bIzqCGo5pTJFc1acZzEWA/aeiDqyxw=; b=owGbwMvMwMXY3/A7olbonx/jabUkhqxIA5WUZNG+6b8ZH05yWZKo9HXXNmcm/bYmhpcBcRy3G K3mHGTrZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiMlc5GHoe3FGob/AsE9QK 21HWerB60qeiM2XfV0UWTxSI/nrxc0Bgv+qZ0uA5fdoZix0Ygw4rGQWdEXPsXau0SNO3i/nCxV8 Pd11deXkLZ1ODM0NGovG2V1FCwudCfJ9u4JfayCeqJPKkINyt5nfJC/Hshj2vPrxhVyqsy39h+f PZzAkz/PQMO+fMD+73We+/dX1Xz8H52zb7JUbxKa1myn0XLdG7/r3YDb1bCaqfNzz07+ATCDyw1 i42+/4VRS9p9aDHaSZVjA8uhxefiGo+tClec+9s3/+Nywws4+TOPg26eOrzYRWmwGtuVc8Y9lma Whi1vPld9rPeNKes+NeVq4lsHEJXvdnVH0y6EzWh1OoGAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Defining a static array in a header results in each .c file that
includes the header (here: drivers/memory/omap-gpmc.c and
drivers/mtd/nand/raw/omap2.c) to contain a copy of that array when
compiled to an object file.

With sizeof(struct of_device_id[3]) ≥ 588 having omap_nand_ids[] twice
just to do two string comparisons is quite some bloat. So move
omap_nand_ids[] to the nand driver which actually needs that array for
its module meta data and do the compatible check by hand.

bloat-o-meter reports for drivers/memory/omap-gpmc.o (ARCH=arm):

	add/remove: 1/2 grow/shrink: 1/0 up/down: 28/-588 (-560)
	Function                                     old     new   delta
	gpmc_probe_generic_child                    2108    2136     +28
	omap_nand_ids                                588       -    -588
	Total: Before=18114, After=17554, chg -3.09%

(drivers/mtd/nand/raw/omap2.o doesn't change).

This allows to drop <linux/mod_devicetable.h> from
include/linux/platform_data/mtd-nand-omap2.h (which is my original
motivation for this change). Note that this header isn't needed in the
two drivers because omap-gpmc.c doesn't use any device id struct and for
the nand driver omap2.c of_device_id is already provided via
<linux/platform_device.h>.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/memory/omap-gpmc.c                   | 9 ++++++++-
 drivers/mtd/nand/raw/omap2.c                 | 6 +++++-
 include/linux/platform_data/mtd-nand-omap2.h | 7 -------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 958d2b0ea54a..48af31a54b55 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2129,6 +2129,13 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 		of_property_read_bool(np, "gpmc,time-para-granularity");
 }
 
+static int gpmc_child_is_nand(struct device_node *child)
+{
+	/* This has to match drivers/mtd/nand/raw/omap2.c's omap_nand_ids[] */
+	return of_device_is_compatible(child, "ti,omap2-nand") ||
+		of_device_is_compatible(child, "ti,am64-nand");
+}
+
 /**
  * gpmc_probe_generic_child - configures the gpmc for a child device
  * @pdev:	pointer to gpmc platform device
@@ -2220,7 +2227,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		goto err;
 	}
 
-	if (of_match_node(omap_nand_ids, child)) {
+	if (gpmc_child_is_nand(child)) {
 		/* NAND specific setup */
 		val = 8;
 		of_property_read_u32(child, "nand-bus-width", &val);
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 39e297486721..552f36da79fc 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -2318,7 +2318,11 @@ static void omap_nand_remove(struct platform_device *pdev)
 	nand_cleanup(nand_chip);
 }
 
-/* omap_nand_ids defined in linux/platform_data/mtd-nand-omap2.h */
+static const struct of_device_id omap_nand_ids[] = {
+        { .compatible = "ti,omap2-nand" },
+        { .compatible = "ti,am64-nand" },
+        { }
+};
 MODULE_DEVICE_TABLE(of, omap_nand_ids);
 
 static struct platform_driver omap_nand_driver = {
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 8c2f1f185353..2ddb624b97fd 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -7,7 +7,6 @@
 #define	_MTD_NAND_OMAP2_H
 
 #include <linux/mtd/partitions.h>
-#include <linux/mod_devicetable.h>
 
 #define	GPMC_BCH_NUM_REMAINDER	8
 
@@ -63,10 +62,4 @@ struct gpmc_nand_regs {
 	void __iomem	*gpmc_bch_result6[GPMC_BCH_NUM_REMAINDER];
 };
 
-static const struct of_device_id omap_nand_ids[] = {
-	{ .compatible = "ti,omap2-nand", },
-	{ .compatible = "ti,am64-nand", },
-	{},
-};
-
 #endif /* _MTD_NAND_OMAP2_H */

base-commit: 1a1757b76427f6201bfe0bf1bea9f7574f332a93
-- 
2.55.0.11.g153666a7d9bb

