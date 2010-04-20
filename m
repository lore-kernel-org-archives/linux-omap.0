From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: DSS2 & V4L2
Date: Tue, 20 Apr 2010 12:26:59 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E13780F@dbde02.ent.ti.com>
References: <4BCC4CB0.7090607@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43400 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008Ab0DTG5L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 02:57:11 -0400
In-Reply-To: <4BCC4CB0.7090607@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>


> -----Original Message-----
> From: Gary Thomas [mailto:gary@mlbassoc.com]
> Sent: Monday, April 19, 2010 6:00 PM
> To: linux-omap@vger.kernel.org
> Cc: Tomi Valkeinen; Hiremath, Vaibhav
> Subject: DSS2 & V4L2
> 
> I'm trying to get the DVSDK (3.01.00.03) working.  It uses
> 2.6.32 + DSS2 + V4L2.
> 
> What I'm having trouble with is how to configure/create/setup
> a video overlay such that I get V4L2 device for the display.
> In particular, what magic is required to create /dev/video1?
> 
[Hiremath, Vaibhav] No magic required here, you just need to configure number of Fb's less than 2.
We have created one config option CONFIG_FB_OMAP2_NUM_FBS, which controls number of Fb nodes and rest goes to V4L2, out of total 3 (number of overlays).

Hope this helps you to understand this.

Thanks,
Vaibhav

> Note: I'd be glad to send this question to a more targeted list,
> but the only one mentioned in the DVSDK documentation does not
> really exist :-(
> 
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
