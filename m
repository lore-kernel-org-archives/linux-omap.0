From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/5] OMAP4: PM: Update PRCM register bitshits and masks
 for ES2
Date: Wed, 22 Sep 2010 18:08:08 +0200
Message-ID: <4C9A29E8.4020509@ti.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com> <1284641906-24231-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1009220014340.21002@utopia.booyaka.com> <0680EC522D0CC943BC586913CF3768C003C21EE40F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33421 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab0IVQIN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 12:08:13 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003C21EE40F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On 9/22/2010 8:43 AM, Nayak, Rajendra wrote:
>
>> From: Paul Walmsley [mailto:paul@pwsan.com]
>> Sent: Wednesday, September 22, 2010 11:47 AM
>>
>> Hi Rajendra
>>
>> On Thu, 16 Sep 2010, Rajendra Nayak wrote:
>>
>>> This patch updates the PRM and CM register bitshifts and masks
>>> for OMAP4430 ES2.0.
>>>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>> Signed-off-by: Beno=C3=AEt Cousson<b-cousson@ti.com>
>>> Cc: Paul Walmsley<paul@pwsan.com>
>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>
>> Thanks, queued for 2.6.37 (with the UTF-8 fix in the patch descripti=
on).
>>
>> One other note:
>>
>>>   #define OMAP4430_IDLEST_MASK					BITFIELD(16,
>> 17)
>>
>> We should really get rid of all these 'BITFIELD' defines, and just r=
eplace
>> them with simple bitshifts.  Care to spin a patch to do that during =
the
>> 2.6.38 timeframe?
>
> Sure, there's already a patch for this which I guess Benoit should be=
 posting pretty soon.

Yes, I already updated the scripts a couple of weeks ago to fix that on=
=20
top of Rajendra's series.
Since it was not critical, I kind of forgot it :-)

I can sent the fix to you right now if you want?

Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
