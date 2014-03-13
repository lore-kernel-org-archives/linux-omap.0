From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH] wl1251 device tree support
Date: Thu, 13 Mar 2014 22:59:54 +0100
Message-ID: <1394747995-25090-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:49683 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350AbaCMWAE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 18:00:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, "John W. Linville" <linville@tuxdriver.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Hi Tony/Beno=C3=AEt,

The DT support for wl1251 has been merged to wireless-next [0],
so I guess it's safe to merge the following DTS addition for 3.15.

[0] https://git.kernel.org/cgit/linux/kernel/git/linville/wireless-next=
=2Egit/commit/?id=3D07bbca6f142d02b4b09d66ed3c2cde36c77057ad

-- Sebastian

Sebastian Reichel (1):
  DTS: ARM: OMAP3-N900: Add WL1251 support

 arch/arm/boot/dts/omap3-n900.dts | 40 ++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 40 insertions(+)

--=20
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
