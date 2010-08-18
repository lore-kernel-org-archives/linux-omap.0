From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 2/4] mfd: twl-core: switch over to defines in twl.h
Date: Wed, 18 Aug 2010 19:50:33 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032422251A@dbde02.ent.ti.com>
References: <1282112377-1335-1-git-send-email-felipe.balbi@nokia.com>
 <1282112377-1335-3-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032422229C@dbde02.ent.ti.com>
 <20100818065905.GC11947@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03242222C7@dbde02.ent.ti.com>
 <20100818071022.GD11947@nokia.com> <20100818071619.GE11947@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60905 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076Ab0HROVW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 10:21:22 -0400
In-Reply-To: <20100818071619.GE11947@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>



>>-----Original Message-----
>>From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
>>Sent: Wednesday, August 18, 2010 12:46 PM
>>To: Balbi Felipe (Nokia-MS/Helsinki)
>>Cc: Gopinath, Thara; Samuel Ortiz; linux-kernel@vger.kernel.org; linux-omap@vger.kernel.org; Tony
>>Lindgren; Andrew Morton
>>Subject: Re: [PATCH 2/4] mfd: twl-core: switch over to defines in twl.h
>>
>>Hi,
>>
>>On Wed, Aug 18, 2010 at 09:10:22AM +0200, Balbi Felipe (Nokia-MS/Helsinki) wrote:
>>>On Wed, Aug 18, 2010 at 09:03:44AM +0200, ext Gopinath, Thara wrote:
>>>>>>No I am not talking about the key values. I was talking about the register offset
>>>>>>for TWL4030_PM_MASTER_PROTECT_KEY. My question is, is it ok for it to be 0xd or 0xe.
>>>>>>Earlier we were using 0xd and in the new implementation it has been changed to 0xe.
>>>>
>>>>Typo. Earlier we were using 0xe and in the new implementation it has
>>>>been changed to 0xd.
>>>
>>>you're right, I'm not sure how I came up with that value since the TRM
>>>shows 0x0e, maybe a copy&paste error. Will change patch 1.
>>
>>ok, it's because there's no register 0x0a. And I missed that when
>>defined the register space. Good catch, thanks. I wonder why it didn't
>>fail to write to that register address :-?

0xd is a valid register offset. Hence no crash. Anyways I saw your new
patch. Looks ok to me.

Regards
Thara
