From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP baseline test results for v3.8-rc6
Date: Fri, 8 Feb 2013 18:29:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081827280.28008@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com> <20130207083217.GA15462@arwen.pp.htv.fi> <79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com> <alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com> <alpine.DEB.2.00.1302081332200.11464@utopia.booyaka.com>
  <79CD15C6BA57404B839C016229A409A83EC071DC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50778 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946611Ab3BHS3k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 13:29:40 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC071DC@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav,

On Fri, 8 Feb 2013, Hiremath, Vaibhav wrote:

> On Fri, Feb 08, 2013 at 20:40:22, Hiremath, Vaibhav wrote:
> > On Fri, Feb 08, 2013 at 19:04:04, Paul Walmsley wrote:
> > > On Fri, 8 Feb 2013, Paul Walmsley wrote:
> > > 
> > > > The point is to try to minimize bootloader dependencies.
> > > 
> > > Also if there are weird bootloader dependendencies that no one can track 
> > > down, we should document them somewhere, maybe underneath 
> > > Documentation/arm/OMAP.
> > > 
> > 
> 
> 
> 
> Paul,
> 
> Have you enabled below options in your defconfig,
> 
> CONFIG_ARM_APPENDED_DTB=y
> CONFIG_ARM_ATAG_DTB_COMPAT=y
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y

For v3.8-rc6, the .config that I'm using is available here:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc6/20130206155004/build/am33xx_only/am33xx_only

The kernel + appended DTB is available here:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc6/20130206155004/build/am33xx_only/uImage-dtb.am335x-bone

The bootlog is available here:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc6/20130206155004/boot/am335xbone/am335xbone_log.txt

> I am sure you must have already enabled it, but still would like to clarify 
> Here.

No problem, thanks for asking.

- Paul
