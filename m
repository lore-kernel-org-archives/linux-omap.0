From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC] DSS2: Need to make dsi, sdi, rfbi as platform drivers
 instead of a library in omapdss driver
Date: Wed, 16 Jun 2010 14:38:20 +0300
Message-ID: <1276688300.12438.22.camel@tubuntu.research.nokia.com>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703042888D6@dbde02.ent.ti.com>
	 <19F8576C6E063C45BE387C64729E7394044E852E04@dbde02.ent.ti.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703042888F8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60082 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758563Ab0FPLit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 07:38:49 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703042888F8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-06-16 at 12:52 +0200, ext Guruswamy, Senthilvadivu wrote:
> Hi,
> 
> When I started with RFC patch "DSS: Movement of base addr, silicon specific 
> data from driver to platform_device",  I see a lot of encapsulation of OMAP
> DSS IPs into the "omapdss" driver.
> 
> The previous RFC patch would only be good enough to handle base address and
> IRQ for multi-omap.  But it won't address the PRCM power management handled
> in HWMOD APIs.
> 
> The encapsulation of all the DSS IPs like RFBI, DSI, SDI, VENC into omapdss
> driver would prevent these drivers being handled from the platform database.
> 
> For Eg:  
> HWMOD adaptation to DSS would not be possible unless these libraries are made 
> as platform drivers.
> 	HWMOD would provide dynamic usage of multi-omap data like base addr,irq.
> 	HWMOD would also manage the PRCM clocks needed for the dss.
> 
> I would make an RFC patch by introducing these IPs as platform drivers which
> would comply and ease for HWMOD adpatation. 
> 
> Before I go ahead make the changes in the code, I would like to get opinions
> on this proposed changes.

I haven't looked at how HWMODs work, but I don't see any downsides to
having the DSS HW modules as platform devices, if that is required.

But the interface modules (DSI/DPI/RFBI/SDI) will still be tightly
connected to the core DSS module, even if they are separate drivers. I'm
not sure what complexities this may bring.

This also raises the question that should the interface modules each
have a bus of their own? This is something I've pondered for a long
time, and sounds to me to be a cleaner architecture, but it may be a
bigger change.

 Tomi


