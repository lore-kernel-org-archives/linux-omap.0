From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch-v2.6.39 08/12] usb: otg: OMAP4430: Introducing suspend
 function for power management
Date: Fri, 18 Feb 2011 09:48:58 +0200
Message-ID: <20110218074857.GY14574@legolas.emea.dhcp.ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
 <1297946329-9353-9-git-send-email-balbi@ti.com>
 <20110217191339.GO14574@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:55373 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752881Ab1BRHtG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 02:49:06 -0500
Content-Disposition: inline
In-Reply-To: <20110217191339.GO14574@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Hema HK <hemahk@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Feb 17, 2011 at 09:13:39PM +0200, Felipe Balbi wrote:
> On Thu, Feb 17, 2011 at 02:38:45PM +0200, Felipe Balbi wrote:
> > From: Hema HK <hemahk@ti.com>
> > 
> > Introduced the suspend/resume function for the OMAP4430 internal PHY.
> > This will be used by the twl6030-usb transceiver driver.
> > Moved the clock enable/disable function calls and power on/off of the PHY
> > code from power on/off functions to suspend/resume function.
> > 
> > Pass the suspend function through board data for OMAP4430sdp and OMAP4panda.
> > This will be used by the twl6030-usb transceiver driver.
> > 
> > Signed-off-by: Hema HK <hemahk@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> Tony, care to ack so I can take this via Greg's tree ?

ping ??

-- 
balbi
