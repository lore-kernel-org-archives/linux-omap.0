From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/3] drivers/misc: introduce face detection module
 driver(fdif)
Date: Sat, 26 Nov 2011 07:04:18 -0800
Message-ID: <20111126150418.GA11680@kroah.com>
References: <1322281904-14526-1-git-send-email-tom.leiming@gmail.com>
 <1322281904-14526-4-git-send-email-tom.leiming@gmail.com>
 <20111126111247.43cb5d35@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51786 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752620Ab1KZPTZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Nov 2011 10:19:25 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 359FE20BFF
	for <linux-omap@vger.kernel.org>; Sat, 26 Nov 2011 10:19:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20111126111247.43cb5d35@lxorguk.ukuu.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, tom.leiming@gmail.com, tony@atomide.com, arnd@arndb.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ming Lei <ming.lei@canonical.com>

On Sat, Nov 26, 2011 at 11:12:47AM +0000, Alan Cox wrote:
> On Sat, 26 Nov 2011 12:31:44 +0800
> tom.leiming@gmail.com wrote:
> 
> > From: Ming Lei <ming.lei@canonical.com>
> > 
> > One face detection IP[1] is integared inside OMAP4 SoC, so
> > introduce this driver to make face detection function work
> > on OMAP4 SoC.
> > 
> > This driver is platform independent, so in theory can
> > be used to drive same IP module on other platforms.
> > 
> > [1], ch9 of OMAP4 TRM
> > 
> > Signed-off-by: Ming Lei <ming.lei@canonical.com>
> 
> If you are submitting it then it ought to have your sign off too. This
> looks hardly ready for submission however.
> 
> > +config FDIF
> > +	tristate "Face Detection module"
> > +	help
> > +	  The FDIF is a face detection module, which can be integrated into
> > +	  SoCs to detect the location of human beings' face in one image. At
> > +	  least now, TI OMAP4 has the module inside.
> 
> So we have a completelt device specific API for what is becoming a more
> general feature and on some hardware is tied to camera and the like. This
> seems wrong
> 
> IMHO this should be part of video4linux because that'll make the
> integrated stuff work sanely and for your cases it still provided the
> right kind of mmap and format interfaces you need.

I agree, as-is, this isn't ok, sorry, please work with the v4l
developers on this.

greg k-h
