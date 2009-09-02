From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH][RFC] OMAP3: PM: Adding OSWR support
Date: Wed, 2 Sep 2009 14:42:50 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9AF1BFD@dbde02.ent.ti.com>
References: <1251391962-11217-1-git-send-email-thara@ti.com>
 <20090828160636.GK25828@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F9A455D7@dbde02.ent.ti.com>
 <010201ca2b5c$897481a0$507018ac@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbZIBJM6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Sep 2009 05:12:58 -0400
In-Reply-To: <010201ca2b5c$897481a0$507018ac@am.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghongdemath, Girish" <girishsg@ti.com>, 'Tony Lindgren' <tony@atomide.com>, "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Girish
 >
 >-----Original Message-----
 >From: Ghongdemath, Girish 
 >Sent: Wednesday, September 02, 2009 5:03 AM
 >To: Sripathy, Vishwanath; 'Tony Lindgren'; Gopinath, Thara
 >Cc: linux-omap@vger.kernel.org
 >Subject: RE: [PATCH][RFC] OMAP3: PM: Adding OSWR support
 >
 >
 >
 >> -----Original Message-----
 >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
 >> Sripathy, Vishwanath
 >> Subject: RE: [PATCH][RFC] OMAP3: PM: Adding OSWR support
 >> 
 >> OSWR stands for Open Switch With Retention.
 >> This is one of the target power states where logic is lost for all the modules in the power domain
 >> except for the ones with Built in retention Flip Flops. This is the main difference between OFF and
 >
 >So, this's supported for CORE, PER and MPU?
 >
 >-Girish
OSWR is supported for only for Core and MPU domains (in SW). PER will be in OFF state when Core is in OSWR.
