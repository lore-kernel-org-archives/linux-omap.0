From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 09/11] ARM: OMAP4+: thermal: introduce bandgap
 temperature sensor
Date: Fri, 1 Jun 2012 04:42:39 -0700
Message-ID: <20120601114238.GP12766@atomide.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-10-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63665 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756609Ab2FALmr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 07:42:47 -0400
Content-Disposition: inline
In-Reply-To: <1337934361-1606-10-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Keerthy <j-keerthy@ti.com>

* Eduardo Valentin <eduardo.valentin@ti.com> [120525 01:31]:
> In the System Control Module, OMAP supplies a voltage reference
> and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> This patch provides a platform driver which expose this feature.
> It is moduled as a MFD child of the System Control Module core
> MFD driver.
> 
> This driver provides only APIs to access the device properties,
> like temperature, thresholds and update rate.

Here too you a better long term solution is probably to ioremap
the temp sensor registers for the driver. That way alloc_mem_region()
provides some checks so the driver won't stomp over other registers.

If you need to use omap_ctrl_read/write here, then we should at
least clearly understand and document why it needs to be done that
way instead of following standard ioremap + readl/writel.

Regards,

Tony
