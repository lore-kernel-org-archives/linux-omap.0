From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: Guidelines to move mach-omap2/gpmc to drivers/memory-controller
Date: Wed, 20 Feb 2013 09:57:13 -0600
Message-ID: <5124F259.6000300@ti.com>
References: <20130215165840.GB2442@localhost> <alpine.DEB.2.00.1302151952410.19565@utopia.booyaka.com> <511E95A8.2090709@ti.com> <20130220003611.GA4688@myrna.SFIH.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55173 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935298Ab3BTP5R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:57:17 -0500
In-Reply-To: <20130220003611.GA4688@myrna.SFIH.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org


On 02/19/2013 06:36 PM, Ezequiel Garcia wrote:
> Hi Jon,
> 
> On Fri, Feb 15, 2013 at 02:08:08PM -0600, Jon Hunter wrote:
>>
>> On 02/15/2013 01:53 PM, Paul Walmsley wrote:
>>> Hi,
>>>
>>> On Fri, 15 Feb 2013, Ezequiel Garcia wrote:
>>>
>>>> I imagine one of the biggest issues is GPMC's dependency on
>>>> hwmod code. Can anyone shed some light on how to handle this?
>>>
>>> What dependency is this?  I'm not aware of any GPMC dependency to hwmod; 
>>> there shouldn't be any.
>>
>> If Ezequiel is referring to the code in omap_gpmc_init() that is looking
>> up the hwmod struct for gpmc, then this not a dependency. This function
>> should remain in mach-omap2/gpmc.c and not be moved into drivers/.
> 
> Yes, I was referring to that code.
> 
>> Eventually once we have migrated to DT, this function will be removed
>> altogether.
>>
> 
> Mmm, I see. So I might try to move GPMC and friends to drivers/memory
> keeping the hwmod code inside mach-omap2.
> 
> I already did a few tests and I **think** that with a little luck 
> we can have a not-so-intrusive patch that moves GPMC.
> 
> @Jon: Do you think it's worth the effort? 

Yes absolutely! We want all the drivers out of mach-omap2. So that would
be great.

Cheers
Jon

