From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: omap3 hsusb0_clk
Date: Fri, 21 Sep 2012 08:45:43 +0000
Message-ID: <FB41A22788BFC44EB94B0CCFEF5E2E2C3EB82C26@DBDE01.ent.ti.com>
References: <alpine.DEB.2.01.1209181137320.3627@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59662 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757071Ab2IUIq0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 04:46:26 -0400
In-Reply-To: <alpine.DEB.2.01.1209181137320.3627@pmeerw.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Balbi, Felipe" <balbi@ti.com>

Peter Meerwald wrote:
> Hello,
> 
> I am wondering if an OMAP3 (say dm3730) can generate the hsusb0_clk (musb)
> for ULPI by itself? (and if so, how?)
> 
> is hsusb0_clk strictly an input depending on an external clock source?
> 
> looking at the DM3730 TRM I am not entirely sure

For MUSB, no it cannot do that. HSUSB0 is strictly ULPI output clocking mode, 
which means the transceiver provides a 60 MHz clock to the OMAP.
For the OMAP, this signal has to be an input.

For the EHCI controller on OMAP3 (hsusb1/2), it's the other way around. The clock
line is ULPI input clocking mode and the OMAP provides the 60MHz clock to the PHY.

Only a small number of transceivers can accept this input clock.

- Anand

