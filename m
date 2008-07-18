From: "Yuri Jaeger Monti" <yurijm@gmail.com>
Subject: Problems compiling kernel for OSK 5912
Date: Fri, 18 Jul 2008 13:35:38 -0300
Message-ID: <65e025470807180935n5b38881fr98f6ce1f6ceb8f4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.186]:3158 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbYGRQfl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 12:35:41 -0400
Received: by rn-out-0910.google.com with SMTP id k40so167205rnd.17
        for <linux-omap@vger.kernel.org>; Fri, 18 Jul 2008 09:35:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear fellows:

I'm trying to compile the latest git tree and I'm getting the following errors:

arch/arm/mach-omap1/built-in.o: In function `osk_tps_setup':
leds-osk.c:(.text+0x2128): undefined reference to `tps65010_set_gpio_out_value'
leds-osk.c:(.text+0x2164): undefined reference to `tps65010_set_led'
leds-osk.c:(.text+0x2170): undefined reference to `tps65010_set_led'
leds-osk.c:(.text+0x2178): undefined reference to `tps65010_set_low_pwr'
leds-osk.c:(.text+0x2180): undefined reference to `tps65010_config_vregs1'

Can anyone help me with this problem?

Thanks

-- 
Yuri Jaeger Monti

The Catholic University at Porto Alegre - PUCRS
(51) 3320.3500 Ramal #7696
