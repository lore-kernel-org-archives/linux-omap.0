From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: query about _setup() in omap_hwmod.c
Date: Fri, 13 Apr 2012 10:35:15 +0200
Message-ID: <4F87E543.3090605@ti.com>
References: <4F8550C6.9050402@ti.com> <alpine.DEB.2.00.1204130205200.25832@utopia.booyaka.com> <4F87E1F8.6000403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54655 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab2DMIfS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 04:35:18 -0400
In-Reply-To: <4F87E1F8.6000403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>

Hi Archit,

On 4/13/2012 10:21 AM, Archit Taneja wrote:
> On Friday 13 April 2012 01:39 PM, Paul Walmsley wrote:
>> On Wed, 11 Apr 2012, Archit Taneja wrote:

...

>>> dss_ick is the slave clock of all the dss hwmods on omap3. This
>>> doesn't seem
>>> to be right, does it?
>>
>> It's not 100% right, but it was intentional. The idea being that if the
>> interface clocks are autoidling, there's no need to enable or disable
>> them. We just enable them once during _setup(), and the hardware takes
>> care of it from then on.
>
> Thanks for the clarification, Rajendra also explained the same to me
> yesterday :)
>
> There were still some issues related to this, particularly on OMAP4, I
> have posted a patch set to fix this just a while back.

Yep, but I'm afraid it is not the right fix :-)

I'll comment further on the patch.

Regards,
Benoit

