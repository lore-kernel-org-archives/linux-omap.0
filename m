From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [RFC][PATCH] Maintainers update for hsmmc driver
Date: Thu, 6 Aug 2009 08:58:28 +0530 (IST)
Message-ID: <36992.192.168.10.88.1249529308.squirrel@dbdmail.itg.ti.com>
References: <39332.192.168.10.88.1249515741.squirrel@dbdmail.itg.ti.com>
    <4A7A1B09.2040006@ti.com>
    <000001ca1628$f1f4b6d0$544ff780@am.dhcp.ti.com>
    <4A7A2B3E.5070308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37016 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbZHFD2j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 23:28:39 -0400
In-Reply-To: <4A7A2B3E.5070308@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: 'Nishanth Menon' <nm@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, adrian.hunter@nokia.com

> Madhusudhan said the following on 08/05/2009 07:00 PM:
>>>> Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
>>>> ---
>>>>  MAINTAINERS |    6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> Index: linux-omap-2.6/MAINTAINERS
>>>> ===================================================================
>>>> --- linux-omap-2.6.orig/MAINTAINERS
>>>> +++ linux-omap-2.6/MAINTAINERS
>>>> @@ -3700,6 +3700,12 @@ L:	linux-omap@vger.kernel.org
>>>>  S:	Maintained
>>>>  F:	drivers/mmc/host/*omap*
>>>>
>>> this regex *omap* and your regex *omap_hsmmc* are conflicting IMHO.
>>>
>>
>> Why do you think so? The omap driver which could support OMAP1 + 2420 vs
>> omap_hsmmc driver which support 2430/3430 controller are two separate
>> drivers.
>>
>>
> Simple:
> $ ls drivers/mmc/host/*omap*
> drivers/mmc/host/omap.c  drivers/mmc/host/omap_hsmmc.c
> $ ls drivers/mmc/host/*omap_hsmmc*
> drivers/mmc/host/omap_hsmmc.c
>

I got your point now. I will resubmit the patch by explicitly changing *omap*
to omap.c and *omap_hsmmc* to omap_hsmmc.c.

Regards,
Madhu
>
> Regards,
> Nishanth Menon
>
>


