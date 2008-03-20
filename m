From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: OMAP3430: MUSB host and hot-plugging
Date: Thu, 20 Mar 2008 07:55:50 -0500
Message-ID: <558bb41d9b118bdc524a148da2ab8864@felipebalbi.com>
References: <5DF83221BE20114E9C331F665ACBC0800477C178@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44561 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538AbYCTMz5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 08:55:57 -0400
In-Reply-To: <5DF83221BE20114E9C331F665ACBC0800477C178@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Kevin Hilman <khilman@mvista.com>, Linux omap <linux-omap@vger.kernel.org>



On Thu, 20 Mar 2008 18:17:55 +0530, "Pandita, Vikram"
<vikram.pandita@ti.com> wrote:
> Felipe
> 
>>Sent: Thursday, March 20, 2008 6:09 PM
>>To: Pandita, Vikram
>>Cc: Kevin Hilman; Linux omap
>>Subject: RE: OMAP3430: MUSB host and hot-plugging
>>
>>
>>> If you can provide us the procedure to enable hot-plugging for MUSB on
>>> OMAP3430, we will look into this issue.
>>
>>As far as musb driver is concerned it should be just a mater of
>>building it with otg support. But as of now, I cannot get id
>>pin status to musb using twl4030.
>>
>>Maybe we still have some missing pieces on linux-omap, which I'm
>>researching on that.
> 
>  I meant if you could pass on how you have written the hot plugging
> function/agent for MUSB.
> I have not tried hot-plugging on omap. 

There should be no need for that.
twl4030-usb is using ulpi interface on 3430sdp, which means all interrupts
are
directed to musb using that interface, also musb switches between
host/peripheral
roles automatically as long as we get an id pin change interrupt.

Somehow this interrupt is not going to musb's driver when we're using ulpi
on 3430.

I have some other questions for you but it'll be privatly.

> 
>>
>>--
>>Best Regards,
>>
>>Felipe Balbi
>>http://felipebalbi.com
>>me@felipebalbi.com
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

