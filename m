From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: [RFC] DSS2: Need to make dsi, sdi, rfbi as platform drivers instead
 of a library in omapdss driver
Date: Wed, 16 Jun 2010 16:22:01 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703042888F8@dbde02.ent.ti.com>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703042888D6@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E7394044E852E04@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35300 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888Ab0FPKwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 06:52:18 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E852E04@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi,

When I started with RFC patch "DSS: Movement of base addr, silicon specific 
data from driver to platform_device",  I see a lot of encapsulation of OMAP
DSS IPs into the "omapdss" driver.

The previous RFC patch would only be good enough to handle base address and
IRQ for multi-omap.  But it won't address the PRCM power management handled
in HWMOD APIs.

The encapsulation of all the DSS IPs like RFBI, DSI, SDI, VENC into omapdss
driver would prevent these drivers being handled from the platform database.

For Eg:  
HWMOD adaptation to DSS would not be possible unless these libraries are made 
as platform drivers.
	HWMOD would provide dynamic usage of multi-omap data like base addr,irq.
	HWMOD would also manage the PRCM clocks needed for the dss.

I would make an RFC patch by introducing these IPs as platform drivers which
would comply and ease for HWMOD adpatation. 

Before I go ahead make the changes in the code, I would like to get opinions
on this proposed changes.

Current dss driver:
-------------------
1.  Omapdss platform driver
	- initialises necessary Ips dss, dispc.
	- also initialises Ips like sdi, dsi, venc, rfbi
	- creates a custom bus and registers the display devices/drivers
	connected on the board to the custom bus.

2.  Suspend/resume of omapdss
	- in turn sends suspend/resume calls for each of the display devices
	registered to it.

	
Proposed change:
----------------
Omapdss platform driver
 	- initialises necessary Ips dss, dispc.
	- continues to have a custom bus and registers the display devices 
	and drivers connected on the board to the custom bus.
	- continues to handle suspend/resume of the display devices registerd
	to the custom bus.

Dsi platform driver
	- initialises DSI IP alone
	- handles suspend/resume as a platform driver.  
		The implementation gets tricky on how to know that the panels 
		connected to it is also in suspended/resumed state.

SDI platform driver
	- initialises SDI IP alone
	- handles suspend/resume as a platform driver.  
		The implementation gets tricky on how to know that the panels 
		connected to it is also in suspended/resumed state.

RFBI platform driver
	- initialises RFBI IP alone
	- handles suspend/resume as a platform driver.  
		The implementation gets tricky on how to know that the panels 
		connected to it is also in suspended/resumed state.	

DPI platform driver
	- initialises DPI IP
	- should also take care of dsi pll inits from the dsi platform driver.
	- handles suspend/resume as a platform driver.  
		The implementation gets tricky on how to know that the panels 
		connected to it is also in suspended/resumed state.

Regards,
Senthil