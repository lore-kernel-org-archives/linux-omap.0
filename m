From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: GPMC clock question
Date: Thu, 18 Dec 2014 17:44:49 -0300
Message-ID: <54933CC1.9010301@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35159 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaLRUqr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2014 15:46:47 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so3129050wid.17
        for <linux-omap@vger.kernel.org>; Thu, 18 Dec 2014 12:46:46 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?B?R3VpZG8gTWFydMOtbmV6?= <guido@vanguardiasur.com.ar>

Tony, Roger:

As far as I can see, the GPMC interface clock (GPMC_FCLK) is not
properly modeled in the devicetree. Instead, hwmod magic seems to be used.

arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c:
struct omap_hwmod_ocp_if am33xx_l3_s__gpmc = {
        .master         = &am33xx_l3_s_hwmod,
        .slave          = &am33xx_gpmc_hwmod,
        .clk            = "l3s_gclk",
        .addr           = am33xx_gpmc_addr_space,
        .user           = OCP_USER_MPU,
};

I'd like to know what would be the appropriate DT model for this clock.
Perhaps, as child of CORE_M4_CLK, divided by 2:

gpmc_fclk: gpmc_fclk {
                #clock-cells = <0>;
                compatible = "fixed-factor-clock";
                clocks = <&dpll_core_m4_ck>;
                clock-mult = <1>;
                clock-div = <2>;
        };

How does it look? Also, I'm wondering if this works OK when used with
the hwmod stuff.

Thanks a lot in advance!
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
