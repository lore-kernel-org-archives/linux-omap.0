From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [RFC/PATCH] OMAP PM interface
Date: Tue, 29 Apr 2008 15:59:43 -0700
Message-ID: <874p9kgtcw.fsf@paris.hilman.org>
References: <alpine.DEB.1.00.0804290119480.5853@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:61022 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYD2W7s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 18:59:48 -0400
In-Reply-To: <alpine.DEB.1.00.0804290119480.5853@utopia.booyaka.com> (Paul Walmsley's message of "Tue\, 29 Apr 2008 01\:32\:14 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, sakari.poussa@nokia.com, sawant@ti.com, karthik-dp@ti.com, igor.stoppa@nokia.com, tony@atomide.com, r-woodruff2@ti.com, veera@ti.com, rnayak@ti.com

Paul Walmsley <paul@pwsan.com> writes:

> Linux PM QOS parameters:
>
> As of February, the mainline Linux kernel contains code that is
> somewhat similar to the SRF: the Linux PM QOS parameters code, located
> in kernel/pm_qos_params.c.  (This code replaced the latency management
> code that was present in earlier kernels.)  Ideally, OMAP drivers
> would be able to use this Linux PM QOS code directly, but the current
> PM QOS code has some drawbacks:
>
> - It combines some power management parameters that should be kept
>   separate for maximum power savings on OMAP3.  For example, in the PM
>   QOS code, CPU and DMA wakeup latency are combined into one
>   parameter; but on OMAP3, these are distinct parameters.  The Linux
>   PM QOS code also combines all network power management knobs into
>   two non-device-specific parameters.  OMAP2/3 systems can have
>   different network devices with different power management
>   requirements - for example, a wired Ethernet interface may have
>   different latency and throughput constraints than a wireless Ethernet
>   interface.
>
> - It does not yet cover all of the power management capabilities of
>   the OMAP3 architecture.  It does not express latency constraints on
>   a per-device or per-powerdomain basis; it only covers
>   cpu_dma_latency and network throughput and latency, which would not
>   cover most of the OMAP3 devices.
>
> The result is that drivers using the current Linux PM QOS layer
> directly are unlikely to reach the same level of power efficiency as
> driver code using the Shared Resource Framework.

Paul,

First, thanks for working on this.  This is a huge step in the right
direction in my opinon.  Thanks!

I've only given a quick glance so far at the actual patch, but my
first comments are regarding the dismissal of the PM QoS framework.

I totally agree that the QoS framework in its current form has several
drawbacks and limitations.  However, instead of re-designing something
new, I think maybe we should first try to extend the QoS framework.

I've had a few conversations with the Intel folks who worked on PM QoS
and got it into mainline, especially Mark Gross.  He is quite aware
that it is only the very beginnings of a framework.  He is also very
interested in potential users and their concerns about limitations of
the framework.

Since it came out of Intel, PM QoS definitely has a PC/UMPC focus, but
this is a perfect opportunity to help extend the framework to be
useful in embedded systems.  I'm sure the Intel guys will be happy to
hear about potential users and use cases for the framework and why it
should be extended/updated to work well in embedded.

For starters, we could just use the existing PM QoS framework as it is
and just add a new set of parameters.  Then begin dissucions with the
PM QoS folks as to how they could be generalized and unified with the
existing ones.

Thoughts?

Kevin
