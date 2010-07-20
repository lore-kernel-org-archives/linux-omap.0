From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Re: Omap3 omap3_clk_lock_dpll5() problem
Date: Tue, 20 Jul 2010 16:33:09 +0200
Message-ID: <AANLkTim4-iU46Xb70KbQj5Wj2fwkR-0moz0Z1mlDmafE@mail.gmail.com>
References: <AANLkTinHudaXyhk3qc1sFydzZaGs3PZKW6DObw_acxOc@mail.gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323A2C8DE@dbde02.ent.ti.com>
	<AANLkTim9fOR4G6zpvzNApHS0uW9c5zgmFKJ7IxMC6_2W@mail.gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323A2C917@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33433 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758116Ab0GTOdM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jul 2010 10:33:12 -0400
Received: by bwz1 with SMTP id 1so2899610bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Jul 2010 07:33:11 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2C917@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Adding debug to bootargs
( Kernel command line: mem=128M console=ttyS2,115200n8 noinitrd
root=/dev/mtdblock6 rw rootfstype=jffs2 debug
ip=192.168.90.101:192.168.90.230:192.168.90.1:255.255.255.0::eth0:on
mac=00:19:6f:cc:cc:dd )
doesn't change the output. Do I need a recompile with some kernel config params?

I found some  CPU_FREQ_DEBUG , DEBUG_LL PM_DEBUG, OMAP_LL_DEBUG_NONE,
DEBUG_KERNEL , DEBUG_INFO which might be involved.

The frequencies the board is running are 12MHz crystal, 322MHz (or
166MHz core) and 600MHz MPU.
Sounds not unusual to me (maybe the 600MHz is not as standard as 550MHz).

I also found this in clock34xx_data.c
       /* REVISIT: Not yet ready for OMAP3 */
#if 0
       /* Check the MPU rate set by bootloader */
       clkrate = omap2_get_dpll_rate_24xx(&dpll_ck);
       for (prcm = rate_table; prcm->mpu_speed; prcm++) {
               if (!(prcm->flags & cpu_mask))
                       continue;
               if (prcm->xtal_speed != sys_ck.rate)
                       continue;
               if (prcm->dpll_speed <= clkrate)
                       break;
       }
       curr_prcm_set = prcm;
#endif

2010/7/16 Gadiyar, Anand <gadiyar@ti.com>:
>> Thanks Anand,
>> I don't have any USB working on the board.
>> If this only for this USB - is it save to comment that out?
>>
>
> If you're not using EHCI/OHCI, it ought to be safe to comment
> it out.
>
> My best guess is that you are using some non-standard frequencies
> and you've made changes to the code/bootloader that cause this
> path to not be able to find a good value to program in the DPLL
> configuration registers.
>
> Quite possibly, this is also the cause of your other problems.
> Can you explain what you are doing so we understand the issue
> better?
>
> - Anand
