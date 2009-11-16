From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] omap3: ehci: Add regulator framework
Date: Mon, 16 Nov 2009 09:55:14 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA6893B6@dbde02.ent.ti.com>
References: <1258274748-28053-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56323 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbZKPEZR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Nov 2009 23:25:17 -0500
In-Reply-To: <1258274748-28053-1-git-send-email-ajay.gupta@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

Ajay

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gupta,
>Ajay Kumar
>Sent: Sunday, November 15, 2009 2:46 AM
>To: linux-omap@vger.kernel.org
>Cc: felipe.balbi@nokia.com; broonie@opensource.wolfsonmicro.com; Gupta, Ajay Kumar
>Subject: [PATCH] omap3: ehci: Add regulator framework
<snip>
>+	/* get ehci regulator and enable */
>+	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
>+		if (omap->port_mode[i] != EHCI_HCD_OMAP_MODE_PHY) {
>+			omap->regulator[i] = NULL;
>+			continue;
>+		}
>+		snprintf(supply, sizeof(supply), "hsusb%d", i);

supply[] being auto variable, is it guaranteed to be null terminated? 
Suggestion:
		n = snprintf(supply, sizeof(supply), "hsusb%d", i);
		supply[n] = '\0';

>+		omap->regulator[i] = regulator_get(omap->dev, supply);
>+		if (IS_ERR(omap->regulator[i]))
>+			dev_dbg(&pdev->dev,
>+			"failed to get ehci port%d regulator\n", i);
>+		else
>+			regulator_enable(omap->regulator[i]);
>+	}
>+
<snip>
