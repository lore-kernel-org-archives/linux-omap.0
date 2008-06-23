From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [RFC/PATCH 2/2] Triton Battery charger interface driver for OMAP3430
Date: Mon, 23 Jun 2008 19:05:12 +0530
Message-ID: <04c501c8d535$f86fd240$35f6180a@ent.ti.com>
References: <62852.192.168.10.89.1213963560.squirrel@dbdmail.itg.ti.com> <27482475ea67b287e41df55112e188a9@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52858 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553AbYFWNfy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2008 09:35:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

Hi Felipe,

Thanks for the comments. I will fix it and resend the patch.

Best regards,
Madhu
----- Original Message ----- 
From: "Felipe Balbi" <me@felipebalbi.com>
To: <x0070977@dbdmail.itg.ti.com>
Cc: <linux-omap@vger.kernel.org>
Sent: Monday, June 23, 2008 2:21 PM
Subject: Re: [RFC/PATCH 2/2] Triton Battery charger interface driver for OMAP3430


> 
> 
> On Fri, 20 Jun 2008 17:36:00 +0530 (IST), x0070977@dbdmail.itg.ti.com
> wrote:
> 
>> +#ifdef CONFIG_TWL4030_BCI_BATTERY
>> +extern int twl4030charger_usb_en(int enable);
>> +#else
>> +static inline int twl4030charger_usb_en(int enable) { return 0; }
>> +#endif
> 
> this should be in include/linux/i2c/twl4030.h
> you should also change it for when bci is built as a
> dynamically linked module.
Okay. Good point.
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
> 
>
