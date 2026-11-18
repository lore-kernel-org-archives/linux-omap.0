Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024357;
	b=ckHHgtVCVhD0c9DCpxfgn1vVHcry41o/uEP8T1NaS7pUmMMVYPbLZCbBfIMTSzKPOrtg
	 ARgVaMTIkHchxeRhg2lGFsG63zEuONkQHE7HTJ2JegVU1f+igEmnQ0LG37MiY+RWhXl0d
	 PCHWcngFuvQZi6o9wzf+V35tZkGF8otYI3fGwE+QfbojdTlZo+lOmthjUIHYbjvrt0zs2
	 rHYy6W13O4G9WbG0Q3SdMGyTg5Cy20h9QTsmih5rfmNhpc+aftWh74pmbkNB0BUnYAqGi
	 W4+pMFrD0+tRuZCbw91T/PayN82GxOkLnCW1/tLUAPZVuAi3Liomn0Fgcd8FwdNNViA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=J1EgIiRCEtP6NYZ369e0XcxgqURhJXdoMTx5P1xUi3k=;
	b=qV9mWbPxIwcbzI4U2blouTRGHZOVwS8a/9C19uWTPUjGWPifeaw0l74uniBdR8Q1RK+y
	 ucbI7fO2tYUvcLucdK+hkUntz1pCImNtyiUeQ/VzBA57Vua0PgRG5x0PgvceKuAfYJ5XY
	 d6BD8Oq6/yu+QWaCbvl2kauaa5v8z4laoD+fTwCv0If800MymFnKSk9pKoYZRX0J1YrSN
	 RHNRIzRNmxGf9Y04i9rvVdHHVWqnpXh+cUIgKJSdzOiF+J6smmG3JYWttMeFGnKedlmAT
	 xdlrCqASZyq6EP6SdpMPq00zggGhtB14ueSuORB3YN0dAtAGq6aezaiHq/F5gvzkRyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cc8LAkjM;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCB60A2615
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 17:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75FCB60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cc8LAkjM
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so11928566b.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 09:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795024355; x=1795629155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J1EgIiRCEtP6NYZ369e0XcxgqURhJXdoMTx5P1xUi3k=;
        b=Cc8LAkjMroplpmfBGNtBTjGU8gxzxa+oFKM98WC1fpw512casTpWmHdMF6Po4wNxXr
         sVs8tryCxZU+VuMfUI0A5OXL3scf3Mr2JQPZL1cOrVQhHa160+Xy1VYLkc0srEIIxFhW
         gAPE5DKyFEUw46sWIL/Jw8fFeL+rf9Z9t+k2TVX5vIcnPRci9MbNUrLgT+B0ByJO4C5E
         ZruLuZg1/YqLSqEJWxF8UPxJWhC2dEb08pgzPHfSaMjMBDY8+HE4m4qUdimCba2PlWm8
         Vyy12n1aWQ00kUltM9GVmOF9ILY/q+LXR8A4nUnJAQ2cIzPPc58eEx+BNc29ztOS6LDM
         C94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795024355; x=1795629155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J1EgIiRCEtP6NYZ369e0XcxgqURhJXdoMTx5P1xUi3k=;
        b=fp6HZ2toZXJoQQnuiL9ugDcvynx38vFK+h2ucb86XVpchT6/qO0DLsDeKDuZTnfDiE
         FA3urL9n5SIq0+ttGfgd/Dzj3JlB37cpc5qjrTYqLrCFtqLnsKW/utwLYP0z6AgtBH6i
         vgXWpsHGqlVaSIms8LZdoAXYiYOXZE43fbI1V+qfxwq+ebUeE+EChkjv3N2F6pdkHnGo
         3bKu9EnO/QJhI3g+A6dSCuURJpj4yfx7MXwoXifXNY8FOoJsm8S49c14v768EKN40mG+
         75SYYERXLsqJjemEttGH/6DUxA6o2/B5a2PpvXiE2MoSr4OjzavnPrOmM/xGD/4hJdSB
         OGKg==
