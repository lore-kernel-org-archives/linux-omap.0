From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v15 06/12] OMAP: dmtimer: switch-over to platform device driver
Date: Thu, 15 Sep 2011 11:12:53 +0530
Message-ID: <CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
	<20110914214533.GA30941@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:42347 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754414Ab1IOFmy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 01:42:54 -0400
Received: by mail-bw0-f53.google.com with SMTP id zt12so2372317bkb.12
        for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 22:42:53 -0700 (PDT)
In-Reply-To: <20110914214533.GA30941@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, Sep 15, 2011 at 3:15 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110908 13:36]:
>> Register timer devices by going through hwmod database using
>> hwmod API. The driver probes each of the registered devices.
>> Functionality which are already performed by hwmod framework
>> are removed from timer code. New set of timers present on
>> OMAP4 are now supported.
>
> Adding the support for the different offsets on some omap4
> timers should be a separate patch.
>
> Also, as we don't need the support for different register offsets
> for the first two omap4 timers, please rather implement support
> for the new timers and the timeouts directly in plat-omap/dmtimer.c.
>
> That way we can still keep the minimal timer support simple
> for clocksource and clockevent. Of course this means that we'll
> be only supporting the first two timers as system timers on
> omap4, but that's fine.
Ok, I can make the change!
But, do we have to keep OMAP5 in mind right now where even timers[1,2]
require addition of offsets?
--
Tarun
[...]
