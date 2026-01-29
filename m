Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369930595C
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665674; cv=none; b=he4yHXD5fJ4rw7UiGEwaXHHuyFXe789D4vLaOcZ9O/T+B2GPR813E2o1NtbERjCPF5yCziD53ASx5hwAWbCFdinM0s2YlB1+hzFIhmDnDJBWF0zZkmsobl6Jrkgc8oEH8FRuxyFZni+CL+MBoggcI+fDaK3chxKvP81r6oXoJEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665674; c=relaxed/simple;
	bh=cihNYnflN3AVGRiDEm19DGgGttXrkIyvwuts3JIQy3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mT58kHzbWudrssNY5g7fbLJVqqvvHN48QpJhkZiHGDxGOFwEyXnAhaCtOVuUEO9kVGuZoTrpSDIEl3jYiHFlGsNuUzYosg88081wX0KDcWAl4t44szMjPrtNyhJwYkt9tJDKOEQL52DM39aXVP61Q4g9KkQgFST4yQLndsQIB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVtFxeYF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVtFxeYF"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-501506f448bso4178261cf.3
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 21:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769665672; x=1770270472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IVPvbiKHqb1wJCwFPWETEeAl2aF1oAt9knBh3vkK+g=;
        b=NVtFxeYFzX+6QeoDNPNE1nAHz1/2Af9CDfqCv/VF1+bzoWWzk73AePadtHoZkRf+9G
         UOCIzF7OjhiUkMh4TYa5n6oiqfpZvuxpj2xLpejy/zWjB48zaU6imX6KA1rX4vAOYp0y
         xngEViK/R42lkkCDqUT9erjWEHwzB954/WEWTfrMi+DP65JGhNH2SFon8sfi6uORaUID
         iYeau2H2DI9Pg4JYX5hhiXgkhIfsOYu2dKiVK2Qh62SvIzLLBJU/jId/uEyAdZdPT7kq
         EDoxqS9X13S5Y4XpW9LT3DLR1d0IUKBTmKQhGeC7WH2qr3f0z1JgwcFxO/BVRUBJjJt4
         Dmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769665672; x=1770270472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IVPvbiKHqb1wJCwFPWETEeAl2aF1oAt9knBh3vkK+g=;
        b=BvZc+5Gu+0mYKgAWXzutYjrYMp30ZcXd6IjnqCP7XWnUzJp/mAH+PiG0imoevGihuX
         QcgGHYT8AqReQ92WosW7O8HdYccGEgXCNX7SMGs7EJXwBsbQ32iWS4YAtY+4MNez7N9O
         kOAoWf9fWzl9quHC4PxOmsPWOcTysBjABkd2wxoIUjfCVK+kJTG8Dm9wsvUxutcKdDgV
         7mdgIThvmp40Kg7e7cmUQcDXyDs1NH3JN+EZVT09qh8Ssy26+RDbxPvb7ewuSo2/9S/u
         W6HQ5/mxmd8wkrw40bwQHDTk4nTCrzHeDPRDdOz413b81MtJ5yy07wnKuBr8q4DQLnwX
         JEpg==
X-Forwarded-Encrypted: i=1; AJvYcCUFYBrVpL+owjn3Rx4z45/dwm9wFaE7iQ339qH8kYpPkb/ATvZSwX4IgQND5YTPHd1AF/ISwXehQ/ps@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Ru3DQP7pT+hXfpGxNRjzE3dsWeTfp3RGg2TrlTxKrMWmXvaL
	icdy1MOTBWi5T+sTt4fS5aicFNyk9SB2llyicCkH6bM1PJM4VfFQvhnS
X-Gm-Gg: AZuq6aLDdx57NyJzFEsFFq60lxQmriMRwFeXqzRDuso3DI1L6DV/3uALT1s2sIRwFBD
	qRMrIo8Hhbxu1WPC2wX9t5zw/kTJzvtgqViYa4U/4nTo3IuIEFM2dZ7F+qJ6GQacjws7Fj9Qrq9
	Bj3guuV/Nu4dBX6jsIPsjKf2HJjqcxebpA22OL5KYsqleuWL+CIm7fs/aJIxQkO0BN318Jqx/FD
	vg2TptmgQV/d5zo1lcQgzBbinn136ep4a/YXoqRtO/pUwwnRofVq5/l61mArrYEedFrGsRLWYN8
	Z2+66zv9EmCLBRVtRBPciHXLtT8KFvqQBHXOLZ045iFrJNr9Q6n9l3vF5kKK0jtDW+JZKX+oyKT
	PXsBOAev2S5h75tHgyHclMp5mZurirR7oBNRu9BwduqKFggRtupJ4BB3IGqxqlXyug9zbid1ysp
	9mu1BtFGvMeLSbCdLJwgHaueFLv6M6RfcOHQYeNjLaIeBlp+fA4rvaNl5O+haf0hYXi9Tqxak=
X-Received: by 2002:a05:622a:3c8:b0:503:2d06:8e1f with SMTP id d75a77b69052e-5032f774707mr95808421cf.19.1769665671643;
        Wed, 28 Jan 2026 21:47:51 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36dd1cfsm30903216d6.25.2026.01.28.21.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:47:51 -0800 (PST)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: aaro.koskinen@iki.fi,
	airlied@gmail.com,
	andreas@kemnade.info,
	conor+dt@kernel.org,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	khilman@baylibre.com,
	krzk+dt@kernel.org,
	laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	jesszhan0024@gmail.com,
	rfoss@kernel.org,
	robh@kernel.org,
	rogerq@kernel.org,
	simona@ffwll.ch,
	thierry.reding@gmail.com,
	tony@atomide.com,
	tzimmermann@suse.de,
	andrzej.hajda@intel.com,
	bavishimithil@gmail.com
Cc: devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 4/8] dt-bindings: display: panel-lvds: Add compatibles for Samsung LTN070NL01 and LTN101AL03 panels
Date: Thu, 29 Jan 2026 00:47:05 -0500
Message-ID: <20260129054709.3878-5-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129054709.3878-1-bavishimithil@gmail.com>
References: <20260129054709.3878-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LTN070NL01 is a 7.0 inch 1024x600, 24 bit, VESA Compatible, TFT
display panel
The LTN101AL03 is a 10.1 inch 800x1280, 24 bit, VESA Compatible, TFT
display panel

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/panel/panel-lvds.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index dbc01e640..b31c67bab 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -58,6 +58,10 @@ properties:
           - hydis,hv070wx2-1e0
           # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - jenson,bl-jt60050-01a
+          # Samsung LTN070NL01 7.0" WSVGA (1024x600) TFT LCD LVDS panel
+          - samsung,ltn070nl01
+          # Samsung LTN101AL03 10.1" WXGA (800x1280) TFT LCD LVDS panel
+          - samsung,ltn101al03
           - tbs,a711-panel
           # Winstar WF70A8SYJHLNGA 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - winstar,wf70a8syjhlnga
-- 
2.43.0

