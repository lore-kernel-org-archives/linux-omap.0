From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: RX-51: Platform support for lp5523
Date: Thu, 31 Mar 2011 15:20:57 +0300
Message-ID: <4D9471A9.9090206@nokia.com>
References: <20110329172922.GA19494@earth.universe> <20110329173647.GK4016@atomide.com> <20110329181615.GA20371@earth.universe> <20110329193301.GP4016@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:57514 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232Ab1CaMV0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 08:21:26 -0400
In-Reply-To: <20110329193301.GP4016@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@debian.org>, linux-omap@vger.kernel.org

Hi Tony,

On 03/29/2011 10:33 PM, ext Tony Lindgren wrote:
> * Sebastian Reichel<sre@debian.org>  [110329 11:13]:
>> On Tue, Mar 29, 2011 at 10:36:47AM -0700, Tony Lindgren wrote:
>>> * Sebastian Reichel<sre@debian.org>  [110329 10:26]:
>>>> Is there any reason, that the rx51 platform code does not support
>>>> the lp5523 chip? The chip driver itself is in the mainline kernel
>>>> since 2.6.37-rc2.
>>>
>>> Got a patch for that? As always, patches related to blinking leds
>>> have a special high priority here! :)
>>
>> Ameya Palande has written one, which is available at [0]. I added
>> him to CC, so that he can comment on mainline inclusion.
>
> OK. Ameya, can you please post it for review for this list with
> linux-arm-kernel list Cc'd?

Done!

Here is the patch: http://marc.info/?l=linux-omap&m=130157389724187&w=2

Cheers,
Ameya.
