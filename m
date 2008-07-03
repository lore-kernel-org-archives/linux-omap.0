From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP3: Fix warnings in clock34xx.h
Date: Thu, 3 Jul 2008 13:47:30 +0300
Message-ID: <20080703104727.GR14276@atomide.com>
References: <485FCA78.9000209@googlemail.com> <alpine.DEB.1.00.0806231308020.4919@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52593 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbYGCMe6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:34:58 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806231308020.4919@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Paul Walmsley <paul@pwsan.com> [080623 22:10]:
> On Mon, 23 Jun 2008, Dirk Behme wrote:
> 
> > Fix warnings
> > 
> > arch/arm/mach-omap2/clock34xx.h:178: warning: initialization makes pointer
> > from integer without a cast
> > arch/arm/mach-omap2/clock34xx.h:204: warning: initialization makes pointer
> > from integer without a cast
> > arch/arm/mach-omap2/clock34xx.h:229: warning: initialization makes pointer
> > from integer without a cast
> > arch/arm/mach-omap2/clock34xx.h:2238: warning: initialization makes pointer
> > from integer without a cast
> > 
> > Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> 
> Thanks, Dirk.
> 
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Hmm, I guess this depends on some other patch? I can't find
usbhost_sar_fck in clock34xx.h?

Tony


> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
