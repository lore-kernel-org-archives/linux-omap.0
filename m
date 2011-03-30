From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: OMAP4 DSS clock setup
Date: Wed, 30 Mar 2011 09:48:53 +0300
Message-ID: <1301467733.2333.83.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59490 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751638Ab1C3Gs7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 02:48:59 -0400
Received: by ewy19 with SMTP id 19so299642ewy.3
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 23:48:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Benoit, Paul,

I've been discussing with Sumit and Archit to understand how the DSS
clocks are set up on OMAP4. I think I now have some idea how things
work, but I'm still at loss why things are the way they are.

So, if I look at OMAP4 TRM, Figure 10-4 DSS Clock Tree, there are two
clocks in PRCM block that are relevant to this discussion: DSS_L3_ICLK
and DSS_FCLK. To my understanding DSS_L3_ICLK is not really
controllable, but it is affected by MODULEMODE bit.

Then we have two relevant clocks defined in clock44xx_data.c: dss_fck
and dss_dss_clk. dss_fck controls the MODULEMODE bit, and dss_dss_clk is
the TRM's DSS_FCLK.

Was that correct?

If so, from DSS driver's perspective, the dss_fck sounds very much like
an interface clock (it's always needed when DSS is used) and dss_dss_clk
sounds very much like functional clock (it's always needed, except if
DSI PLL is used for DSS functional clock).

If "dss_fck" would control DSS_FCLK and "dss_ick" would control
MODULEMODE, they would be about the same as the clocks in OMAP2 and 3,
and we wouldn't need any omap4 spesific trickery in the DSS driver.
("dss_dss_clk" wouldn't be needed).

Why are the clocks set up in this strange fashion?

 Tomi


