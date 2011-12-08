From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2] staging: tidspbridge: request dmtimer clocks on init
Date: Thu, 8 Dec 2011 13:10:04 -0600
Message-ID: <CAB-zwWiNkD=jinUgvdd6w8-2BCYTB+TiPBJij+LgY13gO=NQoQ@mail.gmail.com>
References: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
	<CAMP44s0OvrrWnYJzowkMUT7-jHKYS=LZUty=e1d9gM=OZT-0Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:51850 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750861Ab1LHTKJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 14:10:09 -0500
Received: by faan2 with SMTP id n2so1132399faa.1
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 11:10:06 -0800 (PST)
In-Reply-To: <CAMP44s0OvrrWnYJzowkMUT7-jHKYS=LZUty=e1d9gM=OZT-0Ow@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

On Wed, Dec 7, 2011 at 4:11 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Nov 19, 2011 at 12:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> Given that dm timer framework doesn't support request of clocks
>> by soft | hard irqs because some recent changes, tidspbridge needs
>> to request its clocks on init and enable/disable them on demand.
>>
>> This was first seen on 3.2-rc1.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>
> This looks similar similar to this one:
> http://article.gmane.org/gmane.linux.ports.arm.omap/61816
>
> Are you sure this is what we want instead of that one?

I believe your patch only takes care of gpt5 and gpt6, but not of the
other 2 that could be requested by the dsp, let's say gpt8 for avsync.

As for this patch, dm timer framework should support request on soft
or hard irq[1], but it can't because the underlying functions to use
clk_get->clk_get_sys which holds a mutex.

I believe your error was seen because of patches not in mainline, but
the concept between the patches is similar indeed, however mine:

- Handles the other gpt that can be requested by the dsp.
- Uses start/stop according to future plans of making enable/disable static.
- Might be temporal if *dm_timer_request* functions are fixed and
there is an overall feeling that we can revert to use
request+start/stop+free on request.

Regards,
Omar,
---
[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg58665.html
