Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A138F93B
	for <linux-omap@vger.kernel.org>; Sun, 19 Jul 2026 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470235; cv=none; b=fpL70XahvqYYkUEdZevLlUO4UeU6nuGlFE4Kr8zelULjHjRoz4lYS2R6rpV/BpdvsIVVnYAgIULKjY+9HYyw/3ch3vHRY3pbd0wPk77M8jW0b6r6uWFSE9Mmm8w7sIKitVXQl1PuoSnnNbxScb0uKY5OV5UmUyJ8NajEUyilJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470235; c=relaxed/simple;
	bh=1v4jx88eOjwpIxo/vM0L6nRfw2ufOcyZeERWgwj/FXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QisnoYUxDIuIaRj2B1jNKm6dXGG24IrYdJ6PkcWQdRL1Jz6LL6ntAD0ivhoZLIOIek8IIQrRAoHzGRgqFubPqVYA99qxL/Z04EuHcBEK03L7uF7XdQJAbomn2WqzZtvJaq+34cNp4ECradfMEaY++snCXdc6ZvE6z1KPtOQ1Abw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V232Nd3M; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V232Nd3M"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-476a130c138so5755628f8f.0
        for <linux-omap@vger.kernel.org>; Sun, 19 Jul 2026 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784470232; x=1785075032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Rq18KrwyxmENy5nVsOEr+/h8xbbEY9JxM7ic+yQE3Y=;
        b=V232Nd3M3Gk7hihm9YOwxSFUmSCFZvJ2gKWr4X7/n2cw4s4BYirzmPqpnX5KJc0pDp
         CnWP0ulUosIbNmggxOafG6chUTyELA/YAMDfpijVQBADZ+X+RSGiFMTCC5RrufXJhDb3
         4l56jBhjGVNov1HWyi8ZxkXzfwb/CShIUuZ6M3CAQmvhNe6Gtto/icFdo5yELg87dCiL
         CH9Pw6p2W4wAOMM4pP9pVwhazJqggu3r1Cx8rTnCeangItC3MAiN1fhAmiC9HIzJi0Jh
         mVLIM+ARup4S/5/fTeEwXycGULnsOtGxvSfTBuFpPv6+otT5bX9/qaytir7iIP2m9M18
         nWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784470232; x=1785075032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Rq18KrwyxmENy5nVsOEr+/h8xbbEY9JxM7ic+yQE3Y=;
        b=PvjR/+p4gDH+dnuY19bUc6KxXbYTYi3mlThqL0kvggakYRqfHhxuwoczYHm7lvL3Xg
         sHv4jAHF8NNZ+PyRzWr7A0tEJ23dtqAmbpFe9Qct4RFEVNSX/dXUeEklCL5w2SoVJoVw
         N1Xeabf5JE7M+gi6eBMhPzp4Fq5mUoGg3dXWums9idTLeFccBA5tEx3joV1lw3GsSXN+
         X0NQzA1SGUOYMs0wvBywMwu0Q1FT7V6OJf7jm0I5xvPF6XDn82l2iUgyelso+3WeZe8+
         Deo8+vrtGIEVd+svzY4LedT2MnV/tc5Tn9ywBgi3DxLeGlkSTalZ60BYfnuUgFqMNCxv
         GDgw==
X-Forwarded-Encrypted: i=1; AHgh+RqHuxolYqJPhHTDyAqZrQ2AOC3IECXSBWVZf1Pz7lMV9bbhQOY+FQYz5+qCuVoG2B0c5xf87l+m4KS5@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVAlrzsCoR/rAN2VlJJd/JDHMeE4MFSycfrCbk2eFWcH3nT57
	eEN6aB7sWdDUmuKdDR9MhuqVqX0hH1fqXDoNzAaxwo3ZZwmqYwTt1dky
X-Gm-Gg: AfdE7ckahdXK+Ww2vHCB8VBTnjKxCKOZ4CO1+pGkobw8sQKEnMJVHs6+Fsssb1P5RDj
	m/q3mrHK1NQDDRLAnhr91QhAITSwfXHNPPwDpjNC6jgbjcdzUu+fBa7+sHIC32m5gsw7Eg/2C8h
	6uMnpB/TUDE7xcNF2l4ZcsXCgWUAejPoUk7zKuKL860lEbbiKZ2DJqOjGkP55VcIIAkUXXtOOz/
	bHph3mZVEnjjKfSi7xqMZfIYczcuIUk7/wvkuT2/bfJEV7DaropUIRGC3+QvyK8+ST5n9PY0ccw
	zfvpa/oDyiNwdU2CpqU2cwB++f9Bu6KtPHTALzzlEeEEsfhwEnmqx3MyAohQV34sgsGjAThScGQ
	deuWbOQjVmFYz1VO+hnvOW3HoP9qQM9+KcbnJlqsqV9R6cXf7bb1jFNh6iQW3r/9x/7xjyPsnFm
	QCZQb/uq9FodNH4fpm+Fyw/nXzq2gMkMx8CmI6mO5vt7Gm
X-Received: by 2002:a05:600c:4505:b0:493:f176:dc69 with SMTP id 5b1f17b1804b1-4954a413087mr105760505e9.37.1784470231540;
        Sun, 19 Jul 2026 07:10:31 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63eddd1csm21264859f8f.29.2026.07.19.07.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:10:31 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Eduard Bostina <egbostina@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH 0/2] dt-bindings: rtc: Convert to DT schema
Date: Sun, 19 Jul 2026 14:10:06 +0000
Message-ID: <20260719141008.3562347-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the Texas Instruments Palmas RTC bindings to DT schema
and resolves a node name compliance issue.

Patch 1 converts the text binding to DT schema.

Patch 2 updates the tps659038_rtc nodes across the AM57xx device trees 
to use the generic 'rtc' node name.

Eduard Bostina (2):
  dt-bindings: rtc: Convert TI Palmas RTC to DT schema
  ARM: dts: ti: omap: Fix Palmas RTC node names

 .../devicetree/bindings/rtc/rtc-palmas.txt    | 32 -----------
 .../bindings/rtc/ti,palmas-rtc.yaml           | 57 +++++++++++++++++++
 .../boot/dts/ti/omap/am5729-beagleboneai.dts  |  2 +-
 .../dts/ti/omap/am57xx-beagle-x15-common.dtsi |  2 +-
 .../boot/dts/ti/omap/am57xx-idk-common.dtsi   |  2 +-
 5 files changed, 60 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-palmas.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml

-- 
2.43.0

