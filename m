From: Juha Kuikka <juha.kuikka@gmail.com>
Subject: Issue with DSS power domain always in ON state
Date: Mon, 30 Jul 2012 17:52:35 -0700
Message-ID: <CAKvrXUp6+CcEt51nN-fm8xmcTx7LG2di59pULsCmbnimYVWPow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51437 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765Ab2GaAwg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 20:52:36 -0400
Received: by obbuo13 with SMTP id uo13so9792389obb.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 17:52:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hello,

I am running the l-o (55936cdfaaf11ac352b56bc58e42d6661e65ee13) with following:
- ARM: OMAP3: Add OMAP3_HAS_IVA_REGS feature
- ARM: OMAP3: Use OMAP3_HAS_IVA_REGS with OMAP3503
- OMAPDSS: PM runtime fixes for 3.5-rc

Using omap2plus_defconfig.
- Minus EHCI
- Minus ADS7846
- Minus SMP
- Plus initramfs

Running on Gumstix Overo Earth (OMP3503).

My problem is that while suspend (with the above patches) seems to
function the debug counters for DSS do not indicate retention or off
mode.

What happens:

/ # cat /debug/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:464,INA:0,ON:465,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:464,INA:0,ON:465,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (18)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (24)
core_l3_clkdm->core_pwrdm (4)
neon_clkdm->neon_pwrdm (0)
/ # echo mem > /sys/power/state
[   41.891540] PM: Syncing filesystems ... done.
[   41.910003] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   41.935607] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   41.966796] Suspending console(s) (use no_console_suspend to debug)
[   42.098388] PM: suspend of devices complete after 119.872 msecs
[   42.102722] PM: late suspend of devices complete after 4.272 msecs
[   42.109222] PM: noirq suspend of devices complete after 6.469 msecs
[   44.625213] Successfully put all powerdomains to target state
[   44.628753] PM: noirq resume of devices complete after 3.295 msecs
[   44.632995] PM: early resume of devices complete after 2.685 msecs
[   45.050598] PM: resume of devices complete after 417.449 msecs
[   45.100341] Restarting tasks ... done.
/ # cat /debug/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:0,RET:616,INA:0,ON:617,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:616,INA:0,ON:617,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (18)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (24)
core_l3_clkdm->core_pwrdm (4)
neon_clkdm->neon_pwrdm (0)

In the defconfig DSS is built as a module. After building it (and
PANEL_GENERIC) into kernel the situation does not change.

Strangely the core domain is able to go to retention (or off if
enabled) even though DSS isn't.

Suspend _seems_ to work but I only see a meager 10mA reduction (from
80mA to 70mA) in the current to the gumstix so I'm suspicious.

Can anyone shed any light on this?

 - Juha
