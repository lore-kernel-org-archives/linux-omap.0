From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: [RFC] [Patch 0/2] Proposal for changes to TWL4030/TWL5030 framework
 for integrating the new TWL6030 chip
Date: Tue, 28 Apr 2009 10:54:30 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B42BDE9B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46957 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbZD1FYj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 01:24:39 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3S5OXj2004974
	for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 00:24:39 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3S5OVsW015461
	for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 10:54:32 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi folks,
  We have a new TWL6030 chip that is coming in. In brief, the following are the changes w.r.t. TWL5030:

0. This is the companion chip for OMAP4430.
1. Unlike in TWL5030, audio and power chips are going to be separate chips as TWL6030 and TWL6031.
2. Keypad and GPIO features are no more present in TWL6030 (the power companion chip). They all move into OMAP.
4. Register and module base names/addresses changes (as expected from 2).
5. Changes in interrupt framework:
	- No more PIH and SIH
	- 3 ISRs INT_STS_A, INT_STS_B and INT_STS_C at 3 consecutive address locations (that will allow an I2C burst read).
6. The modules that are inherited from TWL5030 to TWL6030 remain same (like RTC, BCI) except MADC with some minor changes making it a General Purpose ADC (GPADC).


I'd like to propose a new generic framework that will incorporate TWL4030/TWL5030 and TWL6030 functionalities/changes seamlessly.

Proposal
========
1. Rename all registers/functions etc. from twl4030/TWL4030 to twl/TWL.
	- This would allow unchanged modules (like RTC) to work in the same way, transparent to whether it is part of TWL4030 or TWL6030.
2. Have a new twl.c file, that will define functions like
	- twl_i2c_write
	- twl_i2c_write_u8
	- twl_i2c_read
	- twl_i2c_read_u8
	- twl_init
	- twl_exit
	- twl_probe
	- twl_remove
These functions implement the functionalities common to both TWL4030 and TWL6030, doing away with the need to have a copy of these functions in two places.
3. twl4030-core.c and twl4030-irq.c files will define functions that changes between TWL4030 and TWL6030, like:
	- add_children(): We do not need keypad and GPIO; MADC changes to GPADC in case of TWL6030.
	- twl_irq_thread() <<twl4030-irq.c>>: We have new registers to read interrupts from. No more PIH and SIH. So the core loop that dispatches the interrupt changes. We can also use an I2C burst read to get 3 interrupt registers in one shot for TWL6030.

4. New twl6030-core.c and twl6030-irq.c that implements the TWL6030 counter parts of functions applicable in (3).

5. A config option will determine whether TWL4030 or TWL6030 will be compiled as a part of the kernel.

NB:
==
Please note that the patches are for RFC, and they might not even compile properly. These are draft patches to convey the idea across. So please ignore styling and formatting errors.

--
With Regards,
Jagadeesh Bhaskar P
 
----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
----------------------------

