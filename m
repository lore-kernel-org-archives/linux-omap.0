Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307657;
	b=sKLvbiWYl+ZWBbrQ9r7V1q0SQ2/4iKKwqbNtcCHHT2va/hymkVM7dENIGMhBZ19iCvLR
	 aEvbIu5YI92nHWpSeL/UTLqFsd1E32vEjqV31X+oLHHbIX08uSx/q5fCYEYjmpq6oLxXV
	 xRa4t0veaYatTXm/WgNao1BPFWAkVWNlvYt3VPlHbJQ4NdGTzDl4p2LhdZ5a49xKIrw78
	 S4DeFmqU5g1Z4r8ehP2PW70VqGh+9pn++cmXdHwdpFDbPGT4lVWalh8P16QzdslZcaDNC
	 kbkoOGxJ/dR1tl75ecwnTcp0mo+TGp/de64Xw5SxPdurYaJcI527my3GjjRAwzXuFuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307657;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=C10R9+FsWtdMXyeOnMpjjihgOFuMfyeb6FQIN+FCe78=;
	b=jHK/bkHrp7dcIhJ8NIjROpFbQcYeFo4Z0Yyly8HCp4MLY2ZbraBxvkkH2ibeDRs+xomM
	 PDEUZIYPWzkiCNm1SY/yjt+0E8LC6adSrawSl4mjSrmw5uIFLJzsA9s4ylfQT9Oq+i5d6
	 AjvuhyoVUnm+tTNK0OE/wRnQ2TzUM8GqeGyubwVoJ8+aPJHnsFbOVNLb4JCPvqZ77rMfk
	 e+2jGXPZ6p/q9CkH8tqPDrXMQ1jyVaa8EedPV95YrmduuWSoCNTCpx5mx052J88zU3Eo3
	 qprpsoWYs3h0NuWBSN9c8CJZxh6NPz9h3f9rGW8TY8eY6CSPQkPSPAbh9kXZn/WCErw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=zokCQnjd;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E1606A321;
	Tue, 10 Nov 2026 10:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 038E1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=zokCQnjd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=C10R9+FsWtdMXyeOnMpjjihgOFuMfyeb6FQIN+FCe78=; t=1794307656; x=1795517256; 
	b=zokCQnjdQPWHggURwz1gyNwUNLPdEoRCVAk4bsPOeKulQXSApiZZhKOcwS/4ViVwVzYykofOTql
	PcT8gP0ZqXcRPt3FArl1fYa6m7kXSjR/eDPA8X84UbjkIG3zxT2Gi7vJp4zSCnQXYQZC1q7065sZo
	URCfNoudhvzCqgnNNxhgUTaJUUpyoHPcHFEy7XWEJVz262RdN8oWA0rj7arVFekGmefm6hKSFkBWW
	Td4eQ9z3fO8g5S2mPVavYSFkaJ8ZsAwUSGa+Ydwno0jvsWoMeZfmFazn3yDbloJmGCnxxCD2HJNha
	TNThHCMr0TYlstS8z0HtSGlr6NwVHGZO93Lw==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 10 Nov 2026 11:46:12 +0100
Subject: [PATCH 1/3] bus: ti-sysc: fix I2C quirk for OMAP3 variants
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-i2c-sysc-v1-1-8945eb1d38f0@kemnade.info>
References: <20261110-i2c-sysc-v1-0-8945eb1d38f0@kemnade.info>
In-Reply-To: <20261110-i2c-sysc-v1-0-8945eb1d38f0@kemnade.info>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>
Cc: Sicelo <absicsz@gmail.com>, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=3381; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=t9Vuz4zKzjtP9j2cZP3ABiVFU0YuIep4VHnJSsSDv6Q=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq8vX4KDPD9hphPkFWgs6qwxkiFIyIP2rWdSR8Y
 ztME4q1lH2JAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCavL1+AAKCRCEYUX6QCjc
 8XwlD/0XGK2uWBDG8ZRUYitwjUwJNMi5aeiX/b1BUh1+ElNw2GlpojKDrHCrJzJ/f0y87xljHMC
 fTCXvMSBcUS3hXYa7Z/rpjIdg1VBBwTRz1EciGFBgARwTbMl88EG20eQUTCzqq5TUeFnyq7HmsQ
 skhnhP/h2Wc6jSjYR2EAyzuIrvblUvakpc5Gl7z/9AGnF2St3l3hDQEjyKqOua0cl7u5BN422dI
 A4UGR8E5tLIQ42or3a2LuwQ3Dhj4xdcEVoZVgEfkF8CiMfMw5wzOx2JsNHTFfxgwwXXQcgBXrKj
 DpGXcf7GkmhNj9by3nnf3ng49EExKd0srP+DAUSOMlxti0rsoE3SVJ5h1So6wJ5MxWzHGclck/w
 jpxvqKP0hM8LwUHgJqiMcwX5mkxYnnOqrinjoZ7h61+HUIBHxKmDbANWONMnP8Tk7/0FzldhdQi
 TJzw4ZR3Ag6GAPY2e/e+tF0T8JIao2SiJKSkfvIcjQLtRuRr/7OHVrV681q8uq04Ylmy8tG2IUh
 iBn0Q4WiTczXCcDgKU4NxLw/l+dyglPG/pVEEdwRzTO0XpiuWi7SN8lXbxK7XMv2rHIpGdJF3Gt
 pf1fycvSr6ca4Wn3+zBc39B1iyZyfyXZ+Lcgt/Mfdqa0tNfmh0RpDuuvxNPzMKTgDuLsUT3gFar
 QI1ee16EJfwKITQ==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

