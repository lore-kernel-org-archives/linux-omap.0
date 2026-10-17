Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433883D994
	for <linux-omap@vger.kernel.org>; Sat, 17 Oct 2026 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198083; cv=none; b=NrfeuOlffUS17THsXJrxbV6apMvxNalitymaqqmG+AaBfGAM98/wau6pIv8UzRy15vnUwZNKznatmcwhAYKWgz0XXsLewKXLbrahRd8+FJ3OVKXHwvFJSAgtSwcQ9dOLLR3USkw2J4JGsSLI5W9yDCjOfXg5J6PTED16jKTTsro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198083; c=relaxed/simple;
	bh=uQd8KTXKI3I23lJLW91Lf0V1sEGZ4f5qzE8kZvjuFEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvN1FiEH8z9VdR6GbZDaeRFfv0wa4FfI33zJzFRpoIHRHuHu2eAnzAMZNNok+BiZot9zg4KZjv5kh1flEV/tZ4sbm42xEymY++K2PKK2tQ72ZoRyIG1MzqDWgAH7bwXbO24OQOKP2JGiSgcjBjoAViqknEJgInLdlZD7147dwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmNSQZVo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmNSQZVo"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so340038a91.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 17:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792198081; x=1792802881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z7WQxeka8iJk8UZewm7aIuKt31IFYG3pfmjyCh4csfw=;
        b=SmNSQZVoosamiKeLUV/h8v7m/O/OIxtO0zRgZ6ZskISST0fImL9RVmm9ozzn3wXr6n
         8lhhqkT2ygOd4Xo/pUdpB1YkeBonMmMv6b4jAyCih02cmfgCasjyrA/gsCFoDiWlBymX
         97a3Uvxs+YoFPpPM4rDFxE5BmOebxVSzFRe4OcqVFiWYBPDuixXUtakw8OBs3ZXXt7eG
         vtxuu44x/uyMuMcx6Lvrt6orzkG7huYTbhWZlzPphcjkvEKGb0o6nqKGQRzrZ3fBsTF/
         n3gNRfUGYa3X0j+ZnQwY5IjB/hPgjcBas8UWXptpkbuYDb/1C1TRvDcfT9CPREOkNMoq
         8hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792198081; x=1792802881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z7WQxeka8iJk8UZewm7aIuKt31IFYG3pfmjyCh4csfw=;
        b=cSxkQrcuekgX6MwB25/fX8UCpjL+9g87Z0kxt0Asmdc/PEEDyKIr3C3qM66ATuUGR3
         0cCKpWNHiLnTIkTV3PJl2IefWcODpi0sdlEdwFulR6XlfL8u0MFfKLQO9m+jGvzjv5mM
         48mSUWvoRXC7jj4MXSV7SE1fY89MbCUxGu1xiCdhyRaaxCx448h6celmrLWaom9xQWO/
         F3SYtpnjIns7ezB/R50Eq8P+AOX28ENufAQLTbFqRi8N4F766YXpjM+Fe4aKS0NeYy+x
         QmwGmtwRjDj/G/lUY0qIG7KaWfLvIiLmhFwkmYNxnUVdWDCYL7k5znMu1enZj4ns6oe5
         7alw==
X-Forwarded-Encrypted: i=1; AKwUvBwmRMRzMhPCcdb3orcLw4NDEoS6rJfUdh1uLBI2CHIl90NvpQWKoi5tZXWhitJNBgbDZADPBlMlgRBH@vger.kernel.org
X-Gm-Message-State: AFq9FYI4WW7SxERKLAMCa6f2lStflsOll4Vl/Vk3KP9xFvAk+ART/M0B
	nWwVK+sfJ+VpqNmG66HSgMu9DtqsouU53BE1EFi9yut5J9QeS1PuVliJ
X-Gm-Gg: AYBFou1JqQH2qPz6t2F6zKBoE0Zf1n5NaxwH4rwmlEHqriixcBhMmzL+VRyxCTwAmcE
	ZCAnrjdNPML088MhFWkR7mIJEu6PacLi94oEhPD/xP3SqrdA2zPEc0A6Lp6v0i6wPrz+vglGLPa
	86rDrO/SSc1zw5zIJekq2Vji2kmP57AqYQrZ4X2Zx/QPWHSFgQVmMsaytqY2qCaBxW2iSCUgQH0
	/iZJKsgoJjQEm6fMZxyCu6e89s93nCtfPb/xbYlybLNjBLv8jje7ZbK6vyVF1LP50niy09IJQGy
	EXxzX+aOsdkN8W2nIDYI7h2Ff3nM+PYdlttG4nU9qBIaDbQf/4X2YA4ri7GMnESnL6vUOZGaBci
	wpqENYSJXRaPsRGn0revuou/BoPMufbpRuKChtMXHPXx/8hNnw5+o9XNempzD+pviqKnkvV8F18
	Wc12fqIsOSmE854ROjZP5+hAhoNhPeOVhY1IGHKAWHhC5nDrOTgSBkBjR3fz+zO6K66LT/pZSuT
	dylMDH2n43fL1NQP/3PS1DURJnQnr6YP+4/5cFBhUxWbq7jqpsVuIl7YmppXMORmFFcKIzXqv4o
	VVR7X5G1uHWzp8kBjFBHwcxSFhygAXpZwSKhIjyf29hN+gIi
X-Received: by 2002:a17:90b:5112:b0:3ac:9e5e:d19c with SMTP id 98e67ed59e1d1-3acef134c23mr1427783a91.17.1792198081562;
        Fri, 16 Oct 2026 17:48:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3b16c2asm2604171a91.2.2026.10.16.17.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 17:47:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: mfd@lists.linux.dev
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	linux-omap@vger.kernel.org (open list:OMAP2+ SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] mfd: twl-core: Embed the twl_client array in twl_private
Date: Fri, 16 Oct 2026 17:47:58 -0700
Message-ID: <20261017004758.1256875-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At most four I2C slave addresses are ever used (TWL4030 class), so
there is no need to allocate the twl_client array separately. Embed a
fixed array of TWL_MAX_SLAVES entries in struct twl_private and drop the
extra devm_kcalloc() and its error handling.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v4: use a static array
 v3: Capitalize Allocate.
 v2: don't use twl_get_num_slaves().
 drivers/mfd/twl-core.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index f86df356d658..4f70d49ed2f0 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -153,13 +153,15 @@ struct twl_mapping {
 	unsigned char base;	/* base address */
 };
 
+#define TWL_MAX_SLAVES	4
+
 struct twl_private {
 	bool ready; /* The core driver is ready to be used */
 	u32 twl_idcode; /* TWL IDCODE Register value */
 	unsigned int twl_id;
 
 	struct twl_mapping *twl_map;
-	struct twl_client *twl_modules;
+	struct twl_client twl_modules[TWL_MAX_SLAVES];
 };
 
 static struct twl_private *twl_priv;
@@ -788,15 +790,6 @@ twl_probe(struct i2c_client *client)
 	}
 
 	num_slaves = twl_get_num_slaves();
-	twl_priv->twl_modules = devm_kcalloc(&client->dev,
-					 num_slaves,
-					 sizeof(struct twl_client),
-					 GFP_KERNEL);
-	if (!twl_priv->twl_modules) {
-		status = -ENOMEM;
-		goto out;
-	}
-
 	for (i = 0; i < num_slaves; i++) {
 		struct twl_client *twl = &twl_priv->twl_modules[i];
 
-- 
2.56.0

