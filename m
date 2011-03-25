From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/6] arm: mach-omap2: smartreflex: fix sr_late_init() error path in probe
Date: Fri, 25 Mar 2011 07:51:58 -0700
Message-ID: <87bp0zw8vl.fsf@ti.com>
References: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
	<1300984535-10530-2-git-send-email-aaro.koskinen@nokia.com>
	<87fwqczbba.fsf@ti.com> <4D8C1111.7030807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:35371 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753701Ab1CYOwD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 10:52:03 -0400
Received: by mail-gw0-f43.google.com with SMTP id 21so627362gwj.2
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 07:52:01 -0700 (PDT)
In-Reply-To: <4D8C1111.7030807@ti.com> (Nishanth Menon's message of "Fri, 25
	Mar 2011 09:20:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman wrote, on 03/24/2011 10:48 PM:
>> Also, I renamed the subject/shortlog to use 'OMAP2+: smartreflex: ..."
>> instead of 'arm: mach-omap2'.
>
> might be better to be OMAP3+ we dont have SR on OMAP2 :)
>

Good point.  Will use OMAP3+.

Thanks,

Kevin

P.S. Nishanth, as you are one of the primary developers on SR, any
     acks, reviewed-bys from you are most welcome on SR patches.
     Thanks.

