From: Peter Barada <peter.barada@logicpd.com>
Subject: Regulator question regarding I2C devices
Date: Fri, 28 Jan 2011 17:24:01 -0500
Message-ID: <4D434201.6060108@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 174-46-170-154.static.twtelecom.net ([174.46.170.154]:35438
	"EHLO edprlnx06.logicpd.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752290Ab1A1Wdo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 17:33:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Peter Barada <peter.barada@logicpd.com>

I have a tsc2004 touch controller on I2C3 that is powered by vaux1, and since its probed I have to turn the power on before it can be probed.  I've created:

static struct regulator_consumer_supply dm3730logic_vaux1_supply = {
    .supply            = "vaux1",
};

/* VAUX1 for touch chip */
static struct regulator_init_data dm3730logic_vaux1 = {
    .constraints = {
        .min_uV        = 3000000,
        .max_uV        = 3000000,
        .apply_uV    = true,
        .valid_modes_mask    = REGULATOR_MODE_NORMAL
                    | REGULATOR_MODE_STANDBY,
        .valid_ops_mask        = REGULATOR_CHANGE_MODE
                    | REGULATOR_CHANGE_STATUS,
    },
    .num_consumer_supplies    = 1,
    .consumer_supplies    = &dm3730logic_vaux1_supply,
};

and listed it in the twldata initializer
    .vaux1        = &dm3730logic_vaux1,

But it never gets enabled...  How can I tell the kernel to turn the regulator on?

If I try to call regulator_get() right before the call to omap_register_i2c_bus for I2C3, regulator_get returns a NULL due to regulator_map_list being empty.  If I look in sys/class/regulator I see VAUX1 listed (as regulator.4), but there are no users.

Any suggestions on how I can turn on vaux1 so the tsc2004 touch controller is visible to by the I2C system?

Thanks in advance!

-- 
Peter Barada
peter.barada@logicpd.com

