From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 0/7] OMAP: WDT: Implement WDT in hwmod way
Date: Fri, 17 Sep 2010 15:34:36 -0700
Message-ID: <87mxrguhhf.fsf@deeprootsystems.com>
References: <1284733136-20952-1-git-send-email-charu@ti.com>
	<20100917172215.GE29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39472 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016Ab0IQWel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 18:34:41 -0400
In-Reply-To: <20100917172215.GE29610@atomide.com> (Tony Lindgren's message of
	"Fri, 17 Sep 2010 10:22:15 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, wim@iguana.be, linux-watchdog@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Varadarajan, Charulatha <charu@ti.com> [100917 07:11]:
>> Series of patches to port watchdog module to use hwmod APIs
>> for OMAP2PLUS chips and use runtime APIs for all OMAP chips.
>> For this hwmod database for OMAP2PLUS watchdog instances are
>> populated. This patch series also implements watchdog
>> module to use PM runtime APIs.
>> 
>> This patch series is created on "origin/pm-core" and is
>> tested on OMAP2430, OMAP44430, OMAP3430 SDP boards and zoom3 board.
>> Also verified that this patch series does not break the OMAP1 build.
>> 
>> This series is tested on OMAP4430 ES2 using the below series
>> http://www.spinics.net/lists/linux-omap/msg36023.html
>
> Can you please list the exact dependencies to other patches
> for the mainline kernel? Are they the same as for the
> omap serial driver just posted?

Hi Tony,

This series is based on my pm-core branch which is basically the the
stuff I have submitted upstream (my pm-next series, the runtime PM core)
and a collection of hwmod fixes that Paul/Benoit have lined up
for 2.6.37.

I will gladly queue these hwmod conversion patches in my tree if you
prefer since I am already managing all the dependencies.

Kevin