OMAP3 has only one revision register, not split across two registers.
Do not try to interpret the interrupt enable register but instead
use the size of the revision register as indicator.
Specifying a fake 8 byte range and the original quirk only works if
u-boot has not messed around with the interrupt enable register.

Fixes: 4e23be473e306 ("bus: ti-sysc: Add support for module specific reset quirks")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/bus/ti-sysc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 12285ad9ef51f..c07a0e1f9a878 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -153,6 +153,7 @@ struct sysc {
 	struct ti_sysc_cookie cookie;
 	const char *name;
 	u32 revision;
+	bool revision_doubleword;
 	u32 sysconfig;
 	unsigned int reserved:1;
 	unsigned int enabled:1;
@@ -179,7 +180,8 @@ static void sysc_write(struct sysc *ddata, int offset, u32 value)
 
 		/* Only i2c revision has LO and HI register with stride of 4 */
 		if (ddata->offsets[SYSC_REVISION] >= 0 &&
-		    offset == ddata->offsets[SYSC_REVISION]) {
+		    offset == ddata->offsets[SYSC_REVISION] &&
+		    ddata->revision_doubleword) {
 			u16 hi = value >> 16;
 
 			writew_relaxed(hi, ddata->module_va + offset + 4);
@@ -200,7 +202,8 @@ static u32 sysc_read(struct sysc *ddata, int offset)
 
 		/* Only i2c revision has LO and HI register with stride of 4 */
 		if (ddata->offsets[SYSC_REVISION] >= 0 &&
-		    offset == ddata->offsets[SYSC_REVISION]) {
+		    offset == ddata->offsets[SYSC_REVISION] &&
+		    ddata->revision_doubleword) {
 			u16 tmp = readw_relaxed(ddata->module_va + offset + 4);
 
 			val |= tmp << 16;
@@ -761,8 +764,10 @@ static void sysc_check_children(struct sysc *ddata)
  */
 static void sysc_check_quirk_16bit(struct sysc *ddata, struct resource *res)
 {
-	if (resource_size(res) == 8)
+	if (resource_size(res) == 8) {
 		ddata->cfg.quirks |= SYSC_QUIRK_16BIT | SYSC_QUIRK_USE_CLOCKACT;
+		ddata->revision_doubleword = true;
+	}
 }
 
 /**
@@ -1527,9 +1532,11 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("i2c", 0, 0, 0x20, 0x10, 0x00000036, 0x000000ff,
 		   SYSC_MODULE_QUIRK_I2C | SYSC_MODULE_QUIRK_ENA_RESETDONE),
 	SYSC_QUIRK("i2c", 0, 0, 0x20, 0x10, 0x0000003c, 0x000000ff,
-		   SYSC_MODULE_QUIRK_I2C | SYSC_MODULE_QUIRK_ENA_RESETDONE),
+		   SYSC_MODULE_QUIRK_I2C | SYSC_MODULE_QUIRK_ENA_RESETDONE |
+		   SYSC_QUIRK_16BIT | SYSC_QUIRK_USE_CLOCKACT),
 	SYSC_QUIRK("i2c", 0, 0, 0x20, 0x10, 0x00000040, 0x000000ff,
-		   SYSC_MODULE_QUIRK_I2C | SYSC_MODULE_QUIRK_ENA_RESETDONE),
+		   SYSC_MODULE_QUIRK_I2C | SYSC_MODULE_QUIRK_ENA_RESETDONE |
+		   SYSC_QUIRK_16BIT | SYSC_QUIRK_USE_CLOCKACT),
 	SYSC_QUIRK("i2c", 0, 0, 0x10, 0x90, 0x5040000a, 0xfffff0f0,
 		   SYSC_MODULE_QUIRK_I2C | SYSC_MODULE_QUIRK_ENA_RESETDONE),
 	SYSC_QUIRK("gpu", 0x50000000, 0x14, -ENODEV, -ENODEV, 0x00010201, 0xffffffff, 0),
@@ -1872,7 +1879,7 @@ static void sysc_clk_quirk_i2c(struct sysc *ddata, bool enable)
 	u16 val;
 
 	/* I2C_CON, omap2/3 is different from omap4 and later */
-	if ((ddata->revision & 0xffffff00) == 0x001f0000)
+	if (!ddata->revision_doubleword)
 		offset = 0x24;
 	else
 		offset = 0xa4;

-- 
2.47.3

