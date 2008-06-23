From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC/PATCH 2/2] Triton Battery charger interface driver for OMAP3430
Date: Mon, 23 Jun 2008 03:51:08 -0500
Message-ID: <27482475ea67b287e41df55112e188a9@felipebalbi.com>
References: <62852.192.168.10.89.1213963560.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47612 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbYFWIvJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2008 04:51:09 -0400
In-Reply-To: <62852.192.168.10.89.1213963560.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0070977@dbdmail.itg.ti.com
Cc: linux-omap@vger.kernel.org



On Fri, 20 Jun 2008 17:36:00 +0530 (IST), x0070977@dbdmail.itg.ti.com
wrote:

> +#ifdef CONFIG_TWL4030_BCI_BATTERY
> +extern int twl4030charger_usb_en(int enable);
> +#else
> +static inline int twl4030charger_usb_en(int enable) { return 0; }
> +#endif

this should be in include/linux/i2c/twl4030.h
you should also change it for when bci is built as a
dynamically linked module.

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

