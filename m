Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340370;
	b=tMxM5wILMxrk/Sx8wplNfkW2lXt97UT+Fxy7vWDec6uBRKNDyTtZjgWMW2uG1sDlD60l
	 5dmrXMa7FWlMRFKWDFCxCOReoVpuWjEw6Gu2I/zWR4XIlMqKZpLqv6SByzLdPnPE7ScBw
	 psJwayOZR3w1A3HMJr60EB+WMsXGNFyOdF3Hn4dTmhh+f7TXOWmGOensoSIqDwQ7T2H+k
	 cXQaSp6nDzN3qYEfyKVAYRI+ddfRhsD/sWcJvLpUOrnysh6MSocphuhOuls6EZ0I2LGa2
	 I0W+jsjsnsmbgBNWQE6NlljPUYlpaM36F/LCLsBf5XTh5bz5191VoUo6vUZApOiLbsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WV1W9nBfS3ldLXeMMEvma4A9q4C8mtYJggnjjv7e4es=;
	b=pOm4/qAA6ah51sICQVjplWF1vUePQ+lMPwUguD4NwSJXmtHfvELcfj3q5wIPMZA6Cvci
	 x2dBp9p/SSZoudUhCpaIi5QCbFz8WIAc04/yaD1S8rwn2a8F1zSw2MJmxpov2R+yJo1iI
	 5BpFCTMgdlI7+OU3T3GCLUQfQMrMcH5n0GhUiwFzL18DRonCSP7Q3A+9fGEf57/4abDlm
	 x/Y3WgVSIql0MgNZ/g9Y65UciqAQ+7bA0PqnZcdkX/3aMjOijkb3gXTdZ1+8FfbRiAeUw
	 NTErJwSTyc3HN+28s5oU16KABR7LiJaG2DNqICJw7KoN8NORV8unUzzGsKvXcpUdNew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lUH0io+d;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B43606A32D
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 19:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B43606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lUH0io+d
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36e90071735so409700eec.0
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 11:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794340369; x=1794945169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WV1W9nBfS3ldLXeMMEvma4A9q4C8mtYJggnjjv7e4es=;
        b=lUH0io+dIJkjL80OHBeuKDzqchC7AbmDLhSqgQ24PZTwwBvZVSDljr1Gk6w6sBlv+r
         z6E8eBSxdKpeSmSe4zz7QT2ba4CEHDv3Ew6q2+E5CW9BxmI8i28cGvkvFu2eSX0uEGiR
         K9bWyrgI/pnEFPGB+ziuvA4CEI3YGKfG6JhJRlXHRZ+hPNmaLMEmBHfEZqRlcw6gSM+R
         Ygiw7gYN9hg6VLk03KzzaB0HYc/PAliPad4kJNPBu5Sdjwyq1j68bTAcA20pnVD4gzFX
         0vHGphWMEw5Opw7ZrvS7q4DfabU5TDDyiiZ7jRbVo3PJE21w2gtn/EYfKg8okA8xdyUx
         zzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794340369; x=1794945169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WV1W9nBfS3ldLXeMMEvma4A9q4C8mtYJggnjjv7e4es=;
        b=TNudTtJuF5ysGcM3jvxzW3hYS8Ao3T9fkN4D+45PANoLvC9VsmCQ6vBv+6tPWd6x+Z
         LrSw/a1Y72oPiKrwQWsGp1EEi79yZTAYXkujbQXmfO08iqv3DTqtO/BavyVLbU0Ea79R
         FVkTV2gF2BG8ioajWMSVsBB+V2x1w7u8Y/nPCyz2k1WZaKiNO6b9SEn+vAsEjHTCWBRQ
         FJ7VR9ctOWCSGyMqKF30N2tDcuERmu8RPpaKa44udR4oEBkQ2Jnx2zdb1myxknNOzb0l
         ny67Fp3/amtqYcDtcxhr2aDPm0bFOli9TzZqwnDhps5tWRQwPYI/uKqp9DbnL0zNnAmS
         Po7A==
