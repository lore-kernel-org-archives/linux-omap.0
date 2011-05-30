From: Tony Lindgren <tony@atomide.com>
Subject: Re: boot hang using OMAP for-next + Russell's for-linus
Date: Mon, 30 May 2011 01:05:33 -0700
Message-ID: <20110530080533.GF11352@atomide.com>
References: <87d3j3x28x.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40397 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754820Ab1E3IFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 04:05:36 -0400
Content-Disposition: inline
In-Reply-To: <87d3j3x28x.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

* Kevin Hilman <khilman@ti.com> [110527 14:24]:
> FYI... I just found this, but won't be able to look into it until next
> week, so if anyone needs a weekend debug project...
> 
> Using Tony's for-next branch, I'm able to boot an omap2plus_defconfig (+
> busybox initramfs) kernel on my 3430/n900 just fine.   I then tried to
> merge in Russell's for-linus branch and it hangs during boot.
> 
> It appears to hang in the init/registration of i2c busses.  Commenting
> out the i2c bus registration from board-rx51-peripherals and disabling a
> few of the users of i2c, I was able to boot.

Looks like at least v3.0-rc1 boots just fine, so whatever that was
has been already fixed.

Regards,

Tony
