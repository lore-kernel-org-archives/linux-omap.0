From: Peter Barada <peter.barada@gmail.com>
Subject: Trying to understand how to use regulator supplies
Date: Wed, 10 Feb 2010 14:07:04 -0500
Message-ID: <738b3f7e1002101107k4deaeec9ka6c2bc91348289a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:41467 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462Ab0BJTHE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 14:07:04 -0500
Received: by pzk17 with SMTP id 17so327781pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 10 Feb 2010 11:07:04 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I've got a OMAP3530 board with a tsc2004 touch controller that is
powered off of VAUX1(VAUX1_30 on my schematic) at 3V, and I'm trying to
understand how to code it up so that vaux1 power comes up before the i2c
code tries to probe for the touch controller.

Looking at some of the board files, I've added in:

/* VAUX1 for mainboard (touch and productID) */
static struct regulator_init_data omap3logic_vaux1 = {
        .constraints = {
                .min_uV                 = 3000000,
                .max_uV                 = 3000000,
                .name                   = "VAUX1_30"
                .apply_uV               = true,
                .valid_modes_mask       = REGULATOR_MODE_NORMAL
                                        | REGULATOR_MODE_STANDBY,
                .valid_ops_mask         = REGULATOR_CHANGE_MODE
                                        | REGULATOR_CHANGE_STATUS,
        },
};

as well as a corresponding:

        .vaux1          = &omap3logic_vaux1,

in the twl4030_platform_data structure, but the voltage doesn't come up.
How do I tell the kernel to turn on vaux1 so I can detect the tsc2004
chip?
