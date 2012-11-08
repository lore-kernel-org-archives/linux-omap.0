From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Thu, 8 Nov 2012 13:16:28 -0600
Message-ID: <509C050C.6010201@ti.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il> <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il> <509BFFDF.9040605@ti.com> <79CD15C6BA57404B839C016229A409A83EB68799@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58374 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab2KHTQe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 14:16:34 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB68799@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>


On 11/08/2012 12:59 PM, Hiremath, Vaibhav wrote:
> On Fri, Nov 09, 2012 at 00:24:23, Hunter, Jon wrote:
>>
>> On 11/08/2012 01:59 AM, Igor Grinberg wrote:
>>
>> [snip]
>>
>>> There is no reliable way to determine which source should be used in runtime
>>> for boards that do not have the 32k oscillator wired.
>>
>> So thinking about this some more and given that we are moving away from
>> board files, if a board does not provide a 32kHz clock source, then this
>> should be reflected in the device-tree source file for that board.
>> Hence, at boot time we should be able to determine if a 32kHz clock
>> source can be used.
>>
> 
> Let me feed some more thoughts here :)
> 
> The way it is being detected currently is based on timer idle status bit.
> I am worried that, this is the only option we have.

Why not use device-tree to indicate the presence of a 32k clock source?
This seems like a board level configuration and so device-tree seems to
be the perfect place for this IMO.

Jon
