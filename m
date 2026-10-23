Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767360;
	b=GtQh1riDrAwut3CwcAj/jsKFg8qIQ4rUIo9QIHm55ckV0XWPl265ziVFzFU4dqIaA9Vk
	 H0i2bIC6IgqaR2CG+az1FOYfUI6ZgfYx4YqWtHEDxQaWrHiIv1I6kE8sdvbQpRozeEWy9
	 mrVsFi0gJPQP3gWX3bluOdHtZAVmY/v3Jy9vHq67vP13awSgJPZYyJHH3n3owG1KRP5dT
	 suqrfV6CHYRgaj4EhovKEEd6nD6g8g0T9+vLmPnW/U7FTs2JgqpoDsvIz2Pj4e75jj/4i
	 SyqowmyXu/mVSwm5yO+wXNXmWRNnr0hT1GA9MksHeXakG3WlvCeDbnj/o0g1EN3yCwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vB7EoyrHbZim2ck9/2V6ztNSVsZ7Bq2SjbvjQSXWvH4=;
	b=ZrcMG6eJ8zlCcnOfg+4OUbwAOv4wHzVbUetimbHCCyjnKBrCxH9rhyLe69dkbyZkolKV
	 UNl+LoyaVmOvu1GL+3p82zvVYF1cPx7BnzInUGON3hWggeNZHlLhGuTzBMClTXcgo8A55
	 4GVcTlt9yaRowFcru0ylYLIk+2GhCRf8jndPVWyz86lAIrnMpRav2hqTzE7NYBTurKWtn
	 ra5xg2lbqsRA9hnSAiS3/hPdA8MWJaBmdnz49Tj0mxg+wUyjfEjMu3OHjLqbQVFfEIYru
	 ME9XeeZwIaLSwMas0aMQGg3QcYniDxa2vmyR3VYB1vBK6X21xtVF6TMOlhNl6CSup+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=GOR+0AnC;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4C3606A320
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2026 14:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E4C3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=GOR+0AnC
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so10237595e9.0
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2026 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1792767359; x=1793372159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vB7EoyrHbZim2ck9/2V6ztNSVsZ7Bq2SjbvjQSXWvH4=;
        b=GOR+0AnCNVrcZjEffNum74HOdwjgnPDBXe1iRLRP037zO06nFiOqSSqD6DnLgLZtMI
         2bZKwe5rUezmAubDWZ0BLdgmW8OhsBjGp9wMLvyX2WYKQVhP5Th2Dn8WKNJcKcjpZ5qc
         9TlwU7RZxqhQ9grYFc+vCMesanO3amPd/4Hjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767359; x=1793372159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vB7EoyrHbZim2ck9/2V6ztNSVsZ7Bq2SjbvjQSXWvH4=;
        b=fWtCr4UjM54ng9LTfxspWvo7lKhW7UBIwM7G29zow2xtR8NdMQ6LLLanQ0l+CD6EWa
         sIj5Fw4yAFsRNXLu/EmtZgy04vhN252Akm2WFiiMtDS1P9Q2ylH3SUQs0S9+tcCdpRGk
         7r3OFmjxdE+j0PtlRbimSoZ+7odmo9SgwBnzN8ABZauspy65++0QtNnMlIpmaoD4Yq/m
         I+7iziPYYVuk0YHgx4khP/gAodLNlN2npZaWy08udPN5nQ/zP3ZqKhPrSTleuG5L3Rle
         BAuQL4tWZlSCo1ZOxJPsg3Nqz3xKQKrxTlaxDhJq9qdR+uiru4ynGoC3WTgb3QYKbd5U
         bvNA==
X-Forwarded-Encrypted: i=1; AKwUvBwAHe4411FYaJ63ah1K1fBog1wnUaSnJOFS4fSdOajLvmtP+2RMgG9Y7BjqhSGkhp8pqh/NI8UJAFi8@vger.kernel.org
X-Gm-Message-State: AFq9FYJTOvctxGCb1hHh5AAbbAVr7qoq3HE1nJPBEthK1RbW8Q0PDN07
	BQ1BhVG2eigwWN86pLCxELVlAheR2yvxkiFKn7ieCeH+PO071eXN5Dph+EOo9mQ/pUw=
