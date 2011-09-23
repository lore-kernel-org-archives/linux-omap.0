From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2+: clock: cleanup CPUfreq leftovers
Date: Fri, 23 Sep 2011 06:58:10 -0700
Message-ID: <87vcsjl5sd.fsf@ti.com>
References: <1316726006-26925-1-git-send-email-khilman@ti.com>
	<alpine.DEB.2.00.1109221746130.10719@utopia.booyaka.com>
	<alpine.DEB.2.00.1109230034180.10719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:34093 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754142Ab1IWN6Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 09:58:16 -0400
Received: by mail-gx0-f174.google.com with SMTP id 6so3536624gxk.33
        for <linux-omap@vger.kernel.org>; Fri, 23 Sep 2011 06:58:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109230034180.10719@utopia.booyaka.com> (Paul
	Walmsley's message of "Fri, 23 Sep 2011 00:34:59 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> On Thu, 22 Sep 2011, Paul Walmsley wrote:
>
>> On Thu, 22 Sep 2011, Kevin Hilman wrote:
>> 
>> > Now that we have OPP layer, and OMAP CPUfreq driver is using it, we no
>> > longer need/use the clock framework code for filling up CPUfreq
>> > tables.  Remove it.
>> > 
>> > Signed-off-by: Kevin Hilman <khilman@ti.com>
>> > ---
>> > Paul, this patch has a dependency on the OMAP CPUFreq driver
>> > move/cleanup series just posted.  Assuming that is merged for v3.2,
>> > this can go also.
>> 
>> Great, could you cc lakml also ?

doh.

> By the way, I guess the subject line should start with "ARM: OMAP2+: 
> clock: " .. etc., per Arnd's recent request.

yeah, will refresh.

Kevin
