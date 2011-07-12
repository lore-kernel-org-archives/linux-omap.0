From: Jerry Alexander <jerryalex@tx.rr.com>
Subject: DSI lane configuration
Date: Tue, 12 Jul 2011 08:20:28 -0700
Message-ID: <4E1C663C.5040201@tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:52761 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab1GLPU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jul 2011 11:20:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Have a new board with the omap4  and toshiba bridge chipset.
The board has two lanes instead of four.
Removed   DSI_COMPLEXIO_CFG1  entries for data3_lane, data3_pol,
data4_lane, and data4_pol.
With 4 lanes configured we see traffic on the scope ,but  the toshiba
drops it since the board has only two lanes.
With 2 lanes configured we see no traffic.
Cannot other fields in the omap required to reconfigure for 2 lanes.
It is also possible that the  omap_dss_device divisors in the board
file are causing the problem.   If this is the case, there is insufficient
data in the TRM on how to reset  for different lane config and different
clocking.
Note, our LVDS is different and requires  82MHZ and not 66MHZ as
with the Blazetablet.

                                                                       Jerry

                         .lck_div        = 1,    /* LCD */
                        .pck_div        = 2,    /* PCD */
                        .regm           = 394,  /* DSI_PLL_REGM */
                        .regn           = 38,   /* DSI_PLL_REGN */
                        .regm_dispc     = 6,    /* PLL_CLK1 (M4) */
                        .regm_dsi       = 9,    /* PLL_CLK2 (M5) */
                        .lp_clk_div     = 5,    /* LPDIV */

