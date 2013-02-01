From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4] ARM: OMAP2+: AM33XX: omap2plus_defconfig: Add
 support for few drivers
Date: Fri, 1 Feb 2013 10:42:59 -0800
Message-ID: <20130201184259.GN22517@atomide.com>
References: <1357202279-6094-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EAF03E7@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:61988 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755858Ab3BASnC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 13:43:02 -0500
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EAF03E7@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* AnilKumar, Chimata <anilkumar@ti.com> [130118 03:23]:
> On Thu, Jan 03, 2013 at 14:07:59, AnilKumar, Chimata wrote:
> > Adds tps65910 PMIC, lis3lv02d accelerometer, tsl2550 ambient light sensor,
> > tmp275 temperature sensor, matrix keypad, gbio based leds and D_CAN drivers
> > support. These peripherals are present on AM33XX family of devices (EVM,
> > BeagleBone and EVMSK). One has to manually enable these support to use the
> > drivers, so this patch enables all the drivers in omap2plus_defconfig
> 
> Hi Tony,
> 
> Could you please pull this patch, if there are no further comments?

Thanks applying into omap-for-v3.9/board.

Regards,

Tony
