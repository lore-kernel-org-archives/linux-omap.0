From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] omap3: ehci: Add regulator framework
Date: Mon, 16 Nov 2009 19:42:45 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA68981F@dbde02.ent.ti.com>
References: <1258274748-28053-1-git-send-email-ajay.gupta@ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA6893B6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52960 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbZKPOMw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 09:12:52 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA6893B6@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Pandita, Vikram
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gupta,
>>Ajay Kumar
>>Sent: Sunday, November 15, 2009 2:46 AM
>>To: linux-omap@vger.kernel.org
>>Cc: felipe.balbi@nokia.com; broonie@opensource.wolfsonmicro.com; Gupta, Ajay Kumar
>>Subject: [PATCH] omap3: ehci: Add regulator framework
><snip>
>>+	/* get ehci regulator and enable */
>>+	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
>>+		if (omap->port_mode[i] != EHCI_HCD_OMAP_MODE_PHY) {
>>+			omap->regulator[i] = NULL;
>>+			continue;
>>+		}
>>+		snprintf(supply, sizeof(supply), "hsusb%d", i);
>
>supply[] being auto variable, is it guaranteed to be null terminated?
>Suggestion:
>		n = snprintf(supply, sizeof(supply), "hsusb%d", i);
>		supply[n] = '\0';

Setting null is redundant as snprintf() does that internally too.

Can see snprinf calls vsnprintf and:
vsnprintf( ... ) 
...
       if (size > 0) {
                if (str < end)
>>>>                        *str = '\0';
                else
                        end[-1] = '\0';
        }
...
So I guess this is a noisy review comment :) and please ignore.
Patch looks good.

>
>>+		omap->regulator[i] = regulator_get(omap->dev, supply);
>>+		if (IS_ERR(omap->regulator[i]))
>>+			dev_dbg(&pdev->dev,
>>+			"failed to get ehci port%d regulator\n", i);
>>+		else
>>+			regulator_enable(omap->regulator[i]);
>>+	}
>>+
><snip>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

