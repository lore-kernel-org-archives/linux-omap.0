Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA73FA5C8
	for <linux-omap@vger.kernel.org>; Thu, 30 Jul 2026 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403389; cv=none; b=FJJYoC81KiWEhGwGRD2txo5cuf1Gf8Dk2ftrEFUwUviyIBl+8cgIKEsPuOadxzenl3X8dR3Gcn8b1JHBODqupuXG2YRahJR0gz9QdaHTmbn+dEi7n9S5VNgFtG7d2yeHzzhbwPYf7/U7l3GcI72VYP5Olk2ZKfVJtYHUaqaBCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403389; c=relaxed/simple;
	bh=ySfkNi6u/Xc+LnABympw6WDKyKLWbE7/fAO1qnlh9i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZfKLjwZ9W++sCN3QuuV+F6hypukVSsgihHH7rAh2AfZfNUW5OxG3YBDTWAT2PFqVJmTQj5M7OXQ43MV/35tbTJ8p/eOMMeYJsWUs+0ZHQ0Bbf7a9u2zhSEkvfem3Sjoe4+A0MnqjVLOndIrgMDe3W3Jwzmpz4OoCLNzXmJ0ijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TG6tzxlN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG6tzxlN"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954aff6088so17447225e9.3
        for <linux-omap@vger.kernel.org>; Thu, 30 Jul 2026 02:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785403386; x=1786008186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QEVMeO2gE5AFjmkT1VS2N07BKr0N4iKu0FoXOV951KE=;
        b=TG6tzxlNRkpScn319b9F2BgD6jv3UrcWOqgXjd8TK+oNZvfASpP+jkmShLRNxTcKK5
         JBXxyITZoRffTdbfbzRn4qTTFSiRi5A7xdGeRRuKiY0XodQUBITu6Hb1uC+PnOgz57EG
         jPDQfMkiOEpgZbCqRXg8NfDlwp38v5x5JNYWPonBNUPwGGbC4zU8OnPJLjQQTkboEaeJ
         UusAUaIWqYDbmLz0c0JUTS0bYzt+atoiQkCi/fQkSReK9mGphQpQWYzkEqwfWRemSNzr
         ehgMSfzeb6RRN0iyAzMMooGSSArMx4fMqELm1V+ud07LVZ105k0Qlxn5jDpZ3oKQOfDW
         f56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785403386; x=1786008186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QEVMeO2gE5AFjmkT1VS2N07BKr0N4iKu0FoXOV951KE=;
        b=pwzx3zqT6eXEKDi95eON0Mi9RSab8erVUdojDDC47r8Z3caQefBLBP6fKTqHp3qHYw
         LSPeohjRWuK0b0KbnNxMtnHGzrwf1x2bL1xGAVhRYgkp5fUMUp8CkfDR9TMEmUyirSos
         wZywzcR2JA7PvcIXm+25NUOppHU/KVxQd156F8tFJdlogWOL/kK7LUh3cEJfQkm2b46Q
         a8WF4rI4iO1vJrY4zoAxdTHcnha+dkwxNCXSJwuFfK7enCGJOQhUN0HsK5KI/H9CUQ4H
         BVtHSDbzFfc+KJ4ek3tg0/uUrPMHHqetR6YFWxbiCJXypZ6Jp7fC87X4SZOIbPKQ5WkW
         pN6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrl1Akr2OwrdyBIKCX6VCL6oS8awk8OFYbl/3RLPsqqYbjAqmGf+7Uhh5SF+Z9j0UMyknKcpP3c9yeG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0K42cubZLjfxx6JavAxBC1xUsymz45qli3JSQ0NRWRq47TZl
	50UBPduuMwkOv/6QpXkdQYeGRX26112/ITGwpghuATBU+6XdfzLtY6HD
X-Gm-Gg: AR+sD106DwknSx0h9GANj15qfnvppILF2EUmyhuyaW2UDgCT6U/a2HvvWVflGlR9ayP
	U8i587F/yGspSEBLBiQg2yCQHyEP/UiZ07VEVnyv/nm5U+f+NrxN31mUkYHJIwA4Ap/33dQTmhr
	+oo5kkkRozs0Qaoxq5//X2WOvMRzGGKMJcMcJAYneyJKxN3xascqvTxrCGxHJxiptnLXpXHkdhm
	p/BzIwEoimSw4VpLkBwo2F6DV9cnX0tFvm7NHOoMjsL6up1OqLuiGNd/iCFHeyrO+jxgrw4jQ9r
	foHpJLh5R6KXfx4W1J8Pvyw6F2hAEjdqseDYGT1WPiypzEa9cyetyjFeeQ7qdl4hI0zJj5cP4K+
	rTwEOq7rzBz3T8Ow28TH4FAtQX9y8Vr2u7reqmUhvf7Hwzqq6tltoAyW5Nt3PmBhMbz8v0x1uXX
	qXge1r4lStHiCpy+iBoIN49sKxzbKvZJn/LLZoDfQPjMC2sMM02gB8u4ju8ejYAPEVnvT2DkoGm
	McNGuFXKPSOcBY+/+TbNWthIwH4KMN7cg==
X-Received: by 2002:a05:600c:548f:b0:495:4732:1eb9 with SMTP id 5b1f17b1804b1-49800ea1e9cmr24176065e9.21.1785403385560;
        Thu, 30 Jul 2026 02:23:05 -0700 (PDT)
Received: from fedora.tail6d6c39.ts.net ([82.77.79.56])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47fc88e64d5sm4308425f8f.15.2026.07.30.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:23:05 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Eduard Bostina <egbostina@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH 0/2] dt-bindings: display: ti: Convert ti,tpd12s015 to DT schema
Date: Thu, 30 Jul 2026 12:22:43 +0300
Message-ID: <20260730092245.52034-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the TI TPD12S015 HDMI level shifter and ESD
protection chip binding to DT schema, and fixes two device trees
that use it.

Patch 1 is the conversion.
Patch 2 drops the unit addresses from the TPD12S015 encoder and endpoint
nodes in am57xx-idk-common.dtsi and am5729-beagleboneai.dts.

Eduard Bostina (2):
  dt-bindings: display: ti: Convert ti,tpd12s015 to DT schema
  ARM: dts: ti: omap: Fix TPD12S015 node and endpoint names

 .../bindings/display/ti/ti,tpd12s015.txt      | 44 -----------
 .../bindings/display/ti/ti,tpd12s015.yaml     | 78 +++++++++++++++++++
 .../boot/dts/ti/omap/am5729-beagleboneai.dts  |  6 +-
 .../boot/dts/ti/omap/am57xx-idk-common.dtsi   |  6 +-
 4 files changed, 84 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
 create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml

-- 
2.54.0

