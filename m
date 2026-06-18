Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D43F1AD7;
	Thu, 18 Jun 2026 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781123; cv=none; b=JWiHM93Wc1hneKUDRttGCoy+gN2pBzrMnnwBwT49y0YgqidlI+smgf/eul7T3n3JrOBv6ZVz4yofBUU7evk3Sxg1nFewgU7gGVAE0LEtSPygkC45kT7NDwxgC8/Jw/k9ji9Bqia71Kw+lw8Fpk0DVkwrImd/bXhi2LDsuNiQ/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781123; c=relaxed/simple;
	bh=iDf1HIGoeJ7zt/90LyB2obe00YdPXhR/8+NFdQDsnN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eeWy74ORUnmh5bACWSiB8DH0Ok91rtqui1u+xyIUYULPQdd6lgWbtJ8vVvhL5fdXUz5yhAcROvjfr19FG144J7OeKAfssKLqOYfvOTeB4iF1T8LI0n8pnvmYVBQLiLXyN5fCKgSebWJ/+hUHC87+9xEvsm/QmAQGMai/NHr4wHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru; spf=pass smtp.mailfrom=itb.spb.ru; dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b=MVuUProC; arc=none smtp.client-ip=178.154.239.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itb.spb.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b="MVuUProC"
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward203a.mail.yandex.net (Yandex) with ESMTPS id E6AFE86D01;
	Thu, 18 Jun 2026 14:04:00 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net [IPv6:2a02:6b8:c17:2010:0:640:2180:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 0C049C0228;
	Thu, 18 Jun 2026 14:03:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp) with ESMTPSA id c3Qvvj9gASw0-O58CIumu;
	Thu, 18 Jun 2026 14:03:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itb.spb.ru; s=mail;
	t=1781780631; bh=8mklkkdkLH3g2ukErRL/l+z7KVlGHL6lj9Vdmv5YDnc=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=MVuUProCd8khmRyomz+Hd3ipk+b8RMc6HKBA/G6wtvPoPkct2P4kp5ZAmdg8KpO8w
	 fOuys1wu1d6f5IEKXGClkR7Wn69OKO0DwLQ9xedPHTv4uQcGk/8cV7HN2p2zX/NBZr
	 07NfhKY1X7EKOzPrzoRba8h3UA3w4aL/PtNIrjbo=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net; dkim=pass header.i=@itb.spb.ru
From: Aleksandrova Alyona <aga@itb.spb.ru>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Graeme Gregory <gg@slimlogic.co.uk>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] regulator: palmas: Check return value of palmas_smps_write()
Date: Thu, 18 Jun 2026 14:03:38 +0300
Message-Id: <20260618110338.53004-1-aga@itb.spb.ru>
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

Since enable_val is updated after the write, ignoring the error may leave
the cached enable value inconsistent with the hardware state.

Return the error if the register write fails to avoid reporting success
when the mode has not been updated.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 51d3a0c999e1 ("regulator: palmas: preserve modes of rails during enable/disable")
Signed-off-by: Aleksandrova Alyona <aga@itb.spb.ru>
---
 drivers/regulator/palmas-regulator.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 337dd614695e..fa6dd240015e 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -469,8 +469,11 @@ static int palmas_set_mode_smps(struct regulator_dev *dev, unsigned int mode)
 	}
 
 	pmic->current_reg_mode[id] = reg & PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
-	if (rail_enable)
-		palmas_smps_write(pmic->palmas, rinfo->ctrl_addr, reg);
+	if (rail_enable) {
+		ret = palmas_smps_write(pmic->palmas, rinfo->ctrl_addr, reg);
+		if (ret)
+			return ret;
+	}
 
 	/* Switch the enable value to ensure this is used for enable */
 	pmic->desc[id].enable_val = pmic->current_reg_mode[id];
-- 
2.26.2

