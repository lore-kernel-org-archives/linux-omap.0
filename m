From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP: hmwod: Update the sysc_cache in case module context
 is lost
Date: Thu, 21 Oct 2010 17:00:55 +0200
Message-ID: <4CC055A7.8040805@ti.com>
References: <1287080555-25399-1-git-send-email-rnayak@ti.com>	<877hhkv2wb.fsf@deeprootsystems.com>	<EAF47CD23C76F840A9E7FCE10091EFAB030D09A2FE@dbde02.ent.ti.com> <87tyknmpm5.fsf@deeprootsystems.com> <0680EC522D0CC943BC586913CF3768C003FF2DAF83@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59705 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab0JUPA7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Oct 2010 11:00:59 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003FF2DAF83@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

On 10/21/2010 12:13 PM, Nayak, Rajendra wrote:

<snip>

> Hi Kevin,
>
> What the patch does is reprogram's the sysc value (from the cache)
> whenever its lost. So its infact saved in the cache and restored when
> needed.
>
>>
>> Otherwise, all this patch does is refresh the _sysc_cache with
>> completely unknown contents.  It also somewhat defeats the purpose of
>> having a cache.  If you're going to read SYSC in order to determine
>> whether or not you can avoid a write, you might as well just blindly
>> write.
>
> I thought of this and dismissed it thinking I would end up with a read/or/write
> and instead a read always to avoid write is better.
> But now looking back again, it does make sense to still keep the cache to avoid
> a read (since a read has significantly more latency than write) and do a blind write
> always. Does that make sense?

That seems indeed better. The point is that cache is already a location 
for the "save" part.
So writing blindly will do the restore with always the good value.
It is anyway faster than trying to check if we lost context or not 
through PRM registers.

Benoit
