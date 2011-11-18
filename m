From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 17/20] OMAP2+: UART: Use custom activate func for console uart.
Date: Fri, 18 Nov 2011 13:24:38 -0800
Message-ID: <87vcqhuns9.fsf@ti.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
	<1321005712-21871-3-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:52256 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753070Ab1KRVYo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 16:24:44 -0500
In-Reply-To: <1321005712-21871-3-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 11 Nov 2011 15:31:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Omap-uart can be used as console uart to print early boot
> messages using earlyprintk so for console uart prevent
> hwmod reset or idling during bootup.
>
> Identify the console_uart set the id and use the custom
> pm_latency ops for console uart for the first time
> to idle console uart left enabled from bootup and then enable
> them back and reset pm_latency ops to default ops.
>
> Thanks to Kevin Hilman <khilman@ti.com> for suggesting
> this approach.

You're welcome, but Rajendra's solution is much better. ;)

Can you updated your branch without these custom hooks and using
Rajendra's INIT_NO_IDLE change to the hwmod core.

Kevin
