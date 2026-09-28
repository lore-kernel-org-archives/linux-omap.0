Received: from mail-pz2-f27.google.com (mail-pz2-f27.google.com [74.125.228.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B944F55DA
	for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617022; cv=none; b=Ushgt+df6zfn71BvWpiBunO8/A5rrccaBGZr9n5Y1ulxoiWnDerSmIkNfdvGS4UdrFqjtZvPYsZjAvzY0RAAhgfv/rjT3TBe9wigA7A6f4Ec5fYHTknxQQPCOUgmYPiMMTy6wNBhXukK9npVPKE64mCmpvAYurdiRD8f1mi7dHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617022; c=relaxed/simple;
	bh=51IqI+Wuv3O2K3tbr9n/d59/5qo9ePT36iarXmxvd48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ad6E6TE0cCwwRRKAU+SVdRQLefgSycvaYejOFzHbfN+XeGFSi0kwBQXny5IhiE3dmDCZulkIFqEsCl8zxy0qvtXqeubmFOsvighb8QAdZ8r64xVq6sd1XeS7f4bnRdJQbIEqGVfHZpD/yYlK+iO+FfiWHPxLR13i6UrPZeVFIlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ff+Pcosz; arc=none smtp.client-ip=74.125.228.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ff+Pcosz"
Received: by mail-pz2-f27.google.com with SMTP id d2e1a72fcca58-880fcd3790bso1038463b3a.1
        for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2026 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790617020; x=1791221820; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U7p18ol6P0YPGqM1fpj3iPohmUFqHGT7j7iYHvqBoic=;
        b=Ff+PcoszV6RCShxPNYnrtZzXKmSXPjLn5UdePiVoCL1b4M4lp/ZgLG6GOTFpMUH2sj
         1ICP5lKwe0vX3J8xcrOuK/O7lmF86I0qR5oUQgDE1HhpKbLtIUBCevai5SZoX+Td9fPI
         egX3U1Rd/F59bf2/NJ5qoPSudIJvdUNJ/TGB71cpbOqektJM+BFFtIkKATP2+rviqs+t
         IoOwm3+ljPbCqZPp+gJBaCCvQ/aGvevHgCz1PYCMzIApUeJ6nPLMyYCoHP4QA7vO64fc
         HePj5D7UpbKayNOYbfV9B6TqNI2NIg94FQfR5LK63ADjrZsThcmAZYJAPv+dMHbnF1ff
         TPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617020; x=1791221820;
        h=content-type:mime-version:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U7p18ol6P0YPGqM1fpj3iPohmUFqHGT7j7iYHvqBoic=;
        b=PlJD/ELbqEVddJrkQ7gyQTsSZBv0+0+2URUM6NwhwAZlM2DZJDcKTLZmbD3oZ+hre1
         OtBS0M5G+fZT7rWcWpRRmDvDfll9V1Tk1elBIQfTkDbAZCCWvAFLqyF72feaThorFfsZ
         RgDQDVNQkhhd9GUaeWTzFEuw0EafvuETL3uLbpJHpVS4xdSY6SZH7E/VTkVj7K3JqdPH
         LuoxFHEQE4tI76WN50OJsQ2QsVBmUdmQAkMfEwPsnqJ1tsdzbIEwlKpzwrhwadbpA6Jl
         foavTrlquVNMN78T62rrLzog5sQb2iBH8gQyZyA1O+0giMyZ4TKfZhDtqFCTqrbWgY27
         XB/g==
X-Gm-Message-State: AFuF++ma4yAROqh/KQWIqiqXZQ7o2WPbhEKzCz6BcJh05kKtRlwTIZMN
	sIkHJn2GgJgw4gckZTekpL3Xn73R8Mrx4aaD8+U8xwDOPGdP6EVBDVN378xg2ZwsMFYHLeXCq2R
	orXgQ
X-Gm-Gg: AYBFou3EfBknS6+RVSXTdlwMIpguuFIMeeIDGHHyNlZK8ko+/mRHvLdAz1tb/qgc4Dh
	JrrlenQ0mmjgi6/u6j49w/5yL6Rj4y8GbfgMrsI3j7WS+BqAViv/dXA133uQe2ItfjupltQgofJ
	8sEpWqtpMPw0EsCbRj7y28UIAlvV9eSvcRMXkttzX407AHgsDrPUTuW7t29j5grzKAF5w8p1uw+
	n6iLMjwB7PsjdT/B5fzM2w8aMnCFNNfS/4gqRHVhN40YcodVL91IeOhKTKbs3EPthtNi0QYaKY3
	2pu9A8LMoE4Uy/21uFJ5DI/KqyrAnZArxUTINGagYH7nNR1UDTnfSwKYWWUX7pRqYiwyM69yPUC
	ucgNzmGuTQkGClEi37el6YWs30TMzzukJ4xznIkwCoovEbwbVRxvltx68G1jvKywU43dPgAhzQT
	E3osrGEuH6Cgjnt1PmFcwGaT5pqSUZe5DJyW6hblVHuCCOcHJOc5PDmQNfJGuJsS1gcvI=
X-Received: by 2002:a05:6300:6d87:10b0:3de:74ee:c04c with SMTP id adf61e73a8af0-3de74eec3bfmr966694637.60.1790617020321;
        Mon, 28 Sep 2026 10:37:00 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cc7a4b03082sm2807652a12.11.2026.09.28.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:36:59 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: soc@lists.linux.dev
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: dts: OMAP updates for v7.4
Date: Mon, 28 Sep 2026 10:36:59 -0700
Message-ID: <7ha4p1b7lw.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.4/dt-signed

for you to fetch changes up to c3037b5c7c38bdf78c214e7dbe513a553ce8f47b:

  ARM: dts: am335x-bonegreen-eco: Enable 1GHz OPP by increasing vdd_mpu voltage (2026-09-21 09:02:20 -0700)

----------------------------------------------------------------
ARM: dts: OMAP updates for v7.4
- am335x-bonegreen-eco: Enable 1GHz OPP
- clock fixes for camera sensors
- misc cleanups, DT fallbacks, schema updates

----------------------------------------------------------------
Bhargav Joshi (3):
      ARM: dts: ti: am57xx-idk-common: Remove unused ext-clk-src property
      ARM: dts: ti: am335x-shc: Remove unused ti,no-init property
      ARM: dts: omap: dra7: add da830 fallback to am3352 rtc compatible string

Eduard Bostina (3):
      dt-bindings: input: Convert TI Keypad Controller to DT schema
      ARM: dts: ti: omap: Disable keypad and enable it on the boards that use it
      ARM: dts: ti: omap: Fix Palmas RTC node names

Kory Maincent (TI.com) (1):
      ARM: dts: am335x-bonegreen-eco: Enable 1GHz OPP by increasing vdd_mpu voltage

Krzysztof Kozlowski (2):
      ARM: dts: ti: omap: Correct white-space style
      ARM: dts: ti: omap: Replace spaces indentation with tabs

Laurent Pinchart (3):
      ARM: dts: ti: omap3-n950: Replace clock-frequency in camera sensor node
      ARM: dts: ti: omap3-n9: Replace clock-frequency in camera sensor node
      ARM: dts: ti: omap3-n900: Replace clock-frequency in camera sensor node

Roger Quadros (1):
      ARM: dts: ti: Add device tree nodes for PRU-ICSS1 instance on AM571x

 Documentation/devicetree/bindings/input/omap-keypad.txt      | 28 ----------------------------
 Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am335x-boneblack-hdmi.dtsi         |  2 +-
 arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts           |  2 +-
 arch/arm/boot/dts/ti/omap/am335x-shc.dts                     |  4 ----
 arch/arm/boot/dts/ti/omap/am437x-l4.dtsi                     |  2 +-
 arch/arm/boot/dts/ti/omap/am57-pruss.dtsi                    | 11 +++++++++++
 arch/arm/boot/dts/ti/omap/am571x-idk.dts                     | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts            |  2 +-
 arch/arm/boot/dts/ti/omap/am57xx-beagle-x15-common.dtsi      |  2 +-
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi             |  3 +--
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi                       |  2 +-
 arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi      |  8 ++++----
 arch/arm/boot/dts/ti/omap/motorola-mapphone-mz607-mz617.dtsi |  2 ++
 arch/arm/boot/dts/ti/omap/omap3-igep.dtsi                    |  2 +-
 arch/arm/boot/dts/ti/omap/omap3-n9.dts                       |  5 ++++-
 arch/arm/boot/dts/ti/omap/omap3-n900.dts                     |  3 ++-
 arch/arm/boot/dts/ti/omap/omap3-n950.dts                     |  5 ++++-
 arch/arm/boot/dts/ti/omap/omap3-tao3530.dtsi                 |  8 ++++----
 arch/arm/boot/dts/ti/omap/omap4-droid-bionic-xt875.dts       |  2 ++
 arch/arm/boot/dts/ti/omap/omap4-droid4-xt894.dts             |  2 ++
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts            |  2 ++
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi                      |  1 +
 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi |  6 +++---
 arch/arm/boot/dts/ti/omap/omap4-sdp.dts                      |  2 ++
 arch/arm/boot/dts/ti/omap/omap4.dtsi                         |  6 +++---
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi                      |  1 +
 arch/arm/boot/dts/ti/omap/omap5.dtsi                         |  2 +-
 28 files changed, 183 insertions(+), 60 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/omap-keypad.txt
 create mode 100644 Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml
