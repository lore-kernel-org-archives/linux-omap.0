From: =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Subject: am33xx: ignore SYSBOOT 15:14 if board OSC is known
Date: Thu, 21 May 2015 17:26:33 +0100
Message-ID: <CAEXMXLT9EJ33Yu-fQbL77YHaL_ftGSroOTxmRzyDPR6fb7x-yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36203 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbbEUQ0y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2015 12:26:54 -0400
Received: by pdfh10 with SMTP id h10so113347501pdf.3
        for <linux-omap@vger.kernel.org>; Thu, 21 May 2015 09:26:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: t-kristo@ti.com

Currently the processor PLLs and Dividers are configured according to
SYSBOOT levels during boot [1][2].

In the case of boards with expansion capabitliy, like the Beaglebone,
the expansion board might touch this SYSBOOT pins a provide a wrong
clock information.

If we know the OSC on board as a fact (for example 24MHz for the
Beaglebone), the SYSBOOT information can be safely ignored and the
correct value hardcoded on the DT.

The patch following works for am33xx.

Anyway I have some reservations about this. Maybe overriding
"sys_clkin_ck" with "virt_24000000_ck" is a better solution?

Regards,
Nuno

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/am33xx-clocks.dtsi#n11
[2] http://www.ti.com/lit/ug/spruh73l/spruh73l.pdf


diff --git a/src/arm/am335x-bone-common.dtsi b/src/arm/am335x-bone-common.dtsi
index 77067d6..1ddaa58 100644
--- a/src/arm/am335x-bone-common.dtsi
+++ b/src/arm/am335x-bone-common.dtsi
@@ -356,6 +356,10 @@
        status = "okay";
 };

+&sys_clkin_ck {
+       clocks = <&virt_24000000_ck>, <&virt_24000000_ck>,
<&virt_24000000_ck>, <&virt_24000000_ck>;
+};
+
 /* the cape manager */
 / {
        bone_capemgr {
