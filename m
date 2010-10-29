From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: OMAP3 low power mode broken on l-o
Date: Fri, 29 Oct 2010 10:22:12 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D398AD7@dbde02.ent.ti.com>
References: <AANLkTikzVLW08MrZUPWmVx6+w4E8sXN5NHwM1R7Ya8zX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55160 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab0J2EwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Oct 2010 00:52:18 -0400
In-Reply-To: <AANLkTikzVLW08MrZUPWmVx6+w4E8sXN5NHwM1R7Ya8zX@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Jean Pihet
> Sent: Friday, October 29, 2010 2:11 AM
> To: linux-omap@vger.kernel.org
> Cc: Kevin Hilman
> Subject: OMAP3 low power mode broken on l-o
> 
> Hi,
> 
> The low power mode on the latest l-o master branch is broken, so I
> investigated a bit. Here are the results. This has been tested on
> OMAP3EVM and Beagleboard.
> 
> The problem is that the CORE does not reach the desired mode (RET,
> OFF). It is caused by the I2C1 fclk that is left enabled at suspend
> time.
> Extra printks has been added in the clock enable and disable functions
> for I2C and a stack dump has been added in the suspend path if the
> clock is still enabled, cf. log below.
> 
> In the devices suspend sequence the RTC gets suspended, which triggers
> a read of the TWL RTC through the I2C bus, which in turn enables the
> I2C1 fclk. That clock is only disabled on devices resume.
> 
> I am guessing this is linked to the recent changes in the I2C for HWMOD
> support.
> What is the correct fix to have the I2C modules correctly shut off
> before the suspend?
> 
> Any thoughts?
Looks like get_sync / put_sync miss-match has re-appeared again which leads
to I2C clocks are not getting cut.

Regards,
Santosh


