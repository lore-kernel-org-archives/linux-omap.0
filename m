From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: Beagleboard xM crashes when being set to 800MHz with smartreflex
 on linux-omap-3.6-rc6
Date: Wed, 10 Oct 2012 12:49:37 +0200
Message-ID: <CAGGh5h2M30brGOUo98-hkYZL6qf0dHEiZvkA3WBCvDGf4m7wcQ@mail.gmail.com>
References: <5448984682E7954C9BFF27F747A9C6CA56E38E@dolphin.TIGRIS.local>
	<87391xbv52.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59090 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab2JJKth (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Oct 2012 06:49:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so472121pad.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Oct 2012 03:49:37 -0700 (PDT)
In-Reply-To: <87391xbv52.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>, linux-omap@vger.kernel.org

2012/10/2 Kevin Hilman <khilman@deeprootsystems.com>:
> "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de> writes:
>
>> Hi,
>>
>> I've just built a linux-omap kernel at 3.6-rc6 using omap2plus_defconfig
>> as basis for the kernel config.
>>
>> When I enable smartreflex and switch to 800MHz via
>>
>> echo 1 > /sys/kernel/debug/smartreflex/smartreflex_core/autocomp
>> echo 1 > /sys/kernel/debug/smartreflex/smartreflex_mpu_iva/autocomp
>> cpufreq-set -f 800MHz
>>
>> the board crashes. If I switch to 800MHz and enable smartreflex later
>> nothing happens. This used to work in my 3.3 based kernel.
>
> SmartReflex is kwown to be unstable in mainline and there are several
> errata that still need fixing for it to be stable.
>
> I strongly recommend you simply leave SR disabled.
>
Does it apply to a device always at opp1G ?
Ie if I boot @1GHz and then enable smart reflex, is it ok ?

> Kevin
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