X-Forwarded-Encrypted: i=1; AL+hErHOxiROs9t3D/KYNZmciWrVjcKZdO0tF/0Ng8bsYE/qx+fo64BKpQuQYnnq5ouhvXiEWIn4RMgkBb6M@vger.kernel.org
X-Gm-Message-State: APuU4Z9puK5e7ieqxGgC5y1Dq7jNS9SI7Zb3fCPkDj7QRo/w0qWUWuKV
	du9Tz42swCRt6n3uNJN9qgxNG1ERtD3Ri23l/PAVXnFgvMh81IwxnhXN9t45N2ee
X-Gm-Gg: AYBFou3Z3D4ye5eOwnGLWlAzWIk4LC6i5MtXiiHbNjoanXItN49DTOPNn1K15lNyqv5
	35XjZOFGLSAEn4Mz90/YVdrfL+d0rql0et2QTdakh9neCXKrcvmc1waNDnbBnENzZAh/2nr/eyy
	7PSZA0rjlzB7QiVed2GkJl6glKj+0NaPj7EvMEHnRwzFASLbzQ46Y78ErtiAySQRJwRVQti35Li
	UIAyuZIQTz94ALW6AJTVkzZ2qDr2aDhAaZPR2Ii8rIT0rYCTz2uvy97mtL5xUfV1SsvrZZQ0hbF
	9qTf6YJACRdghbqfl2Yut3a7Fpsus1hj3LREA7OVI9rPXav/4WRM25pduE77GvV+27VS6pR7/ku
	IjR+haok46JOXIM4Ln6/oA/X9l6VOwpRS6G0VKTyZNU9MEiCADk/PazZ+ivXFISNQUtV5aj2Adg
	l0i9JH4xKIzE3SSo/GK2lTjDlIJZRvnZULQm7KpM5m0c7+5DBQpryWcB20kvnFeaov7TAKb3r5N
	UrSwa3/6MgBpIoreHRmXkWwpyj9wTsGru/POLFJmZZMjmO/S8zTxYKii1v7hkguWuAxCWeAxFri
	Iso7O8e6tKfGD+FF7TR49CU/g7uTNzHeBCfwjqAhwxeii73rzFSzvhwGyu8RUN79nJoz2zU8pME
	gV7O8BG0ZWZc=
X-Received: by 2002:a17:907:944c:b0:c46:9745:ac13 with SMTP id a640c23a62f3a-c5126667928mr17799166b.32.1795024355531;
        Wed, 18 Nov 2026 09:52:35 -0800 (PST)
Received: from fedora.tux.internal (85.191.71.118.dynamic.dhcp.aura-net.dk. [85.191.71.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889c22d85sm1379135a12.15.2026.11.18.09.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 09:52:35 -0800 (PST)
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
Subject: [PATCH v2 3/3] MAINTAINERS: add entry for Kamstrup boards
Date: Wed, 18 Nov 2026 18:52:09 +0100
Message-ID: <20261118175209.20829-3-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118175209.20829-1-bruno.thomsen@gmail.com>
References: <20261118175209.20829-1-bruno.thomsen@gmail.com>
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

Add an entry covering the Kamstrup i.MX7D and AM335x board families.

These boards are used in long-lived products that are upgraded to
new kernel versions regularly, so keep the device trees maintained.

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
New patch in v2:
- Add a MAINTAINERS entry for the Kamstrup boards.
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d738990161bd..c6ec5b2d20f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14357,6 +14357,12 @@ S:	Maintained
 F:	Documentation/hwmon/k8temp.rst
 F:	drivers/hwmon/k8temp.c
 
+KAMSTRUP BOARD SUPPORT
+M:	Bruno Thomsen <bruno.thomsen@gmail.com>
+S:	Maintained
+F:	arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator*.dts*
+F:	arch/arm/boot/dts/ti/omap/am335x-emperor*.dts*
+
 KANDOU KB9002 PCIE RETIMER HWMON DRIVER
 M:	Andy Chung <andy.chung@amd.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.53.0

