From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: i2c, gpio, spi and regulator DTS updates
Date: Thu, 15 Mar 2012 00:38:13 +0100
Message-ID: <4F612BE5.5000603@ti.com>
References: <4F5E89B4.4010505@ti.com> <4F6120A5.6050407@ti.com> <20120314225743.GT12083@atomide.com> <4F6123E4.5090808@ti.com> <20120314232147.GU12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60168 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560Ab2CNXiT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 19:38:19 -0400
In-Reply-To: <20120314232147.GU12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

On 3/15/2012 12:21 AM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [120314 16:06]:
>> On 3/14/2012 11:57 PM, Tony Lindgren wrote:
>>> * Cousson, Benoit<b-cousson@ti.com>   [120314 15:52]:
>>>> Hi Tony,
>>>>
>>>> It looks like Chris Ball just queued  the HSMMC DT stuff from
>>>> Rajendra, so I can add as well the MMC DTS for OMAP3 and OMAP4 as
>>>> well.
>>>>
>>>> It is fine for an update?
>>>
>>> Sure, I'm not planning to pull this until after the merge
>>> window.
>>
>> OK, so we will not have the DTS support for the new drivers for 3.4 :-(
>
> Well you said this one has driver dependencies :)

Well, this is not a strong dependency, but it is still better to have 
the driver adapted to use the DTS node.

What is really unfair is that I did remove the DTS from the driver 
series to avoid conflict during merge of the various driver series. So 
next time, I guess I'd rather let the DTS along with the driver, but 
this is really a pity.

>> Well, if you pull that in a lo branch, that will be enough to base
>> the further work on it.
>
> Right we got something like seven branches ready to go for
> early merging after the merge window.. We should have patches
> sitting in linux-next for at least a week before the merge
> window opens.

I know that, but since it is just a bunch of DTS, none of them will 
break anything in linux-next anyway...

>>>> Than I can add as Kevin's patch for twl irq_base removal.
>>>
>>> Hmm I don't follow. That's needed first as a fix for the
>>> merge window?
>>
>> No, not that one. It is just some more cleanup on top of the one
>> Felipe already did in the twl series I've just sent to Samuel.
>> But if you do not plan to pull that series for 3.4, that does not
>> really matter.
>
> Ah OK. In that case feel free to update. Also check if some
> of these can be sent as fixes during the -rc cycle?

No, that should be fine, this one can wait 3.5.

Regards,
Benoit
