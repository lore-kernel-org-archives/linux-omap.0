From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP4 errata i740
Date: Fri, 30 Mar 2012 12:08:26 +0200
Message-ID: <4F75861A.8040905@ti.com>
References: <1333094862.1932.15.camel@deskari>  <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com> <1333095982.1932.21.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59186 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab2C3KI3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 06:08:29 -0400
In-Reply-To: <1333095982.1932.21.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>

On 3/30/2012 10:26 AM, Tomi Valkeinen wrote:
> On Fri, 2012-03-30 at 13:51 +0530, Shilimkar, Santosh wrote:
>> On Fri, Mar 30, 2012 at 1:37 PM, Tomi Valkeinen<tomi.valkeinen@ti.com>  wrote:
>
>>> All OMAP4 versions seem to be affected. I couldn't find a mention about
>>> this in the mainline kernel. Any ideas how and where this should be
>>> fixed?
>>>
>> It's not patched for mainline. Generally clock-domain code
>> is abstracted from drivers but considering the errata and affected
>> modules, I guees it should be handled by DSS driver
>> since that is where the state of DSS or ISS will be known. Note
>> ISS will be automatically taken care since it will always use disaplay.
>>
>> In internal tree's this was handled as part of DSS early suspend/resume
>
> That version doesn't work as it uses functions that are not exported to
> drivers.
>
> I don't know much about the clock domain code, but I hope there's a way
> to handle it there. Otherwise I guess I need to add a new set of
> platform callback functions, so that the dss driver can call
> arch/arm/mach-omap2 code to enable and disable the work-around. I
> dislike that because I'm currently trying to remove those kinds of hacks
> to make dss work better with DT =).

I think we should just find another workaround :-)

There is not way we can let the drivers play directly with the clock 
domain idle mode.
And in theory hacking the local sysconfig should have the same effect.

So we should check for a better workaround with HW designers on that one.

Regards,
Benoit
