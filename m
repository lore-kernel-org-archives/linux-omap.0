From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/2] OMAP: tsc2005: Change state machine to be more
	stable.
Date: Tue, 17 Feb 2009 23:13:01 +0530
Message-ID: <5d5443650902170943y24551e8dob8f8e1e6629153fc@mail.gmail.com>
References: <cad4802ce1266717a82d5bb73118713de1fdfd15.1234789985.git.ext-phil.2.carmody@nokia.com>
	 <4602dff1637b96a23837d3552838b20e9a92ceb1.1234789985.git.ext-phil.2.carmody@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:1467 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbZBQRnB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 12:43:01 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3353950wfa.4
        for <linux-omap@vger.kernel.org>; Tue, 17 Feb 2009 09:43:01 -0800 (PST)
In-Reply-To: <4602dff1637b96a23837d3552838b20e9a92ceb1.1234789985.git.ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Phil,

>        r = request_irq(ts->spi->irq, tsc2005_ts_irq_handler,
> -                       IRQF_TRIGGER_FALLING | IRQF_DISABLED |
> -                       IRQF_SAMPLE_RANDOM, "tsc2005", ts);
> +                       (((TSC2005_CFR2_INITVALUE & TSC2005_CFR2_IRQ_MASK) ==
> +                         TSC2005_CFR2_IRQ_PENDAV)
> +                        ? IRQF_TRIGGER_RISING
> +                        : IRQF_TRIGGER_FALLING) |
> +                       IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "tsc2005", ts);

No need to IRQF_SAMPLE_RANDOM, as it is already handled by input
subsystem. Please check input_report_event.

I had submitted earlier version of tsc2005.c to mainline, and we have
got couple of comments, I can see that you have fixed simple_strtoul
return related problem in sysfs in the first patch. I will send you
that thread link tomorrow.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
