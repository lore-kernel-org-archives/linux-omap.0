From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 05/15] tty: serial: Add 8250-core based omap driver
Date: Thu, 21 Aug 2014 13:00:59 +0200
Message-ID: <53F5D16B.4030007@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de> <1408124563-31541-6-git-send-email-bigeasy@linutronix.de> <20140815210716.GE9239@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57193 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371AbaHULB1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2014 07:01:27 -0400
In-Reply-To: <20140815210716.GE9239@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>

On 08/15/2014 11:07 PM, Tony Lindgren wrote:
> Nice, now it mostly works for me with off-idle too :) That is as long
> as I have the DMA channels commented out in the .dts file.
>=20
> And I'm still seeing an occasional hang with pstore console just
> showing:
>=20
> [  289.076538] In-band Error seen by MPU  at address 0
> [  289.076538] ------------[ cut here ]------------
> [  289.076568] WARNING: CPU: 0 PID: 99 at drivers/bus/omap_l3_smx.c:1=
62 omap3_l3_app_irq+0xdc/0x134()
> [  289.076599] Modules linked in:
> [  289.076599] CPU: 0 PID: 99 Comm: test-idle-off-8 Tainted: G       =
 W      3.16.0+ #510
> [  289.076629] [<c0016c44>] (unwind_backtrace) from [<c00129c8>] (sho=
w_stack+0x20/0x24)
> [  289.076660] [<c00129c8>] (show_stack) from [<c0714cd4>] (dump_stac=
k+0x88/0xa4)

Okay. So this backtrace does not show more like from where the access
is happening?

> Which most likely means there's still some glitch with the
> runtime PM somewhere and registers are being accessed when
> not clocked. I _think_ I did not see it when I did not have
> console=3DttyS2,115200 in my cmdline but was using just pstore
> console.
>=20
>> The device name is ttyS based instead of ttyO. If a ttyO based node =
name
>> is required please ask udev for it. If both driver are activated (th=
is
>> and omap-serial) then this serial driver will take control over the
>> device due to the link order
>=20
> That's still not going to help with the existing kernel cmdlines
> and existing installs.. I wonder if we can just do a minimal
> dummy serial-omap.c that just proxies all the ttyO read/write
> access to ttyS?

Hmm. So you are not a friend of the udev solution?. For now the driver
is "default n" and you have to explicit enable it and _then_ you should
be able to update your command line, etc.
If I introduce a kernel proxy for compatibility I assume that people
will wake up once that compatibility piece is gone.

However, if you insist=85 I tried to make a symlink but nobody does thi=
s
in kernel. The "rtc -> rtc0" and friends seem to come from udev _or_
distro. So I sff could a second device node with the same major/minor.
That would work for userland but not for the kernel console=85 So we ne=
ed
a proxy-console for this.

Before I spent time on this proxy-console I would like to hear from Gre=
g
that he is okay with this.

>=20
> Regards,
>=20
> Tony

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
