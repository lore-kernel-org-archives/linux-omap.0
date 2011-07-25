From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Kconfig help descriptions
Date: Mon, 25 Jul 2011 10:41:01 +0100
Message-ID: <20110725094101.GA18447@sirena.org.uk>
References: <20110721092221.GA28942@n2100.arm.linux.org.uk>
 <20110721095702.GP23253@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:33268 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab1GYJlE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jul 2011 05:41:04 -0400
Content-Disposition: inline
In-Reply-To: <20110721095702.GP23253@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>

On Thu, Jul 21, 2011 at 12:57:03PM +0300, Felipe Balbi wrote:

> the problem seems to be worse then you thought:

> $ git ls-files drivers/  | grep madc
> drivers/hwmon/twl4030-madc-hwmon.c
> drivers/mfd/twl4030-madc.c

This is normal for this sort of auxiliary ADC - they're *normally* used
for system monitoring and should show up in hwmon but are more general
purpose than that so you get a MFD core which drives the actual ADC and
a hwomon driver which uses the core to expose things to userspace.

Sadly we don't have a subsystem for ADCs yet, IIO might be it but it's
really designed for much higher volume ADCs.
