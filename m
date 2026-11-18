Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024346;
	b=riXWOUW6t85XoabIpnG2Vrk1w3kCyL59XNUwE1wwwS7YwNH0XnQUfzg9jiYIvS+YuASh
	 Sc65PgpwTB/p+YaEVRTPNyNGKTmKlrXn22pzxWcIhGgx3Joc8E5IYW2wigNKo5ugZoyCO
	 /GCuexZHQCTCnK/Dh6iIxr09YJMvS34CPGRlPPlo1hcicOl2YkY/wG3vLlRnu5ovu+TkG
	 8bknk9ZXQ4KTxH90rknSbsqzDB6hWWKOYX7IhV3Bf4Ch4AUuFEC5p0vPKEEGZgKxLzlrO
	 v1TqbL65zFDeb87WaqO279xI9hWR8eHfAoPCkOxi5IbNV5mDk0xhGszpth42rjZXtOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X0if/5nxidDNKKWNHe2Z86K6FYIe8m/iIqUwPTqkLfk=;
	b=l6L64mbuwYaUJKH81baFtrScSvIpbIrYyyPnEy2DQU+nMMjKPnZDQvfoMFMnbuNCnE+6
	 cRuGxgPulkZRkDsIzGxUsPA9HA8nqA39UXhgqlh2h7Qpmjf2+pHXgoYnHWWk42+OyL1MT
	 /VVluGV/xuSqRvuy+WlndNCxcRuYVkknyFYGYE/9RpQYVZbOR8NAln9Y5oBytXxysDe83
	 Q0Dhj5bbkAIHXkizNlbNRCIv4GOZM5gL9EHmUqFScS7LZY5rDM21JZBC/qSFdJqJz6LZb
	 DHuvxSqXNF5ul5LQqVYzq1ZlUgqL0yegftR7CTYdzShubguIxCJBNB7tyZ+CGysmSyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVv2Q0Wz;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97CB60A2602
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 17:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E97CB60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVv2Q0Wz
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so708446a12.3
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 09:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795024344; x=1795629144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X0if/5nxidDNKKWNHe2Z86K6FYIe8m/iIqUwPTqkLfk=;
        b=VVv2Q0WzHSXNrPNLeRZRZEcxrLziXD2PF6eAJSXsf4n/h1oXYo728ZNJjmTcqYxP/q
         a1ioOho7NWHfRh3rQeQunSRkznDt5U2QJ1fPCwjjWuM4eQX1E+39//B+bXOrSeyBeep4
         bXtJSLe6nLtaND9XVCGfTvyFH7L0MxM6cYK7VOXozgfJt1Iba/Ogsp38ah79wQ/ylWiH
         M85KbW3StC3I+NwmSFkC1RjdOEQagJgL2AzadPBoH2dzP1AcFypUE+E0QZd9cs4f97HW
         UpMgvKFPGkKDZcblqLEmEry9xNUu3ILkgLpgHch+WHLQ400VaoZ1fLjz9IcCeVnwVt2K
         rVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795024344; x=1795629144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0if/5nxidDNKKWNHe2Z86K6FYIe8m/iIqUwPTqkLfk=;
        b=AZUJ4XotB3cSImrBTo2CV4HDbRnDjYQWxVSGW7FkOrbXSlDLF8P6N5YIRCY5mnCyzi
         mTBALBpcY6lueBSb6cK/elUUrAbqSNAstqc0ST2u793oNYkEi9Kfl3Qnkns9ZsmP1I36
         BGxekBY5V8YW95YoYzM2EeGesw9DSgLZfgWSG5d19LxtWJ33vVtlfr65AmdmpJX0VPKz
         p9mCW832GalaD/sXhpHqA8Y7TqPco6FruqAg63SsaWlcmixm3T78b7RNTnh2kpFdxuec
         XtWC4LDPcDHPwXVEfQwrRz+L6ktYNRI6WHVuBThDF0+QKthb5uZjP03rccAl/ORg4iJD
         xKSw==
