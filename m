From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 1/2] ARM: dts: Add SHAM data and documentation for
 AM33XX
Date: Wed, 17 Jul 2013 09:10:23 -0700
Message-ID: <20130717161023.GA12124@animalcreek.com>
References: <1374017368-5267-1-git-send-email-mgreer@animalcreek.com>
 <1374017368-5267-2-git-send-email-mgreer@animalcreek.com>
 <51E620AE.8090602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from p3plsmtpa06-10.prod.phx3.secureserver.net ([173.201.192.111]:59267
	"EHLO p3plsmtpa06-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753901Ab3GQQKZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jul 2013 12:10:25 -0400
Content-Disposition: inline
In-Reply-To: <51E620AE.8090602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

On Wed, Jul 17, 2013 at 10:12:22AM +0530, Lokesh Vutla wrote:
> Hi Mark,

Hi Lokesh.

> On Wednesday 17 July 2013 04:59 AM, Mark A. Greer wrote:
> > From: "Mark A. Greer" <mgreer@animalcreek.com>

> > diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> > index 0c8ad17..b04aea1 100644
> > --- a/arch/arm/boot/dts/am335x-evmsk.dts
> > +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> > @@ -401,4 +401,7 @@
> >  &cpsw_emac1 {
> >  	phy_id = <&davinci_mdio>, <1>;
> >  	phy-mode = "rgmii-txid";
> > +
> > +&sham {
> > +	status = "okay";
>  "};" is missing here.
> >  };

Ugh, yeah, I somehow mess that out.

Thanks for pointing that out.

Mark
--
