From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [POWER DOMAIN suspend callbacks] Observation.
Date: Wed, 24 Aug 2011 11:47:13 +0530
Message-ID: <4E549769.2030800@ti.com>
References: <4E53B6FC.8030507@ti.com> <871uwcjbwi.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:42256 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751059Ab1HXGRU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 02:17:20 -0400
Received: by mail-yx0-f180.google.com with SMTP id 11so1182747yxi.25
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 23:17:19 -0700 (PDT)
In-Reply-To: <871uwcjbwi.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Govindraj R <govindraj.raja@ti.com>

On Tuesday 23 August 2011 10:36 PM, Kevin Hilman wrote:
> Hi Santosh,
>
> Santosh<santosh.shilimkar@ti.com>  writes:
>
>> Rafael, Kevin,
>>
>> On latest kernel( V3.1-rc1+), the subsystem(driver) suspend
>> callbacks are not getting called because power domain callbcaks
>> are populated.
>>
>> And as per commit 4d27e9dc{PM: Make power domain callbacks take
>> precedence over subsystem ones}, it's expected bahavior.
>
> Correct.
>
>> Who is suppose to call the driver suspend callback?
>
> If populated, the PM domain callbacks should call the driver callbacks.
> If there are no PM domain callbacks, then the subsystem (in this case,
> the platform_bus) should be calling the driver callbacks.
>
>> Some drivers/subsystem would have state machine which needs to
>> be suspended.
>>
>> Is the power domain suspend callback, suppose to take care of
>> it ? If yes, then that seems to be missing for OMAP.
>
> Yup, there's a bug.    They're not missing, just misplaced. ;)
>
> When adding the noirq callbacks to ensure devices are idled late in
> suspend by omap_device, I the patch commited mistakenly uses
> SET_SYSTEM_SLEEP_PM_OPS(), which sets the "normal" suspend/resume
> handlers and not the noirq handlers.
>
> Can you try the patch below?  I only briefly tested it on omap3/n900 so
> far.
>
The patch works like charm.

> This populates most of the PM domain methods with the same ones used by
> the subystem (platform_bus) and only overrides the noirq methods with
> custom versions.  This patch should make all the driver's suspend/resume
> methods be called as expected.
>
> After a bit more sanitiy testing, I'll post a real patch for the -rc
> series.
>
Great.

Regards
Santosh
