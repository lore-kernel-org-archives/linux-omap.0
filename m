Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC98366541
	for <linux-omap@vger.kernel.org>; Sun,  5 Jul 2026 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238325; cv=none; b=KhG9vIj9DllbUL0hd2jmmnocu1N/03lJce4NUzqXR9DpLx87gQQUcUPP+ZYdIMJ8amfE368OwE32fWDVpag3h6WttDTMSyLkllFuw2Zu8l/DpRQZGeNBDOYDRbRNkEZ8aAqZoHGXM8F0JM+tyvXX9CaBOQWlnx7tpxUtBAkB0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238325; c=relaxed/simple;
	bh=k1rvSiyDPCpk0SDwFUE32ypMUm2i7I+6V8cUG5dyG3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RuzLk2AYRqjZ7ynbai4OsQn7QevFItEZn+UKDiWEoj0tjaeq5N57XedNHmyA9cU1XghmO3CFU+6ZzGkptCRgSnDo/mb5URxPzLzwIiWLh8bnfGdEkrE27L0acuSdv0RqrXqQe0kh6y8+jkULQzXX3gui0UiFUOieKLI8ueaQcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuVB5TV8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuVB5TV8"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b691cb44so12389805e9.0
        for <linux-omap@vger.kernel.org>; Sun, 05 Jul 2026 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783238322; x=1783843122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii5elS5NgLsQv2qqwGxrcHkoRbkINQLFmPJvl9kn5Xg=;
        b=LuVB5TV8fVpFw5WFm+ZdxERq8bLRePrlkjCOJ07Sg1y45dbOhoUJEA43uaAyYgQgMg
         XaeEkBFD3REg7Bj6JhbbChzIxNTHQDsPyxLZyEAAeFD6rMy1DprsB7YQdfpklPObqtvf
         6XPz4vzgo+s0dXZOYv5/ULBEPk21fqVcajF9Gl/n9meW1GvWyXW88F+zY14cay/DGNXj
         y5MHASMEhqjxE2fDwcqVADtFih1aKIl733wBBSJ09+7j6RTNnEI+fYIwazX9YH2nDf9O
         HxnXoupDOO+Zg0uPleO3qt7RSy/HcvKs9F2wdx+pVMcuOiqRYCU+geSnW9MYTC/AM5aa
         95YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238322; x=1783843122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ii5elS5NgLsQv2qqwGxrcHkoRbkINQLFmPJvl9kn5Xg=;
        b=DxIneempN9qZcvI32SgbEetEi8Nl8dyZRTl8hvUUe1bU7rNHuqvFLDTi0IFDArWhEG
         lOH3EoUbpmIx+nzSjXVUI5CrFXumOxz+uV5ArhZ5r9mg4WwVqFmwltDfg3ABA3uOupG9
         ubXh6AjFTQs/wBaJqowLQDU5u1YAY2bZvOjmpSPVHuWImbJ3fEtdYCgYbt3X6+wtO/3I
         p3kYxVXUlkXMc3FFM3XukRbndth3rwl8JugOQ6huAbFfdPErgSafbK6Bv8sEpUokbjwc
         N9OK0qQwYpniPX8MWjVt40K5UKjzA2mTXF1ia2+/T2lPX2+wOwoNbGtAPvb830+2kouP
         J4aA==
X-Forwarded-Encrypted: i=1; AFNElJ+9FxDuu5Teu7sbxLHVzfbkx9pgT8CKPp/rfZe6UnRQYjtdW2zyspsrroHEb5i07PID4uULulS8Jlzo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6c9l6xEiNthveXI0S/CGNvUaM493iBR75IZ1QD+AStOcVoqm3
	Wmi4zUWKj1GhY5a6RYRY0wveUo10D6uxWBk/HE6GDQU5GQwDZX/PBZHc
X-Gm-Gg: AfdE7ckc4yGgvSiXVy//AS1NmGIlf4fHh/gDDKpLh9F/FTo7ezgYvWrSpsgj7HdpeaY
	RTLVbhuWxNvCiV0b+8AAsLARhFc1qTJyqO6QN+0Y4HVu0VnqKBOpS896afm8qC9mO8ra9SBeHVF
	PFV4JzJbpcNu0p8uR+X079THvQV5BHta35bnHw1qTK/iFwGfF9hxZYXlolDinUQGGyeq++ky0ge
	Uqp4hcDLBV+Yoz0W4DIsalZ21Rk1fMwmnES4opwgrlU1BSsgPwzUqf7Sf2GsX4Tegpl8ikHswA7
	WWWa5IrA9S1HNOksC0kotjs9Tj4mQ6u9dUDVbXSYz+69RtGpklRgLqx5kZcn6ylupM/OnSUEJKb
	y547wwDlgFkdpu+6zC8mqFPoFNCVtYmJH469CvmQ/eQ7HnsmpHDW6qmKjVNpnQEvYXy4QZusU4H
	LlBVbVCzVCI/fZxstnAc5G3aT5dNTGJzy4vA==
X-Received: by 2002:a05:600c:474f:b0:492:4a70:faaa with SMTP id 5b1f17b1804b1-493d11db16emr58211645e9.11.1783238322443;
        Sun, 05 Jul 2026 00:58:42 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm305769765e9.15.2026.07.05.00.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 00:58:40 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v2 2/5] dt-bindings: phy: motorola,cpcap-usb: add chrg_det interrupt
Date: Sun,  5 Jul 2026 10:58:06 +0300
Message-Id: <20260705075809.1793784-3-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260705075809.1793784-1-ivo.g.dimitrov.75@gmail.com>
References: <20260705075809.1793784-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPCAP USB PHY driver uses the CPCAP charger detection interrupt
for DCP detection.

Update the binding and example DTS to use the corresponding
"chrg_det" interrupt name.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 .../devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml     | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
index 0febd04a61f4..1a202cd29724 100644
--- a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
@@ -28,6 +28,7 @@ properties:
       - description: sessvld interrupt
       - description: sessend interrupt
       - description: se1 interrupt
+      - description: charger detection interrupt
       - description: dm interrupt
       - description: dp interrupt
 
@@ -41,6 +42,7 @@ properties:
       - const: sessvld
       - const: sessend
       - const: se1
+      - const: chrg_det
       - const: dm
       - const: dp
 
@@ -91,10 +93,10 @@ examples:
         interrupts-extended = <
             &cpcap 15 0 &cpcap 14 0 &cpcap 28 0 &cpcap 19 0
             &cpcap 18 0 &cpcap 17 0 &cpcap 16 0 &cpcap 49 0
-            &cpcap 48 1
+            &cpcap 48 1 &cpcap 13 0
         >;
         interrupt-names = "id_ground", "id_float", "se0conn", "vbusvld",
-                          "sessvld", "sessend", "se1", "dm", "dp";
+                          "sessvld", "sessend", "se1", "dm", "dp", "chrg_det";
         io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
         io-channel-names = "vbus", "id";
         vusb-supply = <&vusb>;
-- 
2.39.5

