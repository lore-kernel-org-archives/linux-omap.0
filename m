From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Tue, 19 Aug 2008 09:20:34 +0300
Message-ID: <20080819062020.GC17276@atomide.com>
References: <20080818.180829.145776296.Hiroshi.DOYU@nokia.com> <EBA93F3E4CB46947A4C5275F6308CF3E03435165@dlee15.ent.ti.com> <5d5443650808181020l19e9bce2g9ccb59979f626a93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54674 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbYHSGUl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 02:20:41 -0400
Content-Disposition: inline
In-Reply-To: <5d5443650808181020l19e9bce2g9ccb59979f626a93@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, "Woodruff, Richard" <r-woodruff2@ti.com>, felipe.contreras@gmail.com, siarhei.siamashka@nokia.com, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

* Trilok Soni <soni.trilok@gmail.com> [080818 20:21]:
> Hi Vijay,
> 
> On Mon, Aug 18, 2008 at 10:42 PM, Pasam, Vijay <vpasam@ti.com> wrote:
> > Hi Hiroshi,
> >
> >> Yes, "dspgateway" won't support OMAP3 but if I remember
> >> correctly that TWL is already in OMAP2? and also does Camera
> >> use the same mechanism of this MMU? This may be benefit or a
> >> must, I guess..
> >
> > I agree. If we are certain that camera driver or some other driver uses
> > MMU the same way bridge does and the MMU architecture is the same, it
> > makes sense to make this generic code. My point is that if DSPGateway
> > doesn't use TWL, it will not benefit from using the Bridge MMU code
> > which has TWL enabled.
> >
> 
> I think recently some one from TI posted OMAP3 camera driver at
> linux-v4l2 mailing list and which I think was using camera MMU, but
> not the common MMU framework it seems from the description. They
> should first start converting to the common MMU infrastructure then.
> 
> http://lists-archives.org/video4linux/23215-omap3-camera-driver.html

We must make the MMU framework generic for the coprocessors, otherwise
maintenance will be a nightmare and the code will never get merged
upstream.

Tony
