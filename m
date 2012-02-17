From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
	for v3.4 merge window
Date: Fri, 17 Feb 2012 10:06:32 +0000
Message-ID: <20120217100632.GM15338@n2100.arm.linux.org.uk>
References: <20120215182355.18884.18682.stgit@kaulin.local> <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com> <20120216121234.GJ15338@n2100.arm.linux.org.uk> <4F3CF7D1.8050807@ti.com> <4F3D0186.2010500@ti.com> <20120216135151.GK15338@n2100.arm.linux.org.uk> <20120217091433.GL15338@n2100.arm.linux.org.uk> <4F3E1ED5.6090305@ti.com> <4F3E251B.6040404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41419 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab2BQKGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 05:06:42 -0500
Content-Disposition: inline
In-Reply-To: <4F3E251B.6040404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 17, 2012 at 03:29:55PM +0530, Rajendra Nayak wrote:
> hmm, rmmod does not even seem to trigger the drivers .remove if there
> are outstanding requests on the module, so a pdata->teardown called
> from within the .remove does not help to get the gpio_requests done
> from the board file cleaned.

If the module use count is non-zero, then it's only right that it won't
let you remove the module.  So as far as that goes, that's fine.

However, it's still possible to unbind the device:

	echo twl4030_gpio > /sys/bus/platform/driver/twl4030_gpio/unbind

and rebind it:

	echo twl4030_gpio > /sys/bus/platform/driver/twl4030_gpio/bind

assuming that the gpios device name is twl4030_gpio and not twl4030_gpio.0.
This would be equivalent to my steps (4) and (5).

As you point out, the there's no teardown function, which suggests that
the gpios won't be able to be requested at step (5).  You'll probably
also get a WARN_ON() dump too when the hsmmc device is registered for a
second time, or maybe an oops (as it'll be a device which has already
been registered being registered for a second time).
