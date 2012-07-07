From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] Watchdog: OMAP: Fix the runtime pm code to avoid module getting stuck intransition state.
Date: Sat, 7 Jul 2012 14:27:25 +0200
Message-ID: <20120707122725.GY735@spo001.leaseweb.com>
References: <1339996996-3257-1-git-send-email-lokeshvutla@ti.com> <CAMQu2gwUgPewy98L+yF5bcdrqXRLZftb3utLNg5HV1jBscGpTQ@mail.gmail.com> <CAMQu2gy9pe-t9ik+v01Zz3oN6eRZ27+pxom+ECy4491Fvah=SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:54801 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750905Ab2GGM1a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Jul 2012 08:27:30 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gy9pe-t9ik+v01Zz3oN6eRZ27+pxom+ECy4491Fvah=SA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, linux-watchdog@vger.kernel.org

Hi All,

> > On Mon, Jun 18, 2012 at 10:53 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
> >> OMAP watchdong driver is adapted to runtime PM like a general device
> >> driver but it is not appropriate. It is causing couple of functional
> >> issues.
> >>
> >> 1. On OMAP4 SYSCLK can't be gated, because of issue with WDTIMER2 module,
> >> which constantly stays in "in transition" state. Value of register
> >> CM_WKUP_WDTIMER2_CLKCTRL is always 0x00010000 in this case.
> >> Issue occurs immediately after first idle, when hwmod framework tries
> >> to disable WDTIMER2 functional clock - "wd_timer2_fck". After this
> >> module falls to "in transition" state, and SYSCLK gating is blocked.
> >>
> >> 2. Due to runtime PM, watchdog timer may be completely disabled.
> >> In current code base watchdog timer is not disabled only because of
> >> issue 1. Otherwise state of WDTIMER2 module will be "Disabled", and there
> >> will be no interrupts from omap_wdt. In other words watchdog will not
> >> work at all.
> >>
> >> Watchdong is a special IP and it should not be disabled otherwise
> >> purpose of it itself is defeated. Watchdog functional clock should
> >> never be disabled. This patch updates the runtime PM handling in
> >> driver so that runtime PM is limited only during probe/shutdown
> >> and suspend/resume.
> >>
> >> The patch fixes issue 1 and 2
> >>
> >> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Cc: Wim Van Sebroeck <wim@iguana.be>
> >> ---
> 
> Any comments on this patch ? If not, can you please
> queue this up for the 3.5-rc?

Added to linux-watchdog-next.

Kind regards,
Wim.

