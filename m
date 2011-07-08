From: Liam Girdwood <lrg@ti.com>
Subject: Re: [RFC 1/4] twl-regulator: extend for SMPS regulators and
 external controllers
Date: Fri, 8 Jul 2011 19:26:46 +0100
Message-ID: <1310149606.3534.35.camel@CNA0741383>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
	 <1310140588-26078-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37016 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab1GHS0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 14:26:52 -0400
In-Reply-To: <1310140588-26078-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kristo, Tero" <t-kristo@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Petazzoni-XID, Thomas" <t-petazzoni@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>

On Fri, 2011-07-08 at 17:56 +0200, Kristo, Tero wrote:
> This commit adds two things to the TWL regulator driver code :
> 
>  * It extends the twl4030_set_voltage() and twl4030_get_voltage()
>    functions to understand that VDD1 and VDD2 are different regulators
>    from all the other regulators: they don't support a fixed set of
>    voltages, but a wide range of voltages between two minimum and
>    maximum limits.
> 
>  * It creates a twlreg_ext_ctrl structure, which allows code outside
>    of the TWL regulator driver to implement a regulator
>    controller. Such a controller is attached using the new
>    twlreg_attach_external_controller() function of the driver. When
>    such a controller is attached to a regulator, the ->set_voltage()
>    and ->get_voltage() calls made on the regulator will be forwarded
>    to the external controller. This facility will later be used to
>    integrate the Voltage Controller and SmartReflex features of the
>    OMAP CPU with this regulator driver.

This just looks like it should just be another regulator to me. The
board will be responsible for setting up the client mapping (i.e.
whether it should use the "extended" or normal regulator).

Fwiw, Graeme has already done a lot of work on supporting Smartreflex
with TWL6025, it may be best to contact him to align your work.

Liam

