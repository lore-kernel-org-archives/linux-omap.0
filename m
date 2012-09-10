From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP5: Enable arch timer support
Date: Mon, 10 Sep 2012 17:15:10 +0530
Message-ID: <CAMQu2gyVJ_j2faFChyw-v53qz2YXyia8SWKG8hcRc+vLr3z+cQ@mail.gmail.com>
References: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com> <1344856045-15134-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48493 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756867Ab2IJLpc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 07:45:32 -0400
Received: by yhoo21 with SMTP id o21so2910616yho.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 04:45:31 -0700 (PDT)
In-Reply-To: <1344856045-15134-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-arm-kernel@lists.infradead.orig, tony@atomide.com, linux-omap@vger.kernel.org

Benoit,

On Mon, Aug 13, 2012 at 4:37 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Enable Cortex A15 generic timer support for OMAP5 based SOCs.
> The CPU local timers run on the free running real time counter clock.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi |    6 ++++++
>  arch/arm/mach-omap2/Kconfig  |    1 +
>  arch/arm/mach-omap2/timer.c  |    7 +++++++
>  3 files changed, 14 insertions(+)
>
Missed to copy you on this patch. Your comments/ack
on the DT part.

Regards
Santosh
