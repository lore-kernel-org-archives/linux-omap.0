From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 5/8 v2] ARM OMAP2+ GPMC: change get_gpmc_timing_reg output
 for DTS
Date: Wed, 25 Feb 2015 17:26:03 +0100
Message-ID: <54EDF79B.80805@cit-ec.uni-bielefeld.de>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de> <54EDCD29.3010404@ti.com> <20150225152324.GN11056@atomide.com>
Reply-To: rabel@cit-ec.uni-bielefeld.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:43967 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbbBYQ0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 11:26:05 -0500
In-Reply-To: <20150225152324.GN11056@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk

Hi Tony,

On 25 Feb 2015 16:23, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [150225 05:28]:
>> On 24/02/15 22:05, Robert ABEL wrote:
>>> DTS output was formatted to require additional work when copy-pasting into DTS.
>>> Nano-second timings were removed, because they were not a confidence interval nor
>>> an indication what timing values would result in the same #ticks
>> If they were not is it possible to dump min,max timings that will result in
>> the same ticks?
> Yeah my plan was o display the nanosecond range resulting in the
> same tick value. That makes it a bit easier to compare the timings
> to the data sheet. So maybe show both tick and ns range?
Ah, so my hunch was right. I reimplemented that correctly now.
Basically, your code just went [ticks-1, ticks+1] in ns. But times are 
always ceiling(ns / gpmc_[f]clk), i.e. (ticks - 1, ticks] in ns.

Some other patches change as well because of this change, so a v3 is in 
order =].

Regards,

Robert
