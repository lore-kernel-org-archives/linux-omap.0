Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597920;
	b=j4Bowm6Rm350HUOOwnW57EpN3n4aaK1+lawvXry+NiAS8jAsJc04ZLSXNxR5yArY39/q
	 qtBh2E31ajPN/dE+fJA8ohR1VVdAouiHHoOM8fSpZ66D9OYTuE7vfh68MtpIMzM2fwNTF
	 r4YCajikVfWUz3oHzzgu31Ff84vgYSGqjwsUgaZZEOwish9Hk+w26ubJ9ZEq8f9MexNzE
	 /HoOX/39JxuotLurIp6II4i+SpXIGl2O8cH6PX//5JixH3LgDIimCGHSJPIf1mmVkKlwQ
	 xJ+oU3NgiH+74WS6ZuOov/yMV9TuhAmmhoXxIs5kCwxyVPJCdVfQ3OkOWfX7Vf/CS7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597920;
	h=DMARC-Filter:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JRECtW8COtDV/Hx3WN2JZjcB+QasUwMj4ribAmVQyHA=;
	b=YyoU5ttMHma/UJjoThNAvAtcvkJJ89qXLZAp+LK9GKVAb0G7Qse+w25eLtc//2ITozgW
	 jQotGP3kVx/ctTTC6f4h5vHEXe85P3+sj9H6mJfKG/aCSaskm9aRmP1lvc11LkI/jw/e5
	 25eLX2Y8sfC8LIZnJx+jUr39Ej9IObrKRDehKuZwuWPsSn17NyvMOy6XACrh7sY6w9b9W
	 44WNe+nZVvx4t65Hn8KsN+zVQTY2I0ldEVFcPB8eolj5gZMf057O7myHVVO+o1hqS9/se
	 6lprZqgr5jkKYIi3LFmwV9jVtsQvTQf67876SBkw2C5KYKQN3vp4w+N2PriLvaP+kUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=iSKxNgoC;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00AA606A319;
	Wed, 21 Oct 2026 15:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F00AA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=iSKxNgoC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JRECtW8COtDV/Hx3WN2JZjcB+QasUwMj4ribAmVQyHA=; t=1792597919; x=1793807519; 
	b=iSKxNgoC3MtU0bQbTAb+ocMjd1/B3RKRFF3WjHhS+5xcJaLvvm73Hwn5Da69Ez1J1+galFAQQ8O
	K/1snrWhD1NrqaQzJF3e54cVQQ/3dQH0dXZb3CrmOh32IRvbXjhIEWjUKdwZyde/cDrgiS2neB9TW
	CBP/6fKguZ4ZwZGcRQel4XsC0DMbnUxRf9tev+c6opx93zqui+3cQPa7US3OesJDL4Kbe8eoG3ONe
	blV5wM09KPFxB0bJItO30wxa1XR8B5DCn1i12d20F5ceQMZFVDKYYtSAta0ZmCX20bCA2aKPKIupb
	WAPaAq0ZxjwY78Zl864xX1Nnl6sK3olxmTyQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	vigneshr@ti.com,
	jmkrzyszt@gmail.com,
	andi.shyti@kernel.org,
	linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: omap: fix hw version parsing
Date: Wed, 21 Oct 2026 17:51:40 +0200
Message-ID: <20261021155140.243337-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a simple typo to avoid showing confusing chip version.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/i2c/busses/i2c-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f02d294db42a..bd659dfa702f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1407,7 +1407,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	case OMAP_I2C_SCHEME_0:
 		omap->regs = (u8 *)reg_map_ip_v1;
 		omap->rev = omap_i2c_read_reg(omap, OMAP_I2C_REV_REG);
-		minor = OMAP_I2C_REV_SCHEME_0_MAJOR(omap->rev);
+		minor = OMAP_I2C_REV_SCHEME_0_MINOR(omap->rev);
 		major = OMAP_I2C_REV_SCHEME_0_MAJOR(omap->rev);
 		break;
 	case OMAP_I2C_SCHEME_1:
-- 
2.47.3

