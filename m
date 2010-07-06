From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCHv2 04/11] OMAP2: Devkit8000: Setup LCD reset
Date: Tue, 06 Jul 2010 07:42:16 +0200
Message-ID: <4C32C238.4090405@corscience.de>
References: <1275478671-24563-1-git-send-email-weber@corscience.de> <1275478671-24563-5-git-send-email-weber@corscience.de> <20100705125714.GW15951@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59906 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab0GFFnC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 01:43:02 -0400
In-Reply-To: <20100705125714.GW15951@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Am 05.07.2010 14:57, schrieb Tony Lindgren:
> * Thomas Weber <weber@corscience.de> [100602 14:33]:
>   
>> From: Kan-Ru Chen <kanru@0xlab.org>
>>
>> This patch corrects the LCD reset pin configuration.
>>
>> Original code from early devkit8000 patch sets the TWL4030 GPIO_1
>> to EHCI_nOC and TWL4030_GPIO_MAX+1 to ledA. Indeed these two pins
>> are both LCD_PWREN. Setup the lcd reset_gpio properly so it can be
>> disabled when other display is turned on.
>>     
> Applied this and the rest of the series too.
>
>   
Thanks.
Thomas
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   

