From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 01/11] OMAP4: PRCM: add OMAP4-specific accessor/mutatorfunctions
Date: Wed, 15 Dec 2010 13:43:03 +0100
Message-ID: <4D08B7D7.3090204@ti.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <20101208061829.30541.99531.stgit@twilight.localdomain> <25f8b00ceea2d6945cf74024299e81a8@mail.gmail.com> <alpine.DEB.2.00.1012142345050.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58340 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722Ab0LOMnM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 07:43:12 -0500
In-Reply-To: <alpine.DEB.2.00.1012142345050.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On 12/15/2010 7:48 AM, Paul Walmsley wrote:
> Hi Rajendra
>
> On Wed, 8 Dec 2010, Rajendra Nayak wrote:
>
>> Would it help if we can avoid one more level of function
>> indirection (given that these are low level apis) and store
>> the Partition offsets in the tables above (instead of func
>> pointers) and do some thing like this.
>>
>>        return __raw_readl(OMAP2_L4_IO_ADDRESS(cm_read_offset[part],
>> module, idx));
>>
>> with the table entries of cm_read_offset looking something like
>>> +   [OMAP4430_PRM_PARTITION]                = OMAP4430_PRM_BASE,
>>> +   [OMAP4430_CM1_PARTITION]                = OMAP4430_CM1_BASE,
>>> +   [OMAP4430_CM2_PARTITION]                = OMAP4430_CM2_BASE,
>
> I did a version of this patch without the extra level of indirection.
> I'm not sure if it's better or worse.  The original seems conceptually
> cleaner to me, but this revised version is probably slightly more
> efficient.  Do you (or anyone else) have a strong preference?

I do not have a strong but a slight preference for that. It is a little 
bit more readable that function pointers for my point of view.

On the other hand, the function pointers might allow to handle tricky 
differences that this solution will not.

Regards,
Benoit