X-Forwarded-Encrypted: i=1; AL+hErFy2Bx79tJhxHoeXdeUctWmnur75uFeVnAVbZJwiN6tn/5eu9z3bQ5fg0vvl8pSa3fwQLgfFaiVZqxE@vger.kernel.org
X-Gm-Message-State: APuU4Z9di2XS6tRIl85aaqAeFR2b5fxaLJtFB1N+0XIVbHyBw5dyh0CD
	qhyrpz/Q66uDM9nGYvYHtk81hyVH+Uco9baoKp0VnoEvlccjVKdeFaXl
X-Gm-Gg: AYBFou1ShbEa/xd/0vHY2Zuy4WZcILbKk3YJHpZGfn3p6LLykYUnKkNeN/w5iFnoXaX
	Dbyhj/CgcPHN3CpGDXWT3xSftscL+ZMGCVWB2d/4aRLggmYkFAlvE62MH90XQ9Zm7G4XRD19H8i
	Exz8cZF//KgpXgzTEnxw9pHzf0X4IegpwJkzFO3l+1UQa84IaEgs6l/FCtLsRUincbMkCQi0QXr
	DqnYvv8CKWQ1opridY/ml3Jovm0ano5CAvgS+Fny04wSd1PvEEzijUuDBqr2QwdDiK4EjZ2lMhw
	ZFRTBsbDjXJ+2zfYGAOOlakNM153x+UmTcBsIs/VpJvc3PfapW6sgt53dX0QEKKb3CL7mLbY1uT
	yqaemzanHrkHSrtVR5fsaiOeZ8stD8fYZOTCjSlT6+IC5Ok0RLzu/ISQbNBXrVeAVLkOLiy+ve+
	qjb8j8AkDW87z/DMP45L/dRjwN8ozdNZf6voBQPw/gmOSlvA5ys9NfTkqJgUaGgBIc6+pr/WJ6W
	zwUEIS7WYRF6iHzrVxF4znHcX5XBaspVVwJSmfCY+nHQInhrtdJlyvjZXovs7JT0OrLmAmBalBP
	R0VGWkY1uRj4LK7KF75S2wSsvdfdQNtezlA97Nw=
X-Received: by 2002:a05:693c:20cd:20b0:375:f846:5b3f with SMTP id 5a478bee46e88-3767fe8f34bmr696317eec.0.1794340369276;
        Tue, 10 Nov 2026 11:52:49 -0800 (PST)
Received: from [192.168.1.11] ([2401:4900:881f:d9bc:11f3:620a:3333:518d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm8834225eec.11.2026.11.10.11.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:52:48 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Wed, 11 Nov 2026 01:22:31 +0530
Subject: [PATCH 1/7] dt-bindings: vendor-prefixes: add eets and newflow
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
Message-Id: <20261111-ti-omap-dts-fix-v1-1-19022d1ff4b4@gmail.com>
References: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
In-Reply-To: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Mark Jackson <mpfj@newflow.co.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Bhargav Joshi <j.bhargav.u@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794340358; l=1238;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=Rt1rSWZjPfM2baFw8ge3SHaMBlN/XHq/0c9xsidb0yE=;
 b=6v4DY+409b2gCifH+22DH92JVjmI9DIm2x/tQgiJPVFXbnbXc8PIVuxrQH2i0KtZqNevRwJMy
 65XBxJLpJ4hCQF/vGwm7t8wMI02uMT5+FGlnsBiPmI9wxIpm1dMZzff
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Add vendor prefixes for EETS GmbH ("eets") and Newflow Ltd ("newflow").
These prefixes are needed to document the compatibles for the in-tree
AM335x PDU001 and AM335x NanoBone boards.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f10..447f1424bf9c8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -505,6 +505,8 @@ patternProperties:
     description: Emtop Embedded Solutions
   "^eeti,.*":
     description: eGalax_eMPIA Technology Inc
+  "^eets,.*":
+    description: EETS GmbH
   "^efinix,.*":
     description: Efinix, Inc.
   "^egnite,.*":
@@ -1198,6 +1200,8 @@ patternProperties:
     description: Shenzhen Netxeon Technology CO., LTD
   "^neweast,.*":
     description: Guangdong Neweast Optoelectronics CO., LTD
+  "^newflow,.*":
+    description: Newflow Ltd
   "^newhaven,.*":
     description: Newhaven Display International
   "^newvision,.*":

-- 
2.56.0

