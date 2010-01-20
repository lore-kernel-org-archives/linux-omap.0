From: Vladimir Pantelic <pan@nt.tu-darmstadt.de>
Subject: Re: [PATCH] OMAP3630:DSS2:Enable Pre-Multiplied Alpha Support
Date: Wed, 20 Jan 2010 07:35:15 +0100
Message-ID: <4B56A423.80209@nt.tu-darmstadt.de>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DC245@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:32158 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab0ATGql (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 01:46:41 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DC245@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Y, Kishore" <kishore.y@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mande, Nikhil" <nikhil@ti.com>

Y, Kishore wrote:

>>  >  As per TRM, this bit is valid only for ARGB formats and experts
>>  suggested that we can safely assume pre-multiplied data always in real
>>  world
>>
>>  I asked a few experts here, and they weren't so sure, and neither am I.
>>
>>  I don't see any problems making this feature configurable, but there may
>>  be problems if it's hardcoded. So, it should be configurable. I think
>>  the default should be the same as on 3430, so that they will work
>>  similarly.
>>
>>   Tomi
> I haven't considered the backward compatibility with 3430 apps.
> I will make this configurable.

And please defaulting to non-pre-multiplied. All 3430 apps will be
non-pre-multiplied as this is what the 3430 supports only.

So apps need to be actively changed to use pre-multiplied.

