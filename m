From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: RE: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 14:22:04 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1101171410290.8142@esdhcp041196.research.nokia.com>
References: <20110114194758.GM4957@atomide.com> <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com> <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-da02.ext.nokia.com ([147.243.128.26]:31668 "EHLO
	mgw-da02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab1AQMXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 07:23:34 -0500
In-Reply-To: <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org

Hi,

On Mon, 17 Jan 2011, Santosh Shilimkar wrote:
>> Amstrad E3 fails during the boot. Bisection points to:
>>
>>  	commit 211baa7016894c02fc18693e21ca479cd08ac0c0
>>  	Author: Russell King <rmk+kernel@arm.linux.org.uk>
>>  	Date:   Tue Jan 11 16:23:04 2011 +0000
>>
>>  	    ARM: sched_clock: allow init_sched_clock() to be called
>> early
>>
>> The board does not have sched_clock(), although HAVE_SCHED_CLOCK is
>> defined for all OMAP.
>>
> I guess above is sorted out by the attached patch from Paul.

I don't see how it could help? Amstrad E3 is OMAP 15xx.

A.
