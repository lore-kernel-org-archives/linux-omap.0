From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH v2 1/6] omap3: pm: re-program the sleep state of TRITON
 resources by modifying the REMAP register
Date: Thu, 21 Jan 2010 17:30:31 -0600
Message-ID: <4B58E397.4080506@ti.com>
References: <1263922501-13701-1-git-send-email-x0080970@ti.com> <4B572121.50402@compulab.co.il> <020501ca9a60$71a2e800$LocalHost@wipultra1385>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38114 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074Ab0AUXan (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 18:30:43 -0500
In-Reply-To: <020501ca9a60$71a2e800$LocalHost@wipultra1385>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly AM <x0080970@ti.com>
Cc: Mike Rapoport <mike@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Derrick, David" <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly AM wrote:
> ----- Original Message ----- 
> From: "Mike Rapoport" <mike@compulab.co.il>
> To: <x0080970@ti.com>
> Cc: <linux-omap@vger.kernel.org>; "Nishanth Menon" <nm@ti.com>; "David 
> Derrick" <dderrick@ti.com>; "Samuel Ortiz" <sameo@linux.intel.com>
> Sent: Wednesday, January 20, 2010 8:58 PM
> Subject: Re: [PATCH v2 1/6] omap3: pm: re-program the sleep state of TRITON 
> resources by modifying the REMAP register
> 
> 
>> x0080970@ti.com wrote:
>>> From: Lesly A M <x0080970@ti.com>
>>>
>>> omap3: pm: re-program the sleep state of TRITON resources by modifying 
>>> the REMAP register
>>>
>>> Removed the warning print with checking order of scripts, since the order
>>> is not important. Only the values configured in the register, which is 
>>> pointing to
>>> the starting address of each sequence should be correct.
>>>
>>> Signed-off-by: Lesly A M <x0080970@ti.com>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> Cc: David Derrick <dderrick@ti.com>
>>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>>>
>>> ---
>>>  drivers/mfd/twl4030-power.c |   30 +++++++++++++++++++++++-------
>>>  1 file changed, 23 insertions(+), 7 deletions(-)
>>>
>>> Index: linux-omap-pm/drivers/mfd/twl4030-power.c
>>> ===================================================================
>>> --- linux-omap-pm.orig/drivers/mfd/twl4030-power.c 2010-01-19 
>>> 19:18:56.000000000 +0530
>>> +++ linux-omap-pm/drivers/mfd/twl4030-power.c 2010-01-19 
>>> 19:19:02.000000000 +0530
>>> @@ -416,14 +416,35 @@
>>>  return err;
>>>  }
>>>
>>> - return 0;
>>> +
>>> + /* Set the remap sleep cmd */
>>> + err = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &remap,
>>> + rconfig_addr + REMAP_OFFSET);
>>> + if (err < 0) {
>>> + printk(KERN_ERR "TWL4030 Resource %d remap could not read\n",
>>> + rconfig->resource);
>>> + return err;
>>> + }
>>> +
>>> + if (rconfig->remap_sleep >= 0) {
>>> + remap &= ~SLEEP_STATE_MASK;
>>> + remap |= rconfig->remap_sleep;
>>> + }
>>> +
>>> + err = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, remap,
>>> + rconfig_addr + REMAP_OFFSET);
>>> + if (err < 0) {
>>> + pr_err("TWL4030 failed to program remap sleep cmd \n");
>>> + return err;
>>> + }
>>> +
>> Is it necessary to initialize the remap sleep twice?
> No.
> Sorry..  I didn't notice that Amit has already pushed this.

The existing remap programming does have a bug in it.  Lesly, try adding 
the following to this patch:

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 0815292..5b045ff 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -405,7 +405,7 @@ static int __init twl4030_configure_resource(struct 
twl4030_resconfig *rconfig)

         if (rconfig->remap_sleep != TWL4030_RESCONFIG_UNDEF) {
                 remap &= ~SLEEP_STATE_MASK;
-               remap |= rconfig->remap_off << SLEEP_STATE_SHIFT;
+               remap |= rconfig->remap_sleep << SLEEP_STATE_SHIFT;
         }

         err = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,

Regards,
Mike

>>> + return err;
>>>  }
>>>
>>>  static int __init load_twl4030_script(struct twl4030_script *tscript,
>>>         u8 address)
>>>  {
>>>  int err;
>>> - static int order;
>>>
>>>  /* Make sure the script isn't going beyond last valid address (0x3f) */
>>>  if ((address + tscript->size) > END_OF_SCRIPT) {
>>> @@ -444,7 +465,6 @@
>>>  err = twl4030_config_wakeup12_sequence(address);
>>>  if (err)
>>>  goto out;
>>> - order = 1;
>>>  }
>>>  if (tscript->flags & TWL4030_WAKEUP3_SCRIPT) {
>>>  err = twl4030_config_wakeup3_sequence(address);
>>> @@ -452,10 +472,6 @@
>>>  goto out;
>>>  }
>>>  if (tscript->flags & TWL4030_SLEEP_SCRIPT)
>>> - if (order)
>>> - pr_warning("TWL4030: Bad order of scripts (sleep "\
>>> - "script before wakeup) Leads to boot"\
>>> - "failure on some boards\n");
>>>  err = twl4030_config_sleep_sequence(address);
>>>  out:
>>>  return err;
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> -- 
>> Sincerely yours,
>> Mike.
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

