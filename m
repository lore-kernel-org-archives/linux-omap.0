From: sourav <sourav.poddar@ti.com>
Subject: Re: [PATCHv2] i2c: omap: Disable default probing of i2c devices for
 omap i2c.
Date: Thu, 10 Apr 2014 19:15:17 +0530
Message-ID: <5346A06D.1020203@ti.com>
References: <1397039808-28594-1-git-send-email-sourav.poddar@ti.com> <20140409123702.GA8157@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59968 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030713AbaDJNpZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 09:45:25 -0400
In-Reply-To: <20140409123702.GA8157@katana>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>

Hi Wolfram,

On Wednesday 09 April 2014 06:07 PM, Wolfram Sang wrote:
> On Wed, Apr 09, 2014 at 04:06:48PM +0530, Sourav Poddar wrote:
>> I2c core supports defualt probing functionality for devices not registered through
>> dt/board files. If there are any client driver registered, i2c core will try to
>> check if there is any device present corresponding to the address supplied by
>> the client driver. If the device is actually present and not registered, core
>> will register it, else the device default probe will fail and we get a omap i2c controller
>> specific timeout messages.
>> For example, Using multi_v7_config on omap5-uevm, CONFIG_SENSORS_LM90 and CONFIG_ICS932S401
>> is the driver which is enabled and gets registered. I2c core tries to find a valid
>> corresponding device on each of the address supplied by registered driver,
>> but could not find anyone. Hence, keep dumping the controller timeout speciic message.
> This is exactly why I2C_CLASS_DEPRECATED was implemented. So, users
> which are using classes can migrate away. But this needs time. Given
> that I2C_CLASS_DEPRECATED is new in 3.15, I'd think setting classes to 0
> (thus totally disabling them) should not be before 3.17. You don't need
> to resend, I'll do it for all drivers I added this new class to when I
> feel it is safe to do.
OK then, I am dropping this patch, will wait for your patches on it.
Thanks for the review.

~Sourav
>
> Thanks,
>
>     Wolfram
>

