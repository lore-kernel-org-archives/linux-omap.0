From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH v5 0/2] ARM: dts: Add USB host support for Beagle-xm
Date: Thu, 20 Jun 2013 14:11:04 +0000
Message-ID: <B7CE1C39EBFBA0428A012975D4B2FC830B72CECA@DNCE05.ent.ti.com>
References: <1371732374-27191-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371732374-27191-1-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Quadros, Roger" <rogerq@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Thanks Roger,

I'll take them for 3.12. I was already late for my 3.11 pull request.

Regards,
Benoit

>
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 12.654.784

-----Original Message-----
>From: Quadros, Roger
>Sent: Thursday, June 20, 2013 7:46 AM
>To: Cousson, Benoit
>Cc: tony@atomide.com; linux-omap@vger.kernel.org; devicetree-
>discuss@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org; linux-
>kernel@vger.kernel.org; Quadros, Roger
>Subject: [PATCH v5 0/2] ARM: dts: Add USB host support for Beagle-xm
>
>Hi Benoit,
>
>Patch 1 adds USB host support for beagle-XM.
>Patch 2 cleans up pin comments for USB host pins.
>
>Changes in v4:
>- Rebased to todays for_3.11/dts branch
>- added disclaimer about temporary usage of regulator framework for
>GPIO RESET lines.
>
>cheers,
>-roger
>
>Roger Quadros (2):
>  ARM: dts: omap3-beagle-xm: Add USB Host support
>  ARM: dts: omap3-beagle: Make USB host pin naming consistent
>
> arch/arm/boot/dts/omap3-beagle-xm.dts |   81
>+++++++++++++++++++++++++++++----
> arch/arm/boot/dts/omap3-beagle.dts    |   29 +++++++-----
> 2 files changed, 89 insertions(+), 21 deletions(-)
>
>--
>1.7.4.1
