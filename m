From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v2 0/4] ARM: OMAP2+: dmtimer: cleanup related to devm API
 and clk usage
Date: Thu, 5 Jul 2012 09:32:58 +0530
Message-ID: <CAC83ZvLcyRSc-X2o_05tS7R3S1s190ejDQaBOYHOK1JuknrAxA@mail.gmail.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
	<CAC83ZvLOoUwthcv0seXeqJcuvxvhP7P500T66RHCCWvrsaPr2A@mail.gmail.com>
	<CAMQu2gxDbi191EdA0_acaJwhuAddXJ44FzVQJ=5c1Fh0PFDG4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:39075 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750706Ab2GEEDA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 00:03:00 -0400
Received: by qadz32 with SMTP id z32so3424831qad.7
        for <linux-omap@vger.kernel.org>; Wed, 04 Jul 2012 21:02:59 -0700 (PDT)
In-Reply-To: <CAMQu2gxDbi191EdA0_acaJwhuAddXJ44FzVQJ=5c1Fh0PFDG4w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi Tony,

On Thu, Jun 14, 2012 at 4:28 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> Tony,
>
> On Thu, Jun 14, 2012 at 4:24 PM, DebBarma, Tarun Kanti
> <tarun.kanti@ti.com> wrote:
>> On Fri, Apr 20, 2012 at 6:09 PM, Tarun Kanti DebBarma
>> <tarun.kanti@ti.com> wrote:
>>> The devm API usage in probe() simplifies error handling operation.
>>> Since iclk is not used in the driver it is removed from wherever
>>> not needed.
>>> Corrected the timer fck name mis-match between clock44xx_data.c and
>>> omap_hwmod_44xx_data.c.
>>> Added omap_hwmod_get_main_clk() API. There is no more need to construct
>>> clock names using sprintf() to be used in clk_get() during initialization.
>>>
>>> Reference:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>>> Commit: e816b57a337ea3b755de72bec38c10c864f23015 (Linux 3.4-rc3)
>>>
>>> Series is available here for reference:
>>> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev dmtimer_cleanup_for_3.5
>>>
>>> Tested on following platforms:
>>> OMAP5, OMAP4430SDP, OMAP3430SDP, OMAP2430SDP.
>>> Could not test on OMAP2420 due to unavailability of board.
>>>
>>> v2:
>>> - Use devm_request_and_ioremap() instead of request_mem_region() and ioremap()
>>> - Add omap_hwmod_get_main_clk() API
>>> - Reverted changes of clock names from OMAP2 and OMAP3 platforms
>>>
>>> Cc: Cousson, Benoit <b-cousson@ti.com>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Kevin Hilman <khilman@ti.com>
>>> Cc: Rajendra Nayak <rnayak@ti.com>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> Tarun Kanti DebBarma (4):
>>>  ARM: OMAP: dmtimer: use devm_ API and do some cleanup in probe()
>>>  ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API
>>>  ARM: OMAP2+: dmtimer: cleanup iclk usage
>>>  ARM: OMAP2+: dmtimer: cleanup fclk usage
>> [ping]
>> Only one of the patches in the series (ARM: OMAP2+: dmtimer: cleanup iclk usage)
>> has been taken. I just applied the remaining patches on top of Linux 3.5-rc2 and
>> tested on OMAP3 and OMAP4. Can the remaining patches be taken as well?
>
> Just to let you know that this cleanup is essential for Benoit's OMAP4
> hwmod cleanup
> and OMAP5 minimal support series.
This is a gentle reminder in case you have missed somehow!!
Let me know if anything else needs to be done.
Thanks.
--
Tarun
