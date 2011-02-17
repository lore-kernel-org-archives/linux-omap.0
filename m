From: Felipe Balbi <balbi@ti.com>
Subject: Re: [1/7 v4] usb: otg: enable regulator only on cable/device
 connect
Date: Thu, 17 Feb 2011 14:20:11 +0200
Message-ID: <20110217122011.GD22356@legolas.emea.dhcp.ti.com>
References: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:35671 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752020Ab1BQMUS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 07:20:18 -0500
Content-Disposition: inline
In-Reply-To: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Feb 17, 2011 at 12:06:04PM +0530, Hema HK wrote:
> From: Kalliguddi, Hema <hemahk@ti.com>
> 
> Remove the regulator enable while driver loading and enable it only when
> the cable/device is connected and disable it when disconnected.
> 
> Remove the configuration of config_state and config_trans register
> configuration as these registers are programmed when regulator 
> enable/disable is called.
> 
> Signed-off-by: Hema HK <hemahk@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Taken these 7. Tested and it works fine.

-- 
balbi
