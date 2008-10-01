From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: RE: [PATCH 14/22] minor irq-related cleanups
Date: Wed, 1 Oct 2008 12:23:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028C45E77F@dbde02.ent.ti.com>
References: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-2-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-3-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-4-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-5-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-6-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-7-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-8-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-9-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-10-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-11-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-12-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-13-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-14-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-15-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48888 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbYJAGyJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 02:54:09 -0400
In-Reply-To: <1222694079-16289-15-git-send-email-felipe.balbi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>

> -	ret = request_irq(TWL4030_PWRIRQ_RTC, twl4030_rtc_interrupt,
> +	ret = request_irq(irq, twl4030_rtc_interrupt,
>  				0, rtc->dev.bus_id, rtc);

RTC was requesting "TWL4030_PWRIRQ_RTC".

>  out2:
> -	free_irq(TWL4030_MODIRQ_PWR, rtc);
> +	free_irq(irq, rtc);

And, like BCI, was freeing a different IRQ no - "TWL4030_MODIRQ_PWR". Yet another great fix. ACK for this part too.

--
Jagadeesh
