From: Suman Anna <s-anna@ti.com>
Subject: Re: Anybody working on tidspbridge?
Date: Tue, 8 Jul 2014 13:38:12 -0500
Message-ID: <53BC3A94.4050208@ti.com>
References: <53A4569B.70604@gmail.com> <53A45BBD.4040201@gmail.com> <20140629164250.GA31625@kroah.com> <53BBE895.4020105@gmail.com> <alpine.DEB.2.01.1407081452580.5181@pmeerw.net> <20140708143659.GB3104@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39591 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753816AbaGHSi0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jul 2014 14:38:26 -0400
In-Reply-To: <20140708143659.GB3104@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: =?windows-1252?Q?Kristina_Mart=9Aenko?= <kristina.martsenko@gmail.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@copitl.com>

Hi Peter,

On 07/08/2014 09:36 AM, Greg KH wrote:
> On Tue, Jul 08, 2014 at 03:03:58PM +0200, Peter Meerwald wrote:
>> Hello,
>>
>>>> Given the total lack of response here, I suggest just deleting the
>>>> driver.  No one has ever done the "real work" that is going to be
>>>> required to get this code out of staging.  It has had build errors
>>>> causing it to not even be usable for some kernel versions with no one
>>>> noticing, so I doubt anyone cares about it anymore here.
>>>
>>> Cc'ing some more people who might be interested. If no one offers to
>>> work on the driver in the next couple of days, I'll send a patch to
>>> remove it.
>>
>> I'm using the driver (with kernel 3.7) and it works reasonably well for 
>> me; removing it seems a bit harsh.
> 
> Using it is different from being able to maintain the code and move it
> out of the staging tree.  Also, 3.7 is really old and obsolete, not much
> we can do with that kernel version :)
> 
> Are you able to work on the code and do the effort needed to get it out
> of the staging tree?  If so, great, if not, we are going to have to
> delete it, sorry.

I agree with Greg here. In fact, the current TODO does not do enough
justice to the amount of work required to make it even work on the
latest kernel. Most of the TIers who worked on this driver have moved on
as Kristina would have figured with her bounced emails. So I do suggest
that this driver be deleted from the kernel tree. If there are enough
number of folks using it (not sure how many are out there), it can be
worked on out-of-tree and brought back in a cleaner fashion rather than
keeping a broken stale driver in the kernel.

regards
Suman
