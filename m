From: Felipe Balbi <balbi@ti.com>
Subject: Re: [1/7 v4] usb: otg: enable regulator only on cable/device
 connect
Date: Thu, 17 Feb 2011 14:31:04 +0200
Message-ID: <20110217123104.GF22356@legolas.emea.dhcp.ti.com>
References: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:38494 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750995Ab1BQMbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 07:31:09 -0500
Content-Disposition: inline
In-Reply-To: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Feb 17, 2011 at 12:06:04PM +0530, Hema HK wrote:
> From: Kalliguddi, Hema <hemahk@ti.com>

You name is twisted in all this series, this will make git log look
weird:

Hema HK (1):
      usb: musb: Using runtime pm APIs for musb.

Kalliguddi, Hema (7):
      usb: otg: enable regulator only on cable/device connect
      usb: otg: Remove one unnecessary I2C read request.
      usb: otg: OMAP4430: Add phy_suspend function pointer to twl4030_usb_data
      usb: otg: OMAP4430: Introducing suspend function for power management
      usb: otg: TWL6030: Introduce the twl6030_phy_suspend function.
      usb: otg: TWL6030 Save the last event in otg_transceiver
      usb: musb: OMAP4430: Fix usb device detection if connected during boot

I'll fix myself this time, but check those details too from now on.

-- 
balbi
