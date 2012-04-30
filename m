From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: control: Add AM33XX control reg & sec
 clkctrl offset
Date: Mon, 30 Apr 2012 19:40:46 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA0CAEF@DBDE01.ent.ti.com>
References: <1332327499-29946-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204271834260.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33206 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756363Ab2D3Tkz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 15:40:55 -0400
In-Reply-To: <alpine.DEB.2.00.1204271834260.10308@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Apr 28, 2012 at 06:06:40, Paul Walmsley wrote:
> Hi Vaibhav
> 
> On Wed, 21 Mar 2012, Vaibhav Hiremath wrote:
> 
> > Define AM33XX control register, in order to allow access to
> > control register address space, also add CONTROL_SEC_CLK_CTRL
> > register offset; both are required in clock tree data,
> > for wdt0 and timer0 clock source select configuration.
> > 
> > CONTROL.SEC_CLK_CTRL register is provided to select/configure
> > clock input for WDT0 and TIMER0.
> 
> This patch has been updated so it builds, and also updated to add some 
> AM33XX macros needed for the clock tree and to fix some control.h 
> whitespace problems; updated version below.  Could you please take a quick 
> look and see if it is okay with you?
> 

Patch looks ok to me, so you can merge it. 
And thanks for adding sysboot shift/mask bits, one less patch for me :)

Thanks,
Vaibhav
