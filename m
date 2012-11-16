From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix compiler warning for 32k timer
Date: Fri, 16 Nov 2012 09:03:55 -0600
Message-ID: <50A655DB.30504@ti.com>
References: <1353008644-24745-1-git-send-email-jon-hunter@ti.com> <20121115204526.GC12466@arwen.pp.htv.fi> <50A56033.6080908@ti.com> <20121116075258.GC15669@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53864 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab2KPPD7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 10:03:59 -0500
In-Reply-To: <20121116075258.GC15669@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>


On 11/16/2012 01:52 AM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Nov 15, 2012 at 03:35:47PM -0600, Jon Hunter wrote:
>>
>> On 11/15/2012 02:45 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Thu, Nov 15, 2012 at 01:44:04PM -0600, Jon Hunter wrote:
>>>> +static struct of_device_id omap_counter_match[] __initdata = {
>>>
>>> not directly related to $SUBJECT, but shouldn't this be static const
>>> __initconst ?
>>
>> Yes you are right. Looks like there are several other of_device_id
>> structs in arch/arm/mach-omap2 that could be updated to const too.
> 
> here's a quick sed substitution for you:
> 
> $ sed -i 's/static \(struct of_device_id\)\s\(\w\+\[\]\)\s\(__initdata\|\)/static const \1 \2 __initconst/' arch/arm/*omap*/*.c
> 
> It worked fine here.

Thanks. Will fix this up in a subsequent patch.

Cheers
Jon

