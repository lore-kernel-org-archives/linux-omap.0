From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH] twl4030-madc device tree support
Date: Wed, 19 Mar 2014 00:13:45 +0100
Message-ID: <1395184426-316-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:44782 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756274AbaCRXOA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 19:14:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Hi Tony/Beno=C3=AEt,

The DT support for twl4030-madc has been added to mfd queue [0],
so I guess it's safe to merge the following DTS addition for 3.15.

[0] https://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/commit/?h=3D=
ib-mfd-io-3.15&id=3D2f39b70fef194a54c9decd8687bb05d576afebe5

-- Sebastian

Sebastian Reichel (1):
  DTS: ARM: TWL4030: Add madc

 arch/arm/boot/dts/twl4030.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

--=20
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
