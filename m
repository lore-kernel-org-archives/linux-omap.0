From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 6/8] OMAP: PM CONSTRAINTS: implement the devices wake-up
 latency constraints
Date: Fri, 16 Sep 2011 17:43:10 +0200
Message-ID: <CAORVsuWH+MjOL-VYWZQt_Lxpp1=7Emw=ZXfeMCW8TofuX1u_vw@mail.gmail.com>
References: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
	<1314969204-21704-7-git-send-email-j-pihet@ti.com>
	<878vpptlku.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f42.google.com ([209.85.212.42]:33347 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab1IPPnL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 11:43:11 -0400
Received: by vwl1 with SMTP id 1so7244636vwl.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 08:43:10 -0700 (PDT)
In-Reply-To: <878vpptlku.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Kevin,

On Fri, Sep 16, 2011 at 1:47 AM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Implement the devices wake-up latency constraints using the global
>> device PM QoS notification handler which applies the constraints to =
the
>> underlying layer by calling the corresponding function at hwmod leve=
l.
>>
>> Note: the bus throughput function is implemented but currently is
>> a no-op. A new PM QoS class for the bus throughput needs to be
>> added.
>>
>> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wa=
ke-up
>> latency constraints on MPU, CORE and PER.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> This patch does 2 things.
>
> 1) removes the MPU lat stuff from the OMAP PM layer (since it's now
> =A0 available in a generic form
> 2) implements device wake-up latency constraints
>
> This should be broken up into two parts.
>
> Also, this patch seems to remove a bunch of stuff that was just added=
 in
> patch 2/8. =A0Probably best to create the new OMAP PM layer after rem=
ving
> the unused stuff.
>
> It think the code using the new per-device PM QoS API should also liv=
e
> outside the OMAP PM layer, since it's not related, and we want to get
> rid of the OMAP PM layer eventually.
>
> Speaking of which..., the more I think about it, the more I think we
> should take this opportunity to clean and/or remove the OMAP PM layer
> completely.


I agree completely, the OMAP PM 'plugin' layer is useless and anyway
an empty implementation for now.

> With your work, other than the no-op bus throughput API, it's basical=
ly
> unused. =A0I think that rather than creating a new OMAP PM layer just=
 to
> have a a no-op bus throughput function here, I think it's time
> to remove OMAP PM completely.
Ok. The only useful code is to register a PM QoS notifier in order to
apply the constraints to the power domains.
Are you suggesting to move this code to e.g. pmxxx.c?

> =A0 This might also give some incentive
> for a PM QoS bus throughput constraint as well.
Sure the tput constraints should be implemented as well.

>
> Of course, Paul can make the final decision there whether to remove i=
t
> now, but I think it's time.
>
> Just to prove it's usefulness (or lack thereof), Here's a hack that
> combined with your patch 1/8 shows that it is pretty easy to remove.
>
> Kevin

Thanks!
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
