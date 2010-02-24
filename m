From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6] OMAP UART: Add omap-serial driver support.
Date: Wed, 24 Feb 2010 10:39:09 -0800
Message-ID: <87hbp6pjg2.fsf@deeprootsystems.com>
References: <52471.192.168.10.88.1266504626.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f174.google.com ([209.85.222.174]:43630 "EHLO
	mail-pz0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638Ab0BXSjM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 13:39:12 -0500
Received: by pzk4 with SMTP id 4so890729pzk.21
        for <linux-omap@vger.kernel.org>; Wed, 24 Feb 2010 10:39:11 -0800 (PST)
In-Reply-To: <52471.192.168.10.88.1266504626.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Thu\, 18 Feb 2010 20\:20\:26 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From 81fe9a08684830e84e64bed57c7f90e7461a5375 Mon Sep 17 00:00:00 2001
> From: Govindraj R <govindraj.raja@ti.com>
> Date: Thu, 18 Feb 2010 19:34:04 +0530
> Subject: [PATCH] OMAP UART: Add omap-serial driver support.

Please drop this stuff from te mail body.  It's included in the mail
header and makes for extra junk to be manually removed by maintainers.

Also Subject should be something like "serial: add OMAP high-speed UART driver"

For the changelog of a new driver, you should also describe what
devices this driver will be used on etc.  Assume the reader isn't
familiar with the driver or device.

> This patch adds support for OMAP-HIGH SPEED UART Controller.
> It adds support for the following features:

"adds" support to what?

> 1. It supports Interrupt mode and DMA mode of operation.
> 2. Supports Hardware flow control and software flow control.
> 3. Debug Console support on all UARTs.

I think the changelog needs some work.  It should especially describe
that it is based on the 8250 driver and highlight the
additions/differences from the 8250 driver.

> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
> ---
> Incorporating Comments from Tony,Olof,Kevin.


Other than the changelog, this looks pretty good to me.   

Oh, you should also update the copyrights to 2010.

After that and Olof's comments, it should be submitted to linux-serial
and LKML.

I also tested this with the PM branch on SDP, omap3evm, and Beagle
including off mode and things are working well.

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

Kevin
