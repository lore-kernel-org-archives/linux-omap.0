Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE53BE62B;
	Mon, 27 Jul 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141743; cv=none; b=B5wb8x6ZVHGTmr0mfaNg3hfi5VO+ADLHJ4RCj8/gT7NknuoVUc4AD6RiowSQ8Jr75AH4JF2jIrex4u0gYImNZsxE3n3NwrTkjQv0nvXahE1VxVbJd70YVnc8Ed9sM0m6cVq8FB1ZszYLQH8RHyyBN/folB5v+ZtIeGR4Bmnq9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141743; c=relaxed/simple;
	bh=YyFVxqwYq7QE6q7SFcNM1eVuqUxFTR7JlttZe2H1sTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a+RvWCfQoKu7FUpZYhq+ATdQEguWJTxKmAJO+zCDFxrIDa/DwOVyBD7Aug5MXKZL+oDzJhwmUHJjEcKo0qBuGIbgWlOfJ4zMHz5YkchsR/i5kwNQtY7y0tGw+TBtVlRUmqsz62NavGqlNW7TdZ3k3ibyET+4/V3xO+0pbyA2v0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru; spf=pass smtp.mailfrom=itb.spb.ru; dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b=uI+tl3a4; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itb.spb.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b="uI+tl3a4"
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:83a9:0:640:50fd:0])
	by forward500d.mail.yandex.net (postfix) with ESMTPS id 4ECF181B99;
	Mon, 27 Jul 2026 11:42:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp) with ESMTPSA id ofXs9wvf4a60-GQQA53pB;
	Mon, 27 Jul 2026 11:42:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itb.spb.ru; s=mail;
	t=1785141727; bh=JgPtEM3Ca2hp3l2cxElidSe/A7Y1oad8lQfJw8hASiY=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=uI+tl3a4k8hyY+3hL4FwfjUbau9tvdici/Zp5fFAzE2HxnVZvcmRKS6mJ0gpYKjwU
	 5uZFVnX3d4qK3dbXuNmq5SGEmwOFZPWQj/CxzrzqZvHBXuabjoTHnoiigkcCUQl3Tz
	 cfGdmdZXhXlrgU/7tjKxbIb+7OLq32zIM1iMj9YY=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net; dkim=pass header.i=@itb.spb.ru
From: Aleksandrova Alyona <aga@itb.spb.ru>
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] regulator: palmas: Check return value of palmas_smps_write()
Date: Mon, 27 Jul 2026 11:41:50 +0300
Message-Id: <20260727084150.30268-1-aga@itb.spb.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260618110338.53004-1-aga@itb.spb.ru>
References: <20260618110338.53004-1-aga@itb.spb.ru>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

palmas_set_mode_smps() updates the SMPS mode register when the rail is
enabled, but it ignores a possible error from palmas_smps_write().

If the register write fails, the function still reports success to the
caller even though the hardware mode has not been updated.

Return the error if palmas_smps_write() fails. Update current_reg_mode
and enable_val only after a successful register write so that the cached
driver state remains consistent with the hardware state.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 51d3a0c999e1 ("regulator: palmas: preserve modes of rails during enable/disable")
Signed-off-by: Aleksandrova Alyona <aga@itb.spb.ru>
---
v2:
- Update current_reg_mode and enable_val only after a successful register
  write to keep the cached state consistent with the hardware state.

 drivers/regulator/palmas-regulator.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 337dd614695e..8095ebabd671 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -443,6 +443,7 @@ static int palmas_set_mode_smps(struct regulator_dev *dev, unsigned int mode)
 	struct palmas_pmic_driver_data *ddata = pmic->palmas->pmic_ddata;
 	struct palmas_regs_info *rinfo = &ddata->palmas_regs_info[id];
 	unsigned int reg;
+	unsigned int new_mode;
 	bool rail_enable = true;
 
 	ret = palmas_smps_read(pmic->palmas, rinfo->ctrl_addr, &reg);
@@ -468,12 +469,18 @@ static int palmas_set_mode_smps(struct regulator_dev *dev, unsigned int mode)
 		return -EINVAL;
 	}
 
-	pmic->current_reg_mode[id] = reg & PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
-	if (rail_enable)
-		palmas_smps_write(pmic->palmas, rinfo->ctrl_addr, reg);
+	new_mode = reg & PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
+
+	if (rail_enable) {
+		ret = palmas_smps_write(pmic->palmas, rinfo->ctrl_addr, reg);
+		if (ret)
+			return ret;
+	}
+
+	pmic->current_reg_mode[id] = new_mode;
 
 	/* Switch the enable value to ensure this is used for enable */
-	pmic->desc[id].enable_val = pmic->current_reg_mode[id];
+	pmic->desc[id].enable_val = new_mode;
 
 	return 0;
 }
-- 
2.26.2

