From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 3/3] MAINTAINERS: Add dwc3-st.c file to ARCH/STI architecture
Date: Fri,  4 Jul 2014 12:13:52 +0100
Message-ID: <1404472432-24764-4-git-send-email-peter.griffin@linaro.org>
References: <1404472432-24764-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38352 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbaGDLO1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2014 07:14:27 -0400
Received: by mail-wi0-f176.google.com with SMTP id n3so12812233wiv.3
        for <linux-omap@vger.kernel.org>; Fri, 04 Jul 2014 04:14:24 -0700 (PDT)
In-Reply-To: <1404472432-24764-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, devicetree@vger.kernel.org, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 702ca10..269ad3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1325,6 +1325,7 @@ F:	drivers/pinctrl/pinctrl-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/tty/serial/st-asc.c
+F:	drivers/usb/dwc3/dwc3-st.c
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
1.9.1

