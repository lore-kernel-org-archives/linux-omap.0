From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 1/3] I2C: TWL4030: Add power button and power IRQ
	support
Date: Thu, 3 Apr 2008 16:57:33 +0300
Message-ID: <20080403135733.GE5199@codecarver.research.nokia.com>
References: <1207230264-4629-1-git-send-email-felipe.balbi@nokia.com> <20080403134705.GY7004@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62665 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821AbYDCN6F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 09:58:05 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m33E0E7E007921
	for <linux-omap@vger.kernel.org>; Thu, 3 Apr 2008 09:00:15 -0500
Content-Disposition: inline
In-Reply-To: <20080403134705.GY7004@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

Felipe,

> +
> +		for (module_irq = IH_TWL4030_PWRBASE; pwr_isr != 0;
> +			module_irq++, pwr_isr >>= 1) {
> +			if (pwr_isr & 1) {
> +				irq_desc_t *d = irq_desc + module_irq;
> +				d->handle_irq(module_irq, d);

There is a missing } here.

> +		}
> +
> +		local_irq_disable();
> +		desc->chip->unmask(irq);
> +	}
> +}
> +

Cheers,

Peter.
