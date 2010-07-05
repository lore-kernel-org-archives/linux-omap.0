From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH resend 1/3] AM35x: Add musb support
Date: Mon, 5 Jul 2010 17:24:30 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044EAAD8F6@dbde02.ent.ti.com>
References: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com>
 <20100705095015.GP15951@atomide.com> <4C31ADCA.40607@ru.mvista.com>
 <20100705102322.GR15951@atomide.com> <4C31B54F.6040109@ru.mvista.com>
 <20100705104841.GS15951@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42820 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171Ab0GELyi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 07:54:38 -0400
In-Reply-To: <20100705104841.GS15951@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

> > >>   I think Ajay has explained why it's needed. The option is
> > >>necessary in one or another form.
> >
> > >It's not needed for omaps, we can already build in support for
> > >omap2, omap3 and omap4 into the same kernel binary.
> >
> >    Not with AM35x USB support merged -- at least you won't be able
> > to build single kernel with monolithic MUSB support.
> 
> Right. I believe musb is pretty much the only remaining driver
> that won't behave with multi-omap. But let's not merge code that
> would make fixing that even harder.
> 
> > >If a Kconfig option is needed for optionally compiling in the support
> > >for am35x musb, it should be called USB_MUSB_AM35X or similar that
> > >gets selected if the boards using it are selected.
> >
> >    Do you mean that we should have this option in
> drivers/usb/musb/Kconfig?
> 
> Yeah, it could be set automatically with default y if
> MACH_AM35X_SOME_BOARD.
> 
> Then options like this should not be mutually exclusive like they
> currently are for musb, that breaks using musb with multi omap.

Choosing USB_MUSB_AM35X would anyways compile am35x.c and not omap2430.c
File; thus musb would not work on OMAP3x boards with same binary.

I will update the patches and submit for further reviews.

Thanks,
Ajay
> 
> Regards,
> 
> Tony
> 

