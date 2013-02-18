From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
Date: Mon, 18 Feb 2013 15:34:56 +0530
Message-ID: <5121FCC8.7090604@ti.com>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37302 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500Ab3BRKDw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 05:03:52 -0500
In-Reply-To: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, balbi@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Friday 15 February 2013 05:36 PM, Santosh Shilimkar wrote:
> OMAP UART IP needs manual idle modes based on state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.
>
> This however breaks in case of device tree because of missing
> idle handling.
>
> The series tries to address the issue
>
> Patches has been tested on OMAP4 and OMAP5 devices where the console
> slugishness was observed without idle mode handling. CPUIDLE and
> suspend tested ok on these devices.
>
> Need help in testing on OMAP2, OMAP3 and AM3XXX devices.
>
> Santosh Shilimkar (2):
>    ARM: OMAP2+: hwmod-data: UART IP needs software control of sidle
>      modes
>    SERIAL: OMAP: Remove the idle handling from the driver
>
HWMOD_SWSUP_SIDLE flag will is not what will help UART completely.
Also considering UART also needs async wakeup enabled as it implements
another such hook and attaches that through function pointer.

So some more work is needed to get that sorted out at least from
sysc point of view. That way we can deal with io_ring stuff using
pin control APIs.

Some patches will follow in attempt to address it. Stay tuned !!

Regards,
Santosh



