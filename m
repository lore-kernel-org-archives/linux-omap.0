From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/2] omap overo related device tree changes for v3.15
Date: Mon, 17 Mar 2014 09:50:26 -0700
Message-ID: <20140317165026.GB30471@atomide.com>
References: <20140313200135.GA5981@atomide.com>
 <20140313200253.GB5981@atomide.com>
 <201403171518.43389.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10659 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751448AbaCQQud (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2014 12:50:33 -0400
Content-Disposition: inline
In-Reply-To: <201403171518.43389.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [140317 07:22]:
> On Thursday 13 March 2014, Tony Lindgren wrote:
> > The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691:
> > 
> >   Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/dt-overo-signed
> > 
> > for you to fetch changes up to 28b191118c11719bb27db621425a70be28a40e08:
> > 
> >   ARM: dts: Add support for the Overo Summit (2014-03-12 10:21:16 -0700)
> > 
> > ----------------------------------------------------------------
> > Updates to the .dts files to support more Gumstix boards.
> > 
> > These are sent separately from the rest of the .dts changes
> > as these depend on the fixes merged into v3.14-rc4, and
> > needed a bit more time to get updated on the fixes.
> 
> Pulled into next/dt, thanks!
> 
> I had a trivial merge conflict in omap3-overo.dtsi that I resolved as below.
> 
> 	Arnd
> 
> diff --cc arch/arm/boot/dts/omap3-overo.dtsi
> index b08142f,c37b130..69ca7c4
> --- a/arch/arm/boot/dts/omap3-overo.dtsi
> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
> @@@ -91,11 -33,3 +33,6 @@@
>         };
>   };
>   
> - &uart3 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&uart3_pins>;
> - };
> - 
>  +&mcbsp2 {
>  +      status = "okay";
>  +};

Looks good to me thanks, and looks like I merged it wrong in
my omap-for-v3.15/tmp-merge as mcbsp2 is not defined in
omap3-overo-common-peripherals.dtsi.

Regards,

Tony
