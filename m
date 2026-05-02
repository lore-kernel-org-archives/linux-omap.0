Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237229CE1
	for <linux-omap@vger.kernel.org>; Sat,  2 May 2026 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777688009; cv=none; b=D4QOvEkQtxbXiAKt2zslRtoreZPY9qZcdhrdfz7NGhEU9FT5bTA3Ltxsd01D7M0RQeDxLdiDUqEueCmN7rUcUG6fjU2O1/9Rif7+JzfleIe82a+ZIqbgVPZF3hrGYKT6BCGdutN8B8UzLrCfpT8njcf/PlGzXS8g4JtnCgjghrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777688009; c=relaxed/simple;
	bh=qaoSxtxpiDOxluongS3IsFiLg0sU88QL0+hHlGNYt6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i8fnUIHJHY8NbhkXft+aqpYo1aAmoD7wiE2+Hg+30iOeqnNkHq2d2qkv8k75dUO1HZMW+ZRxYKUHGnAlt9+IBsrdE0Qp5qeWk+22Mev277kttsjeLtfxxKkmzph5s99Og8MA4udnsoqxvQzEpB414tkfrdqQcmJzv7AGcl+UCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QEFfTMAZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QEFfTMAZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d73422431so1992958f8f.2
        for <linux-omap@vger.kernel.org>; Fri, 01 May 2026 19:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777688006; x=1778292806; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z/SnEh+R9GBIDmL48pRWXTMLEn8uZXtceFZjBNG9Z4=;
        b=QEFfTMAZ3BIhZGr48gs4NXz9EteavNhN/KccKPxtvF2byNG+h7QVUkRRd0TwB7u0Vs
         VO2ERWhzKPaFiMKS5RXLr5/731CSM0HEmckjvb8VIUArPmoWZbS9z/kGO18gryzvc5Vf
         rXHpRaQAIvyC92SrnD9xOTytuO91ZyfVJGoeoaepQLxQeRmusMMhjMifAEHT91kMK3kn
         c1p0Krn4AlMICZbhUXXkbonjxctZ6L5OfqNXhNvC4CmL2+/y+fgMf0Jm8ULGEjTKtekH
         yrMRnX8cU12nzbeNMdlBGfdYaP9nmulGVbQ0kxqy9fJPM+bDfwwiR3r261NoYyRTROWr
         yhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777688006; x=1778292806;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Z/SnEh+R9GBIDmL48pRWXTMLEn8uZXtceFZjBNG9Z4=;
        b=bwOMNh76h5Mw0b8L1xb0OFem1dixxcXiQFCylPApcljszWUL0QT8leOcEzlsqT3rFo
         v1e8mMJNc3Z8JwKjp0E6b9naE3HuTAvtZSIvEuVNkCWBSIvbXB/rOfz/Enj2iUflJpYo
         8Hh5nyK9GseQ3tvowbo8YM2ZunRLTA19Oh0YwdaXE/UWPiIBBfjoLZ4PRxubkNVhXp3i
         022WjtkhtVJUOhMROrtVngYfx/B83bEtPE9qULJc13A4dnaPW1eAVOASg7QMR53v2apv
         xigbk8oDXpoDlmlaRqCBXG2PsQHFU35FKxFg5bAmIzjEcnNGIbdM32O15lnkdSHVvuwM
         qnkA==
X-Gm-Message-State: AOJu0YwMNUMA86tIZZKXeCiPZpW0AVTD3nyTa0nj9kXFmQHxui/GhD64
	NX9yMb/DRSA5KFwAwmL8CLlbsGARPF5h5ntNzxoTY29BssCOHlY5XZ3qE9+g+xX2xjI=
X-Gm-Gg: AeBDievkrvjqPn8CNE1wkEwltjGDQeGj/sespf3Rd2pWrkEwweqVpibooP96GofzVwb
	R7NE0ov7a8r3FRWvGbui+QYJIRN/kP/nRrqFAq+lltHWkm0jfzDr9xOvWaAMHqRtMp5PSwN3v3+
	4NY9LHHwqlUPgNK95X6cvvecV5aYTFZWW7kho0lDU5Kbtqu8g3c5g5NkOHgLVsm3SpFy/D8YcSw
	E+taQ513D5QKgx5lE5Sr+61keYN9jHRJ65X+4EVqe6sPY5pX0I1FdteDLYhPBcGugq8P2qgNf1w
	QbgwwSdTv+Y5zW2zNMQKNu9eiF+QorasPW0AGWwecPOwsSBS7z6Kws6qJ7he3/+OyH+WFCEnPtl
	Qr+ZqAd2kyD8lGD9Kmle1dyirs8SDXqL1wBMmrFni3K731afzA3J3MWTaSaOwNgPpWZzxrF6J2k
	ZTh2BGC0dx/z/hyXJnTsh/GUPsa+Fhwtv68ixOl5TxewuzhlfMxYRqYlvFt0C7Gk7HeIZlN9m69
	4aOqbgPTInk6fqutqyu2ss=
