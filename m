From: David Brownell <david-b@pacbell.net>
Subject: Re: Problems with jffs2 rootfs using 2.6.28-rc3
Date: Fri, 7 Nov 2008 13:30:43 -0800
Message-ID: <200811071330.44168.david-b@pacbell.net>
References: <5e088bd90811071209w6fb1b6c0y689d589819104862@mail.gmail.com> <200811071246.17303.david-b@pacbell.net> <5e088bd90811071321v5bc2b4adm2b89eebf1f3f906c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:24209 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751415AbYKGVaq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 16:30:46 -0500
In-Reply-To: <5e088bd90811071321v5bc2b4adm2b89eebf1f3f906c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 07 November 2008, Steve Sakoman wrote:
> On Fri, Nov 7, 2008 at 12:46 PM, David Brownell <david-b@pacbell.net> wrote:
> > On Friday 07 November 2008, Steve Sakoman wrote:
> >> I'm having little success.  It used to work back in 2.6.26 timeframe
> >> but seems to have broken sometime during 2.6.27.
> >
> > There's a patch floating around making the omap2 NAND driver
> > use readsw not readsl, which might explain that problem...
> 
> Do you recall where you saw that patch?  Here or linux-mtd?  My
> initial search efforts weren't successful.

On linux-omap.  Or just look at the driver to see the
readsl()... it's a one-liner.

