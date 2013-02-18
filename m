From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
Date: Mon, 18 Feb 2013 16:25:58 +0530
Message-ID: <512208BE.7060207@ti.com>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com> <5121FCC8.7090604@ti.com> <20130218101032.GA32688@arwen.pp.htv.fi> <20130218101113.GB32688@arwen.pp.htv.fi> <5122019D.9030100@ti.com> <20130218104216.GC32688@arwen.pp.htv.fi> <20130218104541.GD32688@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51701 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275Ab3BRKyp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 05:54:45 -0500
In-Reply-To: <20130218104541.GD32688@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Monday 18 February 2013 04:15 PM, Felipe Balbi wrote:
> On Mon, Feb 18, 2013 at 12:42:16PM +0200, Felipe Balbi wrote:
>> Hi,
>>
>> On Mon, Feb 18, 2013 at 03:55:33PM +0530, Santosh Shilimkar wrote:
>>>>> I wonder what are your ideas to sort that part out, I mean, how do you
>>>>> plan to implement ->set_wake() for the tty port ?"
>>>>
>>>> [1] http://marc.info/?l=linux-omap&m=136093334914275&w=2
>>>>
>>> The main need for uart wakeup is the io_ring() trigger and that needs
>>> to happen via generic pin control API. SYSC wakeup bit isn't something
>>> needs to be toggled so that can be decoupled. So again the idea is
>>> to make SYSC handling transparent to UART drivers and let driver toggle
>>> the io_ring() based on ->set_wake() as it is done today.
>>
>> We're either reading different code bases or not understanding each
>> other. Currently this is how ->set_wake() is implemented:
>>
>> serial_omap_set_wake()
>>   serial_omap_enable_wakeup()
>>    omap_uart_enable_wakeup()
>>     omap_hwmod_enable_wakeup()
>>      if (SYSC_HAS_ENAWAKEUP) {	/* true for UART */
>>       _enable_wakeup()
There is no need to toggle this one. It can be set once and left as is.
>>       _write_sysconfig()
>>      }
>>      set_idle_ioring_wakeup()
So this is the part, we need to hookup with pads.

>>       if (!oh->mux || !oh->mux->enabled)
>>        return;
>>
>> If I read the code correctly there's nothing setting oh->mux during DT
>> boot. The only caller to omap_hwmod_mux_init() (which allocates and
>> returns omap_hwmod_mux_info pointer) is
>> arch/arm/mach-omap2/devices.c::omap4_keyboard_init(). This has nothing
>
> actually arch/arm/mach-omap2/serial.c::omap_serial_init_port() also
> calls that, but it's also not used during DT boots.
>
DT boot, all the function pointers are broken so wakeup as well as slave
idle-mode is broken. Nothing new here. Serial file does set the pads
as you noticed and this is what can be offloaded to generic pint control
which can triggered from driver.

Regards,
Santosh




