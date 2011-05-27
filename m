From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 2/2] OMAP: add omap_device_reset()
Date: Fri, 27 May 2011 20:21:26 +0530
Message-ID: <4DDFBA6E.4070005@ti.com>
References: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>	 <1306481908-7386-3-git-send-email-tomi.valkeinen@ti.com>	 <4DDF9B5D.7060408@ti.com> <1306500367.1905.18.camel@deskari> <4DDFB8AF.1080800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:48465 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751525Ab1E0Ovd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 10:51:33 -0400
Received: by mail-gx0-f169.google.com with SMTP id 23so992316gxk.0
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 07:51:32 -0700 (PDT)
In-Reply-To: <4DDFB8AF.1080800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 5/27/2011 8:13 PM, Cousson, Benoit wrote:
> On 5/27/2011 2:46 PM, Valkeinen, Tomi wrote:
>> On Fri, 2011-05-27 at 14:38 +0200, Cousson, Benoit wrote:
>>> Hi Tomi,
>>>
>>> On 5/27/2011 9:38 AM, Valkeinen, Tomi wrote:
>>>> Add omap_device_reset() function which can be used to reset the hwmods
>>>> associated with the given platform device.
>>>
>>> We've never exposed it because we are trying to avoid that any driver
>>> play with asynchronous HW reset. That can lead to undefined HW
>>> behavior :-(
>>>
>>> Do you have some strong need for that?
>>
>> DSS driver has been designed so that it resets the HW before it begins
>> programming it. That way we get the HW into known state. Otherwise we
>> need to be extra careful to program all possible registers to a sane
>> value. Not impossible, of course, but requires extra work.
>>
>> I noticed the problem with DSI driver, it didn't work anymore if I
>> didn't reset it.
>>
>> Why does it lead to undefined HW behaviour? Isn't it much better to
>> reset the HW before starting to use it to be 100% sure it's in known and
>> valid state?
>
> In theory, but since your are resetting only the DSS IP, it can leads to
> side effect at SoC level. Especially wrt to clock management.
>
>> Especially in error situations it may be difficult (even impossible) to
>> recover without reset. DISPC has been known to froze in some sync lost
>> situations, and, if I recall right, if DSI transfer is aborted the only
>> way to recover is to reset the DSI block (on OMAP3).
>
> In case of recovery error it makes sense. What we did with hardreset is
> to re-assert the reset upon disable of the module and then the next
> enable will de-assert it. Softreset does not do that today.
>
I didn't notice this patch but Paul reported an issue on beagle
which was making L3 error handling driver hang.

Later on after debugging we noticed, that DSS initiator
was throwing timeout error.

As a temporary fix, we removed the timeout error from
the handler since root-cause was not known. [1]

I am not sure but may be a proper DSS reset might fix
that issue as well.

Regards
Santosh
[1] https://patchwork.kernel.org/patch/769482/





