From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: OMAP AIC23
Date: Tue, 12 Aug 2008 11:03:44 +0530
Message-ID: <01ae01c8fc3c$fe070790$LocalHost@wipultra806>
References: <65e025470808111221w43dad825jf237ce6c0e89bdde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34999 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbYHLFd7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Aug 2008 01:33:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yuri Jaeger Monti <yurijm@gmail.com>, linux-omap@vger.kernel.org

Hi,
answers below.

----- Original Message ----- 
From: "Yuri Jaeger Monti" <yurijm@gmail.com>
To: <linux-omap@vger.kernel.org>
Sent: Tuesday, August 12, 2008 12:51 AM
Subject: OMAP AIC23


> Dear fellows,
>
> I'm having some errors trying to compile the current kernel version
> for OMAP5912 on AIC23:
>
> ...
>  CC      drivers/i2c/i2c-core.o
>  CC      drivers/i2c/i2c-dev.o
>  LD      drivers/i2c/algos/built-in.o
>  CC      drivers/i2c/busses/i2c-omap.o
>  LD      drivers/i2c/busses/built-in.o
>  CC      drivers/i2c/chips/tps65010.o
>  CC      drivers/i2c/chips/tlv320aic23.o
> drivers/i2c/chips/tlv320aic23.c: In function 'omap_mcbsp3_aic23_clock_init':
> drivers/i2c/chips/tlv320aic23.c:113: error: implicit declaration of
> function 'OMAP_MCBSP_WRITE'

Recently there wre some changes in McBSP driver for multi-omap support. Earlier 
read/write calls used to be
defined as a macro and now it has been converted to a function, hence the 
compilation error (implicit declaration of
function 'OMAP_MCBSP_WRITE') .  you can look for recent patches for
arch/arm/plat-omap/mcbsp.c file.

i have a question, why a client is modifying mcbsp registers. There is a mcbsp 
config function (omap_mcbsp_config) exported which you can use to
configure mcbsp registers.
if its an absolute necessity you can use omap_mcbsp_read and omap_mcbsp_write 
function. which are defined in arch/arm/plat-omap/mcbsp.c.
but you need to pass full register name, like OMAP_MCBSP_REG_SPCR1 instead of 
just SPCR1 ( 'SPCR1' undeclared  error).


> drivers/i2c/chips/tlv320aic23.c:113: error: 'SPCR1' undeclared (first
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:113: error: (Each undeclared
> identifier is reported only once
> drivers/i2c/chips/tlv320aic23.c:113: error: for each function it appears in.)
> drivers/i2c/chips/tlv320aic23.c:114: error: 'SPCR2' undeclared (first
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:117: error: 'PCR0' undeclared (first
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:120: error: 'SRGR1' undeclared (first
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:121: error: 'SRGR2' undeclared (first
> use in this function)
> drivers/i2c/chips/tlv320aic23.c:124: error: implicit declaration of
> function 'OMAP_MCBSP_READ'
> make[3]: *** [drivers/i2c/chips/tlv320aic23.o] Error 1
> make[2]: *** [drivers/i2c/chips] Error 2
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
>
> Anyone know what could this be?
>
> Thanks!
>
> --
> Yuri Jaeger Monti
>
> The Catholic University at Porto Alegre - PUCRS
> (51) 3320.3500 Ramal #7696
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

