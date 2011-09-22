From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
Date: Thu, 22 Sep 2011 13:36:57 -0700
Message-ID: <87fwjotity.fsf@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<CAC83ZvKa7R_rUe-Fa15m0_5P-GE4WC2thazQ+iqF-HAqn8cE1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:50786 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753823Ab1IVUhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 16:37:04 -0400
Received: by mail-gw0-f44.google.com with SMTP id 15so3410827gwj.3
        for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 13:37:02 -0700 (PDT)
In-Reply-To: <CAC83ZvKa7R_rUe-Fa15m0_5P-GE4WC2thazQ+iqF-HAqn8cE1w@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Thu, 22 Sep 2011 20:57:34 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tarun,

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Tue, Sep 13, 2011 at 6:32 PM, Tarun Kanti DebBarma
> <tarun.kanti@ti.com> wrote:
>> This series is continuation of cleanup of OMAP GPIO driver and fixes.
>> The cleanup include getting rid of cpu_is_* checks wherever possible,
>> use of gpio_bank list instead of static array, use of unique platform
>> specific value associated data member to OMAP platforms to avoid
>> cpu_is_* checks. The series also include PM runtime support.*
>>
>> Baseline: git://gitorious.org/khilman/linux-omap-pm.git
>> Branch: for_3.2/gpio-cleanup
>> Commit: 8323374
> Thanks Tony for ack'ing the patches.
> Kevin,
> Since Tony's has acked the patches, can you please pull them?

Before merging, I still need to review and test this version, and I
*might* still get to it this week.

Based on the dbclk aliases you added, I assume this has now been tested
on platforms using some GPIOs with debounce enabled?

Kevin
