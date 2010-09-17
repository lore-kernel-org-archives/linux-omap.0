From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 09/11] OMAP: DMA: Implement generic errata handling
Date: Fri, 17 Sep 2010 08:32:07 -0700
Message-ID: <87hbhoz8qw.fsf@deeprootsystems.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-10-git-send-email-manjugk@ti.com>
	<87sk1qtpnu.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A93@dbde02.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402784DC7D5@dbde02.ent.ti.com>
	<4C9317B5.3050308@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402784DC994@dbde02.ent.ti.com>
	<4C9342FB.30401@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402784DCB8E@dbde02.ent.ti.com>
	<4C938066.2080908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37967 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303Ab0IQPcS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 11:32:18 -0400
Received: by pwi3 with SMTP id 3so701174pwi.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Sep 2010 08:32:18 -0700 (PDT)
In-Reply-To: <4C938066.2080908@ti.com> (Benoit Cousson's message of "Fri, 17
	Sep 2010 16:51:18 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

[...]

>>>>> If you cannot do that, you will need to add an omap_device API as
>>>>> well.
>>>>
>>>> There is already one such API exists in hwmod layer for handling
>>>> this type of errata(omap_hwmod_set_slave_idlemode in omap_hwmod.c).
>>>> Above proposal is based on similar implementation.
>>>
>>> Maybe, but this is not enough. In both case you should not use
>>> directly this API from the driver, so if you want to use that kind
>>> of approach, you will need the omap_device layer as well.
>>
>> Does that mean, extending omap device layer for modifying sysconfig?
>
> Yes,
>

Just to re-iterate Benoit's point:

Driver's should not have any knowledge of omap_hwmods.  All the
interaction with hwmods is done via the omap_device layer. 

So, if it is decide that you need a new API for this sysconfig change,
you have to add it to *both* the hwmod layer and the omap_device layer.

As with all the other functions, driver calls omap_device, and
omap_device calls omap_hwmod as needed.

Kevin
