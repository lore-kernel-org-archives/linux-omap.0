From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC/PATCH 04/14] OMAP: McBSP: use existing macros for converting
 between devices
Date: Wed, 10 Aug 2011 12:15:50 +0200
Message-ID: <4E425A56.4000605@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com> <1312897232-4792-5-git-send-email-manjugk@ti.com> <20110810100704.856fcc5c.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45839 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab1HJKQD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 06:16:03 -0400
In-Reply-To: <20110810100704.856fcc5c.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>

Manju,

On 8/10/2011 9:07 AM, Jarkko Nikula wrote:
> Hi
>
> On Tue, 09 Aug 2011 19:10:22 +0500
> "G, Manjunath Kondaiah"<manjugk@ti.com>  wrote:
>
>> From: Kevin Hilman<khilman@ti.com>
>>
>> For converting from struct device to platform_device, and from
>> platform_device to struct device, there are existing macros.  Use
>> them instead of manual use of container_of().
>>
>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>> ---
>>   arch/arm/plat-omap/mcbsp.c |    6 +++---
>>   1 files changed, 3 insertions(+), 3 deletions(-)
>>
> Kevin dropped this patch and used mine that does more cleanups:
>
> http://marc.info/?l=linux-omap&m=131255627918065&w=2
>
> Worth to check also other patches since Kevin's updated set seems to
> have other differences too:
>
> http://marc.info/?l=linux-omap&m=131258997416300&w=2

In fact, you'd better point to the lastest Kevin's tree and not included 
the patches in this series.

Benoit
