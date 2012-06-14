From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 0/4] ARM: OMAP2+: dmtimer: cleanup related to devm API
 and clk usage
Date: Thu, 14 Jun 2012 16:28:00 +0530
Message-ID: <CAMQu2gxDbi191EdA0_acaJwhuAddXJ44FzVQJ=5c1Fh0PFDG4w@mail.gmail.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com> <CAC83ZvLOoUwthcv0seXeqJcuvxvhP7P500T66RHCCWvrsaPr2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:51388 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753334Ab2FNK6X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 06:58:23 -0400
Received: by qadb33 with SMTP id b33so4475387qad.9
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 03:58:21 -0700 (PDT)
In-Reply-To: <CAC83ZvLOoUwthcv0seXeqJcuvxvhP7P500T66RHCCWvrsaPr2A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

Tony,

On Thu, Jun 14, 2012 at 4:24 PM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Fri, Apr 20, 2012 at 6:09 PM, Tarun Kanti DebBarma
> <tarun.kanti@ti.com> wrote:
>> The devm API usage in probe() simplifies error handling operation.
>> Since iclk is not used in the driver it is removed from wherever
>> not needed.
>> Corrected the timer fck name mis-match between clock44xx_data.c and
>> omap_hwmod_44xx_data.c.
>> Added omap_hwmod_get_main_clk() API. There is no more need to constr=
uct
>> clock names using sprintf() to be used in clk_get() during initializ=
ation.
>>
>> Reference:
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> Commit: e816b57a337ea3b755de72bec38c10c864f23015 (Linux 3.4-rc3)
>>
>> Series is available here for reference:
>> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux=
-omap-dev dmtimer_cleanup_for_3.5
>>
>> Tested on following platforms:
>> OMAP5, OMAP4430SDP, OMAP3430SDP, OMAP2430SDP.
>> Could not test on OMAP2420 due to unavailability of board.
>>
>> v2:
>> - Use devm_request_and_ioremap() instead of request_mem_region() and=
 ioremap()
>> - Add omap_hwmod_get_main_clk() API
>> - Reverted changes of clock names from OMAP2 and OMAP3 platforms
>>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> Tarun Kanti DebBarma (4):
>> =A0ARM: OMAP: dmtimer: use devm_ API and do some cleanup in probe()
>> =A0ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API
>> =A0ARM: OMAP2+: dmtimer: cleanup iclk usage
>> =A0ARM: OMAP2+: dmtimer: cleanup fclk usage
> [ping]
> Only one of the patches in the series (ARM: OMAP2+: dmtimer: cleanup =
iclk usage)
> has been taken. I just applied the remaining patches on top of Linux =
3.5-rc2 and
> tested on OMAP3 and OMAP4. Can the remaining patches be taken as well=
?

Just to let you know that this cleanup is essential for Benoit's OMAP4
hwmod cleanup
and OMAP5 minimal support series.

Regards
santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
