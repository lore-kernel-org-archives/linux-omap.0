From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 0/3] ARM: OMAP3: PM: optimize cpuidle C1 state latency
Date: Fri, 1 Jun 2012 18:29:08 +0200
Message-ID: <CAORVsuVt1rGoW9T+XbDtg+7iP7reiFRxdew80SGwHqya+wpivQ@mail.gmail.com>
References: <1338563468-31403-1-git-send-email-j-pihet@ti.com>
	<87ipfbt2w2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40316 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965301Ab2FAQ3K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 12:29:10 -0400
Received: by lbbgm6 with SMTP id gm6so1793920lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 09:29:09 -0700 (PDT)
In-Reply-To: <87ipfbt2w2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Fri, Jun 1, 2012 at 6:26 PM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Jean,
>
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> The C1 state latency can be improved by optimizing the cpuidle low
>> level code.
>>
>> The first patch is a precaution fix for patch 2.
>> Patches 2 & 3 are optimization changes.
>>
>> Rebased on top of the for_3.6/pm/performance branch of
>> khilman's tree [1].
>>
>> Tested on Beagleboard using a DMA-enabled copy from NAND flash
>> to /dev/null.
>
> Thanks for following this through.
>
> Adding this series to my for_3.6/pm/performance branch.
Great!

>
> Also FYI, combining your series with the various fixes for CORE
> retention, I'm seeing CORE hit retention in idle just fine on 3430/n900
> and 3530/Overo.
Nice, thx for testing!

>
> Thanks!
>
> Kevin

Regards,
Jean
