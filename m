From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 4/4] OMAP2: PM debug: move wakeup timer into
 clockevent code
Date: Mon, 30 May 2011 10:08:14 +0200
Message-ID: <BANLkTikqpRdbixs-UhM1tAUTDM3k9LQ33A@mail.gmail.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
	<1306450971-27732-5-git-send-email-khilman@ti.com>
	<4DDF3421.30308@ti.com>
	<4DE34568.9060901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45053 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab1E3IIP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 04:08:15 -0400
Received: by qwk3 with SMTP id 3so1574437qwk.19
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 01:08:14 -0700 (PDT)
In-Reply-To: <4DE34568.9060901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, p-titiano@ti.com

On Mon, May 30, 2011 at 9:21 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Kevin,
>
> On 5/27/2011 10:48 AM, Santosh Shilimkar wrote:
>>
>> On 5/27/2011 4:32 AM, Kevin Hilman wrote:
>>>
>>> Move suspend wakeup timer from suspend path to be triggered based
>>> on clockevent suspend path.
>>>
>>> When gptimers are eventually converted to be a driver, the wakeup
>>> timer feature can be made to be a driver-specific feature using the
>>> driver's suspend method.
>>>
>> Excellent idea and patch. Never crossed my mind that we could
>> have used "CLOCK_EVT_MODE_SHUTDOWN" instead of our long old
>> hack.

Great!
Acked-by: Jean Pihet <j-pihet@ti.com>

What platform has is been tested on?

Regards,
Jean

>>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
>
> I will use this patch and other series for my OMAP4 re-basing
> since it's all necessary and good clean-up.
>
> Is that ok with you ?
>
> Regards
> Santosh
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
