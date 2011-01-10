From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: More LDP stuff
Date: Mon, 10 Jan 2011 16:45:55 +0000
Message-ID: <20110110164555.GD6541@sirena.org.uk>
References: <20110106153653.GD1198@n2100.arm.linux.org.uk> <e65ceaf93735be6697c31d52325112d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:45561 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab1AJQqA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 11:46:00 -0500
Content-Disposition: inline
In-Reply-To: <e65ceaf93735be6697c31d52325112d2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

On Thu, Jan 06, 2011 at 10:10:03PM +0530, Santosh Shilimkar wrote:

> > ads7846 spi1.0: unable to get regulator: -19

> > Is something missing from the ldp support code to declare this
> > regulator?

> Am not sure what is connected to SPI on LDP. But mostly
> not an important peripheral.

As the log message says it's an ads7846 which is a touchscreen
controller.
