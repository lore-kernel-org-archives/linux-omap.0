Return-Path: <SRS0=Pap7=6F=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27699C5518B
	for <linux-omap@archiver.kernel.org>; Tue, 21 Apr 2020 23:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDAC2072D
	for <linux-omap@archiver.kernel.org>; Tue, 21 Apr 2020 23:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgDUX2P (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 21 Apr 2020 19:28:15 -0400
Received: from muru.com ([72.249.23.125]:50880 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUX2K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 21 Apr 2020 19:28:10 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9543081BA;
        Tue, 21 Apr 2020 23:28:56 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Lee Jones <lee.jones@linaro.org>, Jiri Slaby <jslaby@suse.cz>,
        Johan Hovold <johan@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: omap4-droid4: Enable basic modem support
Date:   Tue, 21 Apr 2020 16:27:52 -0700
Message-Id: <20200421232752.3070-5-tony@atomide.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200421232752.3070-1-tony@atomide.com>
References: <20200421232752.3070-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

This allows apps to use /dev/motmdm1 for voice call AT commands,
/dev/motmdm3 for sending SMS, and /dev/motmdm9 for reading SMS.

Voice call audio mixer and GNSS are not yet supported.

Reviewed-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -698,6 +698,12 @@ &uart1 {
 	pinctrl-0 = <&uart1_pins>;
 	interrupts-extended = <&wakeupgen GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0xfc>;
+
+	modem {
+		compatible = "motorola,mapphone-mdm6600-serial";
+		phys = <&fsusb1_phy>;
+		phy-names = "usb";
+	};
 };
 
 &uart3 {
-- 
2.26.2
