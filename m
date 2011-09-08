From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 1/8] OMAP: hwmod: Fix the addr spaces count API.
Date: Thu, 8 Sep 2011 18:33:30 +0530
Message-ID: <ed9b1afc1264f865f86bf6621bbac0e6@mail.gmail.com>
References: <f44b67c9efd46d2e7d078da4d3acd30c@mail.gmail.com>
 <5e4ae8f3e715eb5e46468695a88c541a@mail.gmail.com> <4E688BBA.3010803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48476 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932609Ab1IHNDj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 09:03:39 -0400
Received: by mail-wy0-f178.google.com with SMTP id 19so585009wyg.9
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 06:03:31 -0700 (PDT)
In-Reply-To: <4E688BBA.3010803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org

[...]
>>> -----Original Message-----
>>> From: Sricharan R [mailto:r.sricharan@ti.com]
>>> Sent: Thursday, September 08, 2011 2:35 PM
>>> To: Sricharan R
>>> Subject: Re: [PATCH 1/8] OMAP: hwmod: Fix the addr spaces count API.
>>>
>
>[...]
>
>>>>
>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>>> b/arch/arm/mach-omap2/omap_hwmod.c
>>>> index 84cc0bd..32a0f48a 100644
>>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>>> @@ -791,9 +791,11 @@ static int _count_ocp_if_addr_spaces(struct
>>> omap_hwmod_ocp_if *os)
>>>>    	if (!os || !os->addr)
>>>>    		return 0;
>>>>
>>>> -	do {
>>>> -		mem =&os->addr[i++];
>>>> -	} while (mem->pa_start != mem->pa_end);
>>>> +	mem =&os->addr[i];
>>>> +
>This extran line isn't needed Sricharan.
>
   Will correct this, along with benoit's commmets.

Thanks,
 Sricharan
