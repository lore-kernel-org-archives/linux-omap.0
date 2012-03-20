From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 RESEND 0/7] gpio/omap: Some more driver fixes
Date: Tue, 20 Mar 2012 10:46:57 -0700
Message-ID: <87haxj17xq.fsf@ti.com>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
	<20120320143544.AA6E93E2834@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:35346 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753333Ab2CTRq7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 13:46:59 -0400
Received: by mail-pb0-f49.google.com with SMTP id un4so260843pbc.22
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 10:46:58 -0700 (PDT)
In-Reply-To: <20120320143544.AA6E93E2834@localhost> (Grant Likely's message of
	"Tue, 20 Mar 2012 14:35:44 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi Grant,

Grant Likely <grant.likely@secretlab.ca> writes:

> On Tue, 20 Mar 2012 16:23:12 +0530, Tarun Kanti DebBarma <tarun.kanti@ti.com> wrote:
>> This series excludes the cleanup patches as suggested by Kevin from
>> the previously posted series.
>> 
>> The fixes include correction of _set_gpio_irqenable() implementation,
>> missing wakeup_en register update in set_gpio_wakeup(), type mismatch
>> of gpio trigger parameter in set_gpio_trigger(), incorrect dataout
>> register update in set_gpio_dataout_() and few corrections in context
>> save logic.
>> 
>> It is baselined on top of:
>> git://git.secretlab.ca/git/linux-2.6.git gpio/next
>> Commit: 81b279d80a63628e580c71a31d30a8c3b3047ad4
>> 
>> Series is available here for reference:
>> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_more_fixes
>
> Merged; thanks

Can you hold off slightly before merging this.

I haven't been through v4 yet or tested the fixes alone now that they're
separated from the other cleanups.

Expect a pull request from me when ready.

Thanks,

Kevin
