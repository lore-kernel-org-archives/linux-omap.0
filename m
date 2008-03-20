From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: OMAP3430: MUSB host and hot-plugging
Date: Thu, 20 Mar 2008 07:38:57 -0500
Message-ID: <8657b483f1b99c61a4d5d142a5af48ba@felipebalbi.com>
References: <5DF83221BE20114E9C331F665ACBC0800477C16D@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35587 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbYCTMjY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 08:39:24 -0400
In-Reply-To: <5DF83221BE20114E9C331F665ACBC0800477C16D@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Kevin Hilman <khilman@mvista.com>, Linux omap <linux-omap@vger.kernel.org>



On Thu, 20 Mar 2008 18:04:01 +0530, "Pandita, Vikram"
<vikram.pandita@ti.com> wrote:
> Hi Felipe/Kevin
> 
>>To: Kevin Hilman; Linux omap
>>Subject: RE: OMAP3430: MUSB host and hot-plugging
>>
>>> Forcing a session start via "echo 'F' > /proc/driver/musb_hdrc" causes
>>> the device to be (re)detected and things look good again.  It is not
>>> until I force the session start that I see the interrupt and the
>>> CONNECT event.
>>>
>>> Any ideas why this isn't detected on insertion?
>>
>>You're better than me then, I can't get even the first insertion
>>I'm suspecting that twl4030_phy_suspend is somehow
>>messing it up. I'm now digging on it and still
>>I can't say for sure what's happening.
>>
>>Maybe somebody else has other comments on that.
> 
> If you can provide us the procedure to enable hot-plugging for MUSB on
> OMAP3430, we will look into this issue.

As far as musb driver is concerned it should be just a mater of
building it with otg support. But as of now, I cannot get id
pin status to musb using twl4030.

Maybe we still have some missing pieces on linux-omap, which I'm
researching on that.

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

