From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Thu, 13 Sep 2012 11:34:48 +0530
Message-ID: <50517780.2080002@ti.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com> <874nn2vpv9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874nn2vpv9.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 13 September 2012 03:57 AM, Kevin Hilman wrote:
> Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
>
> [...]
>
>> This is the cleanup only series.
>>   
>> Tested on omap4sdp and 3430sdp.
> It would be extremely helpful if you would describe how this was tested.
> And for me, it would be a source of extreme joy if you described any PM
> testing.
>
> I gave this some additional PM testing on 3430/n900, 3530/Overo,
> 3730/OveroSTORM, 3730/Beagle-xM and 4430/Panda.
>
> I tested v3.6-rc5 which passed all PM tests and then added this series
> (by merging the i2c-embedded/i2c-next branch.)  PM tests then fail.
>
> At least on 3530/Overo and 3730/Overo, CORE no longer hits retenion (or
> off) during idle.  
>
> The easy way to notice this is to see that even when no i2c transactions
> are happening, the runtime PM status for omap_i2c.1 is remains 'active':
>
> # cat omap_i2c.*/power/runtime_status 
> active
> suspended
>
> Of course that means that clocks are never gated during idle, and CORE
> will never hit retention.
>
> I noticed it because my PM tests detected that the CORE powerdomain was
> not transitioning to retention (or off) during idle.
>
> To reproduce, simply enable UART timeouts so CORE will hit retention:
>
> echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
> echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
>
> and check the core_pwrm state counters:
>
> cat /debug/pm_debug/count
>
> wait > 3 seconds for the UART autosuspend timers to kick in.  At this
> point, CORE should be transitioning to retenion in idle (determined by
> noticing that the RET counter for core_pwrdm is increasing.)
>
> With $SUBJECT series applied, you'll notice that CORE is not
> transitioning.
However I do not see the issue,let me know if I missed something see below.

On my 3430sdp

/sys/bus/platform/devices # cat omap_i2c.*/power/runtime_status
suspended
suspended
suspended
/sys/bus/platform/devices #
/sys/bus/platform/devices # cat omap_i2c.*/power/autosuspend_delay_ms
1000
1000
1000
/sys/bus/platform/devices # echo 3000 >
/sys/devices/platform/omap_uart.0/power/
autosuspend_delay_ms
/sys/bus/platform/devices # echo 3000 >
/sys/devices/platform/omap_uart.1/power/
autosuspend_delay_ms
/sys/bus/platform/devices # echo 3000 >
/sys/devices/platform/omap_uart.2/power/
autosuspend_delay_ms
/sys/bus/platform/devices #
/sys/bus/platform/devices # cat /debug/pm_debug/count
usbhost_pwrdm
(ON),OFF:0,RET:1373,INA:0,ON:1374,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm
(ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:79,INA:0,ON:80,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm
(ON),OFF:0,RET:1373,INA:0,ON:1374,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:1373,INA:0,ON:1374,RET-LOGIC-OFF:0
mpu_pwrdm
(ON),OFF:0,RET:1373,INA:0,ON:1374,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm
(RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RE0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (13)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (23)
core_l3_clkdm->core_pwrdm (4)
neon_clkdm->neon_pwrdm (0)
/sys/bus/platform/devices #
/sys/bus/platform/devices #
/sys/bus/platform/devices # sleep 5
/sys/bus/platform/devices # cat /debug/pm_debug/count
usbhost_pwrdm
(ON),OFF:0,RET:1512,INA:0,ON:1513,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm
(ON),OFF:0,RET:12,INA:0,ON:13,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:218,INA:0,ON:219,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm
(ON),OFF:0,RET:1512,INA:0,ON:1513,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:1512,INA:0,ON:1513,RET-LOGIC-OFF:0
mpu_pwrdm
(ON),OFF:0,RET:1512,INA:0,ON:1513,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm
(RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RE0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (13)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (23)
core_l3_clkdm->core_pwrdm (4)
neon_clkdm->neon_pwrdm (0)
/sys/bus/platform/devices # cat omap_i2c.*/power/runtime_status
suspended
suspended
suspended
/sys/bus/platform/devices #


>
> Kevin
>
>> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
>>
>>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
>>
>> are available in the git repository at:
>>   git://gitorious.org/linus-tree/linus-tree.git for_3.7/i2c/big_cleanups
>>
>>
>> Felipe Balbi (22):
>>   i2c: omap: switch to devm_* API
>>   i2c: omap: simplify num_bytes handling
>>   i2c: omap: decrease indentation level on data handling
>>   i2c: omap: add blank lines
>>   i2c: omap: simplify omap_i2c_ack_stat()
>>   i2c: omap: split out [XR]DR and [XR]RDY
>>   i2c: omap: improve i462 errata handling
>>   i2c: omap: re-factor receive/transmit data loop
>>   i2c: omap: switch over to do {} while loop
>>   i2c: omap: ack IRQ in parts
>>   i2c: omap: switch to platform_get_irq()
>>   i2c: omap: bus: add a receiver flag
>>   i2c: omap: simplify errata check
>>   i2c: omap: always return IRQ_HANDLED
>>   i2c: omap: simplify IRQ exit path
>>   i2c: omap: resize fifos before each message
>>   i2c: omap: get rid of the "complete" label
>>   i2c: omap: always return IRQ_HANDLED
>>   i2c: omap: switch to threaded IRQ support
>>   i2c: omap: remove unnecessary pm_runtime_suspended check
>>   i2c: omap: switch over to autosuspend API
>>   i2c: omap: sanitize exit path
>>
>> Shubhrajyoti D (1):
>>   i2c: omap: remove redundant status read
>>
>>  drivers/i2c/busses/i2c-omap.c |  442 +++++++++++++++++++++++++----------------
>>  1 files changed, 271 insertions(+), 171 deletions(-)
