From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OMAP AIC23
Date: Tue, 12 Aug 2008 21:50:21 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A870D5F0E4D@dlee01.ent.ti.com>
References: <65e025470808111221w43dad825jf237ce6c0e89bdde@mail.gmail.com>
 <01ae01c8fc3c$fe070790$LocalHost@wipultra806>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:60237 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbYHMCue convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 22:50:34 -0400
In-Reply-To: <01ae01c8fc3c$fe070790$LocalHost@wipultra806>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shekhar, Chandra" <x0044955@ti.com>, Yuri Jaeger Monti <yurijm@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Chandra,

> i have a question, why a client is modifying mcbsp registers. There is a
> mcbsp
> config function (omap_mcbsp_config) exported which you can use to
> configure mcbsp registers.
> if its an absolute necessity you can use omap_mcbsp_read and
> omap_mcbsp_write
> function. which are defined in arch/arm/plat-omap/mcbsp.c.
> but you need to pass full register name, like OMAP_MCBSP_REG_SPCR1 instead
> of
> just SPCR1 ( 'SPCR1' undeclared  error).


Looking at the source file "drivers/i2c/chips/tlv320aic23.c" the function "omap_mcbsp3_aic23_clock_init()" is enabling the McBSP sample rate generator in order to generate the 12MHz system clock to the aic23. I believe that this needs to be done in order to configure the aic23.

The good news is that there appears to be a simple fix. All we need to do is move the definitions of the macros OMAP_MCBSP_READ and OMAP_MCBSP_WRITE from mcbsp.c to the header "include/asm-arm/arch-omap/mcbsp.h"

Doing this and making a couple other minor changes I am now able to build the alsa driver successfully for the omap5912 osk. I will submit a patch to the list. Let me know what you think.

Cheers
Jon
