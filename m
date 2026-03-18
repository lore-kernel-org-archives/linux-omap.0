Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6A393DF2
	for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824101; cv=none; b=e7yda28HiLei/aAMYIS2zyLZqThDHusumavI5z2eq0u1NVqj5By5VOrIYpIPWaVb8rSE7dKuQXSHy+2NrEJTMXEom9dTi0uZo2IayHHBwC9j3K+JMnctrSJ185mydV3ENBlAIHnsrsXBrw2Is1dXRMfgv/FJzN86HTT7WEkr37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824101; c=relaxed/simple;
	bh=DWqhZ8OS66vHAdfmqRWFMZNnWQN9i/viTVXUCLXce7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPP+9uP5lc9F/HxvdX3wCoM8fSD0FuzFuMudUVaQwWBwGBV+lYeRrq2s+/w6iAjlMdZV1HVUOKk4nF2qXhbJq/zuMn6POJx165CzEZQMkqY46k5ROjipr/DyAEl9QgJ0qU1y7BtCp0fWiKbKNwLXNI7BgQYktETESJ/npHYRk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZDtNW+H; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZDtNW+H"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66732a99928so2997057a12.0
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2026 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773824095; x=1774428895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4j9cjdUWxfJ3jGQMDt+azVJCkt60E4vJjjkI8IZ8fI=;
        b=KZDtNW+HC9mNeAH3FluqHPfou5B1gIVucs2g4yE2HeuNI+v/T5JZbeAozTdcdSfcZD
         dxp7mQvROivjZSgpzH9DKRJELKLjSR1pWA5en6fq2lQXR3SMRe7RDpuzHH58Ue/cnpR+
         mS5d19q5+Xz2fEHWOP5vtFT6tXeJ5Se2jbtI+rMc1LX/5K5Ugyv7CZopRlbXwT9zL7D3
         cpdEXtKhbxJqsoJ88JKnAPrGvo174tM2vPPlGfV5etUVmMfpaIWqqz7okqY+OkgC8g0Z
         WrWm0wPi1BittyNUTQ7L2md62ko7cGgvrrIj2X3MckGtFXaaeIEJPA7nZReH7nV6wpqM
         BEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773824095; x=1774428895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j4j9cjdUWxfJ3jGQMDt+azVJCkt60E4vJjjkI8IZ8fI=;
        b=O6uFumfwLF/RQdIaVtpkTFmfSHQETH5nqvIEsCnpmO5DecYUsqTUukecpt4lHJy5LB
         00ErrWvqqfxnH7viCoZTt/uNiJEzg9xOnaDwQdJl3FV9pOvc/wZlYUFBTOYkH3xmXa2z
         rdTq9LGalBNF1stcEGtAzAuUiiT1U7OZqQKBD2tcweyr7ABZvJ8DqWXZvtw6JX7wJ/7R
         Nug1ns76qYZlsSyQTn9HGNpUJL3SqeAUH25dgDr63lJdoztSB7cgitQUTnUWmX3kL6Y3
         V3gkpisWbGghex2j8PdEupZBLJSm2S9swcIQ73MQeaidY1M1MM073RFN51/KQCptiHw2
         uXug==
X-Forwarded-Encrypted: i=1; AJvYcCU7kcV4ajGv6jCAE7YSIAZFDtuL1pDf3MoFEHJ/NNBiivKyzfyNYI9aRxh7epz4aWVGkdANKrbO6DN5@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7D0/MCXK3KMhh+//U1CzltkzNjEXHelOm18926BykLQfn2MX
	OaTPD5DWq/DL4EaKpLGBZYLRqrGsQRgJvnMnqV1Z4W7S5tM08UJo5lED
X-Gm-Gg: ATEYQzwFS04BDElU/arqdWn63ft27TVTvVGLfFKd7SUSj2nqTBn6B6vUuH0namvdGPX
	Oi3u/y1px1v0Py8UJF6up7nDjbpU2adiHAUUAWIvev5Cm2Rw6FHycmyq/8bexmyrN39XMhsj9sy
	0ynVSYRNx58AukMxSiQ+w6R+urYVTyjTIODLIylGFuPbKTsX+jy0PZ2KXiC23NMlAPKoEjT3/5A
	nBZRlsUYt7sKJhE5M4XkzYcHWFmld+WFqhLGyh0IDy04y9t3GwnkaLpps3YvpGdNwxTiF28UVnM
	8Q+z5D5un/8YaZgGtkFvto3gxyaQIMhgmxbYxbh/wzWrGhcIK8ZiyD6k/i0Eeo9skrcAyq/Z/Au
	18DHBe+HZ99c+4Vo/3rF4NtfRkEGwaAnyLBzJCv4SAb/4AAowAJQJgDXWPU4L9PDygapVu+FzAI
	TSpxoBcpEp3Sd9XNk131cKUSf+Di29S+2Hbv7AwBuF4EU/W8t7QtuwzoWjePFTtoH1i/QiLUHos
	NJkwcXw
X-Received: by 2002:a17:906:30c1:b0:b8f:9bea:ad6 with SMTP id a640c23a62f3a-b97f4935695mr107418366b.18.1773824094605;
        Wed, 18 Mar 2026 01:54:54 -0700 (PDT)
Received: from fedora.tux.internal (85.191.71.118.dynamic.dhcp.aura-net.dk. [85.191.71.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9801c11fa0sm72259866b.28.2026.03.18.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 01:54:53 -0700 (PDT)
From: Bruno Thomsen <bruno.thomsen@gmail.com>
To: devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Lars Alex Pedersen <lapeddk@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Roger Quadros <rogerq@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Bruno Thomsen <bruno.thomsen@gmail.com>
Subject: [PATCH 2/2] dt-bindings: omap: add kamstrup am335x emperor platform
Date: Wed, 18 Mar 2026 09:54:20 +0100
Message-ID: <20260318085420.7680-2-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318085420.7680-1-bruno.thomsen@gmail.com>
References: <20260318085420.7680-1-bruno.thomsen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the kam,am335x-emperor compatible string.

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
 Documentation/devicetree/bindings/arm/ti/omap.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/omap.yaml b/Documentation/devicetree/bindings/arm/ti/omap.yaml
index 14f1b9d8f59d..9b1b4286f4fa 100644
--- a/Documentation/devicetree/bindings/arm/ti/omap.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/omap.yaml
@@ -105,6 +105,7 @@ properties:
         items:
           - enum:
               - compulab,cm-t335
+              - kam,am335x-emperor
               - moxa,uc-8100-me-t
               - novatech,am335x-lxm
               - seeed,am335x-bone-green-eco
-- 
2.53.0

