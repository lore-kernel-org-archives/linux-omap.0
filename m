Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166174;
	b=EZ1UBGTsm7zmROIEWGVxTE33FvEslFba5pqHqCrUqd4vDyS+ZuFXfmdfGLss2vSHK4P/
	 +qiW4ABjoDy4/7mFodrtmD/JxrOz8e7/ku3+tQc3dbosv/oG9jectIeTsbewqJikNmF8u
	 9xP09FE9dbubWaMOCLvDUTLK0Q7r1rxqajK1wzyVZtIb15WnEee6zj4ZMdbF89QuzVkUc
	 lZM686xkeYjfJNGaqpA12oy+pHePW/gUOKixQDVJnwxqvuLkXDOckeYGsCSXDk0JdtDq/
	 u/nuXmxQCJVeX4ozsnTJeoGg2+pIy1NuSoN0sb8q6xmrhBtu9+khhcjlo4E1AMJ6WDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=OAjTCjU59PATyZ/IPC1r20+cOIDCc27FKXqTgrZ3hjI=;
	b=DLJKN8COPcR/PJbjJrhP+IJOeWmmZ8GLazj6zAgN188uNxbfLUzmi6JRpdWedDy8v/LT
	 SyncgYsvOhfbx3NbLIfIdiaX0gY0zP84nT2ci8ykbu5CtZPIXoq08aSv9SeDh1XBPwwHr
	 sdPyBgaG1/cVN32xgyWWJiKZng1XqQRTisVMjbiTZVXZDPSe9wSaRrMLNf5HU9/SqA9M2
	 QdtqAHvQbRGMivdtjm488sbO5i7I+Xef44SWBsfoPgcbops0fmDQhjOu/n7iMunuoSclH
	 s4NmdHHdyLm4dqdkDuFFp5wkqDtZzrprvNzZaDpemks7RLRdc+wXsXe0lU2WPsQhFlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Tsk8jaZ/";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE2606A31C
	for <linux-omap@vger.kernel.org>; Sun,  8 Nov 2026 19:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BCE2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tsk8jaZ/
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-372cba0ecf9so17624eec.2
        for <linux-omap@vger.kernel.org>; Sun, 08 Nov 2026 11:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794166173; x=1794770973; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OAjTCjU59PATyZ/IPC1r20+cOIDCc27FKXqTgrZ3hjI=;
        b=Tsk8jaZ/bDWD3tcVK3SnIRa473lFlDV8MexVW1PeG+5grPrB7fFhGSj8MYSpDBzSKN
         g+6qnR2BMrMsIaNo8FGnuzAiIB5lpqZKeimcpdkzNNGfkosOFJOgZPUhmboKBxJ3bGfi
         nY8gxc+NNLPWrpb4lbsRoOaFlKbuf+iCcyGn7tX5DIY7luv9lKf8d5HNEkuEg7IC8g1j
         Ff2vK4EnPxAfTLLLuLEol+52cf1jw5Dbs+eiP52v2sb5ORIKiFANUiwNvU3xKnmCfipa
         MlCEdGK8yFe9Bq8Bef3Ml8Fs8HDASbdzfLKKGlrKXS7oBZW8KE/wpn5xuBsEuBgFZ9UC
         ptUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794166173; x=1794770973;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OAjTCjU59PATyZ/IPC1r20+cOIDCc27FKXqTgrZ3hjI=;
        b=LNWgbfU/BSndlvfn/4LhAZJ83r1STYSipjIPUH+GAw3O6WaaPZ86VIrP/lbE1iCyDa
         fkEafylYbDHhz7HMJdXnVRYhjmHK6QN8icQ4fObDhGx4UYN0rwA7KR+KvI8ZcGbaipfF
         JhS9DNbigyR3AaPePxzZ1+0MqyueddvJ2UhH9q3k9gTW7ypN5SOD8nMEfghDZJJrCYOP
         xvr6C3x/6/0arbvZdI6jkkvLZMh9LIrUTOaxNmP2rYYd9C4vyxgQ1khtPeXdpgG+10cK
         04xGZRep6AtTfkgz03g9/xBySl8uLmTO/BSVhBW5wxY8v3TNyFMaQKwtVJ3lGZBVOKK9
         E0bA==
X-Forwarded-Encrypted: i=1; AL+hErEOJlT8QVaP12tm8QBvdGMZR2GnzRBFfD3G2t2cu1LWXVzi+1HVePZE87N+P3sRF8u9gkEWDQfe3rYP@vger.kernel.org
X-Gm-Message-State: APuU4Z+yRCD2bYvGhUyi5/nkEK5f2+Gje+aB2OTvv7qfQui+yYoaHsNa
	E4hyMsiaJufBiE8aIuZjgaEC4HLdSF/a2kekuzfZpWwMq6gSmBmqlzvh
