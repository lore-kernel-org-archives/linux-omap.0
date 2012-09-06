From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Thu, 6 Sep 2012 04:05:08 +0200
Message-ID: <201209060405.08997.marex@denx.de>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com> <201209050513.08588.marex@denx.de> <20120905233416.GP1303@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:60020 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760158Ab2IFCFN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 22:05:13 -0400
In-Reply-To: <20120905233416.GP1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Bryan Wu <bryan.wu@canonical.com>, AnilKumar Ch <anilkumar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, rpurdie@rpsys.net, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

Hi Tony,

> * Marek Vasut <marex@denx.de> [120904 20:13]:
> > Dear Bryan Wu,
> > 
> > > On Sat, Sep 1, 2012 at 4:16 PM, AnilKumar Ch <anilkumar@ti.com> wrote:
> > > > Adopt pinctrl support to leds-gpio driver based on leds-gpio
> > > > device pointer, pinctrl driver configure SoC pins to GPIO
> > > > mode according to definitions provided in .dts file.
> > > 
> > > Thanks for this, actually Marek Vasut submitted a similar patch
> > > before. I'm pretty fine with this patch.
> > 
> > Thanks for submitting this actually ... I didn't have time to properly
> > investigate this.
> > 
> > > But without proper DT setting, it will also give us warning I think.
> > > or we can provide some dummy functions as a temp solution as Shawn
> > > pointed out before.
> > 
> > But this driver is also used on hardware that's not yet coverted to DT,
> > so I'd say dev_warn() if CONFIG_OF is enabled and otherwise simply go on
> > ? Actually, can we not skip whole this pinctrl thing if CONFIG_OF is
> > disabled? Actually (2), what's the relationship between OF and pinctrl?
> 
> The warning should be pinctrl related as the pinctrl drivers may not be
> device tree based drivers.

Exactly my concern. Also the warning shouldnt be present on systems where 
pinctrl is disabled.

> Regards,
> 
> Tony

Best regards,
Marek Vasut
