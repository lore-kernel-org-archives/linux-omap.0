From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP: tsc2005: Change state machine to be more
	stable.
Date: Tue, 17 Feb 2009 16:16:09 -0800
Message-ID: <20090218001608.GJ11928@atomide.com>
References: <cad4802ce1266717a82d5bb73118713de1fdfd15.1234789985.git.ext-phil.2.carmody@nokia.com> <4602dff1637b96a23837d3552838b20e9a92ceb1.1234789985.git.ext-phil.2.carmody@nokia.com> <5d5443650902170943y24551e8dob8f8e1e6629153fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64103 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbZBRAQM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 19:16:12 -0500
Content-Disposition: inline
In-Reply-To: <5d5443650902170943y24551e8dob8f8e1e6629153fc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [090217 09:44]:
> Hi Phil,
> 
> >        r = request_irq(ts->spi->irq, tsc2005_ts_irq_handler,
> > -                       IRQF_TRIGGER_FALLING | IRQF_DISABLED |
> > -                       IRQF_SAMPLE_RANDOM, "tsc2005", ts);
> > +                       (((TSC2005_CFR2_INITVALUE & TSC2005_CFR2_IRQ_MASK) ==
> > +                         TSC2005_CFR2_IRQ_PENDAV)
> > +                        ? IRQF_TRIGGER_RISING
> > +                        : IRQF_TRIGGER_FALLING) |
> > +                       IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "tsc2005", ts);
> 
> No need to IRQF_SAMPLE_RANDOM, as it is already handled by input
> subsystem. Please check input_report_event.
> 
> I had submitted earlier version of tsc2005.c to mainline, and we have
> got couple of comments, I can see that you have fixed simple_strtoul
> return related problem in sysfs in the first patch. I will send you
> that thread link tomorrow.

Yeah let's plan on resetting l-o tree drivers/input/touchscreen at
some point soon to mainline. Those driver patches should be discussed
on the input list with l-o list cc'd.

Regards,

Tony
