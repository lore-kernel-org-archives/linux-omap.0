Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CECD2494FF
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854594; cv=none; b=msHkw+X8DjqeE3WPkCT79fGCWItseuU0a13qtHbXeG24HnQYwthQHqWDu3e0xOdfMmeVosZEbnA4cYuAyDj3GXU8GyCgg4YW82t3asyPEwUDaNEkOzW79SK+xTkY0HBLO/S24u/JSPLv8b92WiHMSYLr0+fUj7w+QXXjFYF0DvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854594; c=relaxed/simple;
	bh=cihNYnflN3AVGRiDEm19DGgGttXrkIyvwuts3JIQy3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIilt2FmFXxaMZDvRTrXgW/VxMIXzGyE7lEulmdgsi080PfzVPAp05M9l+wOnmnQhoyxOIX0ptV36fBlkxyAKxwO0UJmo25It6NC2ls06f4ZWdPxTelZbv9/zEN7KB8k+DmRWpkH2Y1/W1l0a0KzKlu/qQzZbZ9mmrHxT+F6oB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm6S59qU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm6S59qU"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8966bd9da41so44697056d6.2
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771854592; x=1772459392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IVPvbiKHqb1wJCwFPWETEeAl2aF1oAt9knBh3vkK+g=;
        b=dm6S59qUDq4hMCkWKJzB9IOHtInL7S2z7mWuX+vK781iw63HFsqSlAy9vCU/wz9Jqw
         3dgAs2oWOkyZkt3yfpNmrs8lZKeHF7aT33WmzXBui+UbwE6HTm55XVVjEhDrX8bDD6QG
         DzzjzKpfAO6UeYMhC+WyKMmrmjVQAyAk76cX95qIXPAmydhfwpyTai9/wEwoY8nsQ9Jo
         +bAVRCtj7ad/dky5eBDmLNKGenBg+31wyFVSJmtZ20tvLUzcF8xbCybSIUywUjJ52xCc
         xlNQqFicunbRFvUOukqBtT+FRvsMQfUcLacUgptPJmmkVdjOKZRdqFzLZx5vGZMjMeD5
         cljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854592; x=1772459392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IVPvbiKHqb1wJCwFPWETEeAl2aF1oAt9knBh3vkK+g=;
        b=jrA9Cv1hKLowQfzHWdHujuHUgFujOlSjK4U26T1lSpDDIydArGSO7eX5FuGl+KbS5y
         ytm8Me14yQmJnzJs1ZtX3ZQgL6AQPRRtkNIz4dZeA12aZ4uxUfcqyoUsG1suFLMBimjx
         myyPlTWOG6zlcH8/udJLnS/FJsS06GawjE4rA0p2XQNvkmK+dCHVjwZrcCVJxRkCANv3
         xNKRf3Oma4un78Z8gRz7MX20gm2VjMF67tJBVjegX9u05kKGRpnnHAxNF2Ct0GlrVODQ
         +1AyVENGvj7kOMre03HPh67f22U5kYhcOGv0hyTzeKO5wTeTCsSdRqn5NhhHC4JQYRWi
         l+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVDw5BnmchGdmKVfcbKDgHoLCN5SgIVOURFFZPzd+QM0EZUmhby/JG3dq3ZJvgUeP9WbSutjFiJ7nd1@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSLSU6TgUKObmPs8v9TD99R9R2GIHNlag3qWbfKfaMRqKXBTi
	345eHDKimJ/lgU7JrgGlqd9n8HbspdCKjRegnJCRWeMReUjmv7IQp/UP
X-Gm-Gg: ATEYQzyWvieIda2XiJXAT8AAhrFPi8Ats/STGNbI5lV5tQYyvJ2VwIf5sbm7O8JBJrd
	VnAR2XLjTaaeJkSGfdFQTWbokjwurQdagQH9ZPf2BEfGs7HVwgL6OXFOKKBFQ2XPlG6I63c+qvy
	5aMPXtyxTepJQ5MZBjFMn+5N9CThP85wxsw4ypC+QhZlSkFlJC2kuamNNk0FXC/wMabpm3gLax5
	Txwi9LN85VjOy9ZWXWGIZZaHJNGnIrWcwkOX3XBufQLp2Z27RqsGT/rVvFrg8r4zCAk/UAVVFsV
	0BoddTVsJO5R8heArCwvPDuK1qGBKhDRdUVyJIUw2E1DvBit1GBx3+B7VxB/7O+pASkPQFvmO7z
	ZCxOlMGMNitR/WCbsRBoJirDHmD/eF12RB3k7o2Zac1bwlxv+siTvyd5UrbZCamCm1WemGeRru+
	bcWjK1r8JXzzMZ88DQCg6KsIpufVCQFSavM1El/UDBwUH18M0mAncPeooifJe7C4n37I0sUtB9d
	4d2FM8jiXs=
X-Received: by 2002:a05:6214:2482:b0:895:4852:ef49 with SMTP id 6a1803df08f44-89979d4cc07mr143956556d6.34.1771854591950;
        Mon, 23 Feb 2026 05:49:51 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm67954716d6.36.2026.02.23.05.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:49:51 -0800 (PST)
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
Subject: [PATCH v8 4/8] dt-bindings: display: panel-lvds: Add compatibles for Samsung LTN070NL01 and LTN101AL03 panels
Date: Mon, 23 Feb 2026 08:49:36 -0500
Message-ID: <20260223134941.427-5-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223134941.427-1-bavishimithil@gmail.com>
References: <20260223134941.427-1-bavishimithil@gmail.com>
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

