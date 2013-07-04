From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Thu, 04 Jul 2013 16:14:14 +0100
Message-ID: <51D59146.3070002@newflow.co.uk>
References: <51D577E6.5010507@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:50433 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752610Ab3GDPOP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jul 2013 11:14:15 -0400
In-Reply-To: <51D577E6.5010507@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 04/07/13 14:25, Mark Jackson wrote:
> Our custom AM335x board has been booting just fine under 3.10.0-rc4.
> 
> I've just done a git pull to update to 3.10 (now that it's released)
> and the board now hangs.
> 
> Before I start trying to bisect the issue, does anyone have an clues ?

Okay ... I've now bisected it to:-

a630fbfbb1beeffc5bbe542a7986bf2068874633 is the first bad commit
commit a630fbfbb1beeffc5bbe542a7986bf2068874633
Author: Tony Lindgren <tony@atomide.com>
Date:   Mon Jun 10 07:39:09 2013 -0700

    serial: omap: Fix device tree based PM runtime
    
    In the runtime_suspend function pdata is not being used, and
    also blocks the function in device tree based booting. Fix it
    by removing the unused pdata from the runtime_suspend function.
    
    Further, context loss count is not being passed in pdata, so
    let's just reinitialize the port every time for those case.
    This can be further optimized later on for the device tree
    case by adding detection for the hardware state and possibly
    by adding a driver specific autosuspend timeout.
    
    And doing this, we can then make the related dev_err into a
    dev_dbg message instead of an error.
    
    In order for the wake-up events to work, we also need to set
    autosuspend_timeout to -1 if 0, and also device_init_wakeup()
    as that's not being done by the platform init code for the
    device tree case.
    
    Note that this does not affect legacy booting, and in fact
    might make it work for the cases where the context loss info
    is not being passed in pdata.
    
    Thanks to Kevin Hilman <khilman@linaro.org> for debugging
    and suggesting fixes for the autosuspend_timeout and
    device_init_wakeup() related initializiation.
    
    Reviewed-by: Kevin Hilman <khilman@linaro.org>
    Tested-by: Kevin Hilman <khilman@linaro.org>
    Signed-off-by: Tony Lindgren <tony@atomide.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:040000 040000 38900a5a2ed6dfeb812d93bf1918725021298884 a38d37777dcd46276dc27b87157fd0b1e292804c M	drivers


