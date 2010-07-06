From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH resend 1/3] AM35x: Add musb support
Date: Tue, 6 Jul 2010 12:53:06 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044EAADA64@dbde02.ent.ti.com>
References: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com>
 <20100705095015.GP15951@atomide.com> <4C31ADCA.40607@ru.mvista.com>
 <20100705102322.GR15951@atomide.com> <4C31B54F.6040109@ru.mvista.com>
 <20100705104841.GS15951@atomide.com>
 <19F8576C6E063C45BE387C64729E7394044EAAD8F6@dbde02.ent.ti.com>
 <20100705134552.GD15951@atomide.com> <4C31F135.5060108@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52378 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194Ab0GFHXS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 03:23:18 -0400
In-Reply-To: <4C31F135.5060108@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

Hi,
> >>>>> If a Kconfig option is needed for optionally compiling in the
> support
> >>>>> for am35x musb, it should be called USB_MUSB_AM35X or similar that
> >>>>> gets selected if the boards using it are selected.
> 
> >>>>    Do you mean that we should have this option in
> 
> >>> drivers/usb/musb/Kconfig?
> 
> >>> Yeah, it could be set automatically with default y if
> >>> MACH_AM35X_SOME_BOARD.
> 
> >>> Then options like this should not be mutually exclusive like they
> >>> currently are for musb, that breaks using musb with multi omap.
> 
> >> Choosing USB_MUSB_AM35X would anyways compile am35x.c and not
> omap2430.c
> >> File; thus musb would not work on OMAP3x boards with same binary.
> 
> > You should set up things so both can be compiled in, that's standard
> > behaviour for all Linux drivers :)
> 
>    This is much easier said than done.

Tony,

As musb controllers are quite different between OMAPs and AM35x so it
would be difficult in terms of software maintenance with such approach.

Some of the major changes in AM35x are,
	- Has builtin USB PHY
	- It doesn't use Mentor DMA but uses CPPI4.1 DMA
	- Has set of wrapper register which are not present on OMAPs.
	- Doesn't have SYSCONFIG registers which are present on OMAPs.
	- Has bytewise read limitation which is not applicable to OMAPs.

Musb on AM35x is actually quite similar to musb on DA8xx family of
Devices.

I can update the patches to use USB_MUSB_AM35X config within 
drivers/usb/musb/ but that would still not be able to compile in
Both omapx and am35x stuff in single binary.

Thanks,
Ajay 
 
> 
> >> I will update the patches and submit for further reviews.
> 
> > Thanks,
> > Tony
> 
> WBR, Sergei
