Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494865;
	b=dEjLMN37AMbdXUXL1EjD9nKMO9kXihofJhW5f22ofmLrGreGZAB/ELYnSqDiWf1MjU0b
	 +z7YfRQGG2BC5rO1acXGp4dMedbSGZWdMBFFCdNTX9M+H6QHScYO1OtQ/McuvQ8SRVeug
	 E/2h5+8bQros9+B5E27LeyZlJwkExTZ796w1jhB3hTdOaj7AALTNIBeS0xdsiXkqcfI6m
	 DklBnl41CMT/OQ5kqeyIjZ4HBlwW7/0fOcjE/UAY4Iw8pxuJU/USXDHH/+BDG9Lf+3hhV
	 oRy1s3OvDkEfZkJActLmQOym/OhC6ZT7FE3c6/FdcX3ZT9rgeVoB9czrXl6TEbYbubg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494865;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=/e6yF19zcnnSZ5kweRiKxTKNHNpF97qUwlGZCKVgLTI=;
	b=BB0SRO0oCZQOEZk7mjZRM+YzLsGjrTA272H0tUqWUP2LIbzo8nId33FtHezC2TW7/SYz
	 VplNMCd877TlGM0+Wd9cRHE/w6WxJSYeMeeV26aSo7AmUJ/vLWTEZmEbXSFgYnmQb2nSA
	 OksEF5Zo0npNzILEdomBnScUNgSBRv9CMXGX0tIvd4KDX+MZBWHHlGNiSAiOagmwmGldh
	 Ace9C5zymqhGtnE+6vN82YchFAjZ7zBz2u+ca+F8BpWZ+M33z0gfxS/vwz3vhWRsiGuJ9
	 A8QFnfN3hhEIXEUBVT+Lds91+WW47+iBdALoPcUG9NPhvWwpuLgIxC6LtgH5VR2eR7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C59606A326
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 04:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C59606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b51871c5c4so31317767b3.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 20:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795494864; x=1796099664;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/e6yF19zcnnSZ5kweRiKxTKNHNpF97qUwlGZCKVgLTI=;
        b=cxlExYLyEQTrRZ/fW5kSgMSHsEr43dAQZbJrr1tvQxp9bXvKb6n7paikEUJHQvm9tZ
         PiW7ICWml0OjHi9aLMgl35vyf0eHcOvnCVaBUZyXMISWOgwQForToKsSphr2Ik//Ql5h
         gwlkHZ3a9fcuenQ9cSvV7S8Nkv5uedwDBXfHi1ki5jV6pttlV/oTvTHqe7a2hnI8D/hX
         AiXSNCDf3UC+2O7eOLMbYA0lR1oNQMzqHyP7eYq0hShDDCAWQR38syvL7h8sXdpHEMcC
         sWpLLDHCP4CDSzj4B6G/OoNNg8srOd1kq52iUeAWxspfMOYyj9dWLm6kOlo9MoKHtR87
         Z6/A==
X-Forwarded-Encrypted: i=1; AL+hErEpRyx1fIw2nUpUK8cm0UpF4Rynda+p4iLUKUAAoCyovBwExolemxKSFVxlRY+wNViZN43OpO7HKXva@vger.kernel.org
X-Gm-Message-State: APuU4Z9bHRFc7YnGHfqqJDAs2EHSY6PJ7rhIOUdb+cDmsMBn3eOTr20u
	8HeFfEZTRJpTjpfawhds5htkYyUsOcXdE04fI1zasu7srnCH4Jz9GvoT
