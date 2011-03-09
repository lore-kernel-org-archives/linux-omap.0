From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2 14/18] I2C: OMAP1/OMAP2+: create omap I2C functionality
 flags for each cpu_... test
Date: Wed, 9 Mar 2011 16:56:17 +0100
Message-ID: <4D77A321.4070804@ti.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>	<20110308110904.23531.66727.stgit@otae.warmcat.com> <AANLkTi=KjWq9B9Bt90Th72=tXF2BfEv1p1Z-0=Sk1Z+t@mail.gmail.com> <4D779A33.9070905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56403 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757069Ab1CIP4k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 10:56:40 -0500
In-Reply-To: <4D779A33.9070905@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "andy.green@linaro.org" <andy.green@linaro.org>
Cc: Andy Green <andy@warmcat.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, Ben Dooks <ben-linux@fluff.org>

On 3/9/2011 4:18 PM, Andy Green wrote:
> On 03/09/2011 02:31 PM, Somebody in the thread at some point said:
>
> Hi -
>
>> Minor comment, Can you use
>> BIT(0) for 1, BIT(1) for 2 ... BIT (8) for 0x100
>
> OK, I agree it will be nicer.  Thanks for the comment.
>
> I guess I can just change this and issue just this guy as try 3 rather
> than sending the whole series mostly unchanged.  In that case, I'll take
> care of Benoit's member re-ordering to match the scripts at the same
> time and issue that guy as try 3 as well.

It is up to Ben, but maybe it will be less confusing to re-send the 
whole series, since you have at least two patches to update.

Maybe, just wait a little bit in case someone else has something to say 
about this series.

Benoit
