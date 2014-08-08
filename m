From: Fabio Estevam <festevam@gmail.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Thu, 7 Aug 2014 23:29:20 -0300
Message-ID: <CAOMZO5BmzaqVyHEJ0sqja8RgF2i_=FStSToJLwiX6NtTktNvCw@mail.gmail.com>
References: <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
	<20140729084930.GH29045@atomide.com>
	<alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
	<alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com>
	<20140729145312.GT29045@atomide.com>
	<alpine.DEB.2.02.1407291922370.13035@utopia.booyaka.com>
	<20140730053940.GX29045@atomide.com>
	<alpine.DEB.2.02.1407300725290.4477@utopia.booyaka.com>
	<20140731131107.GB29045@atomide.com>
	<alpine.DEB.2.02.1407311922350.1845@utopia.booyaka.com>
	<20140801071056.GD29045@atomide.com>
	<alpine.DEB.2.02.1408072210300.5770@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:44085 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238AbaHHC3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2014 22:29:22 -0400
Received: by mail-la0-f48.google.com with SMTP id gl10so4091362lab.21
        for <linux-omap@vger.kernel.org>; Thu, 07 Aug 2014 19:29:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1408072210300.5770@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel-build-reports@lists.linaro.org

On Thu, Aug 7, 2014 at 7:21 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> It's commit a71e3c37960ce5f9c6a519bc1215e3ba9fa83e75:
>
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Wed Jul 23 16:47:31 2014 -0300
>
>     net: phy: Set the driver when registering an MDIO bus device
>
>     mdiobus_register() registers a device which is already bound to a driver.
>     Hence, the driver pointer should be set properly in order to track down
>     the driver associated to the MDIO bus.
>
>     This will be used to allow ethernet driver to pin down a MDIO bus driver,
>     preventing it from being unloaded while the PHY device is running.
>
>     Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>     Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>     Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>
>
> What's bad is that this went in late during v3.16-rc fixes.  So now v3.16
> itself is broken, and there's no way to fix it.

I have sent a patch reverting this commit and it is in mainline now.
It will reach 3.16.1:

commit ce7991e8198b80eb6b4441b6f6114bea4a665d66
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Tue Aug 5 08:13:42 2014 -0300

    Revert "net: phy: Set the driver when registering an MDIO bus device"

    Commit a71e3c37960ce5f9 ("net: phy: Set the driver when
registering an MDIO bus
    device") caused the following regression on the fec driver:

    root@imx6qsabresd:~# echo mem > /sys/power/state
    PM: Syncing filesystems ... done.
    Freezing user space processes ... (elapsed 0.003 seconds) done.
    Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
    Unable to handle kernel NULL pointer dereference at virtual address 0000002c
    pgd = bcd14000
    [0000002c] *pgd=4d9e0831, *pte=00000000, *ppte=00000000
    Internal error: Oops: 17 [#1] SMP ARM
    Modules linked in:
    CPU: 0 PID: 617 Comm: sh Not tainted 3.16.0 #17
    task: bc0c4e00 ti: bceb6000 task.ti: bceb6000
    PC is at fec_suspend+0x10/0x70
    LR is at dpm_run_callback.isra.7+0x34/0x6c
    pc : [<803f8a98>]    lr : [<80361f44>]    psr: 600f0013
    sp : bceb7d70  ip : bceb7d88  fp : bceb7d84
    r10: 8091523c  r9 : 00000000  r8 : bd88f478
    r7 : 803f8a88  r6 : 81165988  r5 : 00000000  r4 : 00000000
    r3 : 00000000  r2 : 00000000  r1 : bd88f478  r0 : bd88f478
    Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
    Control: 10c5387d  Table: 4cd1404a  DAC: 00000015
    Process sh (pid: 617, stack limit = 0xbceb6240)
    Stack: (0xbceb7d70 to 0xbceb8000)
    ....

    The problem with the original commit is explained by Russell King:

    "It has the effect (as can be seen from the oops) of attaching the MDIO bus
    device (itself is a bus-less device) to the platform driver, which means
    that if the platform driver supports power management, it will be called
    to power manage the MDIO bus device.

    Moreover, drivers do not expect to be called for power management
    operations for devices which they haven't probed, and certainly not for
    devices which aren't part of the same bus that the driver is registered
    against."

    This reverts commit a71e3c37960ce5f9c6a519bc1215e3ba9fa83e75.

    Cc: <stable@vger.kernel.org> #3.16
    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
