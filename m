Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114694;
	b=rBEdyyOxog55CH4Z21KS1+3SGluWBc2WnLn6GaAfdFpQ1eckh5H9e2Rqjy6ZqktO0MFi
	 HaXwXdYS9FbFukD4R5Hs2yR02krTPaW7EVyrG42DUG79e185gBcBIOeytkje7RTmGE9pE
	 Q64v7aDWmRYLgUCQypJilBqJXmY3WvRjnoytB+p8EqQzkBrBtnpfnlzmPX+DVwfu2suU6
	 bHsjDC12kbBKVJw0C0TnDNgi52q6qVrmYmgzUbxg/Gn1wp283pWlRzsHObByFoKZ9+zts
	 0MOjGeIL7Kj1mliEF4xNl8eSHWO5dFlFz/JOdJwj0HDNSxX4YaGF0fZ+/f9UPYdYwdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vjqSPFjUdrt8PscvM9fFZjHp8A1xWrb3rVaClebLZKU=;
	b=OiVC7tCEX+PLVdlOrpYbJEy642w234P00ZCaQ0G4eb1LlImW9BKCPxOy9pCUU29N+9iT
	 P+NxxUQDe1sX/Ys5KbSDvbZoQheOdejcqztVA9NTvEg80Z1F/g1sJtIU0IAawbmZ43qyc
	 c49L7WI8xyuCpuhY8KiVEz1NSLzFi17DGd+AOaCrR87tfVFAwnGEsmeNDZkjrsgk1knkz
	 uwc4h+K8ju/uYFNipyPAmmIaBrhmKgZEWtlv5TEyhJ14NnVfRJsNzUlQ7+suLGBBUmMDk
	 PUbUTIggMGaq1Ne48dPuDZfgtKftcbaobFBI2YG5qX9MJDm1/rRMcsuvCRzug4VfK/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=umAOXndx;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B216606A33B
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 15:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B216606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=umAOXndx
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso1869899a12.0
        for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114693; x=1793719493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjqSPFjUdrt8PscvM9fFZjHp8A1xWrb3rVaClebLZKU=;
        b=umAOXndxvjSlOCIPbIQX2IOta62OjaS2NDgt9ts+RCrfuKW6oHSnzP5O9hLr75KiMY
         qTV0Q0xSNjQkkIDwciaQ51JwIyrC/MKmzRJTYN8bA+M/186GsmpwZh29KzK+N1wrQU4j
         Zc9VN6KCBVL5f1tBH86GeG1exKDp03EQotttGrZQaiZ6d3lpYNbnCcyfrMs2JgFhUgo+
         SSov1Rm0u/nRSuN25Eper0sGTRSR4+9wWZwj/CQQL3fKicGNl9VNf6Jo7p0TyzX5ctuY
         7UbvtmvSVDuGa/4PBqSAJCV5Lz38duGUO9Vn7dj5n2gkBna9eHm3eo4XgQlaG6PDBVxR
         FBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114693; x=1793719493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vjqSPFjUdrt8PscvM9fFZjHp8A1xWrb3rVaClebLZKU=;
        b=LLuOylck4auA2nyTzVpeTDMNiMoZOpzgE7Xi+E1MUndHZqj0r9XDPOQEQ67oiFcgHu
         dnaBG2qCHRADnl2m1K+Nb7c9mYnS7A2jdm91FWj3gTk72b7mT4CR/wq3UMUbdUwbM5t1
         0Rtsvg+zbOiwFR+GzIIxA8JRVcRkAs7wep/alNjM1LV9JCdmIBxbt0c8sJkrtXBlfbgB
         9S8shDuTPr7o6eJCU52QG5HkD7RbfR3Hu3nUwSsSa1tk3IKxH3NgAjQCtDqtKiBVbTjh
         f+nZ087QvLSGzYbiebF18CFJpBTSMUgu5bkNr7UtrlcQ1ASppEl+8AujTL+kvNAy1Y0e
         MiIA==
X-Gm-Message-State: AFq9FYKs3wPL7B5KZk5rQEwztrxGSWqsdUjgYesxGkhw1CLQrupY65dV
	FHcUlMDf6JrC3IQAftr5/5EXNEDQwt2MBlr0Xqv9bDybzw9pq2ZF326h
X-Gm-Gg: AYBFou0fB191CR5tW1MHojqt/vUruv6WougOGcOsAFOg9t2waHnI0poDJKmVFsC2tXb
	Pa/cWfaS5EtdKpDZknFzWCpfriBiH/6KHqXBxsUcCbXD53gK8DtsztjVNaByV0yNBGavK/ArbRj
	yNCTpLzwsD2rekysJHWDTkGQ55Pb8SGYZeGjc3KMkMYG7uG56ExgT4Cvtiz+WrfCkBJSr0HvBob
	fqiBeUw3LwU7HRjq4eqmCsxWZXJQKwQU1ObyUlROzbWFAdHCSZShfT87Lc6XEpTSdmNCOvMmaoo
	lkrbb+EA5LZ5dgvXqDdAJr/sIXf0BO4N8T5TFp6HXzKytstlQx2/RjHEnePeLIcY4RZlfxIjwa2
	oQyCZomrkZfPwQrGgTKmntqcz1P/98ukDb+W1UmcJQCES4t02zPylybHbajZfrDeZYQyZOmMjNz
	7w8IgbO5i3+/5TKmfTJ7LnOZidFcKBx+mDqF6t3WsmYMu53mx1NKV4o57EY9C/xTG4UdIyhVyEa
	Zlp7RWTg7anmdFovUyx5iIvYK+D37bJTAGodKZ2vtbAK6boRrsQI/IgzjnyqPYU0aTt4Hh02qES
X-Received: by 2002:a17:907:7b8b:b0:c42:4f89:13 with SMTP id a640c23a62f3a-c49a73d41d4mr297034266b.15.1793114693026;
        Tue, 27 Oct 2026 08:24:53 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd529b3csm467303866b.37.2026.10.27.08.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:24:52 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mfd: tps65910: Add restart handler
Date: Tue, 27 Oct 2026 17:24:22 +0200
Message-ID: <20261027152423.194794-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027152423.194794-1-clamor95@gmail.com>
References: <20261027152423.194794-1-clamor95@gmail.com>
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

From: Dmitry Osipenko <digetx@gmail.com>

Add restart handler to reset hardware properly on system reboot.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # ASUS TF700T
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/tps65910.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 97855bd9cc3c8..ce7ecba504b3f 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -437,6 +437,17 @@ static int tps65910_power_off(struct sys_off_data *data)
 	return NOTIFY_DONE;
 }
 
+static int tps65910_restart(struct sys_off_data *data)
+{
+	struct tps65910 *tps65910 = data->cb_data;
+
+	regmap_update_bits(tps65910->regmap, TPS65910_DEVCTRL,
+			   DEVCTRL_DEV_OFF_RST_MASK | DEVCTRL_DEV_ON_MASK,
+			   DEVCTRL_DEV_OFF_RST_MASK);
+
+	return NOTIFY_DONE;
+}
+
 static int tps65910_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
@@ -520,6 +531,12 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
 		if (ret)
 			return dev_err_probe(&i2c->dev, ret,
 					     "failed to register power-off handler\n");
+
+		ret = devm_register_restart_handler(&i2c->dev,
+						    tps65910_restart, tps65910);
+		if (ret)
+			return dev_err_probe(&i2c->dev, ret,
+					     "failed to register restart handler\n");
 	}
 
 	ret = devm_mfd_add_devices(tps65910->dev, -1,
-- 
2.53.0

