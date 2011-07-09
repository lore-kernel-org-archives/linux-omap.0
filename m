From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 1/4] twl-regulator: extend for SMPS regulators and external
 controllers
Date: Sat, 9 Jul 2011 10:21:20 +0900
Message-ID: <20110709012118.GF18860@opensource.wolfsonmicro.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
 <1310140588-26078-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40239 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751813Ab1GIBV1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 21:21:27 -0400
Content-Disposition: inline
In-Reply-To: <1310140588-26078-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@ti.com, Thomas Petazzoni <t-petazzoni@ti.com>

On Fri, Jul 08, 2011 at 06:56:25PM +0300, Tero Kristo wrote:
> This commit adds two things to the TWL regulator driver code :

Why is this one commit rather than two commits implementing the two
changes?

>  * It creates a twlreg_ext_ctrl structure, which allows code outside
>    of the TWL regulator driver to implement a regulator
>    controller. Such a controller is attached using the new
>    twlreg_attach_external_controller() function of the driver. When
>    such a controller is attached to a regulator, the ->set_voltage()
>    and ->get_voltage() calls made on the regulator will be forwarded
>    to the external controller. This facility will later be used to
>    integrate the Voltage Controller and SmartReflex features of the
>    OMAP CPU with this regulator driver.

The regulator API has perfectly good support for multiple regulators in
the system already, why would this driver know anything about other
regulators in the system?  If there is something missing why are you
implementing it in a driver and not the core?

I've not read the actual patch.
