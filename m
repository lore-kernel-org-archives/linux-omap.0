From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/6] ARM: OMAP4 PM: Add IO Daisychain support
Date: Fri, 24 Feb 2012 14:23:45 +0530
Message-ID: <CAMQu2gzcZnRaiV-h5zi0AGz4=36iw5Qo-nbMuUT8ZgoCOvvxPg@mail.gmail.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
 <1330003320-17400-3-git-send-email-t-kristo@ti.com> <CAMQu2gxWYVPMBkj0oD=Cj5r1O+X4Y-Lgpntsvc+Jxj3X6XyviQ@mail.gmail.com>
 <4F47355E.3090107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:58078 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755794Ab2BXIyG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 03:54:06 -0500
Received: by mail-tul01m020-f172.google.com with SMTP id wd15so3884484obb.17
        for <linux-omap@vger.kernel.org>; Fri, 24 Feb 2012 00:54:05 -0800 (PST)
In-Reply-To: <4F47355E.3090107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>, "Dhavlikar, Nilesh" <dnilesh@ti.com>

On Fri, Feb 24, 2012 at 12:29 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Thursday 23 February 2012 07:18 PM, Shilimkar, Santosh wrote:
>>
>> On Thu, Feb 23, 2012 at 6:51 PM, Tero Kristo<t-kristo@ti.com> =A0wro=
te:
>
> [..]
>
>>>
>>> +/**
>>> + * Maximum time(us) it takes to output the signal WUCLKOUT of the =
last
>>> pad of
>>> + * the I/O ring after asserting WUCLKIN high
>>> + */
>>> +#define MAX_IOPAD_LATCH_TIME 1000
>>> +
>>
>> Is the 1000 us/ms ?
>
>
> 1000 us.
>
>
>> Is that documented or arbitrary chosen ?
>
>
> looks like it was arbitrarily chosen as there's no documentation
> on the worst case delay. I spoke to Nilesh (copied) and he suggested
> using a value close to 100us instead which should be quite safe.
> 1000us according to him is really very high.
> however there does not seem to be any documented value available for
> this in any of the specs.
>
Thanks for clarification Rajendra.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
