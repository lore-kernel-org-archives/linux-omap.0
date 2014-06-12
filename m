From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [media] staging: allow omap4iss to be modular
Date: Thu, 12 Jun 2014 16:15:32 +0200
Message-ID: <7460455.eZRbtzsNrd@wuerfel>
References: <5192928.MkINji4uKU@wuerfel> <7948240.P51u2omQa4@wuerfel> <2046469.GckHavNRr1@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <2046469.GckHavNRr1@avalon>
Sender: linux-media-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, gregkh@linuxfoundation.org, Mauro Carvalho Chehab <m.chehab@samsung.com>, arm@kernel.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 12 June 2014 16:12:17 Laurent Pinchart wrote:
> > From 3a965f4fd5a6b3ef4a66aa4e7c916cfd34fd5706 Mon Sep 17 00:00:00 2001
> > From: Arnd Bergmann <arnd@arndb.de>
> > Date: Tue, 21 Jan 2014 09:32:43 +0100
> > Subject: [PATCH] [media] staging: tighten omap4iss dependencies
> > 
> > The OMAP4 camera support depends on I2C and VIDEO_V4L2, both
> > of which can be loadable modules. This causes build failures
> > if we want the camera driver to be built-in.
> > 
> > This can be solved by turning the option into "tristate",
> > which unfortunately causes another problem, because the
> > driver incorrectly calls a platform-internal interface
> > for omap4_ctrl_pad_readl/omap4_ctrl_pad_writel.
> > 
> > Instead, this patch just forbids the invalid configurations
> > and ensures that the driver can only be built if all its
> > dependencies are built-in.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Should I take this in my tree for v3.17 or would you like to fast-track it ?
> 

I'd actually like to see it in 3.15 as a stable backport if possible,
but definitely in 3.16. What is the normal path for staging/media
but fix patches?

	Arnd
