From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [Patch 0/2] Proposal for changes to TWL4030/TWL5030
	framework for integrating the new TWL6030 chip
Date: Tue, 28 Apr 2009 11:40:13 +0300
Message-ID: <20090428084013.GA3909@scadufax.research.nokia.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B42BDE9B@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29259 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbZD1IpD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 04:45:03 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B42BDE9B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Apr 28, 2009 at 07:24:30AM +0200, ext Pakaravoor, Jagadeesh wrote:
> Hi folks,
>   We have a new TWL6030 chip that is coming in. In brief, the following are the changes w.r.t. TWL5030:
> 
> 0. This is the companion chip for OMAP4430.
> 1. Unlike in TWL5030, audio and power chips are going to be separate chips as TWL6030 and TWL6031.
> 2. Keypad and GPIO features are no more present in TWL6030 (the power companion chip). They all move into OMAP.
> 4. Register and module base names/addresses changes (as expected from 2).
> 5. Changes in interrupt framework:
> 	- No more PIH and SIH
> 	- 3 ISRs INT_STS_A, INT_STS_B and INT_STS_C at 3 consecutive address locations (that will allow an I2C burst read).
> 6. The modules that are inherited from TWL5030 to TWL6030 remain same (like RTC, BCI) except MADC with some minor changes making it a General Purpose ADC (GPADC).
> 
> 
> I'd like to propose a new generic framework that will incorporate TWL4030/TWL5030 and TWL6030 functionalities/changes seamlessly.
> 
> Proposal
> ========
> 1. Rename all registers/functions etc. from twl4030/TWL4030 to twl/TWL.
> 	- This would allow unchanged modules (like RTC) to work in the same way, transparent to whether it is part of TWL4030 or TWL6030.
> 2. Have a new twl.c file, that will define functions like
> 	- twl_i2c_write
> 	- twl_i2c_write_u8
> 	- twl_i2c_read
> 	- twl_i2c_read_u8
> 	- twl_init
> 	- twl_exit
> 	- twl_probe
> 	- twl_remove
> These functions implement the functionalities common to both TWL4030 and TWL6030, doing away with the need to have a copy of these functions in two places.
> 3. twl4030-core.c and twl4030-irq.c files will define functions that changes between TWL4030 and TWL6030, like:
> 	- add_children(): We do not need keypad and GPIO; MADC changes to GPADC in case of TWL6030.
> 	- twl_irq_thread() <<twl4030-irq.c>>: We have new registers to read interrupts from. No more PIH and SIH. So the core loop that dispatches the interrupt changes. We can also use an I2C burst read to get 3 interrupt registers in one shot for TWL6030.
> 
> 4. New twl6030-core.c and twl6030-irq.c that implements the TWL6030 counter parts of functions applicable in (3).
> 
> 5. A config option will determine whether TWL4030 or TWL6030 will be compiled as a part of the kernel.
> 
> NB:
> ==
> Please note that the patches are for RFC, and they might not even compile properly. These are draft patches to convey the idea across. So please ignore styling and formatting errors.

diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index 769b34b..c6eec75 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -176,6 +176,7 @@
 /* chip-specific feature flags, for i2c_device_id.driver_data */
 #define TWL4030_VAUX2          BIT(0)  /* pre-5030 voltage ranges */
 #define TPS_SUBSET             BIT(1)  /* tps659[23]0 have fewer LDOs
*/
+#define TWL6030                        BIT(2)  /* twl6030 doesn't have
gpio nor keypad */
 
 /*----------------------------------------------------------------------*/
 
@@ -496,7 +497,8 @@ add_children(struct twl4030_platform_data *pdata,
unsigned long features)
                        return PTR_ERR(child);
        }
 
-       if (twl_has_keypad() && pdata->keypad) {
+       if (twl_has_keypad() && pdata->keypad &&
+                       !(features & TLW6030)) {
                child = add_child(2, "twl4030_keypad",
                                pdata->keypad, sizeof(*pdata->keypad),
                                true, pdata->irq_base + 1, 0);

You'd probably only need to make changes to register defines but almost
everything else could remain as is. There shouldn't be any need for
creating separate files.

-- 
balbi
