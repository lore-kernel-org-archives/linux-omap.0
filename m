Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE43B1009;
	Tue, 28 Jul 2026 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241867; cv=none; b=ZsG30yoVynAGXsCmWQc0AaVi2BKSqPQ9OLcuKT+3aoZdTcGSlm7yn9DYCtCGZ13Z/WcI+lTHzznzN/dyP7VyremrsF9RYm7DO2kYcKfcnwloMI74m9I1FhDyuqnMIp9xf+YEu97TesePT0Od6KS5V2dwV5ZCdckjoTMNFKjEwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241867; c=relaxed/simple;
	bh=qI6orTsZn2A50RpCSuXKxWR27K8yosf+eTyGWp6lBFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AJvtZ8i37kk013/NwY/V+RwaGcfd9sG+0ujD1QFBr+iZq/dQ9/sP29nR28UgKEP9RaGK1U3NvuyX9G+qGfLY9ZQ58+zD6f0EWS1xYkcY93oiHXoTKEpkOXNgZP0DBpmMuv6hgdDKLX207lrihIButvy3cTs8lIAWTkadKvwz/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru; spf=pass smtp.mailfrom=itb.spb.ru; dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b=F0vPaI/0; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itb.spb.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b="F0vPaI/0"
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:6c24:0:640:92d0:0])
	by forward102d.mail.yandex.net (postfix) with ESMTPS id 1993EC00FB;
	Tue, 28 Jul 2026 15:30:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (smtp) with ESMTPSA id VUcj0s3eJ0U0-ignxdVt8;
	Tue, 28 Jul 2026 15:30:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itb.spb.ru; s=mail;
	t=1785241850; bh=nWOtPZfN+5Fs/r0az+5giEmQkErxnjsx2WV8egVJ/ks=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=F0vPaI/0NfIAuDsdzmVaxEHQtRRvPotA/8SQXG1p8U3JpQZJ+minipU7wBCANCiie
	 n1yCS9ohJ1lOAUO/u/bsKfbsKTB/ndicqVz5I+evL6ZzRCvRvJ895Ui24aszdUe7PE
	 Qz9pVCrpUnKub1Q0FjOrhNI0ILvgcCJJRUWhj7VU=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net; dkim=pass header.i=@itb.spb.ru
From: Aleksandrova Alyona <aga@itb.spb.ru>
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v3] regulator: palmas: Check return value of palmas_smps_write()
Date: Tue, 28 Jul 2026 15:30:31 +0300
Message-Id: <20260728123031.8759-1-aga@itb.spb.ru>
X-Mailer: git-send-email 2.26.2
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
v3:
- Remove the unnecessary new_mode variable.

v2:
- Update current_reg_mode and enable_val only after a successful register
  write to keep the cached state consistent with the hardware state.

 drivers/regulator/palmas-regulator.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 337dd614695e..d0e604780750 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -468,9 +468,14 @@ static int palmas_set_mode_smps(struct regulator_dev *dev, unsigned int mode)
 		return -EINVAL;
 	}
 
-	pmic->current_reg_mode[id] = reg & PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
-	if (rail_enable)
-		palmas_smps_write(pmic->palmas, rinfo->ctrl_addr, reg);
+	if (rail_enable) {
+		ret = palmas_smps_write(pmic->palmas, rinfo->ctrl_addr, reg);
+		if (ret)
+			return ret;
+	}
+
+	pmic->current_reg_mode[id] =
+		reg & PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
 
 	/* Switch the enable value to ensure this is used for enable */
 	pmic->desc[id].enable_val = pmic->current_reg_mode[id];
-- 
2.26.2

