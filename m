From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: Suspend/Resume support with Omap2fb
Date: Fri, 13 Mar 2009 11:13:56 +0200
Message-ID: <1236935636.457.2.camel@tubuntu>
References: <19F8576C6E063C45BE387C64729E73940427C5206B@dbde02.ent.ti.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63827 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbZCMJON (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 05:14:13 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940427C5206B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2009-03-13 at 10:10 +0100, ext Hiremath, Vaibhav wrote:
> 
> Thanks,
> Vaibhav Hiremath
> 
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Friday, March 13, 2009 2:01 PM
> > To: Hiremath, Vaibhav
> > Cc: linux-omap@vger.kernel.org
> > Subject: RE: Suspend/Resume support with Omap2fb
> > 
> > Hi,
> > 
> > On Thu, 2009-03-12 at 19:26 +0100, ext Hiremath, Vaibhav wrote:
> > > Hi,
> > >
> > > Finally I could able to find the root-cause, actually some of the
> > previous observations miss-led me to dig into power management,
> > suspend/resume path and clock structure. But after bit debugging and
> > with the help of Sanjeev, we got the rid of it.
> > >
> > > The issue is with DSS2 library, inside function
> > "dpi_display_suspend". It calls dispc_enable_lcd_out(0), but doesn't
> > wait till the frame-done interrupt. And due to this I was getting
> > some abrupt behavior in suspend/resume path.
> > > Actually in the beginning I overlooked legacy frame-buffer driver,
> > which handles this scenario perfectly.
> > 
> > dispc_enable_lcd_out(0) waits for FRAMEDONE. Please use the latest
> > DSS2
> > version from my git repository =).
> > 
> [Hiremath, Vaibhav] Ohhh great, but I think yesterday only I pulled changes from your repository, and it was not there. 
> 
> Ok, but it's great that you merged the change.

No, it's been there for quite a while... (weeks, months, I don't
remember).

 Tomi


