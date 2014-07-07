From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Mon, 7 Jul 2014 01:02:39 -0700
Message-ID: <20140707080238.GF28884@atomide.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24603 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750855AbaGGICi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 04:02:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

* Paul Walmsley <paul@pwsan.com> [140706 16:43]:
> 
> Here are some basic OMAP test results for Linux v3.16-rc4.
> Logs and other details at:
...
 
> PM: chip retention via dynamic idle:
>     FAIL ( 7/ 7): 2430sdp, 3530es3beagle, 3730beaglexm, 37xxevm,
> 		  4430es2panda, 4460pandaes, 4460varsomom
> 
> PM: chip off except CORE via suspend:
>     FAIL ( 1/ 1): 3730beaglexm
> 
> PM: chip off except CORE via dynamic idle:
>     FAIL ( 1/ 1): 3730beaglexm
> 
> PM: chip off via suspend:
>     FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
> 		  4460varsomom
> 
> PM: chip off via dynamic idle:
>     FAIL ( 5/ 5): 3530es3beagle, 37xxevm, 4430es2panda, 4460pandaes,
> 		  4460varsomom

With v3.16-rc4 the PM features for omap3 should be working
finally for device tree based booting. At lest beaglexm and
3xxevm should work.

Maybe you are using legacy booting path to idle the UARTs still?

FYI, I'm doing this to find the UART entries:

uarts=$(find /sys/class/tty/ttyO*/device/power/ -type d)
for uart in $uarts; do
        echo 3000 > $uart/autosuspend_delay_ms
done

uarts=$(find /sys/class/tty/ttyO*/power/ -type d)
for uart in $uarts; do
        echo enabled > $uart/wakeup
        echo auto > $uart/control
done

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode

Regards,

Tony
