From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: OMAP PM question
Date: Fri, 24 Jul 2009 10:19:35 +0300
Message-ID: <4A696087.2010203@nokia.com>
References: <1248373377.891.17.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53194 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbZGXHUV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 03:20:21 -0400
In-Reply-To: <1248373377.891.17.camel@blitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Peter Barada <peterb@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

ext Peter Barada wrote:
> Kevin,
> 
> I'm trying to port over the 2.6.30 OMAP PM branch on Logic's SOM, pulled
> from just a few days ago before the rebase to 2.6.31-rc1:
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=e0cffc298098263630b83c458b8fce754badb9a3
> 
> Unfortunately It doesn't go into retention due to MPU_CLK being defined
> as "virt_pcrm_set" where no virt_pcrm_set exists for OMAP3.  Once I
> changed MPU_CLK to "arm_fck" for OMAP3 as suggested by Rajendra in
> http://patchwork.kernel.org/patch/18626/  the board goes  into
> retention, but it won't resume on a serial RX event.  I wonder if
> Rajendra's change is correct.
> 
> 1) Which config did you use on the PM tree in the 2.6.30 timeframe so
> can start over from a known config/board description (that goes into
> retention and comes back out) instead of what I rolled from the rx51 for
> Logic's OMAP35x SOM.  Looking in arch/arm/configs, the only omap3 config
> that has CONFIG_PM=y is for the evm.  Is this the one?
> 
> 2) Is there anything special necessary to have a serial RX event force a
> wakeup?
> 
> 3) Do you have a wake-on-timer patch that works in this tree?
> 
> 4) I've noticed the board hangs after a while of inactivity on the
> serial power - I've tried cranking up the DEFAULT_TIMEOUT in
> arch/arm/mach-omap2/serial.c to (50 * HZ), and then disabling the
> timeout by "echo 0 > /sys/devices/platform/serial/8250.0/sleep_timeout",
> but the hang still happens after a period of inactivity - characters
> typed at ttyS0 don't get echoed back.  How do I enable wake on serial,
> or is it on by default?
> 

Hi Peter,

I was facing similar problems with RX51 boards. The following procedure resolved 
my problems.

1) use 2008q3 compiler (should work with 2009q1 also I guess, but I've not 
tested it)

2) Reset your tree to Kevin's PM branch. This should incorporate the latest fix
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=7e7377395d6b4576341a6939bf2179f3946f2ea0

3) use omap3_pm_defconfig, Then change the CONFIG_OMAP_LL_DEBUG_UART to suit 
your board's serial UART (1, 2 or 3) and also the CMDLINE to suit your board.

cheers,
-roger
