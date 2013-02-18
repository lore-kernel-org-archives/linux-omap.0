From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
Date: Mon, 18 Feb 2013 20:06:40 +0530
Message-ID: <51223C78.1050303@ti.com>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com> <5121FCC8.7090604@ti.com> <20130218101032.GA32688@arwen.pp.htv.fi> <20130218101113.GB32688@arwen.pp.htv.fi> <5122019D.9030100@ti.com> <20130218104216.GC32688@arwen.pp.htv.fi> <20130218104541.GD32688@arwen.pp.htv.fi> <512208BE.7060207@ti.com> <20130218111308.GE32688@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50616 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab3BROfv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 09:35:51 -0500
In-Reply-To: <20130218111308.GE32688@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Monday 18 February 2013 04:43 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Feb 18, 2013 at 04:25:58PM +0530, Santosh Shilimkar wrote:
>>>> If I read the code correctly there's nothing setting oh->mux during DT
>>>> boot. The only caller to omap_hwmod_mux_init() (which allocates and
>>>> returns omap_hwmod_mux_info pointer) is
>>>> arch/arm/mach-omap2/devices.c::omap4_keyboard_init(). This has nothing
>>>
>>> actually arch/arm/mach-omap2/serial.c::omap_serial_init_port() also
>>> calls that, but it's also not used during DT boots.
>>>
>> DT boot, all the function pointers are broken so wakeup as well as slave
>> idle-mode is broken. Nothing new here. Serial file does set the pads
>> as you noticed and this is what can be offloaded to generic pint control
>> which can triggered from driver.
>
> fair enough, understood now.
>
Just keep the thread posted, the slave idle handling with *wakeup*
bit is sorted out now. We are looking at the io_ring() and
pad wakeup stuff now. Once we have that working, we will repost
the series.

Regards,
Santosh

