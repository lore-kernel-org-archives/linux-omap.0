From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [i2c] i2c 2 issues on omap3430
Date: Mon, 25 Aug 2008 11:41:03 +0300
Message-ID: <31e679430808250141h3f03c75dq84c6ad0406a57939@mail.gmail.com>
References: <ef0d8a250808250005sbf8bb8cg9cfacc6a6f2b4195@mail.gmail.com>
	 <ef0d8a250808250018w587c2de0s726511c52c0794e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:17754 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbYHYIlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 04:41:06 -0400
Received: by ug-out-1314.google.com with SMTP id c2so474502ugf.37
        for <linux-omap@vger.kernel.org>; Mon, 25 Aug 2008 01:41:03 -0700 (PDT)
In-Reply-To: <ef0d8a250808250018w587c2de0s726511c52c0794e3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: i2c@lm-sensors.org, linux-omap@vger.kernel.org

Hi,

On Mon, Aug 25, 2008 at 10:18 AM, naveen krishna ch
<naveenkrishna.ch@gmail.com> wrote:
>
>
> Hi,
>     I am facing some i2c issues on omap3430 with linux 2.6.24 kernel.
>
>     My device is a slave sitting on I2C2 of OMAP3430.
>
>     I am observing the following,
>
>      1) Sometimes i get "i2c_omap.2: controller timed out"
>
>                    i2c_omap.2: No acknowledmentif i use i2c 2 at 100khz
>         and i dont find them when i run at 400khz.
>
>      2) Sometimes the i2c write and read succeeds but data received is junk.
>
>      3) The I2C reads are not consistent. with same image if i boot several
> times

I think most of this (if not all of them) are fixed in current
linux-omap git tree.
Could you try that out and report if the same error appears on linux-omap
HEAD ?

Care to keep linux-omap@vger.kernel.org on the loop

>
>
>         The readed values keep variying.
>
>       I am not sure what could be the problem. The mux settings seems okay.
>
>      The client creation seems fine. Can any one suggest me the exact
>      i2c bus registration steps. right now i only have
>
>
>
> omap_register_i2c_bus(1, CONFIG_I2C_OMAP34XX_HS_BUS1, NULL, 0);
>
> in the board file. and
>
> MUX configurations in the
>
> arch/arm/plat-omap/i2c.c
> arch/arm/mach-omap2/mux.c
> include/asm/arch/mux.h
>
>
>
> files
>
>      Am i missing something?
>
>      Please advice,




-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
