From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: L2 cache stability workaround for 4460 ES1.0
Date: Mon, 2 Apr 2012 13:28:26 +0530
Message-ID: <CAMQu2gy0Y1-kJyozbMZS4A4VXVt-K-M4zSih-gfStVmPpq-7NQ@mail.gmail.com>
References: <4F794D5D.3090509@ti.com> <CAMQu2gzsjUKUZtXnTeQ2UoRUQ5ZX4gxY3Cm9hGTLLc70eknUHA@mail.gmail.com>
 <4F795B76.3030002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:46897 "EHLO
	na3sys009amx257.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751082Ab2DBIGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Apr 2012 04:06:18 -0400
Received: by qafl39 with SMTP id l39so2004516qaf.14
        for <linux-omap@vger.kernel.org>; Mon, 02 Apr 2012 01:06:17 -0700 (PDT)
In-Reply-To: <4F795B76.3030002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "Dechesne, Nicolas" <n-dechesne@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Apr 2, 2012 at 1:25 PM, Roger Quadros <rogerq@ti.com> wrote:
> On 04/02/2012 10:38 AM, Shilimkar, Santosh wrote:
>> On Mon, Apr 2, 2012 at 12:25 PM, Roger Quadros <rogerq@ti.com> wrote:
>>> Hi Santosh,
>>>
>>> I came across the attached patch from you. I also came across this post
>>> stating that it was decided not to send this patch upstream.
>>>
>>> http://www.digipedia.pl/usenet/thread/18885/8437/#post8496
>>>
>>> The problem is that we have to keep porting this patch each time we
>>> update the kernel.
>>>
>>> Do you know if the root cause has been found? If not can we have this
>>> patch upstream till the root cause is found?
>>>
>> Yes and fixed in OMAP4460 ES1.2.
>
> Did you mean ES1.1?
>
yep. Sorry for the typo.

> Could you please point me to the errata ID? The only cache related
> errata I can see is Errata ID: i690
>
>>
>>> It seems the patch at least makes the kernel usable on ES1.0.
>>>
>> I know but that still is not enough. It's like 80 % WA of the issue
>> seen on ES1.0. We are not suppose to have many boards with
>> ES1.0
>>
> Even better if there are not many boards. It seems most of the boards
> will be with TI. I think we should have the fix in even if it is not
> 100% fix.
>
> What do you say?
>
My request is to get rid of ES1.0 board because the WA just
not completely correct. Don't feel patching kernel for silicon
which is not suppose to be used nether has complete WA
to support it.

Regards
Santosh
