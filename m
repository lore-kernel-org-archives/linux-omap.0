From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/8] gpio/omap: remaining cleanups and fix
Date: Fri, 27 Apr 2012 16:05:49 -0600
Message-ID: <CACxGe6tq8t97w_e+YiNvZZG4fh7_3t5sFYR5GY791DGQo=TrNQ@mail.gmail.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
 <20120427190759.C6DC43E0B4D@localhost> <87ipgkzvlk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35234 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755695Ab2D0WGK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 18:06:10 -0400
Received: by obbta14 with SMTP id ta14so1604960obb.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 15:06:09 -0700 (PDT)
In-Reply-To: <87ipgkzvlk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, Apr 27, 2012 at 3:57 PM, Kevin Hilman <khilman@ti.com> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>
>> On Fri, 27 Apr 2012 19:43:30 +0530, Tarun Kanti DebBarma <tarun.kant=
i@ti.com> wrote:
>>> Here are the remaining cleanup patches. There are broadly
>>> two categories of cleanups.
>>>
>>> Cat-1: Those missed while introducing new feature like SPARSE_IRQ
>>> =A0 =A0 =A0 =A0handling and DT support; use edge/level handlers fro=
m
>>> =A0 =A0 =A0 =A0generic IRQ framework.
>>>
>>> Cat-2: Removal of redundant fields from struct gpio_bank{} as a
>>> =A0 =A0 =A0 =A0result of they being already covered by members with=
in
>>> =A0 =A0 =A0 =A0context field of struct gpio_bank{}.
>>>
>>> Reference: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux-2.6.git
>>> Commit: 66f75a5d028beaf67c931435fdc3e7823125730c (Linux 3.4-rc4)
>>>
>>> Series is available for reference here:
>>> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linu=
x-omap-dev.git for_3.5/gpio_more_cleanup_fixes
>>>
>>> Test info:
>>> OMAP2+ platforms: OMAP2430SDP, OMAP3430SDP, OMAP4430SDP
>>> OMAP1: Bootup test on OMAP1710SDP.
>>>
>>> Cc: Kevin Hilman <khilman@ti.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Cc: Cousson, Benoit <b-cousson@ti.com>
>>> Cc: Grant Likely <grant.likely@secretlab.ca>
>>> Tarun Kanti DebBarma (8):
>>> =A0 gpio/omap: remove virtual_irq_start variable
>>> =A0 gpio/omap: remove saved_fallingdetect, saved_risingdetect
>>> =A0 gpio/omap: remove suspend_wakeup field from struct gpio_bank
>>> =A0 gpio/omap: remove saved_wakeup field from struct gpio_bank
>>> =A0 gpio/omap: remove retrigger variable in gpio_irq_handler
>>> =A0 gpio/omap: remove suspend/resume callbacks
>>> =A0 gpio/omap: remove cpu_is_omapxxxx() checks from *_runtime_resum=
e()
>>> =A0 gpio/omap: fix missing check in *_runtime_suspend()
>>
>> The changes look fine to me. =A0Which branch should this series be
>> merged through? =A0It can either go via arm-soc or my gpio/next bran=
ch.
>
> This needs a little more review/testing on OMAP.
>
> Expect a pull request from me when it's ready and you can take it
> through gpio/nex.

Okay.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
