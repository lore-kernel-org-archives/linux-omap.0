From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [RFC] tidspbridge: use a parameter to allocate shared memory
Date: Thu, 7 Oct 2010 12:01:31 -0500
Message-ID: <4CADFCEB.4030008@ti.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com> <201010070940.14208.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57183 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714Ab0JGRBw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 13:01:52 -0400
In-Reply-To: <201010070940.14208.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@suse.de>, Russell King <linux@arm.linux.org.uk>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>

On 10/7/2010 2:40 AM, Laurent Pinchart wrote:
> Hi Omar,
>
> On Thursday 07 October 2010 07:45:36 Omar Ramirez Luna wrote:
>> tidspbridge driver uses a block of memory denominated SHared Memory
>> to store info&  communicate with DSP, this SHM needs to be physically
>> contiguous and non-cacheable,
>
> There are non-cacheable mappings, but there's no such thing as non-cacheable
> memory. Does the MPU mapping for that SHM block really needs to be non-
> cacheable,

yes

> your could you instead flush the cache after writing to it
> (performance issues might be involved, I don't know the details about that SHM
> usage) ?

You can do that too, but it will involve more changes to dsp side, and 
yes performance might be an issue too.

The so called "shared memory" is used between arm tidspbridge and the 
DSP, they exchange communication structures/streams/messages/parameters 
needed on both sides for its correct functionality (this is an eagle-eye 
view of the SHM, for more info if interested check page 32 of the 
overview pdf[1]).

tidspbridge could have the changes made for flushing the SHM every time 
it writes into it, a flag could be used to prevent both of them (ARM & 
DSP) flushing at the same time if needed, but I don't know how feasible 
would be making those changes in the dsp code.

Regards,

Omar

---
[1] 
https://gforge.ti.com/gf/download/docmanfileversion/17/674/OMAP3430_Bridge_overview.pdf