X-Gm-Gg: AYBFou2OkPdlpih27qkp1+Wmc/+vJdIJ2pdROwDuInyjIkZA/7Uh729mKvEjLl/hlwp
	sV65kPy3ScfiR4YyAPU9tjFFi3rC76KtOOm7DXC9ocl0p6/jcXlFrrgBS//wb6nskuX138UctzS
	fVwsCYGgoyekwqS4dqaK8B6mH1yEZ0DIEj8Old9wlOkMF1VlJ+lu3ZzD9JUUOmtpZ7soXK68UOc
	iej4MxzEUNByQLEOhdizFRG3uPNhxzsbJA/OXKwAGz2Jexz2S8nE5jZaQgKo76zDbA19nJ5FfKV
	Z3kvYoFRspAVfWwFS8lgItUfF/aFgrcBdm5THHrLwBFrsuLipjSVn/8h5S5vi9Iph5qnW1JtiAv
	mciu4BT1YExHrwYL4yuSJhqIzgnWMK3RB4FhiiW1pRIG4XrUpYNbdjeNYMJQALNMSPUER4+cVxu
	w7GtqYqIqfVg/hccFogDCFp95jwt8kqjrCLA0JpPmKojCCZ4kj9MT2WJfNj3a3BkkkQjnuiC80o
	GSa+6LHk3tN82/nv8WwLh9lR7ewUFG0OsBnE+G8sCYDzGBGCyNj1T48x1PvFRG4xQva3wGjCFnj
	gVzy6WWZLQYHpzMG3TGVVjHFBfHsaC8+BQCy6YZtEL1etGddUMEk7ghrBvbFOw==
X-Received: by 2002:a05:701b:4552:10b0:143:5c2a:e45f with SMTP id a92af1059eb24-1b39fdaf96bmr5061989c88.0.1794166173146;
        Sun, 08 Nov 2026 11:29:33 -0800 (PST)
Received: from [192.168.1.11] ([2401:4900:881e:93af:b6d8:a723:b13b:3c1b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755eb6efsm8800387c88.4.2026.11.08.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:29:32 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Subject: [PATCH v2 0/2] dt-bindings: arm: omap-l3-noc: Convert to DT schema
Date: Mon, 09 Nov 2026 00:59:16 +0530
Message-Id: <20261109-ti-l3-noc-v2-0-509e8485a1f3@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NQQ6CMBAAv0L27BraRgOe/IfhULYLrAFqWmw0h
 L8LGBOPk0xmZogchCNcshkCJ4nixxX0IQPq7NgyilsZdK7PKs81ToK9wdET6sI1ZAvVODrB6j8
 CN/LaW7fqy/FZ35mmLbAZncTJh/c+S2rzfl3z100KFZa1UwVZMobLaztY6Y/kB6iWZfkAlTM+G
 LQAAAA=
X-Change-ID: 20261002-ti-l3-noc-28dfca81fdc5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Santosh Shilimkar <santosh.shilimkar@ti.com>, 
 Sricharan R <r.sricharan@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com, linux-omap@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794166167; l=1249;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=K6eNGCEmoAmi4nk9SdcQuMxZbbIDLpxuaZ3Z3g7Mvjc=;
 b=k6VrIzg4IlUrfH0wtgd/Rbtm22qUDGqnR/FcbVb/nmGOY8v7B4sz+3m8fvb+DOOVQBjDyilxI
 VImtW87SNqrDkaNLRnIRJMO95m7fWCC+bV6iok1BX5rAw98GeBM6tsR
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

This series converts the TI OMAP L3 NoC binding from text to DT schema.

On OMAP3 the ti,omap3-l3-smx node is deliberately modelled as a flat
simple-bus for the whole SoC,so  schema allows child nodes for that
compatible only. The NoC variants AM437x have no child nodes.

Patch 1 is a DTS change and patch 2 is the binding change. Patch 2
depends on patch 1 only to avoid a dtbs_check warning on omap36xx
boards.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Changes in v2:
- Move binding to bindings/bus/
- Rebase to latest mainline rc
- Add unit address to regulator-abb-mpu node
- Link to v1: https://lore.kernel.org/r/20261003-ti-l3-noc-v1-1-9bd18cac33e9@gmail.com

---
Bhargav Joshi (2):
      ARM: dts: omap36xx: Add unit address to ABB regulator node
      dt-bindings: arm: omap-l3-noc: Convert to DT schema

 .../devicetree/bindings/arm/omap/l3-noc.txt        |  23 ----
 .../devicetree/bindings/bus/ti,omap-l3-noc.yaml    | 153 +++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/omap36xx.dtsi            |   2 +-
 3 files changed, 154 insertions(+), 24 deletions(-)
---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261002-ti-l3-noc-28dfca81fdc5

Best regards,
-- 
Bhargav

