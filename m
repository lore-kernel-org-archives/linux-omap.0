From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod
 required for am33xx
Date: Thu, 28 Jun 2012 20:15:48 +0530
Message-ID: <4FEC6E1C.8080203@ti.com>
References: <1329481488-27771-1-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204271934230.10308@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA5D46A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43373 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab2F1Op7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:45:59 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5D46A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>



On 6/28/2012 8:10 PM, Hiremath, Vaibhav wrote:
> On Sat, Apr 28, 2012 at 07:04:38, Paul Walmsley wrote:
>> On Fri, 17 Feb 2012, Vaibhav Hiremath wrote:
>>
>>> In case of AM33xx family of devices (like cpsw) have different sysc
>>> bit field offsets defined,
>>>
>>> sysc_type3:
>>> |  3     2  |  1    0  |
>>> | STDBYMODE | IDLEMODE |
>>>
>>> So introduce new sysc_type3 in omap_hwmod common data.
>>>
>>> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> Thanks, queued for 3.5.
>>
> 
> We missed this patch last time, can you pleas make sure to include it this 
> time.
> 

Another patch which got missed from your last pull-request is,

ARM: OMAP3/4: omap_hwmod:Add rstst_off field to struct omap_hwmod_omap4_prcm


Can you please add it to your pull request?

Thanks,
Vaibhav
