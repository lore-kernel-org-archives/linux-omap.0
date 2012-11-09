From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP baseline test results for v3.7-rc4
Date: Fri, 09 Nov 2012 15:23:23 -0800
Message-ID: <87390iicno.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1211050241410.23228@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1211050241410.23228@utopia.booyaka.com> (Paul
 Walmsley's message of "Mon, 5 Nov 2012 02:46:51 +0000 (UTC)")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Venkatraman S <svenkatr@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

+Felipe, Venkat

Paul Walmsley <paul@pwsan.com> writes:

[...]

> Failing tests: needing investigation
> ------------------------------------
>

Here's another one for v3.7-rc4.

On all OMAP3 platforms I tested (3430/n900, 3530/Beagle, 3530/Overo,
3730/OveroSTORM, 3730/Beagle-xM), a system suspend (retention or off)
fails to wake up after a dynamic idle off-mode test (test script
below[1]).

I found that disabling MMC in the config made the tests pass again, so
then bisected it down to the commit below removing SYSCONFIG
accesses[2].  I haven't had the time to find out exactly the cause, but
clearly the code that was removed was doing something that hwmod is not
taking care of automatically.

Venkat, Felipe, could you please investigate this and hopefully get a
fix out for v3.7-rc?

Thanks,

Kevin


[1] Test for system suspend (retention) after off-idle

#!/bin/sh

echo 1 > /debug/pm_debug/enable_off_mode

echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
if [ -e /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms ]; then 
   echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
fi

sleep 5

echo -1 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
echo -1 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
echo -1 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
if [ -e /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms ]; then 
   echo -1 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
fi

echo 0 > /debug/pm_debug/enable_off_mode

rtcwake -m mem -s 1


[2]
commit 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c
Author: Venkatraman S <svenkatr@ti.com>
Date:   Wed Aug 8 14:26:52 2012 +0530

    mmc: omap_hsmmc: remove access to SYSCONFIG register
    
    SYSCONFIG register of HSMMC IP is managed by the omap hwmod
    abstraction layer. Resetting the IP and configuring the correct
    SYSCONFIG mode is centrally managed by hwmod.
    
    Remove code which manipulates IP reset and SYSCONFIG directly in
    the driver.
    
    Signed-off-by: Venkatraman S <svenkatr@ti.com>
    Acked-by: Felipe Balbi <balbi@ti.com>
    Signed-off-by: Chris Ball <cjb@laptop.org>
