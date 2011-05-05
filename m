From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: DSS pm_runtime problem
Date: Thu, 5 May 2011 19:12:30 +0200
Message-ID: <4DC2DA7E.7070504@ti.com>
References: <1304611189.30935.38.camel@deskari> <1304614938.30935.44.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43487 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab1EERMd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 13:12:33 -0400
In-Reply-To: <1304614938.30935.44.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, lo-ml <linux-omap@vger.kernel.org>

You were faster than me :-)

On 5/5/2011 7:02 PM, Valkeinen, Tomi wrote:
> On Thu, 2011-05-05 at 18:59 +0300, Tomi Valkeinen wrote:
>> Hi Paul, Benoit,
>>
>> I've started testing pm runtime with DSS, and I encountered a problem.
>>
>> I'm using latest -rc5 as a base, and it looks like
>> omap_hwmod:_wait_target_ready() does not succeed for dss_core hwmod.
>> This causes _enable() to fail, but omap_device_enable_hwmods() does not
>> check the return values so it looks like everything went well, until the
>> driver crashes as the DSS HW module was off.
>>
>> Ideas about _wait_target_ready()? And omap_device_enable_hwmods() would
>> need some fixing, I wasted quite a while debugging this =).
>
> Ah, the HW needs dss_dss_clk to be enabled before calling
> pm_runtime_get, otherwise _wait_target_ready() fails. Now that I think,
> I guess Sumit mentioned this at some point.
>
> Too bad, I was hoping I could enable the required opt clocks in
> runtime_resume callback.

I guess we should at some point control that clock from the fmwk. 
Unfortunately, we still do not have the good hwmod representation for 
the DSS for the moment.

I'm working on something for all these big subsystems like DSS, ISS, c2c 
to try to fix that. It will unfortunately not be there for 2.6.40 :-(

> Shouldn't the hwmod code be able to enable/reset/etc the HW module
> independently?

Yes, it should, but we have to change the fck / modulemode / opt_clk 
management for the DSS hwmod.

> I wonder if this goes for all other DSS modules also...

We do have some dependency between all DSS modules and the dss_core that 
are not handled today by the fmwk:-(

Regards,
Benoit
