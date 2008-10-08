From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 2.6.27-rc9-omap] i2c-omap: timeouts begone
Date: Wed, 8 Oct 2008 17:35:48 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620365B589EC@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com>
 <20081008183808.GA31385@atomide.com>
 <200810081236.48940.david-b@pacbell.net>
 <200810081436.06810.david-b@pacbell.net> <20081008215455.GA15087@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52053 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754144AbYJHWgA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 18:36:00 -0400
In-Reply-To: <20081008215455.GA15087@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> At least we can say the problem seems to be related to pm. Maybe after
> context restore we should wait until the clock stabilizes or some
> register changes ??

Maybe.  An experiment would be to not shut the clock off in the idle routine.

Actually, scanning i2c_init shows what looks to be a problem.

 235 static int omap_i2c_init(struct omap_i2c_dev *dev)
 236 {
 237         u16 psc = 0, scll = 0, sclh = 0;
 238         u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
 239         unsigned long fclk_rate = 12000000;
 240         unsigned long timeout;
 241         unsigned long internal_clk = 0;
 242
 243         if (!dev->rev1) {
 244                 omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SRST);

None of the module local OCP registers are being setup properly.  A write of a 0x2 kills other settings.  If after this operation the SSYC reg will say:
        -Forced Idle
        -Locally gate I+F clock on ocp-segment idle request
        -wake up disabled

If it is left this way what can happen is when L4/L3 clock stop partial idle is broadcast, this module will ack and gate its clocks.  This will result in you dropping data. Or if the data was sent ok, but clock stop happens, you won't be able to wake the system properly as you've cleared the local wakeup generation.  The result will be a timeout.

On OMAP2 I2C wasn't hooked properly into PRCM for handshake so it needed a workaround.  The same isn't true for OMAP3.  Treating the two as if they are the same with respect to power is false.

Regards,
Richard W.

