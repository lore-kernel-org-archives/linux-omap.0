From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 1/2 v2] omap3: sr: fix memory leak and simplify
 the code
Date: Mon, 30 Aug 2010 19:29:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1D05F@dbde02.ent.ti.com>
References: <1278687874-26123-1-git-send-email-nm@ti.com>
 <87vd6zn1oy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52755 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755451Ab0H3OAH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 10:00:07 -0400
In-Reply-To: <87vd6zn1oy.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, Peter p2 De Schrijver <peter.de-schrijver@nokia.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, August 25, 2010 2:55 AM
>>To: Menon, Nishanth; Gopinath, Thara
>>Cc: linux-omap; Artem Bityutskiy; Peter p2 De Schrijver
>>Subject: Re: [PM-SR][PATCH 1/2 v2] omap3: sr: fix memory leak and simplify the code
>>
>>Nishanth Menon <nm@ti.com> writes:
>>
>>> From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>>>
>>> This patch fixes the following problem indicated by kmemleak:
>>>
>>> kmemleak: unreferenced object 0xdf93c280 (size 64):
>>> kmemleak:   backtrace:
>>> kmemleak:     [<c00df6d4>] create_object+0x104/0x200
>>> kmemleak:     [<c00d7638>] kmem_cache_alloc+0xe4/0xf4
>>> kmemleak:     [<c000fc38>] omap_devinit_smartreflex+0x44/0x244
>>> kmemleak:     [<c003a33c>] do_one_initcall+0x5c/0x1b8
>>> kmemleak:     [<c00083fc>] kernel_init+0x94/0x110
>>> kmemleak:     [<c003ba04>] kernel_thread_exit+0x0/0x8
>>>
>>> The reason is that 'omap_devinit_smartreflex()' allocates 'sr_data',
>>> then passes it to 'omap_device_build()', which 'kmemdup()'s it and
>>> uses the copy. But 'omap_devinit_smartreflex()' never frees 'sr_data'.
>>>
>>> This patch make 'sr_data' to be a stack variable, which eliminates
>>> the memory leak and simplifies the code a bit.
>>>
>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>> Cc: Thara Gopinath <thara@ti.com>,
>>> Cc: Peter p2 De Schrijver <peter.de-schrijver@nokia.com>
>>> Cc: Nishanth Menon <nm@ti.com>
>>>
>>> Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>>> Acked-by: Nishanth Menon <nm@ti.com>
>>> ---
>>> Changes from V1:
>>> 	rebased to latest pm-sr branch
>>> 	default of sr_data set to 0 to make it equivalent to kzalloc
>>>
>>> NOTE: this probably should be squashed when being send upstream along with
>>> rest of SR series
>>
>>Thara, you appear to have fixed this problem differently in your latest
>>series.  Looks like you just ensured kfree() was always done, correct?
>>
>>In the future, it would be helpful if you would reply to these proposed
>>fixes on the list so we know if they are incorporated or handled
>>differently.

Yes.. you r correct.. I missed replying on this one. Sorry for the confusion.
Will take care of this in future.
It is indeed fixed by ensuring kfree() always.

Regards,
Thara
