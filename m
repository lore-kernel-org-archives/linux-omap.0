From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 00/11] OMAP: GPIO: Implement GPIO in HWMOD way
Date: Wed, 19 May 2010 17:24:27 +0200
Message-ID: <4BF402AB.50308@ti.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com> <4BF3A72D.3080501@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C566669E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49488 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab0ESPYe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 11:24:34 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C566669E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

On 5/19/2010 3:55 PM, Varadarajan, Charulatha wrote:
>
>> From: Cousson, Benoit
>> Sent: Wednesday, May 19, 2010 2:24 PM
>>
>> On 5/18/2010 4:50 PM, Charulatha V wrote:
>>> This patch series implements GPIO module in platform device model.
>>> It also makes OMAP2PLUS specific GPIO implemented in HWMOD FW way.
>>>
>>> This patch series is created on "origin/pm-wip/runtime".
>>>
>>> This patch series is tested on OMAP3430 SDP board. It would be of
>>> great help if someone could test the same on OMAP1 and OMAP2 boards.
>>
>> What about OMAP4? Didn't you test it on SDP or Blaze?
>
> I tested this series on 4430SDP using an TI internal tree. Since origin/pm-wip/runtime branch does not have OMAP4 hwmod database, I did not mention about OMAP4.

Since the OMAP4 data was posted one week ago 
(https://patchwork.kernel.org/patch/99052/), I think you can use them in 
order to validate on both OMAP3 & OMAP4 with the public code.

Benoit
