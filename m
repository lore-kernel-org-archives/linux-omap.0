From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/PATCH 05/10] cbus: retu: move to threaded IRQ and GENIRQ
Date: Tue, 4 Jan 2011 09:47:56 +0200
Message-ID: <20110104074756.GD2656@legolas.emea.dhcp.ti.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
 <1294040988-21191-6-git-send-email-balbi@ti.com>
 <20110104014002.GV7771@atomide.com>
 <20110104065229.GB2367@legolas.emea.dhcp.ti.com>
 <20110104074615.GC2656@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:37452 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751734Ab1ADHsC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 02:48:02 -0500
Received: by gwj17 with SMTP id 17so7878247gwj.31
        for <linux-omap@vger.kernel.org>; Mon, 03 Jan 2011 23:48:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110104074615.GC2656@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Jan 04, 2011 at 09:46:15AM +0200, Felipe Balbi wrote:
>@@ -593,6 +594,14 @@ static struct twl4030_platform_data sdp3430_twldata = {
>        .vpll2          = &sdp3430_vpll2,
> };
>+static void __init sdp3430_twl_init(void)
>+{
>+       int             irq_base = omap_irq_get_base();
>+
>+       sdp3430_twldata.irq_base = irq_base;
>+       sdp3430_twldata.irq_end = irq_base + TWL4030_BASE_NR_IRQS;
>+}
>+
> static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
>        {
>                I2C_BOARD_INFO("twl4030", 0x48),

this hunk should be:

@@ -593,6 +594,16 @@ static struct twl4030_platform_data sdp3430_twldata = {
         .vpll2          = &sdp3430_vpll2,
  };
  
+static void __init sdp3430_twl_init(void)
+{
+       int             irq_base = omap_irq_get_base();
+
+       sdp3430_twldata.irq_base = irq_base;
+       sdp3430_twldata.irq_end = irq_base + TWL4030_BASE_NR_IRQS;
+
+       omap_irq_add(TWL4030_BASE_NR_IRQS);
+}
+
  static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
         {
                 I2C_BOARD_INFO("twl4030", 0x48),

otherwise it won't work for other irq_chips

-- 
balbi
