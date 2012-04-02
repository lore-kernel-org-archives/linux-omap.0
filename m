From: Roger Quadros <rogerq@ti.com>
Subject: Re: L2 cache stability workaround for 4460 ES1.0
Date: Mon, 2 Apr 2012 10:55:34 +0300
Message-ID: <4F795B76.3030002@ti.com>
References: <4F794D5D.3090509@ti.com> <CAMQu2gzsjUKUZtXnTeQ2UoRUQ5ZX4gxY3Cm9hGTLLc70eknUHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58847 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027Ab2DBHzg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Apr 2012 03:55:36 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q327taq0017129
	for <linux-omap@vger.kernel.org>; Mon, 2 Apr 2012 02:55:36 -0500
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q327ta5u020582
	for <linux-omap@vger.kernel.org>; Mon, 2 Apr 2012 02:55:36 -0500 (CDT)
In-Reply-To: <CAMQu2gzsjUKUZtXnTeQ2UoRUQ5ZX4gxY3Cm9hGTLLc70eknUHA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Dechesne, Nicolas" <n-dechesne@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 04/02/2012 10:38 AM, Shilimkar, Santosh wrote:
> On Mon, Apr 2, 2012 at 12:25 PM, Roger Quadros <rogerq@ti.com> wrote:
>> Hi Santosh,
>>
>> I came across the attached patch from you. I also came across this post
>> stating that it was decided not to send this patch upstream.
>>
>> http://www.digipedia.pl/usenet/thread/18885/8437/#post8496
>>
>> The problem is that we have to keep porting this patch each time we
>> update the kernel.
>>
>> Do you know if the root cause has been found? If not can we have this
>> patch upstream till the root cause is found?
>>
> Yes and fixed in OMAP4460 ES1.2.

Did you mean ES1.1?

Could you please point me to the errata ID? The only cache related
errata I can see is Errata ID: i690

> 
>> It seems the patch at least makes the kernel usable on ES1.0.
>>
> I know but that still is not enough. It's like 80 % WA of the issue
> seen on ES1.0. We are not suppose to have many boards with
> ES1.0
> 
Even better if there are not many boards. It seems most of the boards
will be with TI. I think we should have the fix in even if it is not
100% fix.

What do you say?

regards,
-roger