X-Gm-Gg: AZFdTZfCS47zjTXD0f1S92SlOJdmC7TW922zyeX2YH7LIH8XzVet9NZiQTLMW7zRA1r
	WqA2TnUGX4VuFLbB/Yr9L0DlA1RxMXuvJBc9CNN4OawjQjfPPh1KJHMv9Kb81NyJOKCNjGAJJm9
	YBWu0KaDrL1qsvhE0ugTEyOKVsUNZUmP9uPfsXJve0kau2l/SZ8UNtx25tmpoegR9PCFgS6vx5M
	hMJZB1JuHPPi3sBlV5ZkiNF2v1EyWgRl6oWUefCFzeZT5nzarPFoqcmyMAGQwWUw3IuptGa9IoP
	9a+ksAzd+qZZEceYVqySXQ5Qm3XWlc7QTvFhZ93y2WavXz7EX7paJXy3homZiW6FZV8DxqsFS7U
	Iu1a9H/rxeRfbIjgiE4q1BJ2uVnd4QkkwZiodhSAD1SRaKDkUB4j//UhKACmwCac0sfvqJrQHrf
	xWdlTRwxx++SBS+hkD9RgUcMX9XLFR16eLNiNwbVaLLPlYXwoxPEOzXFo4TSCKbxDdDnoahKprJ
	s0yqvsm6HAPPPyQeBXM6zTB8omyukJGeBeg0VFfGoSgu+oCvd4snxuA8KPn9jR0eIgOb95Bcfd5
	nGqZ6Rgu49YnsvkWUHjXtuyYlwx++nBwINrulV0zpr5RG0Y3znIMY208uh+LLOZWRuWaJNxPDMa
	A/vZUO+dzH5tniEpN7vDwJSQnWIQTTjADqo3xzZa5bKE+eQzfZ6jouiCzIrPlsemJWABbCmY6cA
	GzzMJyoK+5YeqHDiaFSW9M6xfbvLk=
X-Received: by 2002:a05:690c:f16:b0:8b0:a01e:2ce2 with SMTP id 00721157ae682-8b518ec3105mr54040937b3.15.1795494864418;
        Mon, 23 Nov 2026 20:34:24 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202fb0a2sm53106397b3.27.2026.11.23.20.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 20:34:24 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH v2 0/2] ASoC: ti: omap-mcbsp: TDM slots for generic cards
Date: Mon, 23 Nov 2026 23:34:19 -0500
Message-Id: <20261123-omap-mcbsp-tdm-slot-v2-0-3e3aae215952@telaak.dev>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/22NQQ6CMBBFr0Jm7RhaoYgr72FYlDJIVSjp1EZDu
 LuAcefyJf+/NwGTt8RwSibwFC1bNywgdwmYTg9XQtssDDKVSgiRo+v1iL2pecTQ9MgPF7AgUuK
 QHaVUNSzP0VNrX5v1Un2Zn/WNTFhV66KzHJx/b9ko1t2voP4WosAUlSnbQuss17I8B3pofd83F
 KGa5/kDEdJeA8kAAAA=
X-Change-ID: 20261115-omap-mcbsp-tdm-slot-7ee61348226b
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0

With simple-audio-card or audio-graph-card, McBSP as clock provider runs
its bit clock at the full SRG input, since only a machine driver can set
its divider. Patch 2 adds set_tdm_slot() so these cards can ask for a
frame of slots x slot_width bit clocks; patch 1 lets the divider use all
8 bits of CLKGDV.

The ADV7513 in the test takes S32_LE only with a companion adv7511
patch:
https://lore.kernel.org/r/20261116-adv7511-s32-v1-1-40ae8228db42@telaak.dev

---
Changes in v2:
- 2/2: hw_params() checks the stream against the slots and the sysclk
  (Mark).
- 2/2: rates are limited at open only for a sysclk set outside a stream,
  as simple-audio-card does at init; a sysclk a card sets in hw_params()
  is checked there (Mark).
- 2/2: both directions share the SRG, so the second is held to the
  first's rate and sysclk until the first's hw_free().
- 2/2: channels are pinned to the active slots, non-empty TX and RX masks
  need the same weight, and unsupported slots are reported.
- 2/2: a sysclk from the internal fclk must be that clock's rate, so
  simple-card's mclk-fs (rate x fs) is refused instead of misprogrammed.
- 2/2: dropped Jarkko's Acked-by since the patch changed.
- 1/2: commit message wording only; keeps Jarkko's Acked-by.
- Not supported: dai-tdm-slot-width-map switching.
- Not tested on hardware: full duplex and a sysclk set in hw_params();
  the test board has playback only.
- Link to v1: https://patch.msgid.link/20261116-omap-mcbsp-tdm-slot-v1-0-6c9f7aa45a29@telaak.dev

---
Joseph Telaak (2):
      ASoC: ti: omap-mcbsp: Use all 8 bits of CLKGDV
      ASoC: ti: omap-mcbsp: Implement set_tdm_slot

 sound/soc/ti/omap-mcbsp-priv.h |  15 +-
 sound/soc/ti/omap-mcbsp.c      | 334 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 345 insertions(+), 4 deletions(-)
---
base-commit: 2c0f21bfcda98db49f6476ff9b042402e5f20d3e
change-id: 20261115-omap-mcbsp-tdm-slot-7ee61348226b

Best regards,
--  
Joseph Telaak <joseph@telaak.dev>

