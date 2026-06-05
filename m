Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766A3CEBA6
	for <linux-omap@vger.kernel.org>; Fri,  5 Jun 2026 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780693001; cv=none; b=ms+QPNSrOwPezP0p2ur2DmxKBAmett3jV5zybkCkJZvG4c4ze5Vl5PlYyrMa+9inAz3bDEQwZ5982S8dslExlOWCf8JYJ6eG8tw9H/bggD12xvPzerDuQrPeLFzN8EIlpNNiYOgac7ClmZVFhSo3sWKGmmwA6cpzeJVM261nrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780693001; c=relaxed/simple;
	bh=TAlX/MBj9t38pJGd4AC8U0jUF1uArbeoK5p0c92YSSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q6OJ0C6RZryXsfFuw7Jaes24984idE+dYi5aGEDycoJgq9pWkrcd08iPgWOrDG9Zy1IfOeA3t96tbWy4XsUu/1lCsr87K0ofmI19PaRt8trzb0im20PIM0eUAwgunKXuPLRkpvU5k/6khWuhwLDOaTqQNYt7YSczfqilX/sN3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db0o2w2D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db0o2w2D"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf1497de04so3688665ad.3
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2026 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780692999; x=1781297799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIxeKA2d6OLuIfSBHegRQdEPIVJJ3D6xA5+Qs8RncbI=;
        b=db0o2w2DHeNLGwJaVmfxYID2LEWw16+H0pgvsLuuUNcuK+rlWVOy1tF06nkX/DpP59
         THa8LY9GSOl6DaU1ZhUvd3u8az1tphgtHHBOaXTAsbTHAGhHayhAPGCdzFki7pl0f7+h
         iwkdMIEe3JU5DgyolSrhkllskek20eBBlThVKnq5LqI2LH64y2CEVFLaSoMori0dF61W
         1GgIdoiJn/pHA1EsWp5JVAWWSri+33xVXOEtf5AexB5J/D5uXXSlmsIxj7DRaNF6R5GC
         cucO6sg+92fFfnjgZCZ2mb7cbtiq8nUJ+gNQPYommOiBsFE5lt8OmgMlnBM+LK5mXmmI
         TEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780692999; x=1781297799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aIxeKA2d6OLuIfSBHegRQdEPIVJJ3D6xA5+Qs8RncbI=;
        b=q3o+m1aeqijhHTndrxjNG8Z77J/0DcJ5+6414FK4UJ9NjM43lKNEHOTSIDLLYLjGRi
         axFrkNIgVN88LjFYuU0ZsHWkta45yYRS2PF3CrEMUXiw1pHyDXymxf8ZYLjGTUzmDLO8
         W5ao22d+hNuJBq6796SN3rQrLzUyG/nJn9IkZ5jJT0zCkGe/gbPhZHZ3qgJTkDxa3hBS
         OZ7wmv7MAcBMO8fEosBzp/B2LduVRmGIYIZ3Ex2PjGKblArbNrfACykDLyxO7C+uRFTb
         Nur4HF/c9yBHjJk8Mu2SlR3ac9MKeQNN9AC5A4rQ7yKEw0CBvAcg8PrKTS2ch9iAVBRu
         Hliw==
X-Forwarded-Encrypted: i=1; AFNElJ88nlZ3jdgpeJq+XYcNRf+/lhG+H/24Gz+3bN8oGEjaxh4Ql0y6Q1yO/O5APIQbh+ombd07D4lG+MyJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxxgrctyWqK6hGe2wEIibdD7DO5rpXZdeAL9VTP2TzwWGcb8xMW
	VbBB2ZY/pzjNI9z0cVO5yucE64bJKArGz4h7UB2l6Y1xKdxoSGSMvlVO
X-Gm-Gg: Acq92OGXBliV+xWvueEzN9gq5htcduGI2kDOLRYn0wgAgTXbRZ/eYDhq3748KWhhmKD
	zqVUcQdDQsxrAdQtl3L4rBnlOo0UShjjErZs7MUG7mw4oOFDvf9JbL6SQ2Z2t+JCbKyqMd50seR
	cmAUgpyum9Gw/uxanA+9dUf44ENi83G5XDgorusVLeJ516YDGLgk/1J4iaQh11QCmJf+dE9jrHB
	wlHhcCwA9dziSfIa3LQXjdv2XWcq6B379DwgtHWio9VlTwbahtSAFMeFmzU9x+FRsOX053BB13f
	80UNW7mbA/Gb8JDlXdfimasn9soPE99o4uyCqJ398KVQO7gVNx+GIYKomXt9eDk5n61FBBQql9J
	75sVX7Wo4tzN/lUxDsbeDwKg7OVPQYLRZ5S8a5F0RtfK4+1G5nRjznb1il6aiqKxwwuS3r3Tgqx
	hPdbRhuGmJpIc2G/GevodqPhLBsIwNclHk7ngLxXy2jQ==
X-Received: by 2002:a17:90b:53c7:b0:36b:9c6d:b60b with SMTP id 98e67ed59e1d1-370ebef967bmr2679800a91.0.1780692999211;
        Fri, 05 Jun 2026 13:56:39 -0700 (PDT)
Received: from [192.168.1.3] ([2401:4900:881c:baba:b3d5:d6d:608b:987f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3712fcb2607sm2197036a91.0.2026.06.05.13.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:56:38 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Sat, 06 Jun 2026 02:26:12 +0530
Subject: [PATCH 3/3] ARM: dts: omap: dra7: Use new property name
 ti,crossbar-irqs-reserved
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-crossbar-v1-3-f67f7cb9ee50@gmail.com>
References: <20260606-crossbar-v1-0-f67f7cb9ee50@gmail.com>
In-Reply-To: <20260606-crossbar-v1-0-f67f7cb9ee50@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Sricharan R <r.sricharan@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
 daniel.baluta@gmail.com, simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780692975; l=982;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=TAlX/MBj9t38pJGd4AC8U0jUF1uArbeoK5p0c92YSSU=;
 b=xRBSV+NoD4DR5C5gkumtbkwnLNDvsIJyxmZUieht1Fedlt3KjTOz2Yo9d1RpZCU/aQ5yyTDZJ
 49SBeen4Ej+DqESpaPWR2BrOOohvXKTqLZGWhXVYNSZe4+wpy849Q4u
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Property name for irq-crossbar 'ti,irqs-reserved' is updated to
'ti,crossbar-irqs-reserved' by new binding conversion.

Update the crossbar node in dra7.dtsi to use the new property name.
since driver accepts both new and old name this is non-functional
change.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
index 711ce4c31bb1..80bee3db3a53 100644
--- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
@@ -866,7 +866,7 @@ crossbar_mpu: crossbar@4a002a48 {
 			ti,max-irqs = <160>;
 			ti,max-crossbar-sources = <MAX_SOURCES>;
 			ti,reg-size = <2>;
-			ti,irqs-reserved = <0 1 2 3 5 6 131 132>;
+			ti,crossbar-irqs-reserved = <0 1 2 3 5 6 131 132>;
 			ti,irqs-skip = <10 133 139 140>;
 			ti,irqs-safe-map = <0>;
 		};

-- 
2.54.0

