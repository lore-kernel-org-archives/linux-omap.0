From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/13 v2] OMAP: Serial: Add omap-serial driver with  platform support
Date: Wed, 22 Sep 2010 13:14:58 -0700
Message-ID: <87k4mda62l.fsf@deeprootsystems.com>
References: <37596.172.24.137.131.1285168390.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <37596.172.24.137.131.1285168390.squirrel@dbdmail.itg.ti.com>
	(Govindraj R.'s message of "Wed, 22 Sep 2010 20:43:10 +0530 (IST)")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> This patch series adds a serial driver to handle uarts on omap platforms.
> Currenlty omap-uarts are handled with 8250 driver, since updating
> this driver with omap specific features will over load
> the 8250 driver with all omap-specific data thus a new driver
> is added to configure and support features like
> dma, h/w, s/w flowcontrol for omap-uarts.
> Also the patch series updates various low level platform specific
> serial data to support omap-uarts with hwmod framework and adds support
> for uart4 on OMAP3630.
>
> v1 to v2 changes:
> ----------------
> 1) Incorporate timeout check
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35106.html
> 2) Add wk_st, padconf etc for uart4
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35105.html

3) All UARTs initialized for Zoom2/3

Also, please report platforms this was tested on, and what was tested.
You need to validate retention and off-mode during idle and suspend, as
well as enabling/disabling the UART sleep_timeout values via sysfs.

Thanks,

Kevin