X-Gm-Gg: AYBFou1ICKquEPM7bt9/IDxsU3N4qnD8MOeTHzqW6ETXfaWtRBiSxGWSuICUAaKrdmt
	0NTELbpIF0hP3mVNFLQX5tXsghza6Nz6qi67FhZp4BHf4QmSWop5IKCUFEjx/kuXUw9zVGEQFmq
	lmFhtJ5tnuz0VOtz18M6r7jEyuJu1z+3QVLUq97HrRM3zT/nzAAp0yWjoO/CeSfMfMJl4zmDS6F
	yhccqjwAcFOuw4SQMng3nj5+yCc0BDY4WlF6ml0hQ6b8fgm8n90Ov44J8m4nNpxhQpTV8LeFmrF
	wWx0XKtgDOIiMkq9mVEH895pLYErT3su9YDk8dZaL/Q/XSqgdXY0lm3m6e4rZTjoo+QrwIPhVm7
	sCfcCq1QK2mKugKhggwa8FQzQGkvPkJChbAvXW9KdOGDfpPWjKHW9kk6HHFsfYGefqvQu2cHmSU
	jlJDUiOgGWB89EvZJryMOSaLyVcbm5o0Y06GlPov3V9ATwhb9eHxn3bLfK+AjMPmFUxN4+tpx/V
	+xBkY2LZXu0GBwUXIJ3tVzNTXoZ0Nb0iNvO73wDub96UUuLcafNuZfMlZaTeDqP/eHqOkBiNgCd
	VfP+VpjyoJmOgvngoiTtonK9hecA8WDBHKZ5GXBowJMlfLMPsPMDLg6kz1yCTlRJKVJwLdfXiYu
	bag3ZDmO2xmWG5k2BcWiUV5HO62kwWeUI/Af63RNhWPu9PNtXKCx9vw==
X-Received: by 2002:a7b:c303:0:b0:49e:795e:ba89 with SMTP id 5b1f17b1804b1-4a204bc31e6mr73887275e9.6.1792767358753;
        Fri, 23 Oct 2026 07:55:58 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d42f884sm226760f8f.57.2026.10.23.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:55:58 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH 0/3] clk: ti: dpll: switch spread spectrum to the generic framework
Date: Fri, 23 Oct 2026 16:55:29 +0200
Message-ID: <20261023145555.3578469-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

The am33xx/am43xx DPLL spread spectrum clocking (SSC) is configured
through vendor specific DT properties. Since 7.3 the clock framework
provides a generic API and the assigned-clock-sscs DT property for it,
so the series moves the TI DPLL to the generic configuration and drops
the vendor specific properties.

The last patch applies the configuration right away, as the clock
core skips set_rate() when the requested rate is already the current
one, e.g. when the bootloader has set it up.

Tested on a BeagleBone Black with equivalent parameters. The
dpll_disp_ck SSC registers are programmed with the same values as with
the vendor specific properties.


Dario Binacchi (3):
  dt-bindings: clock: ti: dpll: drop the ti,ssc-* properties
  clk: ti: dpll: use the generic spread spectrum configuration
  clk: ti: dpll: apply the spread spectrum configuration right away

 .../devicetree/bindings/clock/ti/dpll.txt     |  6 --
 drivers/clk/ti/clock.h                        |  2 +
 drivers/clk/ti/dpll.c                         |  8 +-
 drivers/clk/ti/dpll3xxx.c                     | 98 +++++++++++++++++--
 include/linux/clk/ti.h                        |  9 +-
 5 files changed, 94 insertions(+), 29 deletions(-)

---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
branch: am33xx-assigned-clock-sscs

-- 
2.43.0

