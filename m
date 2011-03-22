From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: tca6416-keypad: Change to module_init()
Date: Tue, 22 Mar 2011 14:28:55 +0000
Message-ID: <20110322142855.GB2202@sirena.org.uk>
References: <20110322142619.1109.89105.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:36164 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab1CVO3E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Mar 2011 10:29:04 -0400
Content-Disposition: inline
In-Reply-To: <20110322142619.1109.89105.sendpatchset@t400s>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: dmitry.torokhov@gmail.com, srk@ti.com, khilman@ti.com, chinyeow.sim.xt@renesas.com, linux-sh@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Mar 22, 2011 at 11:26:19PM +0900, Magnus Damm wrote:

> The tca6416 driver makes use of the I2C bus for chatting
> with the actual hardware device. Without this patch both
> the I2C bus driver and the tca6416 driver are initialized
> at the subsys_initcall() level. This may lead to problems
> with the tca6416 driver being initialized before the I2C
> bus driver.

While this change seems reasonable I'm curious what the problems caused
by out of order registration are?
