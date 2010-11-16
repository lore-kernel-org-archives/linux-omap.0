From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/7] OMAP: mux: Add support for control module split in
 several partitions
Date: Tue, 16 Nov 2010 18:03:13 +0100
Message-ID: <4CE2B951.2070609@ti.com>
References: <1289511321-18532-1-git-send-email-b-cousson@ti.com> <1289511321-18532-3-git-send-email-b-cousson@ti.com> <20101115200316.GK9264@atomide.com> <4CE1AA4A.10602@ti.com> <20101116164149.GQ9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41039 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768Ab0KPRDT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 12:03:19 -0500
In-Reply-To: <20101116164149.GQ9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Tony,

On 11/16/2010 5:41 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [101115 13:36]:
>> Hi Tony,
>>
>> On 11/15/2010 9:03 PM, Tony Lindgren wrote:
>>> * Benoit Cousson<b-cousson@ti.com>   [101111 13:26]:
>>>> Starting on OMAP4, the pin mux configuration is located in two
>>>> different partitions of the control module (CODE_PAD and WKUP_PAD).
>>>> The first one is inside the core power domain whereas the second
>>>> one is inside the wakeup.
>>>> - Add the capability to add any number of partition during board init
>>>> time depending of Soc partitioning.
>>>> - Add some init flags as well in order to avoid explicit Soc version
>>>> check inside the mux core code.
>>>> - Add a comment with mux0 mode on top of omap_mux/board/<partition>
>>>> if the current mux mode is not the default one.
>>>
>>> Here's one more patch that I'd like to merge into this patch to avoid
>>> repeating the partition for each mux entry.
>>
>> The memory vendors will not like you ;-)
>>
>>> Assuming no more comments, I'll queue these for 2.6.38 merge window.
>>
>> I'll update the series and re-post tomorrow.
>
> Thanks, no need to post them again, I already have them queued
> locally, they will hit for-next and linux-omap master today.

OK, but I already did it because there is a checkpatch issue in your 
first patch and I received another patch from Dan to add __func__ in the 
pr_xxx macros.
I can repost, or you can get the update in my GIT (ctrl-wip/mux-omap4-v4).

> BTW, next time you do a git branch, please base it on Linus recent
> -rc tag instead of linux-omap master branch. We don't want the
> history of linux-omap master branch merged to the mainline tree..

Euh, this is what I already did for this series. Quoting myself:

"The series is based on mainline (2.6.37-rc1) and is available here:
git://gitorious.org/omap-pm/linux.git ctrl-wip/mux-omap4-v3"

Did I messed up something?

Regards,
Benoit

