From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH][v4.0-rc] ARM: dts: dra7x-evm: beagle-x15: Fix USB Host
Date: Tue, 24 Feb 2015 10:03:04 -0800
Message-ID: <20150224180303.GG11056@atomide.com>
References: <1424781427-15356-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery7.ore.mailhop.org ([54.149.205.143]:33728 "EHLO
	pmta2.delivery7.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753619AbbBXSL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2015 13:11:59 -0500
Content-Disposition: inline
In-Reply-To: <1424781427-15356-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, nsekhar@ti.com, nm@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150224 04:40]:
> In commit 87517d26d888 ("ARM: dts: dra7-evm: Add extcon nodes for USB")
> we enabled Extcon USB gpio to tackle the USB ID pin and get
> peripheral mode to work.
> 
> But the extcon-gpio-usb driver [1] didn't make it into v4.0
> and this makes the USB driver defer probe indefinitely breaking
> USB Host functionality.
> 
> As a temporary fix we remove the extcon handle from the
> USB controller and add it back when the extcon driver
> merges in v4.1.

Uhh OK, If there are dependencies, can you please start splitting
your patches so the dts changes that cause issues are sent only
after the related driver changes are in Linux next?

Anyways, applying into omap-for-v4.0/fixes.

Tony
 
> [1] - https://lkml.org/lkml/2015/2/2/187
