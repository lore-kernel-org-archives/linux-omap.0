From: tomi.valkeinen@nokia.com
Subject: RE: kernel panic with latest DSS
Date: Fri, 19 Mar 2010 13:11:19 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1003191308080.16870@tubuntu.research.nokia.com>
References: <5e088bd91003091158l6cfa0b76u204e5432389d573@mail.gmail.com>  <5e088bd91003101016s4148751es1a142c21d1540564@mail.gmail.com>  <5e088bd91003101042t236c5d90p62c700c424d83e12@mail.gmail.com>  <3647DBDA80551C4696E9E4506F0BE08E255DC2F2A7@NOK-EUMSG-02.mgdnok.nokia.com>
  <5e088bd91003101148o82a07e2j4df803d23ee78d83@mail.gmail.com> <1268391093.28571.137.camel@tubuntu.research.nokia.com> <19F8576C6E063C45BE387C64729E7394044DE0E316@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38224 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab0CSLLb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 07:11:31 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DE0E316@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, ext Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



On Fri, 19 Mar 2010, ext Hiremath, Vaibhav wrote:

>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
>> Sent: Friday, March 12, 2010 4:22 PM
>> To: ext Steve Sakoman
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: kernel panic with latest DSS
>>
>> Can you try this patch?
>>
>> I haven't run into this earlier as I always have DSI compiled in. It
>> possibly doesn't behave correctly in that case either, but doesn't
>> crash.
>>
>>  Tomi
>>
>>
>>> From c065bb82e1358105d57d80974ce71d3e5aeabf35 Mon Sep 17 00:00:00 2001
>> From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>> Date: Fri, 12 Mar 2010 12:46:05 +0200
>> Subject: [PATCH] OMAP: DSS2: initialize dss clk sources properly
>>
>> Clk sources were not initialized, leading to kernel crash, or possibly to
>> strange behaviour if DSI was compiled in.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>> ---
>>  drivers/video/omap2/dss/dss.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
>> index 8254a42..5434418 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -590,6 +590,9 @@ int dss_init(bool skip_init)
>>  		}
>>  	}
>>
>> +	dss.dsi_clk_source = DSS_SRC_DSS1_ALWON_FCLK;
>> +	dss.dispc_clk_source = DSS_SRC_DSS1_ALWON_FCLK;
>> +
>>  	dss_save_context();
>>
>>  	rev = dss_read_reg(DSS_REVISION);
>> --
>> 1.6.5
>>
>>
> [Hiremath, Vaibhav] Tomi, No this is not helping here, one thing I am 
> not able to understand how does this related to reboot? The crash is 
> happening because the disable is getting called multiple times. So I 
> think the check (added by my patch) is necessary here.
>
> Also I am seeing this crash irrespective of DSI enabled or not.

Hmm, reboot? I'm not following. I don't see any patch from you in this 
mail thread.

Are you perhaps talking about some other issue?

  Tomi
