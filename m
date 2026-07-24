Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5A37DEA1
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926935; cv=none; b=VlYOzOAFWA6jPiuiY1EEuxRVjl8Kx6wORrhO5bBMhAwiNf//JYGLk3sOIP8P63heWt+fskODVYdKGxGBPg2zBXznflLzhBP46Vc/bpImWX+tqX8604quZVZJ8P78lglLss7P+8O0pBzaIlbTGzUGZztVOuV5j1V4lDC5nPlCLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926935; c=relaxed/simple;
	bh=oiezVeKcRlTe1PqOfCSipMo+Ro5s/wiQve6Jzg9tiMU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gBwiseHc2MpjB5l1x4+K9cPJwwbMhrEphkivTEWI616/9e8fHxLcL+obdVNl7djNS/gPHEOf9C82lwTqk999/vgYHkzGgywnyyEmLZiQ/tT4P/+k6i/XkC5GRqQFL22wGXH0dPFtDOS+25ODjQOVRIyvoqSpGratEputwa7E7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckaD+4du; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckaD+4du"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca6d9c91206so75654a12.2
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 14:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784926934; x=1785531734; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YG/Q8uWJXgAMBnQ0HDciH4ZFOI8e9N+pTkNtrhEgb1E=;
        b=ckaD+4duOP2LsCnJA8YAbUx8D62dEpfcdTTrzdJ2QWojyOjIDU2bVA33rGeF7/gRTx
         jYPnKbto/i9AQJkWoqE6hiSpWXj6GVWvAfWKyAnN+OzsX2a9hBagrei91cEnLZ1WoXHJ
         vlOlpicXh5EjAyN/ix9bVBECwF3b3Q6FIhRNdkNm9dfN/DY4oRqif72nbILYTRaOSx8E
         wicDVZeVpSfG2JL4Hi29C0ymGsvkLCtAFTHyTfoHBwjVgA14fHyeqhjuNmjwFx5FTAfk
         NAP703FNOMOvE+rAzaCwqvZu9gcvWHYJxKGlYdgFM7CDmBVKIOB9ejLkKGpH/gxvklSo
         IECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784926934; x=1785531734;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YG/Q8uWJXgAMBnQ0HDciH4ZFOI8e9N+pTkNtrhEgb1E=;
        b=ci/adLfdb6LZ54yMDDWYETPakK4RIG4VxbFj8h/XUUzIZP71IILwT7BP6AYHI1XxI/
         rKp7ZQHOsefQMq+s0h3GyO0FhedtcT2ocqKk//AJNrYFyKOS5by9C+t0R9WMPz0iQNHn
         UsbqAuZeeefSyEjUgBM2g/gKO059otd5e5OyjiB/X7XHbMowI1usapqSKm3mQsn50wtZ
         k63lsjKKFj4vcra1azjsN+8s90Lttb8KKfMTs07gV1OmlFYmpQsMgW0IJuAVazQoxpaq
         YFgTDH99+UdmrHNbb74wGSWv4o1Uk+2mcsBuHMXUHF5pVS/mX6NpI0eBMd5RBVYRYoyq
         QKig==
X-Gm-Message-State: AOJu0YyD7J34GNVu/+IUV/lXouh8CpmCxAdh7ipRql5PFDPjcAAzNAox
	kZTaJPF0dxrFhHjvmiLsVkJyG/z6QkhSOTDlDDhI17HfFgUJ9B5wHCxq
