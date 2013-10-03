From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 0/2] ARM: dts: Add initial support for IGEP AQUILA
Date: Thu, 3 Oct 2013 11:17:59 -0700
Message-ID: <20131003181758.GS8949@atomide.com>
References: <1378824949-18792-1-git-send-email-eballetbo@gmail.com>
 <CAAwP0s2NOswrZPdeM7GG2J3e+2JeQSKUpX3cki+CbF9G4KyTpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57984 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab3JCSSB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Oct 2013 14:18:01 -0400
Content-Disposition: inline
In-Reply-To: <CAAwP0s2NOswrZPdeM7GG2J3e+2JeQSKUpX3cki+CbF9G4KyTpA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

* Javier Martinez Canillas <martinez.javier@gmail.com> [130925 06:18]:
> On Tue, Sep 10, 2013 at 4:55 PM, Enric Balletbo i Serra
> <eballetbo@gmail.com> wrote:
> > From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> >
> > Hi all,
> >
> > These two patches introduces initial support for the IGEP AM335x-based
> > platforms. The first patch add support for IGEP COM AQUILA products, and the
> > second patch add support for the development board.
> >
> > These patches apply on top of bcousson/for_3.12/dts repository.
> >
> > Changes since v2:
> >   * Make it compatible with "isee,am335x-base0033", "isee,am335x-igep0033",
> >     "ti,am33xx" since these boards are manufactured by ISEE not TI. (Javier)
> > Changes since v1:
> >   * Use &node to reference the nodes already defined in dtsi files. (Javier)
> >
> > Best regards,
> >
> > Enric Balletbo i Serra (2):
> >   ARM: dts: AM33XX: Add support for IGEP COM AQUILA
> >   ARM: dts: AM33XX: Add support for IGEP AQUILA EXPANSION board.
> >
> >  arch/arm/boot/dts/Makefile             |   1 +
> >  arch/arm/boot/dts/am335x-base0033.dts  |  16 ++
> >  arch/arm/boot/dts/am335x-igep0033.dtsi | 265 +++++++++++++++++++++++++++++++++
> >  3 files changed, 282 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/am335x-base0033.dts
> >  create mode 100644 arch/arm/boot/dts/am335x-igep0033.dtsi
> >
> > --
> > 1.8.1.2
> >
> 
> Hi Benoit and Tony,
> 
> Any comments on this series? I had already reviewed previous versions
> of the DT and it looks good to me now.
> 
> It would be great if this can make it for 3.13.

Looks good to me, I would assume Benoit will be looking at this
shortly.

Tony
