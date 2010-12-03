From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v7] OMAP2+: PM: omap device: API's for handling mstandby
 mode
Date: Fri, 3 Dec 2010 13:19:06 +0100
Message-ID: <4CF8E03A.4010000@ti.com>
References: <1291298392-28729-1-git-send-email-manjugk@ti.com> <4CF8AC8B.9040800@ti.com> <20101203092514.GA10048@GLPP-machine>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35485 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758379Ab0LCMTM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 07:19:12 -0500
In-Reply-To: <20101203092514.GA10048@GLPP-machine>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/3/2010 10:47 AM, G, Manjunath Kondaiah wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [2010-12-03 09:38:35 +0100]:

[...]

>>> v7: replaced mutex lock with spin lock. Added use count for controlling
>>> access to sysconfig registers in case if overlapping request/release API's
>>> are used.
>>
>> I'm not sure it should be done here. I'd rather keep that code in
>> the DMA, since this is the only user of that feature.
>
> Are you referring to spin lock or usage count?

The spinlock is needed, I was referring to the usage count.

That being said, the API proposed by Paul (request/release
) sound like a get/put, so maybe he had that kind of usage in mind.

I'm still not convince it should be done at hwmod API level.


Paul,
Any thoughts on that?

Regards,
Benoit
