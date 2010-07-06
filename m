From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH resend 1/3] AM35x: Add musb support
Date: Tue, 6 Jul 2010 10:57:09 +0300
Message-ID: <20100706075707.GC3192@atomide.com>
References: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com>
 <20100705095015.GP15951@atomide.com>
 <4C31ADCA.40607@ru.mvista.com>
 <20100705102322.GR15951@atomide.com>
 <4C31B54F.6040109@ru.mvista.com>
 <20100705104841.GS15951@atomide.com>
 <19F8576C6E063C45BE387C64729E7394044EAAD8F6@dbde02.ent.ti.com>
 <20100705134552.GD15951@atomide.com>
 <4C31F135.5060108@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044EAADA64@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50268 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab0GFH5Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 03:57:16 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044EAADA64@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

* Gupta, Ajay Kumar <ajay.gupta@ti.com> [100706 10:17]:
>
> As musb controllers are quite different between OMAPs and AM35x so it
> would be difficult in terms of software maintenance with such approach.

Hmm, this is all pretty standard stuff..
 
> Some of the major changes in AM35x are,
> 	- Has builtin USB PHY

Register the PHY from platform data.

> 	- It doesn't use Mentor DMA but uses CPPI4.1 DMA

Register DMA functions from platform data.

> 	- Has set of wrapper register which are not present on OMAPs.

Yeah tusb6010 has the same problem, but that's already dealt with
I believe.

> 	- Doesn't have SYSCONFIG registers which are present on OMAPs.
> 	- Has bytewise read limitation which is not applicable to OMAPs.

Sounds like this has been mostly dealt with already with tusb6010.
 
> Musb on AM35x is actually quite similar to musb on DA8xx family of
> Devices.
> 
> I can update the patches to use USB_MUSB_AM35X config within 
> drivers/usb/musb/ but that would still not be able to compile in
> Both omapx and am35x stuff in single binary.

Sounds like we should first fix thing before adding new code
that will make fixing the basic issues harder.

Tony
