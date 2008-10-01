From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: RE: [PATCH 23/25] twl4030-bci: move to new style registration method
Date: Wed, 1 Oct 2008 12:19:59 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028C45E775@dbde02.ent.ti.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
 <1222800189-29737-2-git-send-email-me@felipebalbi.com>
 <1222800189-29737-3-git-send-email-me@felipebalbi.com>
 <1222800189-29737-4-git-send-email-me@felipebalbi.com>
 <1222800189-29737-5-git-send-email-me@felipebalbi.com>
 <1222800189-29737-6-git-send-email-me@felipebalbi.com>
 <1222800189-29737-7-git-send-email-me@felipebalbi.com>
 <1222800189-29737-8-git-send-email-me@felipebalbi.com>
 <1222800189-29737-9-git-send-email-me@felipebalbi.com>
 <1222800189-29737-10-git-send-email-me@felipebalbi.com>
 <1222800189-29737-11-git-send-email-me@felipebalbi.com>
 <1222800189-29737-12-git-send-email-me@felipebalbi.com>
 <1222800189-29737-13-git-send-email-me@felipebalbi.com>
 <1222800189-29737-14-git-send-email-me@felipebalbi.com>
 <1222800189-29737-15-git-send-email-me@felipebalbi.com>
 <1222800189-29737-16-git-send-email-me@felipebalbi.com>
 <1222800189-29737-17-git-send-email-me@felipebalbi.com>
 <1222800189-29737-18-git-send-email-me@felipebalbi.com>
 <1222800189-29737-19-git-send-email-me@felipebalbi.com>
 <1222800189-29737-20-git-send-email-me@felipebalbi.com>
 <1222800189-29737-21-git-send-email-me@felipebalbi.com>
 <1222800189-29737-22-git-send-email-me@felipebalbi.com>
 <1222800189-29737-23-git-send-email-me@felipebalbi.com>
 <1222800189-29737-24-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43278 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338AbYJAGuV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 02:50:21 -0400
In-Reply-To: <1222800189-29737-24-git-send-email-me@felipebalbi.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>


>  	/* request Power interruption */
> -	ret = request_irq(TWL4030_PWRIRQ_CHG_PRES, twl4030charger_interrupt,
> +	ret = request_irq(irq, twl4030charger_interrupt,
>  		0, pdev->name, di);

BCI was requesting " TWL4030_PWRIRQ_CHG_PRES".

>  batt_failed:
> -	free_irq(TWL4030_MODIRQ_PWR, di);
> +	free_irq(irq, di);

And it was freeing "TWL4030_MODIRQ_PWR". Now that is fixed. Nice catch!! ACK for this part.