X-Received: by 2002:a05:6000:184e:b0:43d:7af0:3a7c with SMTP id ffacd0b85a97d-44bb61111a9mr2649471f8f.29.1777688006126;
        Fri, 01 May 2026 19:13:26 -0700 (PDT)
Received: from localhost (host86-170-11-80.range86-170.btcentralplus.com. [86.170.11.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981dee7asm8657699f8f.21.2026.05.01.19.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 19:13:25 -0700 (PDT)
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Sat, 02 May 2026 03:13:18 +0100
Subject: [PATCH] ARM: dts: dm8168-evm: Set stdout-path to uart3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-wip-obbardc-omap-dm8168-evm-stdout-path-v1-1-d1e69c295c21@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL1d9WkC/x3NQQ7CIBBA0as0s3YSIBaJVzEuBhjtLCgEsJo0v
 XuJy7f5f4fGVbjBfdqh8iZN8jqgLxOEhdY3o8RhMMpYNSuDXymYvacaA+ZEBWNy2jrkLWHrMX8
 6FuoLWiJ384Gt01cYtVL5Jb//6fE8jhP7YX/peQAAAA==
X-Change-ID: 20260502-wip-obbardc-omap-dm8168-evm-stdout-path-6aa87bce6814
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Ettore Chimenti <ettore.chimenti@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029;
 i=christopher.obbard@linaro.org; h=from:subject:message-id;
 bh=qaoSxtxpiDOxluongS3IsFiLg0sU88QL0+hHlGNYt6U=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBp9V2/Z7SAfNmXHf1mRY2kfCkl87UHMTaHCecdO
 BaZ9VwJ6pmJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCafVdvwAKCRBjTcTwaHBG
 +C7lD/9h/R28wE+iUDIREfj+zwXLaqw5SSXZVkVjic4HXSEyBvMWqiOnRhMhK/EmfdI8RcItA/v
 JxufYrCUZtL0zaJobPmSccvfl0iZ8ZvI+2nJuyD+QM5c6f++d2ekms5ozkzKHxYDs1V253ja+Sz
 8UNekFGWVJyQbrchanM4oWNsI5IbISWRASbN1uXrlLXzOdjL9Aw435j3UrqEuRZ8xYTZvS9mQZH
 Z7iCV+aSdp6r9UwGKq60ylgPpO5IwvH/ysuELkp8hbNXF9ONM/EJDoaeupjtZNqZxX+D710Ckko
 XnWxnQU8F7k7LZjM43dk1BncDkKFg8ROMfVhcKO6Ee65o7yCiqlBdPZif64RukaSIIjj2xt6hT0
 fu0PVhEqfHD1Dr1LbPat1cV/Hnq+d2jHL7DHkAsXP4acH5UlrcjSwPinmc8JGy3J+4xpnjry16r
 6u9ArhAOTDOGNr0hiD9OdzRcf6EjiQNP0yH7KjphZqSDgTkuZBh1sf9eKlgRCjA0raNeCO3OCT3
 JcocJb7DSmdh51eGhWfODBNSBiq+GrU623qbheMKXlmltcCQ1dLr6hkAnjSbGyT+nPn6tdWeY5p
 LDgm2LaBzhumlQUOt7Bj8+7xh95mKb4bvdPPEi51mJpeOVk+wIKIkqL3bZv3QzcM7NHpMFvsx2a
 PWF5szyWQNpoYXQ==
X-Developer-Key: i=christopher.obbard@linaro.org; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8

Specify the board's default console UART by setting chosen/stdout-path
to uart3, so that early console output and /dev/console map to the
expected serial port by default.

Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm8168-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
index 6130b9a5f660..81450e15b889 100644
--- a/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/dm8168-evm.dts
@@ -8,6 +8,10 @@ / {
 	model = "DM8168 EVM";
 	compatible = "ti,dm8168-evm", "ti,dm8168", "ti,dm816";
 
+	chosen {
+		stdout-path = &uart3;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000	/* 1 GB */

---
base-commit: f1a5e78a55ebf2b05777fd5eb738038ddae609d6
change-id: 20260502-wip-obbardc-omap-dm8168-evm-stdout-path-6aa87bce6814

Best regards,
-- 
Christopher Obbard <christopher.obbard@linaro.org>

