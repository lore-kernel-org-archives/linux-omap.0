From: "Yuri Jaeger Monti" <yurijm@gmail.com>
Subject: OMAP AIC23
Date: Mon, 11 Aug 2008 16:21:24 -0300
Message-ID: <65e025470808111221w43dad825jf237ce6c0e89bdde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:38657 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbYHKTVZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 15:21:25 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4193828wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 11 Aug 2008 12:21:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear fellows,

I'm having some errors trying to compile the current kernel version
for OMAP5912 on AIC23:

...
  CC      drivers/i2c/i2c-core.o
  CC      drivers/i2c/i2c-dev.o
  LD      drivers/i2c/algos/built-in.o
  CC      drivers/i2c/busses/i2c-omap.o
  LD      drivers/i2c/busses/built-in.o
  CC      drivers/i2c/chips/tps65010.o
  CC      drivers/i2c/chips/tlv320aic23.o
drivers/i2c/chips/tlv320aic23.c: In function 'omap_mcbsp3_aic23_clock_init':
drivers/i2c/chips/tlv320aic23.c:113: error: implicit declaration of
function 'OMAP_MCBSP_WRITE'
drivers/i2c/chips/tlv320aic23.c:113: error: 'SPCR1' undeclared (first
use in this function)
drivers/i2c/chips/tlv320aic23.c:113: error: (Each undeclared
identifier is reported only once
drivers/i2c/chips/tlv320aic23.c:113: error: for each function it appears in.)
drivers/i2c/chips/tlv320aic23.c:114: error: 'SPCR2' undeclared (first
use in this function)
drivers/i2c/chips/tlv320aic23.c:117: error: 'PCR0' undeclared (first
use in this function)
drivers/i2c/chips/tlv320aic23.c:120: error: 'SRGR1' undeclared (first
use in this function)
drivers/i2c/chips/tlv320aic23.c:121: error: 'SRGR2' undeclared (first
use in this function)
drivers/i2c/chips/tlv320aic23.c:124: error: implicit declaration of
function 'OMAP_MCBSP_READ'
make[3]: *** [drivers/i2c/chips/tlv320aic23.o] Error 1
make[2]: *** [drivers/i2c/chips] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2

Anyone know what could this be?

Thanks!

--
Yuri Jaeger Monti

The Catholic University at Porto Alegre - PUCRS
(51) 3320.3500 Ramal #7696
