From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: OMAP AIC23
Date: Wed, 13 Aug 2008 12:07:57 +0530
Message-ID: <001001c8fd0f$20620290$LocalHost@wipultra806>
References: <65e025470808111221w43dad825jf237ce6c0e89bdde@mail.gmail.com> <01ae01c8fc3c$fe070790$LocalHost@wipultra806> <7B4574D56E4ADF438756313E9A172A870D5F0E4D@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47895 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbYHMGiR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Aug 2008 02:38:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>, Yuri Jaeger Monti <yurijm@gmail.com>, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Hunter, Jon" <jon-hunter@ti.com>
To: "Shekhar, Chandra" <x0044955@ti.com>; "Yuri Jaeger Monti" 
<yurijm@gmail.com>; <linux-omap@vger.kernel.org>
Sent: Wednesday, August 13, 2008 8:20 AM
Subject: RE: OMAP AIC23


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


>Looking at the source file "drivers/i2c/chips/tlv320aic23.c" the function 
>"omap_mcbsp3_aic23_clock_init()" is enabling the McBSP sample rate generator in 
>order >to generate the 12MHz system clock to the aic23. I believe that this 
>needs to be done in order to configure the aic23.

>The good news is that there appears to be a simple fix. All we need to do is 
>move the definitions of the macros OMAP_MCBSP_READ and >OMAP_MCBSP_WRITE from 
>mcbsp.c to the header "include/asm-arm/arch-omap/mcbsp.h"

Look like this should be doable.
but we will have two read/write defs in header. one will be Macro and other will 
be function, both mapping to same code.



Doing this and making a couple other minor changes I am now able to build the 
alsa driver successfully for the omap5912 osk. I will submit a patch to the 
list. Let me know what you think.

Cheers
Jon 

