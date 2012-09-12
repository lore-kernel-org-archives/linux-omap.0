From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Wed, 12 Sep 2012 15:27:22 -0700
Message-ID: <874nn2vpv9.fsf@deeprootsystems.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347447496-16793-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Wed, 12 Sep 2012 16:27:54 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

[...]

>
> This is the cleanup only series.
>   
> Tested on omap4sdp and 3430sdp.

It would be extremely helpful if you would describe how this was tested.
And for me, it would be a source of extreme joy if you described any PM
testing.

I gave this some additional PM testing on 3430/n900, 3530/Overo,
3730/OveroSTORM, 3730/Beagle-xM and 4430/Panda.

I tested v3.6-rc5 which passed all PM tests and then added this series
(by merging the i2c-embedded/i2c-next branch.)  PM tests then fail.

At least on 3530/Overo and 3730/Overo, CORE no longer hits retenion (or
off) during idle.  

The easy way to notice this is to see that even when no i2c transactions
are happening, the runtime PM status for omap_i2c.1 is remains 'active':

# cat omap_i2c.*/power/runtime_status 
active
suspended

Of course that means that clocks are never gated during idle, and CORE
will never hit retention.

I noticed it because my PM tests detected that the CORE powerdomain was
not transitioning to retention (or off) during idle.

To reproduce, simply enable UART timeouts so CORE will hit retention:

echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms

and check the core_pwrm state counters:

cat /debug/pm_debug/count

wait > 3 seconds for the UART autosuspend timers to kick in.  At this
point, CORE should be transitioning to retenion in idle (determined by
noticing that the RET counter for core_pwrdm is increasing.)

With $SUBJECT series applied, you'll notice that CORE is not
transitioning.

Kevin

> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
>
>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
>
> are available in the git repository at:
>   git://gitorious.org/linus-tree/linus-tree.git for_3.7/i2c/big_cleanups
>
>
> Felipe Balbi (22):
>   i2c: omap: switch to devm_* API
>   i2c: omap: simplify num_bytes handling
>   i2c: omap: decrease indentation level on data handling
>   i2c: omap: add blank lines
>   i2c: omap: simplify omap_i2c_ack_stat()
>   i2c: omap: split out [XR]DR and [XR]RDY
>   i2c: omap: improve i462 errata handling
>   i2c: omap: re-factor receive/transmit data loop
>   i2c: omap: switch over to do {} while loop
>   i2c: omap: ack IRQ in parts
>   i2c: omap: switch to platform_get_irq()
>   i2c: omap: bus: add a receiver flag
>   i2c: omap: simplify errata check
>   i2c: omap: always return IRQ_HANDLED
>   i2c: omap: simplify IRQ exit path
>   i2c: omap: resize fifos before each message
>   i2c: omap: get rid of the "complete" label
>   i2c: omap: always return IRQ_HANDLED
>   i2c: omap: switch to threaded IRQ support
>   i2c: omap: remove unnecessary pm_runtime_suspended check
>   i2c: omap: switch over to autosuspend API
>   i2c: omap: sanitize exit path
>
> Shubhrajyoti D (1):
>   i2c: omap: remove redundant status read
>
>  drivers/i2c/busses/i2c-omap.c |  442 +++++++++++++++++++++++++----------------
>  1 files changed, 271 insertions(+), 171 deletions(-)
