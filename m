From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 23:50:22 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870251066D3A@dbde02.ent.ti.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
  <1228926833.32014.162.camel@localhost.localdomain>
  <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>
  <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
  <20081211005733.GZ18138@atomide.com>
  <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
 <5e088bd90812110940k158b14dbq6ea9ff4138e52dfb@mail.gmail.com>
 <alpine.DEB.2.00.0812111110250.26754@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43100 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYLKSVP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 13:21:15 -0500
In-Reply-To: <alpine.DEB.2.00.0812111110250.26754@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>, Jeff Steele <jsteele@coloradocollege.edu>

Paul

>-----Original Message-----
>From: Paul Walmsley [mailto:paul@pwsan.com]
>Sent: Thursday, December 11, 2008 12:15 PM
>To: Pandita, Vikram
>Cc: Steve Sakoman; Tony Lindgren; linux-omap; David Brownell; me@felipebalbi.com; Jeff Steele
>Subject: Re: status of USB on omap35xx ?
>
>Hi Vikram,
>
>looking at ehci-omap.c lines 190-204.  Is there some reason why the
>USBHOST clockdomain needs to be in software-supervised mode?  Also, is
>there some reason why the interface clock must be prevented from
>auto-idling?  This will cause problems with power management.

All these checks were in place for initial debugging. 
There is no need to keep these check now.

>
>
>- Paul
>
>	/* PRCM settings for USBHOST:
>	 * Interface clk un-related to domain transition
>	 */
>	cm_write_mod_reg(0 << OMAP3430ES2_AUTO_USBHOST_SHIFT,
>				OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
>
>	/* Disable sleep dependency with MPU and IVA */
>	cm_write_mod_reg((0 << OMAP3430ES2_EN_MPU_SHIFT) |
>				(0 << OMAP3430ES2_EN_IVA2_SHIFT),
>				OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
>
>	/* Disable Automatic transition of clock */
>	cm_write_mod_reg(0 << OMAP3430ES2_CLKTRCTRL_USBHOST_SHIFT,
>				OMAP3430ES2_USBHOST_MOD, CM_CLKSTCTRL);
>
>
>
>

