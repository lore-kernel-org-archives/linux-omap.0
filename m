From: Grant Erickson <marathon96@gmail.com>
Subject: Suspend / Resume and sys_clkout1
Date: Thu, 18 Nov 2010 13:35:53 -0800
Message-ID: <CC9BC649-F032-4B05-A573-A61B9206CC1C@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58836 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757205Ab0KRVf4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 16:35:56 -0500
Received: by gwj17 with SMTP id 17so2222283gwj.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 13:35:55 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I am working with a board that deviates from what seems to be common OMAP-as-clock-slave-from-the-TWL4030-PMIC-clock-master practice. In order to get this board to work correctly when used with SmartReflex-enabled, I had to add the following to the board initialization function:

    /* In this architecture, we use the OMAP3 as a 19.2 MHz clock
     * master and the TWL4030 as a clock slave, fed via the OMAP3's
     * sys_clkout1 pin.
     *
     * We need to request the 'sys_clkout1' clock source to at least
     * give it a reference count of one (1); otherwise, if the SmartReflex
     * power management code has been configured, it'll get unceremoniously
     * turned off with a message:
     *
     *   Disabling unused clock "sys_clkout1"
     *
     * and general system functionality fails thereafter.
     */

    sys_clkout1 = clk_get(NULL, "sys_clkout1");

    BUG_ON(IS_ERR(sys_clkout1));

    clk_enable(sys_clkout1);

However, now working with suspend/resume functionality, I see that this clock is preventing the system from fully going down to sleep. This leads me to believe that perhaps board-specific initialization was/is not the right place for this as there is no board-specific suspend/resume handling.

Any recommendations on a more architecturally-correct way to address OMAP-as-clock-master-to-the-TWL4030-PMIC-clock-slave in a suspend/resume-friendly way?

Best,

Grant