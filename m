From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP3: PM: PRCM interrupt: Fix warning "MPU wakeup but
 no wakeup sources"
Date: Fri, 19 Nov 2010 13:47:27 +0200
Message-ID: <20101119114727.GM2329@legolas.emea.dhcp.ti.com>
References: <1290165993-23847-1-git-send-email-ext-madhusudhan.1.gowda@nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:35538 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751257Ab0KSLrW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 06:47:22 -0500
Received: by mail-gw0-f46.google.com with SMTP id 17so2958317gwj.5
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 03:47:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290165993-23847-1-git-send-email-ext-madhusudhan.1.gowda@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Gowda <ext-madhusudhan.1.gowda@nokia.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Hi,

On Fri, Nov 19, 2010 at 01:26:33PM +0200, Madhusudhan Gowda wrote:
>@@ -277,13 +278,16 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
> 		if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
> 				     OMAP3430_IO_ST_MASK)) {
> 			c = _prcm_int_handle_wakeup();
>+			ct++;
>
> 			/*
> 			 * Is the MPU PRCM interrupt handler racing with the
> 			 * IVA2 PRCM interrupt handler ?
> 			 */
>-			WARN(c == 0, "prcm: WARNING: PRCM indicated MPU wakeup "
>-			     "but no wakeup sources are marked\n");
>+			if (ct == 1)
>+				WARN(c == 0, "prcm: WARNING: PRCM indicated "
>+					"MPU wakeup but no wakeup sources "
>+					"are marked\n");

WARN(!c && (ct == 1), "prcm: WARNING: PRCM indicated "
	"MPU wakeup but no wakeup sources "
	"are marked\n");

would do it? Then you don't need the extra if ().

-- 
balbi
