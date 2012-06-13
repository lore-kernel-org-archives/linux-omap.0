From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: onenand: cleanup for gpmc driver conversion
Date: Wed, 13 Jun 2012 11:38:47 -0500
Message-ID: <4FD8C217.2050006@ti.com>
References: <cover.1339419244.git.afzal@ti.com> <2d6f0fb31cde98cd700d7a4268683b4aeeee87f2.1339419244.git.afzal@ti.com> <4FD63AAE.90008@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997D47@DBDE01.ent.ti.com> <4FD77CC8.4000003@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E998781@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40105 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab2FMQiq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 12:38:46 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998781@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 06/13/2012 12:03 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Tue, Jun 12, 2012 at 23:00:48, Hunter, Jon wrote:
> 
>> On 06/12/2012 01:16 AM, Mohammed, Afzal wrote:
>>> With the existing code, set_async was done as part of set_sync, hence
>>> requiring GPMC to be configured twice after driver takes control, with
>>> your suggestion too, GPMC would have to be configured twice.
>>
>> I am just suggesting that you place the call to set_async_mode in the
>> gpmc_onenand_setup() instead of the gpmc_onenand_init() and remove the
>> calls from set_sync (like you have done). So I don't see that these
>> would configure the GPMC twice.
> 
> As gpmc_onenand_setup is a callback by onenand driver, we would have
> lost the opportunity to configure onenand before driver is probed.

Is that a problem? Looks like it is called early in the probe and so I
would hope no one is attempting to access the onenand itself before the
probe has completed.

> This would cause requirement of double GPMC configuring and we lost
> the opportunity to configure GPMC before driver is probed.

I am not convinced we need to. Furthermore with your change you do not
actually set async mode in the onenand until _set_sync() is called.

> And the first step for onenand configuration is always to set it
> to async mode (with the way it is done now), so it seems reasonable
> to rely on normal GPMC configuration for async & then do reconfigure
> for sync.

Yes but as far as I can see, it seems that this is the intent of the
onenand_setup() function to perform the necessary initialisation.

Have you tested onenand? Do you have a board with onenand?

Cheers
Jon

