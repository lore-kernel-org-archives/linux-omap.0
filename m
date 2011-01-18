From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [Query] OMAP: DSS2: Margin for downscaling in clock calculations
Date: Tue, 18 Jan 2011 10:45:43 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F86FA74@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39206 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab1ARFPx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 00:15:53 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I was going through the DSS2 code which sets up the FCLK
coming from PRCM and the DISPC divivors to get the required pixel
clock. 
 
The function dss_calc_clock_div() does a brute force search across
all possible values of: a) DPLL divisor whose output goes to DSS, b)
DISPC_DIVISOR.LCD, c) DISPC_DIVISOR.pcd

The combination which gives a clock frequency closest to the
required pixel clock is chosen.

Hence, it seems that the resultant DISPC_FCLK clock frequency doesn't
take into account the extra margin needed for downscaling:

Req dispc_fclk >= pck * hscale_ratio * vscale_ration * K

Do you thing putting a further constraint (like DISPC_FCLK needs to be
greater than a given value) should be a part of the calculations to
ensure successful scaling?

Regards,
Archit