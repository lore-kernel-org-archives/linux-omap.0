From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Wed, 16 Feb 2011 13:45:23 +0200
Message-ID: <20110216134523.ba5d3917.jhnikula@gmail.com>
References: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
	<20110215171652.601c9c68.jhnikula@gmail.com>
	<20110215172931.3a6e45a8.jhnikula@gmail.com>
	<AANLkTi=3PCBOvFtd1T-=tDjXcs+_0opKqxVps+StCZqf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63543 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab1BPLo5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 06:44:57 -0500
Received: by ewy5 with SMTP id 5so344727ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 03:44:56 -0800 (PST)
In-Reply-To: <AANLkTi=3PCBOvFtd1T-=tDjXcs+_0opKqxVps+StCZqf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, 16 Feb 2011 11:22:09 +0530
"Gulati, Shweta" <shweta.gulati@ti.com> wrote:

> On Tue, Feb 15, 2011 at 8:59 PM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> > Probably discussed earlier but would it make more sense to have flag in
> > struct twl4030_platform_data and to do registers writes in twl-core?
> > Looks suspicious to have i2c_writes under arch/arm/.
> twl_i2c_read/write APIs are used from arch/arm in many board files,
> so I think it should not cause any issue.

Not good either e.g. in modularization point of view. I was thinking
something like below. I played safe and let the SR to be enabled only if
the twl4030_power_data.sr_enable is set. I read that Kevin had problems
earlier with 2430SDP if SR was enabled.

Note proof of concept patch only. I omitted the comments and don't do
explicit SR disable and I'd clean up the error paths in twl4030_power_init
a bit before this (e.g. printing error codes). Not sure either is the
twl4030-power.c right place for this or core.

-- 
Jarkko

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 16422de0..e767b0f 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -92,6 +92,9 @@ static u8 twl4030_start_script_address = 0x2b;
 #define OFF_STATE_SHIFT		4
 #define OFF_STATE_MASK		(0xf << OFF_STATE_SHIFT)
 
+#define TWL4030_DCDC_GLOBAL_CFG	PHY_TO_OFF_PM_RECEIVER(0x61)
+#define SMARTREFLEX_ENABLE	BIT(3)
+
 static u8 res_config_addrs[] = {
 	[RES_VAUX1]	= 0x17,
 	[RES_VAUX2]	= 0x1b,
@@ -510,6 +513,22 @@ int twl4030_remove_script(u8 flags)
 	return err;
 }
 
+int __init twl4030_sr_enable(void)
+{
+	u8 temp;
+	int ret;
+
+	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
+			      TWL4030_DCDC_GLOBAL_CFG);
+	if (ret)
+		return ret;
+
+	temp |= SMARTREFLEX_ENABLE;
+
+	return twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
+				TWL4030_DCDC_GLOBAL_CFG);
+}
+
 void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 {
 	int err = 0;
@@ -549,8 +568,15 @@ void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 
 	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0,
 			TWL4030_PM_MASTER_PROTECT_KEY);
-	if (err)
+	if (err) {
 		pr_err("TWL4030 Unable to relock registers\n");
+		return;
+	}
+
+	if (twl4030_scripts->sr_enable)
+		err = twl4030_sr_enable();
+	if (err)
+		pr_err("TWL4030 Unable to set smartreflex. %d\n", err);
 	return;
 
 unlock:
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 61b9609..1f64e3e 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -630,6 +630,7 @@ struct twl4030_power_data {
 	struct twl4030_script **scripts;
 	unsigned num;
 	struct twl4030_resconfig *resource_config;
+	bool sr_enable;	/* Smartreflex enable state */
 #define TWL4030_RESCONFIG_UNDEF	((u8)-1)
 };
 

