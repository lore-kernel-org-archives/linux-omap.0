From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v2 0/4] ARM: OMAP2+: dmtimer: cleanup related to devm API
 and clk usage
Date: Thu, 14 Jun 2012 16:24:39 +0530
Message-ID: <CAC83ZvLOoUwthcv0seXeqJcuvxvhP7P500T66RHCCWvrsaPr2A@mail.gmail.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:46148 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755514Ab2FNKyl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 06:54:41 -0400
Received: by qcsg15 with SMTP id g15so1290079qcs.27
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 03:54:39 -0700 (PDT)
In-Reply-To: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Fri, Apr 20, 2012 at 6:09 PM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> The devm API usage in probe() simplifies error handling operation.
> Since iclk is not used in the driver it is removed from wherever
> not needed.
> Corrected the timer fck name mis-match between clock44xx_data.c and
> omap_hwmod_44xx_data.c.
> Added omap_hwmod_get_main_clk() API. There is no more need to constru=
ct
> clock names using sprintf() to be used in clk_get() during initializa=
tion.
>
> Reference:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Commit: e816b57a337ea3b755de72bec38c10c864f23015 (Linux 3.4-rc3)
>
> Series is available here for reference:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-=
omap-dev dmtimer_cleanup_for_3.5
>
> Tested on following platforms:
> OMAP5, OMAP4430SDP, OMAP3430SDP, OMAP2430SDP.
> Could not test on OMAP2420 due to unavailability of board.
>
> v2:
> - Use devm_request_and_ioremap() instead of request_mem_region() and =
ioremap()
> - Add omap_hwmod_get_main_clk() API
> - Reverted changes of clock names from OMAP2 and OMAP3 platforms
>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Tarun Kanti DebBarma (4):
> =A0ARM: OMAP: dmtimer: use devm_ API and do some cleanup in probe()
> =A0ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API
> =A0ARM: OMAP2+: dmtimer: cleanup iclk usage
> =A0ARM: OMAP2+: dmtimer: cleanup fclk usage
[ping]
Only one of the patches in the series (ARM: OMAP2+: dmtimer: cleanup ic=
lk usage)
has been taken. I just applied the remaining patches on top of Linux 3.=
5-rc2 and
tested on OMAP3 and OMAP4. Can the remaining patches be taken as well?
--
Tarun
>
> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0 =A0 | =A0 33 ++++=
++-----------
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 15 =
++++++++
> =A0arch/arm/mach-omap2/timer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 10 +-----
> =A0arch/arm/plat-omap/dmtimer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 51 ++++++++------------------
> =A0arch/arm/plat-omap/include/plat/dmtimer.h =A0 =A0| =A0 =A02 +-
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A02 +
> =A06 files changed, 46 insertions(+), 67 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
