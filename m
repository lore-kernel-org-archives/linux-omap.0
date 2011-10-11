From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 14/16] OMAP2+: UART: Take console_lock in suspend path if not taken
Date: Tue, 11 Oct 2011 12:01:17 -0700
Message-ID: <87sjmz1hfm.fsf@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<1317380561-661-5-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43615 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754940Ab1JKTB0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 15:01:26 -0400
In-Reply-To: <1317380561-661-5-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:32:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> In suspend path the console_lock is taken by uart_port_suspend
> however when no_console_suspend is used console_lock is not taken.
>
> During system wide suspend omap_pwr_domain hooks cut all
> clocks that are left enabled. So its unsafe to proceed printing after
> clocks are cut by pwr_domain hooks. 

As I've mentioned in previous reviews, when no_console_suspend is
enabled, the user has explicitly requested console output during
suspend.  In order to support that, we should not be cutting clocks at
all in that mode.

One way to address this would be to just disable runtime PM in the
->prepare method of the driver if no_console_suspend is enabled.

> Also pm_runtime will be disabled after dpm_suspend devices happens.

Not sure why this is relevant.

> So buffer all prints in suspend path by taking console_lock and print
> them back safely after power domain hooks re-enable clocks back.
>
> Use CONFIG_SERIAL_OMAP_CONSOLE macro check to take console_lock since
> console ops are available only if omap console is defined.
> omap-serial can be built as module without console support.

Please revisit use of #ifdefs.  (c.f. #ifdefs are ugly in
Documentation/SubmittingPatches)

Kevin
