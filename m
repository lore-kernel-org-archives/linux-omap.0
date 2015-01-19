From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MAINTAINERS: add omap2plus_defconfig under OMAP SUPPORT
Date: Mon, 19 Jan 2015 14:05:09 -0800
Message-ID: <20150119220508.GN18552@atomide.com>
References: <1421703901-28295-1-git-send-email-balbi@ti.com>
 <CABxcv=keBgUme5mrNKg_h_h1WZHsaz4QOOyEPLa3XJYaEPE0Jw@mail.gmail.com>
 <20150119215558.GW20386@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50833 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751641AbbASWIk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 17:08:40 -0500
Content-Disposition: inline
In-Reply-To: <20150119215558.GW20386@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

* Felipe Balbi <balbi@ti.com> [150119 13:59]:
> On Mon, Jan 19, 2015 at 10:52:56PM +0100, Javier Martinez Canillas wrote:
> > Hello Felipe,
> > 
> > On Mon, Jan 19, 2015 at 10:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> > > omap2plus_defconfig is also part of the OMAP Support
> > > maintained, because of that it's best to list it
> > > under OMAP SUPPORT on MAINTAINERS so people know
> > > to Cc linux-omap when patching that file.
> > >
> > > Reported-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 97de006f38f0..abc6281892e7 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -6783,6 +6783,7 @@ Q:        http://patchwork.kernel.org/project/linux-omap/list/
> > >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> > >  S:     Maintained
> > >  F:     arch/arm/*omap*/
> > > +F:     arch/arm/configs/omap2plus_defconfig
> > 
> > While been there, could you please also add omap1_defconfig?
> 
> Sure, Tony, is that ok ?

Oh yeah that would be nice :)

Tony
