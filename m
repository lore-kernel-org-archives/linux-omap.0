From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/6 v8]usb: musb: hwmod and runtime pm support for musb
Date: Thu, 17 Feb 2011 13:58:37 +0200
Message-ID: <20110217115818.GC22356@legolas.emea.dhcp.ti.com>
References: <1297924642-3791-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:42256 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752310Ab1BQL6p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 06:58:45 -0500
Content-Disposition: inline
In-Reply-To: <1297924642-3791-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Feb 17, 2011 at 12:07:16PM +0530, Hema HK wrote:
> This patch series makes OMAP2PLUS and AM35x musb module implemented
> in HWMOD FW way. It also implements musb driver to
> use the runtime pm apis for OMAP2PLUS.
> 
> As per the OMAP usbotg specification[1] musb sysconfig register
> has to be set to force idle and force standby when not used
> and set smart idle/standby or no idle/standby during operation.
> otherwise core-off will be prevented by musb.
> 
> [1]: http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf
> 
> This patch series is based on V2.6.38-rc4 + [1] +[2] + [3]
> 
> [1] https://patchwork.kernel.org/patch/513461
> [2] http://www.spinics.net/lists/linux-usb/msg40575.html
> [3] https://patchwork.kernel.org/patch/566751/
> 
> With this patch series tested musb functionality like testusb, masstorage
> OMAP4430SDP, OMAP3430SDP, and OMAP3630 zoom3.Boot and basic usb tested on AM35x.
> 
> Tested global suspend resume for offmode and retention on OMAP3630Zoom3.
> Idle path retention and offmode validation is not done with these patch series.

taken all these. Had to manually fix patch 5/6 though.

-- 
balbi
