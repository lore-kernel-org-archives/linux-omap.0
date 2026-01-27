Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD9265CC2;
	Tue, 27 Jan 2026 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769545062; cv=none; b=nnTie1fwJF2D9eRttsBh7qIx7K49oNq8rX+QIrFhNfe+T73OzrC4vA9lwgUx2tbQpKwTYJcBRgVbq6nudF08x+Oj7u6V4KdgPrH0uKNFTKPXZ3ZHCSRo86OwP//K/2OfEfoHG/EEfWRVlqWHguMkInLPb1pMLCnSQmy2J42h4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769545062; c=relaxed/simple;
	bh=vEytL+Y/qdFKKK5dqeD19/KGlCQJaSuediroltnMIy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYjANVcrNjzFPMAPhgGcMBeAEQ7fTvFnmbsfMS6kkMVz80MxGAzEO3e/WZ8ZRuPiuNtIgChLD2edR7vYoYScydOlKgsMtdTm11iCrp18V+T2Mt665Zu25V4tHuOpdlJj1tqHzMEu6Xu62YpVKLhDg7Av6stSL5TS0wc2Dq6NAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJbT0kFs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJbT0kFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C049C19422;
	Tue, 27 Jan 2026 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769545061;
	bh=vEytL+Y/qdFKKK5dqeD19/KGlCQJaSuediroltnMIy4=;
	h=From:To:Cc:Subject:Date:From;
	b=DJbT0kFseDWENQVa2oFe2KoZHXOF0A5i7l0Kx0eW04bRfhNtbiIfylQi6kSL/NA3n
	 xJJK5v9o/gnUIZWHedySFWid/3kofUgeEcKhmmyu641DolK4ttmWr3zMvr4XO2+yQY
	 DmRWky3fxedBZrRlpirdRApU0d37DtU+lYLxYOoEj/m6XneMoXV3dhJc5tsnoshpPG
	 mVgkkOhm3rM7pvcbvIKbdwHSpNDpNSJe43oisQlTn9p2RWKPAWypbDlK81qVSqZZSJ
	 mheGuuden/pPF60xN1aZssOw7LKE1WN7Ss6bbV1lAo+piWbHimMlrSPzmE3DepMd+4
	 IGoOd6jwe0JrQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	broonie@kernel.org,
	will@kernel.org,
	grygorii.strashko@ti.com,
	ssantosh@kernel.org,
	khilman@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2] gpio: omap: do not register driver in probe()
Date: Tue, 27 Jan 2026 21:17:12 +0100
Message-ID: <20260127201725.35883-1-dakr@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 11a78b794496 ("ARM: OMAP: MPUIO wake updates") registers the
omap_mpuio_driver from omap_mpuio_init(), which is called from
omap_gpio_probe().

However, it neither makes sense to register drivers from probe()
callbacks of other drivers, nor does the driver core allow registering
drivers with a device lock already being held.

The latter was revealed by commit dc23806a7c47 ("driver core: enforce
device_lock for driver_match_device()") leading to a potential deadlock
condition described in [1].

Additionally, the omap_mpuio_driver is never unregistered from the
driver core, even if the module is unloaded.

Hence, register the omap_mpuio_driver from the module initcall and
unregister it in module_exit().

Link: https://lore.kernel.org/lkml/DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org/ [1]
Fixes: dc23806a7c47 ("driver core: enforce device_lock for driver_match_device()")
Fixes: 11a78b794496 ("ARM: OMAP: MPUIO wake updates")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpio/gpio-omap.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e136e81794df..e39723b5901b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -799,10 +799,13 @@ static struct platform_device omap_mpuio_device = {
 
 static inline void omap_mpuio_init(struct gpio_bank *bank)
 {
-	platform_set_drvdata(&omap_mpuio_device, bank);
+	static bool registered;
 
-	if (platform_driver_register(&omap_mpuio_driver) == 0)
-		(void) platform_device_register(&omap_mpuio_device);
+	platform_set_drvdata(&omap_mpuio_device, bank);
+	if (!registered) {
+		(void)platform_device_register(&omap_mpuio_device);
+		registered = true;
+	}
 }
 
 /*---------------------------------------------------------------------*/
@@ -1575,13 +1578,24 @@ static struct platform_driver omap_gpio_driver = {
  */
 static int __init omap_gpio_drv_reg(void)
 {
-	return platform_driver_register(&omap_gpio_driver);
+	int ret;
+
+	ret = platform_driver_register(&omap_mpuio_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&omap_gpio_driver);
+	if (ret)
+		platform_driver_unregister(&omap_mpuio_driver);
+
+	return ret;
 }
 postcore_initcall(omap_gpio_drv_reg);
 
 static void __exit omap_gpio_exit(void)
 {
 	platform_driver_unregister(&omap_gpio_driver);
+	platform_driver_unregister(&omap_mpuio_driver);
 }
 module_exit(omap_gpio_exit);
 

base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
-- 
2.52.0

