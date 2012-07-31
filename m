From: Archit Taneja <a0393947@ti.com>
Subject: Re: Issue with DSS power domain always in ON state
Date: Tue, 31 Jul 2012 18:57:21 +0530
Message-ID: <5017DD39.6000509@ti.com>
References: <CAKvrXUp6+CcEt51nN-fm8xmcTx7LG2di59pULsCmbnimYVWPow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34527 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612Ab2GaN2n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 09:28:43 -0400
In-Reply-To: <CAKvrXUp6+CcEt51nN-fm8xmcTx7LG2di59pULsCmbnimYVWPow@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hi,

On Tuesday 31 July 2012 06:22 AM, Juha Kuikka wrote:
> Hello,
>
> I am running the l-o (55936cdfaaf11ac352b56bc58e42d6661e65ee13) with following:
> - ARM: OMAP3: Add OMAP3_HAS_IVA_REGS feature
> - ARM: OMAP3: Use OMAP3_HAS_IVA_REGS with OMAP3503
> - OMAPDSS: PM runtime fixes for 3.5-rc
>
> Using omap2plus_defconfig.
> - Minus EHCI
> - Minus ADS7846
> - Minus SMP
> - Plus initramfs
>
> Running on Gumstix Overo Earth (OMP3503).
>
> My problem is that while suspend (with the above patches) seems to
> function the debug counters for DSS do not indicate retention or off
> mode.
>
> What happens:
>
> / # cat /debug/pm_debug/count
> usbhost_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
> per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> neon_pwrdm (ON),OFF:0,RET:464,INA:0,ON:465,RET-LOGIC-OFF:0
> mpu_pwrdm (ON),OFF:0,RET:464,INA:0,ON:465,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
> usbhost_clkdm->usbhost_pwrdm (1)
> sgx_clkdm->sgx_pwrdm (0)
> per_clkdm->per_pwrdm (18)
> cam_clkdm->cam_pwrdm (0)
> dss_clkdm->dss_pwrdm (1)
> d2d_clkdm->core_pwrdm (0)
> iva2_clkdm->iva2_pwrdm (0)
> mpu_clkdm->mpu_pwrdm (0)
> core_l4_clkdm->core_pwrdm (24)
> core_l3_clkdm->core_pwrdm (4)
> neon_clkdm->neon_pwrdm (0)
> / # echo mem > /sys/power/state
> [   41.891540] PM: Syncing filesystems ... done.
> [   41.910003] Freezing user space processes ... (elapsed 0.01 seconds) done.
> [   41.935607] Freezing remaining freezable tasks ... (elapsed 0.02
> seconds) done.
> [   41.966796] Suspending console(s) (use no_console_suspend to debug)
> [   42.098388] PM: suspend of devices complete after 119.872 msecs
> [   42.102722] PM: late suspend of devices complete after 4.272 msecs
> [   42.109222] PM: noirq suspend of devices complete after 6.469 msecs
> [   44.625213] Successfully put all powerdomains to target state
> [   44.628753] PM: noirq resume of devices complete after 3.295 msecs
> [   44.632995] PM: early resume of devices complete after 2.685 msecs
> [   45.050598] PM: resume of devices complete after 417.449 msecs
> [   45.100341] Restarting tasks ... done.
> / # cat /debug/pm_debug/count
> usbhost_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> core_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
> per_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> neon_pwrdm (ON),OFF:0,RET:616,INA:0,ON:617,RET-LOGIC-OFF:0
> mpu_pwrdm (ON),OFF:0,RET:616,INA:0,ON:617,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
> usbhost_clkdm->usbhost_pwrdm (1)
> sgx_clkdm->sgx_pwrdm (0)
> per_clkdm->per_pwrdm (18)
> cam_clkdm->cam_pwrdm (0)
> dss_clkdm->dss_pwrdm (1)
> d2d_clkdm->core_pwrdm (0)
> iva2_clkdm->iva2_pwrdm (0)
> mpu_clkdm->mpu_pwrdm (0)
> core_l4_clkdm->core_pwrdm (24)
> core_l3_clkdm->core_pwrdm (4)
> neon_clkdm->neon_pwrdm (0)
>
> In the defconfig DSS is built as a module. After building it (and
> PANEL_GENERIC) into kernel the situation does not change.
>
> Strangely the core domain is able to go to retention (or off if
> enabled) even though DSS isn't.

I see similar behaviour on 3430sdp in the mainline kernel, with OMAPDSS 
not built in.

At bootup, the registers PM_PWSTCTRL_DSS and PM_PWSTST_DSS show the 
states as RET and ON respectively.

On doing echo mem > /sys/power/state, and putting a print in 
omap3_pm_suspend() in pm34xx.c for each power domain after setting the 
new power state, I get:

[   86.683532] power domain wkup_pwrdm, next 1 reg 3
[   86.683563] power domain iva2_pwrdm, next 1 reg 1
[   86.683563] power domain mpu_pwrdm, next 1 reg 3
[   86.683563] power domain neon_pwrdm, next 1 reg 3
[   86.683593] power domain cam_pwrdm, next 1 reg 1
[   86.683593] power domain dss_pwrdm, next 1 reg 3
[   86.683593] power domain per_pwrdm, next 1 reg 3
[   86.683624] power domain core_pwrdm, next 1 reg 3
[   86.683624] power domain sgx_pwrdm, next 1 reg 0
[   86.683654] power domain usbhost_pwrdm, next 1 reg 3

where next represents the next power state to be set (by 
pwrst->next_state) and reg represents the value of the domain's PWSTST 
register (by pwrdm_read_pwrst(pwrst->pwrdm))

It looks like DSS(and others) don't go to the desired states. Any ideas 
on this?

Archit

>
> Suspend _seems_ to work but I only see a meager 10mA reduction (from
> 80mA to 70mA) in the current to the gumstix so I'm suspicious.
>
> Can anyone shed any light on this?
>
>   - Juha
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

