From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/5] omap device tree changes for v3.6 merge window
Date: Thu, 12 Jul 2012 23:41:48 -0700
Message-ID: <20120713064147.GG1122@atomide.com>
References: <pull-1341925556-888624>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A8BE1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:46376 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2GMGlx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 02:41:53 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9A8BE1@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120712 23:19]:
> Hi Tony,
> 
> On Tue, Jul 10, 2012 at 18:35:55, Tony Lindgren wrote:
> > The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:
> > 
> >   Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-dt-for-v3.6
> > 
> > for you to fetch changes up to f700c4d780f14125f61b70e86d805908efe3fb89:
> > 
> >   arm/dts: New dts file for PandaBoardES (4460) (2012-07-09 05:37:05 -0700)
> > 
> > ----------------------------------------------------------------
> > Device tree related patches for omaps
> > 
> > ----------------------------------------------------------------
> > Afzal Mohammed (1):
> >       arm/dts: am33xx wdt node
> 
> The above patch seems to be an empty one, actual changes in it as in
> original patch [1] is missing, same changes are shown below for your
> reference [2].
> 
> Can you please do the needful so that the intended change of this
> patch makes to mainline this merge window.

Argh. Thanks for letting me know. I must have something wrong with
my scripts when applying patches. We'll have to apply this as a fix.

Regards,

Tony
 
> Regards
> Afzal
> 
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg71644.html
> [2]
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index f46e353..08b2a5b 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -185,5 +185,10 @@
>                         compatible = "ti,omap3-hsmmc";
>                         ti,hwmods = "mmc3";
>                 };
> +
> +               wdt2: wdt@44e35000 {
> +                       compatible = "ti,omap3-wdt";
> +                       ti,hwmods = "wd_timer2";
> +               };
>         };
>  };
