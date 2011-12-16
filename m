From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Prevent DSS module from going idle
 when playing audio
Date: Fri, 16 Dec 2011 10:11:41 +0100
Message-ID: <4EEB0B4D.2010305@ti.com>
References: <1324019032-31532-1-git-send-email-ricardo.neri@ti.com>  <alpine.DEB.2.00.1112160107380.12660@utopia.booyaka.com>  <1324023504.1859.11.camel@deskari>  <alpine.DEB.2.00.1112160121250.12660@utopia.booyaka.com> <1324025267.1859.29.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51309 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759321Ab1LPJLo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 04:11:44 -0500
In-Reply-To: <1324025267.1859.29.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Ricardo Neri <ricardo.neri@ti.com>, linux-omap@vger.kernel.org, mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

On 12/16/2011 9:47 AM, Tomi Valkeinen wrote:
> On Fri, 2011-12-16 at 01:27 -0700, Paul Walmsley wrote:
>> On Fri, 16 Dec 2011, Tomi Valkeinen wrote:
>>
>>> But with DT we can't use func pointers in platform_data either, right?
>>
>> In the future, if someone wants to run a platform_data-less kernel,
>> they'll have to come up with a replacement mechanism for these.  Several
>> replacements have been proposed internally, such as having an
>> omap_bus/omap_device for devices with OMAP-specific integration, but right
>> now there are more pressing crises to deal with...
>
> Ok. Benoit was telling me not to use pdata, so I thought it's a hard
> rule for DT. He didn't give me a clear alternative, though =).

Well, it is a hard requirement for DT...
So we'd better find alternative now, than introducing code we will have 
to remove later for my point of view.
But I guess it is up to you to decide the best strategy here...

I'm sorry if the DT community did not provide any better guidelines to 
replace that :-(

There are a bunch of arch that does not have any pdev/pdata, so some 
alternative should exist... I hope :-)

Regards,
Benoit
