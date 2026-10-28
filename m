Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203589;
	b=O75rmV5vkMePJBqxpIFFEUdaDHiTyhG6x8J4oYsb7te45G1QA7e9+xC9QniGWKgHXeDi
	 le+j+ILOj1KD/iVRwHej7bYbVWOdl8aFMNru9DJqNkKUdk3HTnTX7kGsWpTtQGiEOM3hl
	 Fhlm1Ftuk9xzNKBHh4AA1hx0ISA31Gk7yvTJiM/qeIvXEzoH+FFvwP0E1m2obCAq71R1b
	 RjkRpB8xNw5xYkf/2wh8ZZsMdch3168F+yApapFih8oT2dVBi9tlCaRHW2Q3it0BYtKmn
	 l66WVB51mJKqb0IDBCDBPtQFM6wRqwM8gBCx4esipbkeiZQHAkDvcGlzyhj9WfDvLxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7rFZDp5Fkk3pXBS1B4nPunTNFGpd1zfRgzV12OlUjhY=;
	b=Q9x+OVXYBnq9Cv7NfGiIOzxa4UjhautsyxJPS5vl8mGpKhpfXUHdjMcW5Xf8xB580mnx
	 RzpWqAwC3yqdXkWngMch3SyGVGyBAKCkuQT+O1Ae+228arXxzY4anYzpwclfLCL/t0u6d
	 QQUgWg7Bf7SnTjXeYlKIKfp9xo8ct51cn19xQqKcIXdBUEFGVastF1b8kH1j/JFSzXdVd
	 sOSUb1niU4kX4jw+b41wl0ZvW58XnSdnM73CrjLzvtLzYMw9t65samWBTB5gZv31EzLKZ
	 /TT6REltjfjkDzlM714Vo9SzpvviepN/rpeJz+31WnjRqGfYATA8GIbaNxytl8nituQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LHY69A8z;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283C606B27A
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 16:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F283C606B27A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LHY69A8z
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso10612275e9.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793203587; x=1793808387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7rFZDp5Fkk3pXBS1B4nPunTNFGpd1zfRgzV12OlUjhY=;
        b=LHY69A8zem1uo86TLqWbdiIDHeomOMMuc1jlaBY5+fJbstzoHGUh7oLXUHKpkGViC5
         4oPwpRAKE8riDfYFeY/2kvk1pmf+AufiCWqnoIfEA0FpA9BasK/hHyAUXUtBFfpOWyHk
         VFzeRplRrXfDckkj9c2qUNAKIFGDDK2pJ0SZ3lezx8NOlB6HMtpgkVFfsg1dkWT6RQNe
         tH/QNlJiv5dkag717/pgo2lMex/BkNL6QTru49B/61ah6ADjMXveFsNGwl83yoAEuF1a
         3FIpnIrrvwzYJf+16JvLakvEnSCQOP3zs5hUngBPv0/7uKT4Soqk76lHcoUx8aIT4J6/
         qr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203587; x=1793808387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7rFZDp5Fkk3pXBS1B4nPunTNFGpd1zfRgzV12OlUjhY=;
        b=ecrroilZs4m7/dICgfBT7cALrtUd1B/MgcUNylA/kowJe3IQdpBgk5iSRMKbgy/yjE
         ltwIY5A9Kj0bRE9oy6Q0ZoS6DcnnoAkutscgJJc9/dBJuR4GvGun/W0x/BxC7KH+bMiC
         HLS41yfZ/TR2qYyT1U4r0xpuYGqHAi9/L4QahQJtwnR2pLKShRqVO/u/VAgdtebANJFk
         3gEKbSDBMJ/ay43QBcS28YW1JEQDP7bDajkLXfPbmVfKHqxao8YdNmqCp2ZPlO/NRbJ8
         cyjOymUjEWek2XrrZEjuqLR+Jis02oPxUyNLt5TEYVIgUj49VexDOY630ZjrkJQ2MjDw
         QZgw==
