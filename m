From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 18/20] GPIO: OMAP: Use PM runtime framework
Date: Wed, 20 Jul 2011 12:33:14 +0300
Message-ID: <4E26A0DA.5040202@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com> <1309513634-20971-19-git-send-email-tarun.kanti@ti.com> <4E2675AB.1070606@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB037C0C4D7B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53454 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab1GTJdS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jul 2011 05:33:18 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037C0C4D7B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

On 07/20/2011 12:28 PM, DebBarma, Tarun Kanti wrote:
> [...]
>>    From this patch it seems that the GPIO module is kept active as long as
>> one of its GPIOs is requested. This is not optimal.
> Yes, but...
>
>>
>> The GPIO needs to be active only when accessing its registers e.g.
>> during gpio_get or gpio_set. The rest of the time it can be suspended.
> A GPIO module would typically be used by multiple client drivers.
> However, the clock control is common for all GPIO pins within the module.
> So clocks can't be turned-off/on without negatively impacting present users.

Why not.

Let's say GPIO 1 and 2 belong to the same GPIO module.
Driver A uses GPIO 1 and driver B uses GPIO 2.
A is just blinking an LED every second whereas B uses GPIO 2 as input.

both drivers will keep the GPIOs requested as long as they are loaded.
Why can't you turn off the clocks when nobody is accessing GPIO registers?

In your current implementation, the GPIO module will never go idle.

cheers,
-roger
