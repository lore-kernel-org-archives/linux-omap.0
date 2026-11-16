Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866624;
	b=eY4JFO4XV7JRLh8iM+TCdAWO8PkeLLSXLk/mrM9jetu+UzhQjtoAk2ieq4wXJDByNKvT
	 1/KjCDMERAkwgk/L5JPXWZN++0F0b0O7nXh2cim3LIlBTJtuH9IqFribNiozUAGWEOdWW
	 Houvn/4ylYqRsn+OdynFr2TV6pv5fg1FZVgm0kkYbr15v/Pv9MOOk4sA2oo21cAkLwZRD
	 6I03GFjhTH+wewtiQSBbbAoRHGW8IRCCBBs745hlcwSkqDdfB1eP0L/AaYwDxLMnscolq
	 7qltKHvh9/FrHqIU3EQ0LqiN6a1a259oDAGNK4sXQCkAU+SI2TOEWqzr/eaza4XbalA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866624;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=m+cxQs8yTdgDvbABlUHThuxHL2i4RK+nNcUQlxgwMtk=;
	b=sE/0nwT+zHgelkl9uQYWfKsVeUCe9/NH9Q6c73FkU5YHl7xPcVP3NFFglCIkwOSIxp5t
	 OwRclp4Pcst9fNEOKDjjXz0PrDex7dy/lx/W7/Wxio5uo0mXfRyaHDVwdn4NKGhIP4aqo
	 imOglnPFg/gSbHRvIIk9LIpigbKjU7kZqC1qEPVP6WFbXfElDtsv99KqV9uIrCqkuuZ5W
	 wm3lrzpl9B9Vmv0Iw0nFGeT/bhgsRTZyMdOrKuJSxCJcNvo7pyPiKSY807lGOJo/chdPB
	 fzs3OgQ59aiMfE7wYREJg/S/uXbFsxkwWpMxwCN1nZL3IQpH2wyQ7G9/GIpwoYwdL0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89370606A31C
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2026 22:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89370606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67db0791748so2052469d50.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2026 14:03:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866623; x=1795471423;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m+cxQs8yTdgDvbABlUHThuxHL2i4RK+nNcUQlxgwMtk=;
        b=tazorCXIqA1aEbRvALa21fC1FPDaiUiab/H3iUd5L8rXX4euWFOtH5VbKcciiLeyF4
         aQKMrXIcZjDQWXeRrOAXqHnCeecWBrWuYbP4/Gl75QpLs8xlm9aMzmJpUccsePMZo/o8
         RuGwsdAWw5uWLYNk/6KrORDTmp0t5AP1424xpiiEPm8dkrGdIfeG5UJ25oZSFYbJ5bD6
         A8n9t1JSzLt7hKQBsw5MtvKsCfOeR6wAj6uBAnyfErmGA/gscC4MWwjW8PN8mRbMN0lq
         hn+EhSHskcL+vIyIrbzsC11m+bPBrmJVRyIq6GnFKMxzmv6sSzKAu+d/2VKbpDTBH9Um
         Y6XA==
X-Forwarded-Encrypted: i=1; AL+hErFi/MEtQPKus+M3S3bXV7GBH91jhOW73Fa06wxrOWX7zhDREDLBhY8hgU5qv2bhzlfApjUhN/V7p6Af@vger.kernel.org
X-Gm-Message-State: APuU4Z9gR5+2W5kYI4vI+3i1u/zJznHETzLol3Diov6J9FqUgNWPuYxP
	S504L5AA/vDz+0HUPZlC88HbSdid6MMOJxlxSI+c7qmKwgt6oqCxW/yuFmWyy2je27w=
X-Gm-Gg: AZFdTZeSA85+sVSeyxYmGcuUWAndsx+1BZmL3hb796en6PSwf/+X5qxrfVnGrozXWN5
	mECzKt8veo67+k8s4x5J8DgxVQycEW6uluah9N+3nnpLmA/bNji+yjyQAb271GvCjDafsZIqIHU
	LY7P/92Ens0R14fk7tIhD7FTYejZM0j0uppLqGaQvOpcOpktsNWuFR650Pya07vGewMR6CqlQhR
	vAEcJnNOhPHVaqwP/4Zn9oD4Uc2lmZnzynVVmRAmwTonTy8/+bV+eKwLooR7ivQ8g1ksMCB6Onc
	/Ha+kS4m+udPAiLfC5Mh1BWZ+b7vbItgP/hVXnzbBmyBi67xBuZa6lO9ZKMfBg79rZRHmW5lyJ1
	3GtfpPDln9ZvnyIztUsR0ZBVEiB5wYEDmBkOl3EltvcNXSHVWU5Zew25j4crIMy17fk9wf+DwJB
	qmLwwneBBnv9gnwPtZCwV54Gv4uUHxtndeXHWshxd0mU6L4i2NBjdNMcjYm1wI5A/z5qyM5SG8d
	rELvBzaihDxntNoXoAE1PHRY7yWtsav6HUN1Op6WXSBj/E01arJ4mPS3sOgPOei0p8GSMwxEyD4
	riEFxR1ZVjruBuCzmMU2fYi+JszSktwpNQkg+Wy3oS7Ai8cRJUdKVWnq8LnSe9JKHUOXYXU+tfT
	DgAdXoPhRnc3KFkrn5q+gtV1WhMVzBIsE3Yo=
X-Received: by 2002:a05:690e:169b:b0:67c:3484:f8e6 with SMTP id 956f58d0204a3-67d8963cae1mr7159104d50.38.1794866623596;
        Mon, 16 Nov 2026 14:03:43 -0800 (PST)
Received: from josephs-mac-mini.local ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a629a2dsm11133078d50.21.2026.11.16.14.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:03:43 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH 0/2] ASoC: ti: omap-mcbsp: TDM slots for generic cards
Date: Mon, 16 Nov 2026 17:03:20 -0500
Message-Id: <20261116-omap-mcbsp-tdm-slot-v1-0-6c9f7aa45a29@telaak.dev>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQ6CMBBA0auQWTsJU7Ear2Jc0DLAGEubTjUkh
 LtbdfkW/2+gnIUVrs0Gmd+iEpcKOjTg536ZGGWoBtMaS0QnjKFPGLzThGUIqM9Y8Mxs6dhdjLE
 Oapkyj7L+rrf73/pyD/blu4J9/wCFfJBsdwAAAA==
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
Joseph Telaak (2):
      ASoC: ti: omap-mcbsp: Use all 8 bits of CLKGDV
      ASoC: ti: omap-mcbsp: Implement set_tdm_slot

 sound/soc/ti/omap-mcbsp-priv.h |   6 +-
 sound/soc/ti/omap-mcbsp.c      | 155 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 159 insertions(+), 2 deletions(-)
---
base-commit: 7cd6b1fd8f9c1fcb1da1b761d502649f50b9800f
change-id: 20261115-omap-mcbsp-tdm-slot-7ee61348226b

Best regards,
--  
Joseph Telaak <joseph@telaak.dev>

