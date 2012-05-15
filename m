From: Kevin Hilman <khilman@ti.com>
Subject: Re: PATCH: add small infrastructure and definitions to export debugfs files for OMAP powerdomain attributes
Date: Tue, 15 May 2012 10:47:35 -0700
Message-ID: <87d365l4js.fsf@ti.com>
References: <CAHjCt2-LrQOKwX2XpepGgLewS5mnFzZxJAKnr+smOgtmRLmsnw@mail.gmail.com>
	<CAP245DV2u5DM+dk-kYNK5jtP8f1AHCHce0MBBOwFUFDKc6sX8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:40174 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932478Ab2EORrg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 13:47:36 -0400
Received: by pbbrp2 with SMTP id rp2so8519924pbb.0
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 10:47:34 -0700 (PDT)
In-Reply-To: <CAP245DV2u5DM+dk-kYNK5jtP8f1AHCHce0MBBOwFUFDKc6sX8A@mail.gmail.com>
	(Amit Kucheria's message of "Tue, 15 May 2012 14:56:00 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: eric van tassell <evttxl@gmail.com>, Hongbo Zhang <hongbo.zhang@linaro.org>, linaro-kernel@lists.linaro.org, linux-omap@vger.kernel.org

Hi Amit, Eric,

Amit Kucheria <amit.kucheria@linaro.org> writes:

> Eric,
>
> This looks interesting, but I'll add the linux-omap list to CC so
> someone can verify if there isn't already a patch to export this.

We used to have similar PM debug code in the kernel, but as the one who
maintained it, I decided to remove it.  This kind of thing is obviously
very SoC specific, and therefore a major pain to maintain in the kernel
for all the SoCs we support in linux-omap.

In my view, this kind of raw register dump/analysis does not belong in
the kernel, but rather in userspace tools.  

What we have been moving towards is using tracepoints in the
clock/clockdomain/powerdomain layers to track state transitions in all
of these layers.  By analyzing the trace you can similarily see the
state of each of the clocks and powerdomains.  We currently don't have
all of the low-level details (like context loss, logic & mem state,
etc.) but that is not difficult to add with some new tracepoints.

I removed the in-kernel register dumping in the hope that folks would
start using userspace tools perf/ftrace to do the same.

Kevin
