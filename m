From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 00/13] Device tree support for OMAP HS USB Host
Date: Tue, 5 Feb 2013 16:55:01 +0530
Message-ID: <5110EC0D.40609@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41805 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab3BELZO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 06:25:14 -0500
In-Reply-To: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, paul@pwsan.com

On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
> This patchset adds device tree support for OMAP's High Speed USB Host
> subsystem. Board adaptation for Panda and Beagleboard is also provided.
>
> Tested on Beagleboard.
>
> Will only work with Panda if we provide a reference to the PHY clock

But there is no reference provided even for Beagle. Does it work because
the default clk speed is 192Mhz?

> generator in the device tree in PATCH 11. I do not know how to do that
> as there is no way to provide a phandle to any of the OMAP generated clocks
> in the device tree. Suggestions welcome:).

