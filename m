From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 05/16] OMAP2+: UART: Cleanup part of clock gating mechanism for uart
Date: Mon, 10 Oct 2011 15:30:43 -0700
Message-ID: <87ty7gfpik.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-5-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46824 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752419Ab1JJWar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 18:30:47 -0400
In-Reply-To: <1317380495-584-5-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:31:31 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Currently we use a shared irq handler to identify uart activity and then
> trigger a timer. 

OK.

> Based the timeout value set from sysfs the timer used to expire.

Please re-phrase as I'm not sure what is being said here.

> If no uart-activity was detected timer-expiry func sets can_sleep
> flag. Based on this we will disable the uart clocks in idle path.
>
> Since the clock gating mechanism is outside the uart driver, we currently
> use this mechanism. In preparation to runtime implementation for omap-serial
> driver we can cleanup this mechanism and use runtime API's to gate uart clocks.
>
> Also remove timer related info from local uart_state struct and remove
> the code used to set timeout value from sysfs. Remove un-used function
> omap_uart_check_wakeup.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

The patch itself fine, and is a well-neede cleanup, but changelog
(especially the first part) does not read well.

Kevin
