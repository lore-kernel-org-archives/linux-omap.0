Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731F34676D
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771825888; cv=none; b=e7ntO0ZY0RtBu6lA7UxNZE2z71nHJEgeELRepO+rX53i6g2qFPJZrG/gHzWzgsCfv28WJ/qvKKrqelgtuOBgTGEHyxw2VG/gXD9pf/DYDrG+QlobkEpgWjwscYYoga0yM4SCRnjOfFIqYMPTxxW7SJmpFJkkOqcsPeudF1BBUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771825888; c=relaxed/simple;
	bh=cihNYnflN3AVGRiDEm19DGgGttXrkIyvwuts3JIQy3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6kLiEfsioloXzw0KSyAIzHYtXVZNf4zNDTNYcdlwAkRsdaF0qSF/ipwclgcl7ZEoGFOJ99X5OQH00Bv/cjnk5WtmjWd10X+nwIyrPZYelXicdAOCqGWQdYvTUbsV4ksyiaIxrlystiumdkACwPmSuIgo4i07jKsO4pYCClZoPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCwK+eRf; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCwK+eRf"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89464760408so24560496d6.0
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2026 21:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771825886; x=1772430686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IVPvbiKHqb1wJCwFPWETEeAl2aF1oAt9knBh3vkK+g=;
        b=eCwK+eRf0Z7p6fzbqmjf8pZffEqsEQOzpgDsnZAPJuG9PPhnzil1JkReC5yblhLuOV
         ZygNNFJHAcTNPCsQEs91Ih1zYJR7G/ArqoeE+iPfLnB59Ja5EOxLtL/If5RYRdzGrC+O
         N9gLCuDj+raq+QhWc5ifqaaIaNLS2xXCWJVAA7sgOM0rxMdLCHM9qJ3ELBpz7dOXSGAy
         egRwB3c8IFWhS+iZv3OCmE+tU2idNu1BCa22D+2GuRZ3JlgPK1zI8QciD7P5+5Yb17Jk
         TEInSLrqzTd38dbUCCiAb8om47M4ckC/3MaZ1MQgQCO/2PEVaXvQLnocUbms0rNXqjke
         cnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771825886; x=1772430686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IVPvbiKHqb1wJCwFPWETEeAl2aF1oAt9knBh3vkK+g=;
        b=UVY9UoSn13q/skW7ZsXUWE9+MIkG1OZ+VrVZbRssSXnxZ4g6ESPOJ0gATpRcQXV3Qr
         CN/UGS0VaVqRXOwD/d4OLYTulXauV1r+T+XMyAietqdiRccIIE6dBlq5VOGusaPD2xkF
         sFPP7rfkgAQ15iQvpTQgYowXJktIjnYuibd4eMQ2ED8ROVMmcOy3hdcUZ4JIUH7HZreO
         qOMXtfEitfg8askZfquZU9PBgSEVmCPxly+zK/azRI8GEXc6bpbPrp4iSBKfNesvXGBQ
         upBQ1jKhCZy/wHXgElhbLTOrtpfoaF8F348XnCJsMnTtTGeVulV1ycbNwD1pAj6lPBo3
         7E4w==
X-Forwarded-Encrypted: i=1; AJvYcCUczuhG5/Mxxx+c538VPj+HJNd0wrYN1XysGtWF2Qet3t74mindAw1fFiKb/Y/m69wgSzMd9d7ssIJu@vger.kernel.org
X-Gm-Message-State: AOJu0YxTlKbYZ2M73X17bHr9qmVPdNevz0tb60MSW9P7cuDo4UFCFSfY
	cK4ykMgQtTgArN8MopITTrgsf2q0wB9Dsf5Bs/8bEiVnjxfVnByk2Ka/
X-Gm-Gg: AZuq6aJigkLrx4FmunFJGWxXWBDKOoke+jv3404Yma6RlTS7y8j9MIhL/mQYcF7FuwY
	bUv2yT6sitwpdCuIyoMo9Xn4ARYH/24RZK0pelJ/IiNIRX7qCHc2E9CGwKT8h4VlZjejAUtMKY4
	0SDrbMFALkOpBVhuUSZQyUjKuKSyxfyocidOmHNCh+TnIFIktGRsDYaIj5WM5fSSQ9qPIUR6EAt
	+UfjeJuAOAPSHd0k8hnweyNj4ORcp9eM59qzFKrHUAgKvMDXs2HQOMBzvhMSttJ01Hanst61jGn
	6Gx25/aUyQCRg6mVLBno0dnHzTI5KOuwg589O6Iv2iaty3d5waG8Dsey7RnTSIGtgIrpaVyOL9Y
	v0zQIJkGEAQN1SAObpMW3Z3O8yMPfKA40/LpIKPsEh/pIcyMkmFd84TtvqbRGs6Ju8vpxJSZ0Pv
	jiEBe6NMDenNgfxaiE8PeFxfPE18eaXsg2AIvgsd8qJ/SQ8wN+xfeJvUt59sm3lgZBS82BHhjOH
	Lq41tbKwxA=
X-Received: by 2002:a05:6214:767:b0:888:3d1e:f95 with SMTP id 6a1803df08f44-89979d382damr116207246d6.32.1771825886251;
        Sun, 22 Feb 2026 21:51:26 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm59459096d6.36.2026.02.22.21.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 21:51:25 -0800 (PST)
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
Subject: [PATCH v7 4/8] dt-bindings: display: panel-lvds: Add compatibles for Samsung LTN070NL01 and LTN101AL03 panels
Date: Mon, 23 Feb 2026 00:51:09 -0500
Message-ID: <20260223055113.1288-5-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223055113.1288-1-bavishimithil@gmail.com>
References: <20260223055113.1288-1-bavishimithil@gmail.com>
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

