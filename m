From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Suspend/Resume support with Omap2fb
Date: Fri, 13 Mar 2009 14:47:42 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940427C52071@dbde02.ent.ti.com>
References: <1236935636.457.2.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60836 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758001AbZCMJR5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 05:17:57 -0400
In-Reply-To: <1236935636.457.2.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Friday, March 13, 2009 2:44 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: RE: Suspend/Resume support with Omap2fb
> 
> On Fri, 2009-03-13 at 10:10 +0100, ext Hiremath, Vaibhav wrote:
> >
> > Thanks,
> > Vaibhav Hiremath
> >
> > > -----Original Message-----
> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > Sent: Friday, March 13, 2009 2:01 PM
> > > To: Hiremath, Vaibhav
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: RE: Suspend/Resume support with Omap2fb
> > >
> > > Hi,
> > >
> > > On Thu, 2009-03-12 at 19:26 +0100, ext Hiremath, Vaibhav wrote:
> > > > Hi,
> > > >
> > > > Finally I could able to find the root-cause, actually some of
> the
> > > previous observations miss-led me to dig into power management,
> > > suspend/resume path and clock structure. But after bit debugging
> and
> > > with the help of Sanjeev, we got the rid of it.
> > > >
> > > > The issue is with DSS2 library, inside function
> > > "dpi_display_suspend". It calls dispc_enable_lcd_out(0), but
> doesn't
> > > wait till the frame-done interrupt. And due to this I was
> getting
> > > some abrupt behavior in suspend/resume path.
> > > > Actually in the beginning I overlooked legacy frame-buffer
> driver,
> > > which handles this scenario perfectly.
> > >
> > > dispc_enable_lcd_out(0) waits for FRAMEDONE. Please use the
> latest
> > > DSS2
> > > version from my git repository =).
> > >
> > [Hiremath, Vaibhav] Ohhh great, but I think yesterday only I
> pulled changes from your repository, and it was not there.
> >
> > Ok, but it's great that you merged the change.
> 
> No, it's been there for quite a while... (weeks, months, I don't
> remember).
> 
[Hiremath, Vaibhav] May be I looked into wrong branch, can you please provide in which branch of yours the change is? So that I can validate my changes and make it more close to yours, it will be easy for me to migrate in the future.

>  Tomi
> 
> 

