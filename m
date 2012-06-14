From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: onenand: cleanup for gpmc driver conversion
Date: Thu, 14 Jun 2012 12:53:48 -0500
Message-ID: <4FDA252C.4020708@ti.com>
References: <cover.1339419244.git.afzal@ti.com> <2d6f0fb31cde98cd700d7a4268683b4aeeee87f2.1339419244.git.afzal@ti.com> <4FD63AAE.90008@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997D47@DBDE01.ent.ti.com> <4FD77CC8.4000003@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E998781@DBDE01.ent.ti.com> <4FD8C217.2050006@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9993EF@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42795 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154Ab2FNRxp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 13:53:45 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9993EF@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 06/14/2012 12:40 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Wed, Jun 13, 2012 at 22:08:47, Hunter, Jon wrote:
>> On 06/13/2012 12:03 AM, Mohammed, Afzal wrote:
> 
>>> As gpmc_onenand_setup is a callback by onenand driver, we would have
>>> lost the opportunity to configure onenand before driver is probed.
>>
>> Is that a problem? Looks like it is called early in the probe and so I
>> would hope no one is attempting to access the onenand itself before the
>> probe has completed.
> 
> During gpmc driver probe, it will configure all the connected peripherals,
> if configuration details are not present at that point of time, gpmc driver
> will cry out saying that configuration & timings has not been configured,
> (please see holler if no configuration patch). 

Sorry, I am not sure if I am missing something here, but isn't the
chip-select requested during the gpmc probe? If so then we should not be
programming the gpmc registers at all until the chip-select has been
allocated. Hence, after the probe seems more appropriate.

> And I do not see any reason
> why gpmc driver should not be fed with async mode configuration initially,
> as it has to be done always.

It is more of where you are doing it. I am not against putting in async
mode to begin with.

>>
>>> This would cause requirement of double GPMC configuring and we lost
>>> the opportunity to configure GPMC before driver is probed.
>>
>> I am not convinced we need to. Furthermore with your change you do not
>> actually set async mode in the onenand until _set_sync() is called.
> 
> Yes, setting async mode in onenand is done in set_sync function, and it is
> always called by onenand driver indirectly.
> 
> Seems if setting async mode in onenand is taken out of set_sync & placed
> it before set_sync invocation in gpmc_onenand_setup, intention will be
> clear, right ? (even though sequence wise same thing is happening now)

Exactly.

>>
>>> And the first step for onenand configuration is always to set it
>>> to async mode (with the way it is done now), so it seems reasonable
>>> to rely on normal GPMC configuration for async & then do reconfigure
>>> for sync.
>>
>> Yes but as far as I can see, it seems that this is the intent of the
>> onenand_setup() function to perform the necessary initialisation.
> 
> I believe doing it in gpmc_onenand_init is better, due to the reasons
> mentioned above as well as because function name will correspond to what
> it is doing, i.e. initialization

If the chip-select is allocating during the probe, then I don't agree.

>> Have you tested onenand? Do you have a board with onenand?
> 
> Yes, on omap3evm, with help of local patches (as mainline doesn't have
> those). It was mentioned in cover letter of gpmc driver conversion series

Great. Sorry but with 20+ patch spread across 3 series it is not always
easy to find the details. So ideally it should be mentioned in this
cover letter too.

Thanks
Jon
