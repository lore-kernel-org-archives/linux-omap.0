From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 12/13] ARM: OMAP5: Add the build support
Date: Mon, 7 May 2012 09:05:50 +0530
Message-ID: <CAJ7qFSeJc+F5xnW+P5r89yZEZXi8k-LqqnD8R1KEUONqravNBw@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
	<1336029982-31898-13-git-send-email-r.sricharan@ti.com>
	<20120504225857.GB5613@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43590 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752874Ab2EGDfy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 6 May 2012 23:35:54 -0400
Received: by lboj14 with SMTP id j14so3691168lbo.21
        for <linux-omap@vger.kernel.org>; Sun, 06 May 2012 20:35:50 -0700 (PDT)
In-Reply-To: <20120504225857.GB5613@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

Hi Tony,

>> - =A0 =A0 select NEON if ARCH_OMAP3 || ARCH_OMAP4
>> + =A0 =A0 select NEON if ARCH_OMAP3 || ARCH_OMAP4 || ARCH_OMAP5
>> =A0 =A0 =A0 select SERIAL_OMAP
>> =A0 =A0 =A0 select SERIAL_OMAP_CONSOLE
>> =A0 =A0 =A0 select I2C
>
> If we add CONFIG_SOC_OMAP3PLUS and CONFIG_SOC_OMAP4PLUS, then
> this becomes more future proof with select NEON if SOC_OMAP3PLUS.
>
 ok. will change this.

>> +config ARCH_OMAP5
>> + =A0 =A0 bool "TI OMAP5"
>> + =A0 =A0 depends on ARCH_OMAP2PLUS
>> + =A0 =A0 select CPU_V7
>> + =A0 =A0 select ARM_GIC
>> + =A0 =A0 select HAVE_SMP
>
> No need to have depends on ARCH_OMAP2PLUS, it's all inside
> if ARCH_OMAP2PLUS anyways. I removed those already once, but that
> had to be reverted because the patch was doing other things too
> that did not work out too well..
>ll
 ok, will remove this then.

>> +config MACH_OMAP5_SEVM
>> + =A0 =A0 bool "OMAP5 sevm Board"
>> + =A0 =A0 depends on ARCH_OMAP5
>> +
>> =A0config OMAP3_EMU
>> =A0 =A0 =A0 bool "OMAP3 debugging peripherals"
>> =A0 =A0 =A0 depends on ARCH_OMAP3
>
> No need for it here either. Actually, I think this whole chunk
> can be now left out since it's DT based?
>he
 ok, but the concern here was that without this macro
 the print from compress and subsequently early
prints appear broken.

machine_is_omap5_sevm becomes zero without this config and
machine_is_xxxx is used by the macro _DEBUG_LL_ENTRY
uncompress.h.

Thanks,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
