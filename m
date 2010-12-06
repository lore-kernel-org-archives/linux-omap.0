From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2] musb: am35x: fix compile error due to control apis
Date: Mon, 06 Dec 2010 20:13:11 +0300
Message-ID: <4CFD19A7.5020902@ru.mvista.com>
References: <1291623211-959-1-git-send-email-ajay.gupta@ti.com> <4CFCBCF1.9010902@ru.mvista.com> <19F8576C6E063C45BE387C64729E739404BCE3A1EC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34887 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab0LFROf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 12:14:35 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BCE3A1EC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Hello.

Gupta, Ajay Kumar wrote:

>>> As the control.h have been moved to new location and it's
>>> uses are not allowed to drivers directly so moving the phy
>>> control, interrupt clear and reset functionality to board
>>> files.

>>     I'm not fond of the whole approach. I'm not sure why accesses to the
>> control registers are such a no-no, taking into account that one needs to
>> access such regisyter to clear the interrupt...

> I think Tony is the right person to answer this :)

    Yeah, I thought he must be reading linux-omap...

>>> Signed-off-by: Ajay Kumar Gupta<ajay.gupta@ti.com>
>> [...]

>>> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c

> [...]

>>> +	regval&= ~AM35XX_USBOTGSS_SW_RST;
>>> +	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
>>> +
>>> +	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
>>     Why read it and ignore the result?

> This is due to recommendation for OMAPs as discussed at below
> Link,
> http://markmail.org/message/s3lp7xlyq7zxnjtc#query:+page:1+mid:kfia4ld4xgzek6kq+state:results

    There is recommendation to read back the interrupt status register, which 
this register isn't. Anyway, a comment wouldn't hurt...

> Thanks,
> Ajay

WBR, Sergei
