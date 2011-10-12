From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 10/16] OMAP2+: UART: Modify omap_uart_can_sleep function
Date: Wed, 12 Oct 2011 12:41:09 -0700
Message-ID: <87wrcangkq.fsf@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<87vcrv2xox.fsf@ti.com>
	<CAAL8m4xTmz+-ureDiGPoKUu634q1Wy=h01kpfRWCk9LFCV0+Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:44557 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753095Ab1JLTlS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Oct 2011 15:41:18 -0400
In-Reply-To: <CAAL8m4xTmz+-ureDiGPoKUu634q1Wy=h01kpfRWCk9LFCV0+Dg@mail.gmail.com>
	(Govindraj's message of "Wed, 12 Oct 2011 19:08:51 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Govindraj <govindraj.ti@gmail.com> writes:

> On Tue, Oct 11, 2011 at 11:54 PM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> Modify the omap_uart_can_sleep function to check uart is active
>>> or not to be used by pm code to enter low power states.
>>
>> Doesn't the driver now control when the UART clocks are gated (using
>> runtime PM autosuspend)?
>>
>> IMO, this check should be completely removed and the driver should
>> be managing this with the autosuspend timeout.
>>
>>> Removing this check can cause console response little sluggish.
>>
>> Sluggish in what way?
>>
>
> response is slower like when we type something or cat debugfs/pm_count
> see things little slower on console, there is no character loss.
>
> Happens even though we have not set the autosuspend timeout and uart
> clocks are active, which basically means allowing mpu to enter
> retention keeping uart active.

OK, I see now.

> this delay in response or sluggishness is not there on my 3430SDP or
> 3630zoom board but I was able to see this behavior on a beagle
> board(xm rev c).

Here's why:

The difference is the powerdomain that the console UART is on for these
boards.  UART1,2 are in CORE, UART2/3 are in PER.   SDP uses UART1 (CORE),
Zoom3 doesn't use OMAP UARTs at all, and Beagle uses UART3 (PER).

Due to a HW sleepdep between MPU and CORE, MPU will not transition until
CORE does, which means MPU will not transition until UART 1 & 2 are
idle.

On Beagle, the console is ttyO2 (UART3) which is in PER, and since the
MPU is free to transition independently of PER, that is what is
happening, resulting in slower response time on for any boards that have
PER-UART consoles.

> retaining this uart_can_sleep check in omap3_can_sleep ensures a better
> console user experience. (not allowing mpu to enter retention
> until uart clocks are cut)

Yes, but obviously comes at the expense of power savings.  IOW, This is
a hard-coded power vs. performance trade off that we are trying to get
away from.

So, the root of the problem is that the MPU wakeup latency is causing a
"sluggish" console.  The solution?  request an MPU wakeup latency
constraint.

This is a classic use-case for such a constraint, and the serial driver
should have the option of requesting a constraint to prevent the sluggish
console.  The constraint only needs to be held until the auto-suspend
delay expires, so should be relased in the ->runtime_suspend() method of
the driver.

This constraint needs to be configurable, probably from the board file,
so that it is optional, and so users who don't care about sluggish
consoles (or non-console UART users who don't care about response time)
have the option of preferring power savings over UART responsiveness.

As a reference, the i2c driver is currently doing something similar 
in that it request an MPU constraint to prevent the MPU from going into
retention/off while waiting for an i2c interrupt to arrive.

Kevin