X-Gm-Gg: AR+sD10OP4Xoxn23TDEiIny3652ImiIyO+rIim6S9AUL34vWahi9pyJN71pXr4wDA4w
	k0EX9gyOg6z3NHrkd1bvKNTovFJkZmIOrtug7cVfVEudPkWvFdTimXqOHNyvLsextFRnx+SiNr6
	lKU8KBtF2Rk/Wv6g+uKY2q8D0WvWq+f+DypnyvBsjHMCnUZ59D0HcdtQOuXvuObDCh4YXq7Ltey
	D9vXfQB8oJ5ZlvJtlGPT8AF0wJjkzaJKh5DNKzWCBAQiNwfxBzgGzQ4YB2Jztx4SH9AP+yytFpm
	dcAr8LHu0kgJ7ukCJtdk5Vy/iO+OIAntcppvOG/iMEYwv6u3cZTjsZZQmfw//d1/l1LVjdo7Lnh
	vZR1/dUQXjXF6mOdL5ehQP3m3cXbA5RBJHtGx8+sF68sNRAxNlx2h/VQ8RH8mbSHnZS1CpNbteM
	TJtTPnkHFiHE+yqFg=
X-Received: by 2002:a17:903:468d:b0:2c9:99be:f011 with SMTP id d9443c01a7336-2cfde8941b5mr333455ad.6.1784926933449;
        Fri, 24 Jul 2026 14:02:13 -0700 (PDT)
Received: from [172.28.140.252] ([2409:40c2:505f:3320:3d54:c6f0:368a:d94b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e63sm2485324eec.19.2026.07.24.14.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:02:12 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Subject: [PATCH v2 0/3] dt-bindings: rtc: ti,omap-rtc: Convert to DT schema
 and cleanups
Date: Sat, 25 Jul 2026 02:31:55 +0530
Message-Id: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7RgoQhtX3MOwqGUKY4SSthIN4
 e5S3Lp8yfvvrxDIMwW4Zit4Wjiwm3YQpwzMoKeekLudQeSizqW4YGR0o57RR4O1rkyllCJJJey
 L2ZPl91G7tT8Or/uDTEyJZAwcovOf424pkve/vBSYo7VkpVJVabq66UfNz7NxI7Tbtn0Bqa5ga
 bgAAAA=
X-Change-ID: 20260724-ti-omap-rtc-6a5c5888e7e3
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Keerthy <j-keerthy@ti.com>, Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784926923; l=1583;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=oiezVeKcRlTe1PqOfCSipMo+Ro5s/wiQve6Jzg9tiMU=;
 b=uxL1i3VF9gRymvQeuoapoNvahdEpP7fouKUw9bWexjYWd3CnT6hBRO/nNfA/3vEzij0TyBumX
 nB9P+HwP/eICgWWFglzshKkiuxRWC60rW+Iidog2TC6mtN0lv4LMgdV
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

This series converts the Texas Instruments OMAP Real Time Clock (RTC) 
binding from the legacy format to dt-schema.

During the conversion process, two legacy, undocumented properties 
were discovered in the upstream device trees:
 - 'ext-clk-src' in am57xx-idk-common.dtsi
 - 'ti,no-init' in am335x-shc.dts

Both properties are completely unhandled by the rtc-omap driver. Patches
1 and 2 remove them from the device trees. Patch 3 then introduces the
new YAML schema.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Changes in v2:
- Patch 1: unchanged
- Patch 2: unchanged
- Patch 3: Removed left out legacy text binding and Added constraint
  block restricting 'system-power-controller' and 'ext-wakeup' subnodes
  strictly to hardware variants that support PMIC mode
- Link to v1: https://lore.kernel.org/r/20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com

---
Bhargav Joshi (3):
      ARM: dts: ti: am57xx-idk-common: Remove unused ext-clk-src property
      ARM: dts: ti: am335x-shc: Remove unused ti,no-init property
      dt-bindings: rtc: ti,omap-rtc: Convert to DT schema

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  53 --------
 .../devicetree/bindings/rtc/ti,omap-rtc.yaml       | 149 +++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am335x-shc.dts           |   4 -
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi   |   1 -
 4 files changed, 149 insertions(+), 58 deletions(-)
---
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
change-id: 20260724-ti-omap-rtc-6a5c5888e7e3

Best regards,
-- 
Bhargav

