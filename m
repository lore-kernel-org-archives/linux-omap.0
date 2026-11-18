Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035192;
	b=4chyrB4lJEsV411mxxJCIe/PAE78AR6HuWp/pHzwT2Tu+5E6YPDK0ys8qe/9mlJMIdTH
	 +TQW0KYwg7tg7Ga4++wCt4cYs69FXmJrcGTSOwKDcaSUbSAkWftzzxWbGdxHRVKz3b8wB
	 R/n4wiPD1N6qEIDBJvy4amr5SwSjI9qCKuoTZvgIJE/qho6+Tx+DuK/fJbPKQ7/17hswK
	 lDogDy6b/QWyXzLYIQro4qKqfV1d5JEcHiRjzaHPEdFoWw5XhpuZEBUbXo1oSSf6QgFJU
	 unoHiObNSd2o+/V1h4DOW6fz3YUn0SEy60qb7Gurxy/GnobsLelK6Xj3Y9vTJoQ/EXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yM3BPJ8QKqRePbbotO/o8nLTIwSIfzAlG3YqharGRPA=;
	b=byiqvCSmENEgRI1UHgeFQp3eRAiII1/ClFI/WVBOFFHryM2VABxOv6+LweiNEcQY6U23
	 hmBRBuAOYBWaOuZr/PnBAQB2vy4UIQcnGoM9S0I0Czqgvwvl6RpobR7VbEqseHYEy5ThM
	 0o7ITLweaeEN/rWhQLgSXGRFmoiixrpUgYeIVxidKUg6nDXGLKsc4p/pTfdCcuyCOc2at
	 GPwqQ79v5iihc/lFBeeQOcGlh0oJVN6949VmJPI/HWlCybKA0ovPBSTVYl+c4gCXCtn7x
	 LDE/oVy1Y6jHctXHVxnimTRH/ukAmxcRGSFvVjDM8MuO0K6kB9ysK+B3x0lvh8dyt5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0YGOL0/h";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92860A2609
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 20:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E92860A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0YGOL0/h
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c40f29667e6so235859766b.0
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 12:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035189; x=1795639989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yM3BPJ8QKqRePbbotO/o8nLTIwSIfzAlG3YqharGRPA=;
        b=0YGOL0/hyy6+47TsMZ+kpoOWJcdMNz0GQ5f6BO1ey+aUmPaC7C71wt2b8RcN4Npjpt
         ZZBnKB0GopgEbcVVyhxPsQdkIoxmT1KFZJ4Phbk9TfkdktIBirbceKHg97mcgujRhAB5
         9XTBHooBlgxF5Wew11cVQUHE8Hla1aNPc4Peiq6BKv3nUwdbxqjnV11oq0FG9syzUWzh
         +7JfH+eFSVVOemmQNNHUb/ulaN8WoGpGuhrjrpY+R0w4aElmtEQqoXcX2SKDk4L/eGOS
         1xR2eW/G8uFy7TstA8Fqx2tZvmS/ayRWdPAHIj2etOseL8xKMjKXkO9WQ+ii653YBZ1s
         xXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035189; x=1795639989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yM3BPJ8QKqRePbbotO/o8nLTIwSIfzAlG3YqharGRPA=;
        b=1FyX9ub+15OxLnXPzChd71Q4VCYYnqbXzbaCh7dFc6YImwq+nXYCkHiOehl27s+Bfx
         lqFx7H4hfUxQZUktH9yENnVLTtTblfCdhM4zcmYLMEpCxIEO+rtsS8hosRPrfHaSWxza
         Qo3ScBHkSAQOZJcAVUoOY78PG8sq4aJWkj0USRlX8vuZYOAvCF26Th5/By9uJK1QkDRo
         JuetPFAkv+zDp/j6TDRTX236BE07pAPa9BehK67MBukQe9zT+SMmUqID/f1LDIq2r5om
         /r98qe37kpDuqJolO9nYhfI2HLsAsblHR0E8B/CdLsCWNsaGtuvUI7oD9GESCCGN1PKG
         51nw==
X-Gm-Message-State: APuU4Z+SNSD8hGyjKi0yk1GIFioddReKpZdz64aJz39mg/XqtHivVXol
	XgIYNLr5Np70WDulh9UaTyITxZWb6ph69Op+uUR/E/tD3VSsHquDvaAE
X-Gm-Gg: AYBFou0LCavvkxSpTxlfTyvs7QdTA0Xk5S6saFOOEzMGWB9zLTeFsh4ATPJ3J2VMiCw
	uvq3iuHQg3ce5/QVGobBQWI+GMxFW/1+hRnwrJBEF0QKZXYYAhHJfAw1qyxxVop4QA+SwUEix6e
	PoQw4fPW2OFE6wZidPcX4GIVSXEA/gRDgxUFDOcaKJv0vFZvST7KllzejRMNgn2Ux27llldT10r
	n5ArQ3vYNOevmtD1XP4PX7pvdy50Zxt9gUDY9+E9GH+rnZAHP9zCluf8RE5I2HUmTq0HdeN7p2b
	nRLK8dr+lKFF9evXVoOvyH5qZtKzKmmk42tFb5OupmO3zY2EJwTdSQxp9O/+cIrMdYpCgvNJBqt
	e7z2MTlzJNArMal6o3bGe1ot1U2IZ+AuIBXnoGxqTMuenBxwKFzGsCRpUKvwSes3YzPeVPqwEzG
	NEMcl1YmM4c0nqcHGyHAPVTgNBedZT1LCbSaHPJ9e9Wic8RdAR598z3r62TqivRs4FwBkYtljmh
	/olIKxVRfMszpoSGFK+SQXT263+RWXcGlDFjD6buR270ema2mq7dehtrD83Eo6h2+oaOHYahwiA
	D02O28UJVoVjOwir0oc9heWqzCTl3BngrloEwTPiaGlxg07BVpfOZAC0Ck9ibQ==
X-Received: by 2002:a17:906:9f8a:b0:c41:61b9:6ef6 with SMTP id a640c23a62f3a-c510e376c7dmr374133066b.27.1795035189529;
        Wed, 18 Nov 2026 12:53:09 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:53:09 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	jmkrzyszt@gmail.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 3/4] i2c: omap: remove unused is_rdr and is_xdr function arguments
Date: Wed, 18 Nov 2026 21:52:06 +0100
Message-ID: <20261118205213.88778-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118205213.88778-1-apokusinski01@gmail.com>
References: <20261118205213.88778-1-apokusinski01@gmail.com>
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

Both functions omap_i2c_{receive|transmit}_data() have unused arguments
is_{r|x}dr which can be deleted.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f02d294db42a..3f7060d57a86 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -996,8 +996,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *omap)
 	return 0;
 }
 
-static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_rdr)
+static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1017,8 +1016,7 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
 	}
 }
 
-static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_xdr)
+static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1122,7 +1120,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 					OMAP_I2C_BUFSTAT_REG) >> 8) & 0x3F;
 			}
 
-			omap_i2c_receive_data(omap, num_bytes, true);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RDR);
 			continue;
 		}
@@ -1133,7 +1131,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			omap_i2c_receive_data(omap, num_bytes, false);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RRDY);
 			continue;
 		}
@@ -1145,7 +1143,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->fifo_size)
 				num_bytes = omap->buf_len;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, true);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
@@ -1160,7 +1158,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, false);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
-- 
2.56.1

