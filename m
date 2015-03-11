From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] i2c: omap: implement bus recovery
Date: Wed, 11 Mar 2015 15:47:53 +0200
Message-ID: <55004789.7080706@ti.com>
References: <1424369209-26735-1-git-send-email-balbi@ti.com> <20150309163917.GI3739@saruman.tx.rr.com> <20150311015004.GB21726@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47259 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbbCKNsB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2015 09:48:01 -0400
In-Reply-To: <20150311015004.GB21726@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: wsa@the-dreams.de, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org

Hi Felipe,

On 03/11/2015 03:50 AM, Felipe Balbi wrote:
> On Mon, Mar 09, 2015 at 11:39:17AM -0500, Felipe Balbi wrote:
>> On Thu, Feb 19, 2015 at 12:06:49PM -0600, Felipe Balbi wrote:
>>> If either SCL or SDA are stuck low, we need to
>>> recover the bus using the procedure described
>>> on section 3.1.16 of the I2C specification.
>>>
>>> Note that we're trying to implement the procedure
>>> exactly as described by that section. First we
>>> check which line is stuck low, then implement
>>> one or the other procedure. If SDA recovery procedure
>>> fails, we reset our IP in an attempt to make it work.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>> ---
>>>
>>> Tested with AM437x IDK, AM437x SK, BeagleBoneBlack and Beagle X15 with
>>> 1000 iterations of i2cdetect on all available buses.
>>>
>>> That said, I couldn't get any device to hold the bus busy so I could
>>> see this working. If anybody has any good way of forcing a condition
>>> so that we need bus recovery, I'd be glad to look at.
>>
>> ping
>
> any comments here ?? Anybody at all ????
>

I think the I2C bus recovery infrastructure should be used here ;)
As I did there https://lkml.org/lkml/2014/12/1/397, but
there are no comments too :(

regards,
-grygorii

