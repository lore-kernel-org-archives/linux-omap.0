From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 0/2] Add support for Toby Churchill SL50 board.
Date: Tue, 26 May 2015 13:13:25 +0200
Message-ID: <1432638807-6582-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34038 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbbEZM7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2015 08:59:19 -0400
Received: by wicmc15 with SMTP id mc15so64033206wic.1
        for <linux-omap@vger.kernel.org>; Tue, 26 May 2015 05:57:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: javier.martinez@collabora.co.uk, andy.simpkins@toby-churchill.com, sjoerd.simons@collabora.co.uk, nick.milner@collabora.co.uk

Hi Tony,

These patches add support for a new board based on AM335x processor. If it
is ok, take in consideration to include in next DT merge window, please.

Best regards,

Enric Balletbo i Serra (2):
  of: Add vendor prefix for Toby Churchill Ltd.
  ARM: dts: am335x-sl50: Add Toby-Churchill SL50 board support.

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-sl50.dts                  | 482 +++++++++++++++++++++
 3 files changed, 484 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-sl50.dts

-- 
2.1.0

