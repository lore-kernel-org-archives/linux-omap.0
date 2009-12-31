From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/5] Enable DSS2 for OMAP3EVM & AM3517
Date: Thu, 31 Dec 2009 10:17:47 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A277BAF@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1261063083-19822-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60660 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755AbZLaEsK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 23:48:10 -0500
In-Reply-To: <1261063083-19822-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Thursday, December 17, 2009 8:48 PM
> To: tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; linux-fbdev-
> devel@lists.sourceforge.net; linux-fbdev@vger.kernel.org; Hiremath,
> Vaibhav
> Subject: [PATCH 0/5] Enable DSS2 for OMAP3EVM & AM3517
> 
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Patch series adds following features -
> 
> 	- Enable DSS2/Fbdev on OMAP3EVM
> 	- Add LQ043T1DG01 panel file
> 	- Enable DSS2/Fbdev on AM3517EVM
> 	- Warning message fix in dss-core
> 	- Kconfig option added to choose between S-Video and CVBS
> output
> 
> TODO -
> 	- V4L2 Display driver ontop of DSS2 (will post in couple of
> days)
> 	- regulator_get for panel-generic.c, which is required to get
> DVI colors
> 	  properly
> 
> Vaibhav Hiremath (5):
>   dss2-core:Warning Fix: core_dump_clocks enclosed under DEBUG_FS
>   OMAP: DSS2: Add Sharp LQ043T1DG01 panel drivers
>   OMAP: Enable DSS2 for OMAP3EVM board
>   AM3517: Enable DSS2 for AM3517EVM board
>   OMAP3EVM: Kconfig option added for selection between SVIDEO and
> CVBS
> 
>  arch/arm/configs/am3517_evm_defconfig              |   53 ++++-
>  arch/arm/configs/omap3_evm_defconfig               |   51 ++++-
>  arch/arm/mach-omap2/board-am3517evm.c              |  142
> +++++++++++
>  arch/arm/mach-omap2/board-omap3evm.c               |  250
> +++++++++++++++++++-
>  drivers/video/omap2/displays/Kconfig               |    6 +
>  drivers/video/omap2/displays/Makefile              |    1 +
>  .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  120
> ++++++++++
>  drivers/video/omap2/dss/Kconfig                    |   15 ++
>  drivers/video/omap2/dss/core.c                     |    2 +
>  9 files changed, 627 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/panel-sharp-
> lq043t1dg01.c
[Hiremath, Vaibhav] 
Tomi,

Any update on this? Can we merge these patches? 
(Of-course except Kconfig changes for TV out selection, actually I am waiting for your comment on this patch.)

Thanks,
Vaibhav

