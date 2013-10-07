From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Mon, 7 Oct 2013 08:41:03 -0700
Message-ID: <20131007154103.GW8949@atomide.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com>
 <20131007021556.GV8949@atomide.com>
 <52525642.8010307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56743 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752920Ab3JGPlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 11:41:07 -0400
Content-Disposition: inline
In-Reply-To: <52525642.8010307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [131006 23:43]:
> On 10/07/2013 05:15 AM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [131004 08:42]:
> >>Hi,
> >>
> >>Just a gentle reminder, anybody have any comments on this series or
> >>should we start queuing stuff?
> >
> >Well omap4 seems to work for me just fine, and omap3 in legacy
> >mode. But looks like omap3 device tree based booting is breaking
> >after I pulled in your test branch. I get the following on
> >3630 based dm3730.
> 
> Uart4 breaks because of the issue with basic DT blobs. You need at
> least this patch:
> 
> http://linux-kernel.2935.n7.nabble.com/RFC-PATCH-ARM-OMAP3630-Add-generic-machine-descriptor-td722791.html
> 
> ... from Nishanth to get it to work right. Otherwise the clock init
> tries to use omap3430 clock data for omap3630 which leaves uart4
> nodes out.

OK thanks yes that solves it, I was missing the compatible flag
for my not quite ready test boards (3730-evm and zoom3).
I'll apply Nishant's fix with some changes.

Then for this series, once you have the necessary acks, can you
please split into following two separate immutable branches
against v3.12-rc3:

1. clock code changes

2. dts changes

Then those can be pulled in as needed by Benoit, Mike and I.

For the whole series, I think this quite nicely removes some
nasty kernel data dependencies for omaps, so feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
