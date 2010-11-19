From: <ext-madhusudhan.1.gowda@nokia.com>
Subject: RE: [PATCH] OMAP3: PM: PRCM interrupt: Fix warning "MPU wakeup but
 no wakeup sources"
Date: Fri, 19 Nov 2010 14:53:19 +0100
Message-ID: <090FE800A758CA439B2752C082AC3DEF0666E2AB0B@NOK-EUMSG-06.mgdnok.nokia.com>
References: <1290165993-23847-1-git-send-email-ext-madhusudhan.1.gowda@nokia.com>,<20101119114727.GM2329@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36903 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab0KSNyx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 08:54:53 -0500
In-Reply-To: <20101119114727.GM2329@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Yes Balbi. I will incorporate your comments.

Regards
Gowda 

________________________________________
From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of ext Felipe Balbi [balbi@ti.com]
Sent: Friday, November 19, 2010 1:47 PM
To: Gowda Madhusudhan.1 (EXT-Elektrobit/Helsinki)
Cc: linux-omap@vger.kernel.org; paul@pwsan.com
Subject: Re: [PATCH] OMAP3: PM: PRCM interrupt: Fix warning "MPU wakeup but no wakeup sources"

Hi,

On Fri, Nov 19, 2010 at 01:26:33PM +0200, Madhusudhan Gowda wrote:
>@@ -277,13 +278,16 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>               if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
>                                    OMAP3430_IO_ST_MASK)) {
>                       c = _prcm_int_handle_wakeup();
>+                      ct++;
>
>                       /*
>                        * Is the MPU PRCM interrupt handler racing with the
>                        * IVA2 PRCM interrupt handler ?
>                        */
>-                      WARN(c == 0, "prcm: WARNING: PRCM indicated MPU wakeup "
>-                           "but no wakeup sources are marked\n");
>+                      if (ct == 1)
>+                              WARN(c == 0, "prcm: WARNING: PRCM indicated "
>+                                      "MPU wakeup but no wakeup sources "
>+                                      "are marked\n");

WARN(!c && (ct == 1), "prcm: WARNING: PRCM indicated "
        "MPU wakeup but no wakeup sources "
        "are marked\n");

would do it? Then you don't need the extra if ().

--
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