X-Forwarded-Encrypted: i=1; AL+hErHc8EUODnUsH2/M8LJIcDEI8CAExel9SA3X/2EqTWUZct/eyazNXaRCTn04reJmLxVFjvaj96vDjxvt@vger.kernel.org
X-Gm-Message-State: APuU4Z+gZjriCFeC8s53zb0tsTzVVkZo2wBnCO1XJSUVQ2uWOqtEe937
	ooEMXijrQEo1ylHnkVXj6n2DmD8qB28hTwu0lHyDruquKprHUfgIiZ/p
X-Gm-Gg: AYBFou3d8WYXTJVkTrosXyHG7RUGwjX8lsuHiEUGkr/PzUOg4N3e3tV2EN61oOlW9JR
	Ug0zwjb6rh/fOOzvcJFuiwKGSmTFGoqJNWhCLnao2tLn6mC5K52e9wBqSsGh24yj713+N3odAEY
	qB0QUY0in0TnsU5ZMw6BXm5ZW8M/LY2ZPNmhGzw/1BncKQ76I2PJ3Xu+JdX8RT2DejxTnpQlzET
	EnEUKE7BiQ2uBtFMVlNPWjGF8XV1Wjs6YaBJG2dOH2Bhah07USpAoUHE6n2TgJEsksruxFdUTJI
	S5AGaj8j9utWcHwfF8C8bwphvCdjPM1d7IXrnm/SeV1u/BECDtZVV+Ka1+F0RXwpgYeBZBPetvz
	Jf53Bqp+DfYuKBoCg0n9C8Lp5QZsO7uWQIXEOuqj7rYjwhaaE4/99Vly6cvuT+ib+LB+NYaeI82
	gik2anHjp7i+BID4yOe1B3qrtT2sIf5BOR2dDjaih/lXjF3jFRIxmFtQ+u4gMyKOsGY35DopfBL
	Xv0gHgbvXiPrUdpmoHzJuX04eIqx/RFUWNPKIuDVrBo9aKWRwbsTzd5xXofJIb7Svq4kpfTBn/d
	AvfySA6oKIqqYzvDXqHKM6+F6nB79mdT6hwgfH1S53e9ZaJJzr+niMn7t3zigi7Swjt/F8LWluf
	AkHCfsgFipZI=
X-Received: by 2002:a05:6402:51c8:b0:6b8:7657:24ce with SMTP id 4fb4d7f45d1cf-6b887e5559dmr2525641a12.12.1795024344129;
        Wed, 18 Nov 2026 09:52:24 -0800 (PST)
Received: from fedora.tux.internal (85.191.71.118.dynamic.dhcp.aura-net.dk. [85.191.71.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889c22d85sm1379135a12.15.2026.11.18.09.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 09:52:22 -0800 (PST)
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
	Bruno Thomsen <bruno.thomsen@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: omap: add kamstrup am335x emperor platforms
Date: Wed, 18 Nov 2026 18:52:07 +0100
Message-ID: <20261118175209.20829-1-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Document the kam,am335x-emperor and kam,am335x-emperor-mini compatible
strings.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
Changes in v2:
- Reorder the series so the binding comes before its user. (Conor)
- Add the kam,am335x-emperor-mini compatible and name the product
  behind each compatible in a trailing comment. Conor's Acked-by was
  given for kam,am335x-emperor alone, kept here since the change is
  additive.
---
 Documentation/devicetree/bindings/arm/ti/omap.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/omap.yaml b/Documentation/devicetree/bindings/arm/ti/omap.yaml
index f694dcbf2348..041776496a67 100644
--- a/Documentation/devicetree/bindings/arm/ti/omap.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/omap.yaml
@@ -105,6 +105,8 @@ properties:
         items:
           - enum:
               - compulab,cm-t335
+              - kam,am335x-emperor      # Kamstrup READy Concentrator 1M/2M/2C
+              - kam,am335x-emperor-mini # Kamstrup connectIQ IoT Gateway 500
               - moxa,uc-8100-me-t
               - novatech,am335x-lxm
               - seeed,am335x-bone-green-eco

base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.53.0