X-Gm-Message-State: AFq9FYK4N3qee002W4Pt+x8s4wkIsdF3F0AxGcz7ouGUlF2ujhd62N6T
	gPjnl6BfeCZU0egP7nwo7jJqc4sisTtXZpUO8oM82h5AeyVU5vn2Tr6kp+ibC2qN730=
X-Gm-Gg: AYBFou0RGCHR9+1tkMNRHavAezc4BMBlqXZHE+I1aMudf9+b0Mn6XQklCrz2eU+K4dN
	qwrzmYQKQ/53JDrfhml4FA3c85jRrm6BYgfaRRRj4wxxJ4q5SQpn/P1YBgt4Xiab0tb7RDF1H2I
	N+ve9slkvhXA61XKKro3oyXVH8bUAlzhURQJW5odzLCEIwbC4pgQxjJO6Q4ME5FL5CcMlC4Otov
	NjaMroXX4iWkWwZkFeAP5OSfNUUC9ch/ZxRoaAfPIBRQLaJ6KaDqGBPsJ5YgRtEDdMMTbyAD0Kb
	q+OWJ/7i8C4Zlhchz5i4AzWO6oLQNO5uyvc1mMCcpXiONZ2xd6+X4g5Mrg/G3h1sDSPjJs7MBbP
	yD/bziZqAbFJaQclsTituHMS0t0FqjDWO5m8YyO18ZxGl5LnNhiEvhtHcQZw4GwX2Zd39LZwh3Y
	2HznlDf+uf1lwzhus2U/CJhQtx4uaf1pWBfGJj2+JYjlV9VjBb4vOgCWxJAGdgqrfmaQ4DVHcjS
	CGZI6et7VdTtvx+QhzpNX1efk/z0HRUoy62Co9XnfJbiXorAD0RKWUuksjgIawDX/j02CZpE458
	7qPA30DxEORLG6YP3CDhaCSCtX8AkYhCMEHXKRKJ1BJj8uOmdxpVdWs0X4/NBpTI4Ai0FRgn1nl
	zQW0sQnJ1wIe0H2nEppjRHoj89Q==
X-Received: by 2002:a05:600c:34ca:b0:4a2:133:45e1 with SMTP id 5b1f17b1804b1-4a967202e8emr63277675e9.24.1793203587385;
        Wed, 28 Oct 2026 09:06:27 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm1625875e9.9.2026.10.28.09.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:06:27 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 17:06:04 +0100
Subject: [PATCH v2 3/9] ARM: dts: omap: dm816x: Fix pinctrl range
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-patch-ektor5-dm8168-dts-v2-3-4544429251e2@linaro.org>
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
In-Reply-To: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ettore Chimenti <ettore.chimenti@linaro.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793203582; l=1216;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=l89+KyhDD7zp4e3bcIBRXS/O0eyS2NPYdXJ3nkvpksE=;
 b=FRIsaf92TWQOagF+GOv8n6t9aT9JwhYIl1hTYOAJmhh5eb4lmXgIOUlXafuwYpqaXP0CZzzW3
 cxWCAzBrZVVAGYkE4JwhQ10VVBHHlU2jeyyfH71jwum/JRrFs++azkm
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

The range of addresses accessed for the pinctrl module needs to be
extended to take account of the fixing of the size of the pinctrl
register to be 32 bits instead of 16 bits. So in order to allow the
final pin control register the address range must end on a 32 bit
boundary, not a 16 bit one.

Fixes: 86800ffe84055 ("ARM: dts: omap: dm816x: Correct pinctrl register")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index 261ebca8863d..fc124f9ecfa1 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -90,7 +90,7 @@ scrm: scrm@48140000 {
 
 			dm816x_pinmux: pinmux@800 {
 				compatible = "pinctrl-single";
-				reg = <0x800 0x50a>;
+				reg = <0x800 0x50c>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#pinctrl-cells = <1>;

-- 
2.56.0

