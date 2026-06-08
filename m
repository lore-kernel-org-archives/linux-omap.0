Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474763F4DE1
	for <linux-omap@vger.kernel.org>; Mon,  8 Jun 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931987; cv=none; b=iv78lxaKX2OyuZWUwJpzV5OXZv2NzOiDXE13Ss/X54w9vA2i4FFytFlK6th2PTGYgRnwC1jLTIzURMLVGI5+vi2+ijFqGe6BABtVBb31vDWuViWiggVoy1PbgRyGpkaX21RGDUaBGwxSGIuPyNBldFXIxc+9l57A82xRkxyHhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931987; c=relaxed/simple;
	bh=k1s0VB9TgaMOMV66fAfiCRAE+O1DR3Txvggw9WOuKn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iGF4vcG2ja7wYKE0HQI6zoKHaghHqQfeVO2CS6cUpQhIGlnpcANv4bYznMzNC7h9rGD7W9JyofXikTNA3YQ43QRNQ3xnDIiwyAJj9+UASaDg6Y346z/dP+0rAP2qK/VTkmRS7vPLAzF6Ir6HScxZmZ+IauT003eTj6e5eOrirq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gj5fV8+h; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gj5fV8+h"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so4013964a91.0
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2026 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780931985; x=1781536785; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=33VwqNJKC3vQHdZOYexSv3O8gJeHLE5NCtrHEddwJEI=;
        b=gj5fV8+howhbwSgmujoz6i/EQ8HT1R4ml7czq7ap1PhPb3+LSbjwN2/H0oc9JvBexX
         oryl1ewdHpZxN3a6SW8WxRbLSuj/U7pXfqlp8w3pkfCUzXGZvvSkKL89Kq+k17GyQn8J
         xQ4TOxvcxLiSkc+74lYw0O4gLxxRM6AVh6NZoKlyTpzNRNXRs4JjRX0rbXOyV7PJwJnG
         +JFMTpjAfRlA0k9UpBIwxRZPcuLIN3sRkVhkHUXsCrsSxPaxsai842DtPYzBSQAz1WEh
         bT+1Tl63EqwIb8BI2xw1nQq6aLbpRKvgdmXcHjwmBayQcepco4v9NI/JsPUBSY6mR5E1
         CEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931985; x=1781536785;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33VwqNJKC3vQHdZOYexSv3O8gJeHLE5NCtrHEddwJEI=;
        b=CyVoktAKJRyhKWVMQN8fXovLuoBcMjxUtrT6dQlQd8/Rz+xGBSPWHdbjEN+D3qCljP
         tH5aYgaNxQeZkqird3YqgSp/JCpN61+QevvVd8ffx0AW3A2RKSfyYA6Wxe5rHqDiamG8
         pyamCRjGqWP1vqcPX3CcN/kFl46bdrQgeDUOylnjOZ+vgHpUo4ueD8TcugMcTvO3ZF5D
         AfVhRsfSjSE3fF79m3h9/vz0uVqXO4S0KLRJFNITkIop0sBYJotJPXeu8qd/cQl/DRaY
         5Uq0/QnGAizL4TVi4uTHvG9NZ0rqSW6FmJVLI03c8j9wUbXgVvWDkMkhh9mqeyYfcnHf
         AlyQ==
X-Gm-Message-State: AOJu0YwFMhyqngf8VqMu3U8d4LFLIF+lbnFHYuNEuYYxZO/YK9fOX7KY
	00Yj6PTQZ31XYYtXRlfeAHEQAlc7FEtOJdEsWF2QYzNjsmrIA3Vt5XBVqvLUPoPXNkE=
X-Gm-Gg: Acq92OGleCqk6HY5ZbNulri2Q4NEOtwtN8lU2Du55LJFZq1u92+dk+gSvQ2xIDTnAlX
	U6/BOohDc7+yxpCGC3Iram7i8UdxCxUXX9jaQnlrS8zyQIoWIYasA4cIHbYrasEuSi84CLiZD1b
	yN4OIT2DsXJUXUDMvu6FzBdbqk3PNhSwXrN2fviY1OpN+mE5DgaFureDVV9hl7hTNgybduXk1UQ
	+bG4uqPN5aSgXI77b0fhU00DNHWwk5g5LrNX3WsmXKEqb686l4yt0A5JvX/XLP/OqGr3+BiZ+b1
	KMiHpzY1YurAvyqHXGfMvrwx68gUM69WZp8ywwTPqXuQ5omZTFBdZHy16+o55+y9fmSMeW3WPEl
	OKSEAiGd/lZgvz+tYqVFPQ4SbxmeafNIrMsPZufnIP/v8oWqarUpCW2x0xfrzvHQmyaQRg8Wnog
	DNYOzcrr7O/g6g0Srq9HoKLqi2IlJbtmc=
X-Received: by 2002:a05:6a21:2c11:b0:3b4:81b4:9b74 with SMTP id adf61e73a8af0-3b4cd0cbd08mr20264896637.42.1780931984644;
        Mon, 08 Jun 2026 08:19:44 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-c85df0a505fsm16290448a12.20.2026.06.08.08.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:19:44 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: dts: OMAP updates for v7.2
Date: Mon, 08 Jun 2026 08:19:43 -0700
Message-ID: <7hqzmhm54g.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.2/dt-signed

for you to fetch changes up to b6aefeea7b4aa9158c1dcec8c050a678af7bf9b0:

  ARM: dts: dm8168-evm: Set stdout-path to uart3 (2026-05-06 14:23:24 -0700)

----------------------------------------------------------------
ARM: dts: OMAP updates for v7.2

Minor DTS fixes & updates

----------------------------------------------------------------
Andreas Kemnade (1):
      ARM: dts: ti/omap: omap4-epson-embt2ws: fix typo in iio device property

Christopher Obbard (1):
      ARM: dts: dm8168-evm: Set stdout-path to uart3

Ivaylo Dimitrov (2):
      arch: arm: dts: cpcap-mapphone: Set VAUDIO regulator always-on
      arch: arm: dts: cpcap-mapphone: Add audio-codec jack detection interrupts

Jihed Chaibi (1):
      ARM: dts: am335x-sl50: Fix audio bitclock and frame master endpoint

 arch/arm/boot/dts/ti/omap/am335x-sl50.dts              | 4 ++--
 arch/arm/boot/dts/ti/omap/dm8168-evm.dts               | 4 ++++
 arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi | 6 +++++-
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts      | 4 ++--
 4 files changed, 13 insertions(+), 5 deletions(-)
