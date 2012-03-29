From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
Date: Thu, 29 Mar 2012 10:01:48 -0500
Message-ID: <4F74795C.1080506@ti.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com> <79CD15C6BA57404B839C016229A409A83183E0CE@DBDE01.ent.ti.com> <4F73FD52.60209@ti.com> <79CD15C6BA57404B839C016229A409A83183FB9F@DBDE01.ent.ti.com> <4F74252A.7060809@ti.com> <79CD15C6BA57404B839C016229A409A83183FC32@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46635 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758908Ab2C2PBx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 11:01:53 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83183FC32@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Viabhav,

On 3/29/2012 4:14, Hiremath, Vaibhav wrote:
> On Thu, Mar 29, 2012 at 14:32:34, Nayak, Rajendra wrote:
>> On Thursday 29 March 2012 02:26 PM, Hiremath, Vaibhav wrote:
>>> The point I was trying to make here was, cpu_is_xxx() check will become ugly,
>>> as more and more devices gets added to the list, am33xx being the first one
>>> in omap34xx family.
>>
>> So are there more, other than AM33xx which are cortex A8 based but
>> share the OMAP4 PRCM IP block?
>>
>
> I would say, probably yes.
>
> But, things are so dynamic and you never know how things will shape up by
> the time you freeze the design.

So this begs the question, why does AM33xx return true from 
cpu_is_omap34xx() is the architecture is based upon OMAP4 and not OMAP3?

I understand it is a Cortex-A8 versus Corex-A9, but if the architecture 
is closer to OMAP4, then should it not be classed as OMAP4 and not OMAP3?

Raises another question if we should really have arch_is_omapXXXX and 
not cpu_is_omapXXXX.

Cheers
Jon
