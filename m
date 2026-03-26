Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F83386C3D
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515756; cv=none; b=AUFeA1B333XRApHGHTDFvDJtjy0eLjFKUe4dJoUau1yCF74AAZMF7i06WUJguEn+7WKBhJF0an2HE1deAjR0CrDd4iLB+E1dMPKxk5Gi5oGqp2k+zlFAVWCwfQ/QzK7mDwKTpzcACd/mJAefeD+R63uWbNOIqZsS3veXTYujxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515756; c=relaxed/simple;
	bh=co3E8YYuCGAMynSlF1x77qEAi6/uMlzl2DbnqJh8R/E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TRV8oEt+ZlYZnf75+yvSrX7Jkw1VwwmN2DfWZuw3YnyoFd6K2opBPjqJ1/vuxgHnqMR3TmBcFt1qdwpgmG5UHJaGJGs2vQC2jGs10BJsG8g85HTg/u6hE/70ifHtQ/X+QmVv7ko+fYKH5IrLuVuEW8fojZ7MSj6qN1zBK1lMXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Db0avO0s; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Db0avO0s"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b6d9c981so395118f8f.1
        for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774515754; x=1775120554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aR0wLsPR0VESQO9syCcKz5Tsz9cbRLvy3YYlrOhT3Q=;
        b=Db0avO0sOzBnfhB7ZtQ3pVpbqbhgybES0uueMNVDvlN77RdaCwxNhj01Gct+NAlw/E
         7MRgs+jyJz2LZ86oj/rNyXpPgH8w2//WtiW8tUmmEvgi6Oyc12qDZvpGXbHAKVwJS7Dv
         BdG3h5q398xQY3VCSXXs9dFUeRxv6bwfBwagGAoRvsRJsPQC0voLnHUB8F5f7fEiICfM
         0/ojmVjr+wyQeL1XY9KBwEcCwG07wVzGNZq4I5Jwt04ovygmGqvvU6Dke2/59qy62XQF
         EhhGGqGHbWQtZApZofW12isrwbemXkVdpdJ7WdWoe8WgzMGDNkuvqdt8pkOimuGKRtG8
         +68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515754; x=1775120554;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9aR0wLsPR0VESQO9syCcKz5Tsz9cbRLvy3YYlrOhT3Q=;
        b=PHKIfCWd2b+TuRe3/fE+WsDb8gyaqmlYK3t2/7ga8LBpZdyNxqAI3Zu8iIXSLM/h6U
         VvzFuCChi6Qx8WJBXV7Jc2ISyTyd0ZUrw5Xclp9PQne7284lWUpU45s4D5kRAliWc4+Q
         iIveZufU5wq4hl8hk8fupBCSpR2sBF2hp178v7vL+/hXbgsc7mJz2hBzIxPlsCQw7PFQ
         3YGw8n+DbNMaIqMnjQmpqUqQ0ADFgOwMjo6sNrao0faKVus6y6aWPbCBZTweWbHhqylZ
         fIJLGrIqAXoIrOI41+K1VU18Ex6BgOTAF4LOm2Xyl1d9uQvzbe9vtn9Qcgmly+ma4NRL
         0uqg==
X-Forwarded-Encrypted: i=1; AJvYcCWrGNpwwjpPyBg0XgOqwgaq1ty/uFyV3eFTqLWKMjtRiZWFDcY3boczTcl0oIM5O5sL/+/5MMehhROI@vger.kernel.org
X-Gm-Message-State: AOJu0YxucCaY1uC8zjHLphz1XP8KuITOtlyl+b8Nj8eOBPDAUWHKlgms
	MctW308FvcQ1/H/N1yTZACKboimxSWoaNjtHBgiaq0UR7Y9HQ+Rmw5lL3fCmJ0jLpk4=
X-Gm-Gg: ATEYQzzAiMprDXmNQZjNHzZ0X/6Yev1ssCwxgkFA4jaz6dcULBTdOocgKqwSqbV+W/g
	moG/XmMJgRnfrSdvlOwAG7DxqjvtESsoywiTreFCMSesn5sy3ibL+VEO2c6/RuGozk4BeXIcyTx
	SXX3ytT2V/DHNSAySWRgUbrzZgmm6d6zGsQur1HAK3SfDZr1kFc+TmhTZtM83L3Ib0MbsE0/gxk
	5izC1V3tSJEXUZ5YFmgNblD1uNol+yJ2jROu2BTf5ABl7+miBzfgy96/mq84r1b1PPTtFvQDG9y
	b+u+dnnLuS8uI5Xu4rgLoaKG1wWN0bC/DmZILb+N14cmQNYu5CTYe+bXjfVtLr/8yEVA2+0imFo
	kud/Im1lTdTO84sUz0glJTSZDiXY21HUiTm1H+fWmQOOTiuBVg369SDWJHb1tQzan8kMEdJ+ETG
	JkUVEB8v3ZC5ZMIHmVVgNuUrqWaQv8RdstLZ9rkB/UMvJ2b22IZhoI7f8=
X-Received: by 2002:a05:6000:240d:b0:43b:94bf:6400 with SMTP id ffacd0b85a97d-43b97a35be6mr1360876f8f.24.1774515753519;
        Thu, 26 Mar 2026 02:02:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 02:02:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: aaro.koskinen@iki.fi, airlied@gmail.com, andreas@kemnade.info, 
 conor+dt@kernel.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
 khilman@baylibre.com, krzk+dt@kernel.org, laurent.pinchart@ideasonboard.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 prabhakar.mahadev-lad.rj@bp.renesas.com, jesszhan0024@gmail.com, 
 rfoss@kernel.org, robh@kernel.org, rogerq@kernel.org, simona@ffwll.ch, 
 thierry.reding@gmail.com, tony@atomide.com, tzimmermann@suse.de, 
 andrzej.hajda@intel.com, Mithil Bavishi <bavishimithil@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20260223134941.427-1-bavishimithil@gmail.com>
References: <20260223134941.427-1-bavishimithil@gmail.com>
Subject: Re: (subset) 
Message-Id: <177451575250.103892.15582882531965177075.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:32 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Mon, 23 Feb 2026 08:49:32 -0500, Mithil Bavishi wrote:
> Subject: [PATCH v7 0/8] Initial support for Samsung Galaxy Tab 2 series
> 
> This series adds initial support for the Samsung Galaxy Tab 2
> (samsung-espresso7/10) series of devices. It adds support for 6 variants
> (P3100, P3110, P3113, P5100, P5110, P5113). Downstream categorised them
> based on 3G and WiFi, but since they use different panel, touch
> controllers, batteries, I decided to categorise them based on screen
> size as espresso7 and espresso10.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[2/8] dt-bindings: vendor-prefixes: Add Doestek
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e1f4ecd21f04f766f2cad5cca806147f47553d2f
[3/8] dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0c74f4e8d7592122c9e2c7b6f0bbdd8fd51b7fb3

-- 
Neil

