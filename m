From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv6 2/3] OMAP: I2C: Remove the reset in the init path
Date: Fri, 26 Aug 2011 16:11:18 -0700
Message-ID: <87pqjrydih.fsf@ti.com>
References: <1312524035-5549-1-git-send-email-shubhrajyoti@ti.com>
	<1312524035-5549-2-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312524035-5549-2-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Fri, 5 Aug 2011 11:30:34 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> -  The reset in the driver at init is not needed anymore as the
>    hwmod framework takes care of reseting it.
> -  Reset is removed from omap_i2c_init, which was called
>    not only during probe, but also after time out and error handling.
>    device_reset were added in those places to effect the reset.
> -  Earlier the hwmod SYSC settings were over-written in the driver.
>    Removing the same and letting the hwmod take care of the settings.
> -  Clean up the SYSS_RESETDONE_MASK macro as it is no longer needed.
> -  Clean up the SYSCONFIG SYSC bit defination macros.
> -  Fix the typos in wakeup.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

I asked this in an earlier version, but here it is again.

Are you sure a full IP reset is needed on the timeout and error
conditions and not just the module-level one done by:

	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
        
        [ and later... ]

	/* Take the I2C module out of reset: */
	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);

I kind of suspect that the IP rese was done because the omap_i2c_init()
function was callled under the timeout/error conditions, but that a full
IP SW reset is a bit heavy handed.

Kevin
