From: Heikki Krogerus <heikki.krogerus@nokia.com>
Subject: Re: [patch-v2.6.39 12/12] usb: otg: notifier: switch to atomic
 notifier
Date: Fri, 25 Feb 2011 13:32:24 +0200
Message-ID: <20110225113224.GD30637@esdhcp034230>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
 <1297946329-9353-13-git-send-email-balbi@ti.com>
 <20110225104653.GA30637@esdhcp034230>
 <20110225105013.GB30637@esdhcp034230>
 <20110225105317.GE4190@legolas.emea.dhcp.ti.com>
 <20110225110741.GC30637@esdhcp034230>
 <20110225112400.GF4190@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:21473 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab1BYLc3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 06:32:29 -0500
Content-Disposition: inline
In-Reply-To: <20110225112400.GF4190@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <balbi@ti.com>
Cc: Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Feb 25, 2011 at 01:24:00PM +0200, ext Felipe Balbi wrote:
> On Fri, Feb 25, 2011 at 01:07:41PM +0200, Heikki Krogerus wrote:
> > On Fri, Feb 25, 2011 at 12:53:17PM +0200, ext Felipe Balbi wrote:
> > > > > drivers/power/twl4030_charger.c will need to be made atomic notifier
> > > > > safe.
> > > 
> > > oops, that thing is doing i2c transfers. Would you care to send a patch
> > > since you have that hardware easily available ??
> > 
> > I can make a patch for this if you like, but I don't have the hw.
> 
> Aha, I got confused with the isp1710, sorry. If you can cook a patch
> please do and Cc Grazvydas Ignotas <notasas@gmail.com> when you send it
> ;-)

OK, np.

-- 
heikki
