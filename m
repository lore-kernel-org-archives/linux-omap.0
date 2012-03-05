From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Ethernet problems on AM3517, possible regression?
Date: Mon, 5 Mar 2012 09:32:22 -0800 (PST)
Message-ID: <1330968742.99498.YahooMailNeo@web125205.mail.ne1.yahoo.com>
References: <1330488712.31452.YahooMailNeo@web125205.mail.ne1.yahoo.com> <1330536469.53752.YahooMailNeo@web125203.mail.ne1.yahoo.com> <1330621988.48456.YahooMailNeo@web125202.mail.ne1.yahoo.com> <1330643793.82609.YahooMailNeo@web125204.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm23-vm2.bullet.mail.ne1.yahoo.com ([98.138.91.211]:31101 "HELO
	nm23-vm2.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753321Ab2CERcY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Mar 2012 12:32:24 -0500
In-Reply-To: <1330643793.82609.YahooMailNeo@web125204.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

******

Sorry this is almost certainly going to the wrong place for this post t=
o land.=A0 I'm still trying to sort out how to properly use this list.=A0=
 I have tried subscribing, but that tends to flood my inbox with everyt=
hing going on here.=A0 That's great, but timewise I haven't been able t=
o follow it closely enough to keep it sorted at the moment.=A0 Is there=
 a way to simply subscribe to certain threads, like those one posts or =
replies to?=A0 Once I unsubscribed from the list, I started receiving n=
o messages - even responses to questions I ask, etc.=A0 :-(=A0 Thanks.
******


Hi Igor,


Thanks for your reply!=A0 So are both ports working on the CM-T3517 sim=
ultaneously now?=A0 Looking at the latest board file for the CM-T3517 (=
arch/arm/mach-omap2/board-cm-t3517.c), I don't see either the SMSC or t=
he EMAC ports being initialized.=A0 Has that initialization code been m=
oved somewhere else in the kernel?

Regarding the patches:=A0 I had actually seen those (in the previous "v=
ersion #2" I believe), and applied them to our kernel.=A0 If you take a=
 look at my board file below, you'll notice I defined a "USE_ALT__EMAC_=
ETH" definition that causes the separate EMAC file (created by those pa=
tches) to be used.=A0 I've tried both the old and the new (separate fil=
e) way of doing this.=A0 Our EMAC does work fine, as does our SMSC, exc=
ept our SMSC does not store a MAC address.=A0 They just do not work tog=
ether.=A0 One or the other must be disabled (commented out of the code)=
 or neither work.

It appears to me that the problem with running both is the mdio id sett=
ing.=A0 Perhaps they're both demanding the same slot or something?

Thanks again for your reply.=A0 Please let me if I'm looking in the wro=
ng place for any of this or have this mixed up.


----- Original Message -----
=46rom: CF Adad <cfadad@rocketmail.com>
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc:=20
Sent: Thursday, March 1, 2012 6:16 PM
Subject: Ethernet problems on AM3517, possible regression?

We have both a CompuLab CM-T3517 and a Technexion TAM-3517 at the shop.=
=A0 Both boards provide dual Ethernet support in an identical fashion.=A0=
 One port uses the onboard EMAC tied to an SMSC LAN87xx series PHY.=A0 =
The other is the old trusty SMSC LAN911X hooked up to the GPMC.

Both boards support both interfaces when loaded with their respective T=
I PSP-based images.=A0 These unfortunately date clear back to 2.6.37 or=
 even 2.6.32 however.=A0 When upgrading to the 3.x series linux-omap ke=
rnel, we noticed we could get one or the other of these to work, _but n=
ot both simultaneously_.=A0 If both are enabled in code, neither work.

Even when we can get one or the other working, we seem to be having som=
e problems with autonegotiation and MAC addressing.=A0 MAC addresses on=
 the SMSC are still random.=A0 On the EMAC port, as you can see from ou=
r code below, we have put a patch in that is letting us establish a fix=
ed MAC address.=A0 However, I'm not sure this is a proper method to use=
 at this point.

We suspect issues are known to exist with the Ethernet ports as the CM-=
T3517 has mainlined Linux support, and its latest board file does not s=
how any configuration for either Ethernet interface.=A0 Support from th=
e previous kernel versions has apparently been removed, despite patches=
 being applied to it as recently as mid-last year:=A0 http://lists.infr=
adead.org/pipermail/linux-arm-kernel/2011-May/050430.html

We also suspect this is being caused by an address conflict of some sor=
t between the two ports.=A0 We are using a linux-omap kernel, version 3=
=2E2.0-rc6 that is a month or two old now.=A0 We've been monitoring thi=
s list, and have noted that some changes have been checked in for SMSC,=
 but have not been able to update our kernel source as we were in the m=
idst of a heavy debugging exercise that ended late last evening.=A0 We =
plan to migrate to the latest HEAD soon.=A0 Neverthelss, we've not seen=
 any of these board files update.=A0 So, we're assuming there are still=
 known issues here.

I have attached the relevant sections of the board file we've created=20
for the TAM-3517 (the one we've played with the most) below.=A0 It is b=
ased off the=20
older board files from the TI PSP and various configurations we have se=
en in similar hardware
board files (overo, am3517_evm, cm-t3517, etc.)=A0 If you note the=20
configurable defines at the top, we've tied various combinations of cod=
e
with no success to date.


Would you folks please take a look?=A0 Any help would be appreciated.=A0=
 Thanks!

-----------------------------------------------------------------------=
------------------------------------------
__NOTES:__

***When we run with just the SMSC enabled, the device works:
=2E..
[=A0=A0=A0 1.119415] smsc911x: Driver version 2008-10-21
[=A0=A0=A0 1.126739] smsc911x-mdio: probed
[=A0=A0=A0 1.130554] smsc911x smsc911x: eth0: attached PHY driver [SMSC=
 LAN8700] (mii_bus:phy_addr=3Dffffffff:01, irq=3D-1)
[=A0=A0=A0 1.142456] smsc911x smsc911x: eth0: MAC Address: d6:b4:7d:2c:=
03:40
=2E..
root@board:~# ifdown eth0
root@board:~# ifup eth0
[=A0 187.145019] smsc911x smsc911x: eth0: SMSC911x/921x identified at 0=
xd086e000, IRQ: 313
=2E..
(*NOTE: the MAC address is random!)

***When we run with just the EMAC enabled, the device works:
=2E..
[=A0=A0=A0 1.184112] davinci_mdio davinci_mdio.0: davinci mdio revision=
 1.5
[=A0=A0=A0 1.190612] davinci_mdio davinci_mdio.0: detected phy mask fff=
ffffe
[=A0=A0=A0 1.197998] davinci_mdio.0: probed
[=A0=A0=A0 1.201690] davinci_mdio davinci_mdio.0: phy[0]: device 0:00, =
driver SMSC LAN8710/LAN8720
=2E..
[=A0 213.613555] davinci_mdio davinci_mdio.0: resetting idled controlle=
r
[=A0 213.621704] net eth0: attached PHY driver [SMSC LAN8710/LAN8720] (=
mii_bus:phy_addr=3D0:00, id=3D7c0f1)
[=A0 215.621917] PHY: 0:00 - Link is Up - 100/Full
=2E..

*** When we run with BOTH enabled, they show in boot but neither works:
[=A0=A0=A0 1.135864] smsc911x: Driver version 2008-10-21
[=A0=A0=A0 1.143249] smsc911x-mdio: probed
[=A0=A0=A0 1.147064] smsc911x smsc911x: eth0: attached PHY driver [SMSC=
 LAN8700] (mii_bus:phy_addr=3Dffffffff:01, irq=3D-1)
[=A0=A0=A0 1.158966] smsc911x smsc911x: eth0: MAC Address: 7e:92:21:13:=
be:ec
[=A0=A0=A0 1.207580] davinci_mdio davinci_mdio.0: davinci mdio revision=
 1.5
[=A0=A0=A0 1.214080] davinci_mdio davinci_mdio.0: detected phy mask fff=
ffffe
[=A0=A0=A0 1.221405] davinci_mdio.0: probed
[=A0=A0=A0 1.225097] davinci_mdio davinci_mdio.0: phy[0]: device 0:00, =
driver SMSC LAN8710/LAN8720
=2E..
root@board:~# ifup eth0
ifconfig: SIOCSIFFLAGS: Input/output error
ifconfig: SIOCSIFFLAGS: Input/output error
=2E..
root@board:~# ifup eth1
[ 1034.624603] net eth1: PHY already attached
[ 1034.628936] net eth1: could not connect to phy ffffffff:01



-----------------------------------------------------------------------=
------------------------------------------

/*
=A0* linux/arch/arm/mach-omap2/board-tam3517.c
=A0*
=A0* Copyright (C) 2011
=A0* Author: Technexion + others
=A0*
=A0* Based on mach-omap2/board-tam3517.c from Technexion BSP release
=A0*
=A0* This program is free software; you can redistribute it and/or modi=
fy it
=A0* under the terms of the GNU General Public License as=A0 published =
by the
=A0* Free Software Foundation version 2.
=A0*
=A0* This program is distributed "as is" WITHOUT ANY WARRANTY of any ki=
nd,
=A0* whether express or implied; without even the implied warranty of
=A0* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See the GN=
U
=A0* General Public License for more details.
=A0*/

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/clk.h>
#include <linux/platform_device.h>
#include <linux/delay.h>
#include <linux/gpio.h>
#include <linux/mtd/mtd.h>
#include <linux/mtd/nand.h>
#include <linux/mtd/partitions.h>
#include <linux/can/platform/ti_hecc.h>

#include <linux/mmc/host.h>

#include <linux/regulator/machine.h>
#include <linux/regulator/fixed.h>

#include <mach/hardware.h>

#include <asm/mach-types.h>
#include <asm/mach/arch.h>
#include <asm/mach/map.h>

#include <plat/board.h>
#include "common.h"
#include <plat/usb.h>
#include <plat/nand.h>
#include <plat/gpmc.h>

#include <mach/am35xx.h>

#include "mux.h"
#include "control.h"
#include "hsmmc.h"

/* custom settings */
#define ENABLE_EMAC_ETH=A0=A0=A0 1 // this messes with the SMSC right n=
ow
#define USE_ALT__EMAC_ETH=A0=A0=A0 0

#define ENABLE_SMSC_ETH=A0=A0=A0 1 // this messes with the EMAC right n=
ow
#define USE_ALT__SMSC_ETH=A0=A0=A0 0

{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
{{{{{{{{{{{{{{{{{{{{{{{{{{{=A0=A0=A0 SNIP=A0=A0 }}}}}}}}}}}}}}}}}}}}}}}=
}}}}}}}}}
{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}

/**********************************************************************=
******
=A0*
=A0* SMSC LAN
=A0*
=A0********************************************************************=
********/

#if ENABLE_SMSC_ETH && ( defined(CONFIG_SMSC911X) || defined(CONFIG_SMS=
C911X_MODULE) )

#include <linux/smsc911x.h>
#include <plat/gpmc-smsc911x.h>

#define SMSC911X_GPIO_IRQ 153
#define SMSC911X_GPIO_RESET 142
#define SMSC911X_GPIO_CS 5

#if USE_ALT__SMSC_ETH // gpmc-smsc911x style

static struct omap_smsc911x_platform_data tam3517_smsc911x_cfg =3D {
=A0=A0=A0 .id=A0=A0=A0 =A0=A0=A0 =3D 0,
=A0=A0=A0 .cs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D SMSC911X_GPIO_CS,
=A0=A0=A0 .gpio_irq=A0=A0=A0=A0=A0=A0 =3D SMSC911X_GPIO_IRQ,
=A0=A0=A0 .gpio_reset=A0=A0=A0=A0 =3D -EINVAL,
=A0=A0=A0 .flags=A0=A0=A0 =A0=A0=A0 =3D SMSC911X_USE_32BIT | SMSC911X_S=
AVE_MAC_ADDRESS,
};

static void __init tam3517_init_smsc911x(void)
{
=A0=A0=A0 gpmc_smsc911x_init(&tam3517_smsc911x_cfg);
}

#else // use older style


static struct resource tam3517_smsc911x_resources[] =3D {
=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 .name=A0=A0=A0 =3D "smsc911x-memory",
=A0=A0=A0 =A0=A0=A0 .flags=A0=A0=A0 =3D IORESOURCE_MEM,
=A0=A0=A0 },
=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 .start=A0 =3D OMAP_GPIO_IRQ(SMSC911X_GPIO_IRQ),
=A0=A0=A0 =A0=A0=A0 .end=A0=A0=A0 =3D OMAP_GPIO_IRQ(SMSC911X_GPIO_IRQ),
=A0=A0=A0 =A0=A0=A0 .flags=A0=A0=A0 =3D=A0 (IORESOURCE_IRQ | IRQF_TRIGG=
ER_LOW),
=A0=A0=A0 },
};

static struct smsc911x_platform_config smsc911x_config =3D {
=A0=A0=A0 .phy_interface=A0=A0=A0 =3D PHY_INTERFACE_MODE_MII,
=A0=A0=A0 .irq_polarity=A0=A0 =3D SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
=A0=A0=A0 .irq_type=A0=A0=A0=A0=A0=A0 =3D SMSC911X_IRQ_TYPE_OPEN_DRAIN,
=A0=A0=A0 .flags=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D SMSC911X_USE_16BIT | SM=
SC911X_SAVE_MAC_ADDRESS,
};

static struct platform_device tam3517_smsc911x_device =3D {
=A0=A0=A0 .name=A0=A0=A0 =A0=A0=A0 =3D "smsc911x",
=A0=A0=A0 .id=A0=A0=A0 =A0=A0=A0 =3D -1,
=A0=A0=A0 .num_resources=A0=A0=A0 =3D ARRAY_SIZE(tam3517_smsc911x_resou=
rces),
=A0=A0=A0 .resource=A0=A0=A0 =3D tam3517_smsc911x_resources,
=A0=A0=A0 .dev=A0=A0=A0 =A0=A0=A0 =3D {
=A0=A0=A0 =A0=A0=A0 .platform_data =3D &smsc911x_config,
=A0=A0=A0 },
};

static void __init tam3517_init_smsc911x(void)
{
=A0=A0=A0 unsigned long cs_mem_base;

=A0=A0=A0 if (gpmc_cs_request(SMSC911X_GPIO_CS, SZ_16M, &cs_mem_base) <=
 0) {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "Failed request for GPMC mem for sm=
sc911x\n");
=A0=A0=A0 =A0=A0=A0 return;
=A0=A0=A0 }

=A0=A0=A0 tam3517_smsc911x_resources[0].start =3D cs_mem_base + 0x0;
=A0=A0=A0 tam3517_smsc911x_resources[0].end=A0=A0 =3D cs_mem_base + 0xF=
=46;

=A0=A0=A0 if ((gpio_request(SMSC911X_GPIO_IRQ, "smsc911x irq") =3D=3D 0=
) &&
=A0=A0=A0 =A0=A0=A0 (gpio_direction_input(SMSC911X_GPIO_IRQ) =3D=3D 0))=
 {
=A0=A0=A0 =A0=A0=A0 gpio_export(SMSC911X_GPIO_IRQ, 0);
=A0=A0=A0 } else {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "could not obtain gpio for SMSC911X=
 IRQ\n");
=A0=A0=A0 =A0=A0=A0 return;
=A0=A0=A0 }

=A0=A0=A0 omap_mux_init_gpio(SMSC911X_GPIO_IRQ, OMAP_PIN_INPUT_PULLUP |=
 OMAP_MUX_MODE4);
=A0=A0=A0 gpio_direction_input(SMSC911X_GPIO_IRQ);

=A0=A0=A0 // next 2 lines redundant?
=A0=A0=A0 tam3517_smsc911x_resources[1].start =3D OMAP_GPIO_IRQ(SMSC911=
X_GPIO_IRQ);
=A0=A0=A0 tam3517_smsc911x_resources[1].end=A0 =3D OMAP_GPIO_IRQ(SMSC91=
1X_GPIO_IRQ);
=A0=A0=A0 omap_mux_init_gpio(SMSC911X_GPIO_RESET, OMAP_PIN_INPUT_PULLUP=
|OMAP_MUX_MODE4);

=A0=A0=A0 if (gpio_request(SMSC911X_GPIO_RESET, "smsc911x reset") < 0)
=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 printk(KERN_ERR "can't get smsc911x reset GPIO\n");
=A0=A0=A0 =A0=A0=A0 return;
=A0=A0=A0 }
=A0=A0=A0=20
=A0=A0=A0 gpio_direction_output(SMSC911X_GPIO_RESET, 0);
=A0=A0=A0 mdelay(1);
=A0=A0=A0 gpio_direction_output(SMSC911X_GPIO_RESET, 1);

}

#endif // USE_ALT__SMSC_ETH

#else
static inline void __init tam3517_init_smsc911x(void) { return; }
#endif

/**********************************************************************=
******
=A0*
=A0* EMAC LAN
=A0*
=A0********************************************************************=
********/
#if ENABLE_EMAC_ETH

#include <linux/davinci_emac.h>

#define AM35XX_EVM_MDIO_FREQUENCY=A0=A0=A0 (1000000)

#if USE_ALT__EMAC_ETH // Use new standalone EMAC code for generic AM35x=
x?

#include "am35xx-emac.h"

#else // Use original Davinci EMAC code

static struct resource tam3517_mdio_resources[] =3D {
=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 .start=A0 =3D AM35XX_IPSS_EMAC_BASE + AM35XX_EMAC_M=
DIO_OFFSET,
=A0=A0=A0 =A0=A0=A0 .end=A0=A0=A0 =3D AM35XX_IPSS_EMAC_BASE + AM35XX_EM=
AC_MDIO_OFFSET +
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 SZ_4K - 1,
=A0=A0=A0 =A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
=A0=A0=A0 },
};

static struct mdio_platform_data tam3517_mdio_pdata =3D {
=A0=A0=A0 .bus_freq=A0=A0=A0 =3D AM35XX_EVM_MDIO_FREQUENCY,
};

static struct platform_device tam3517_mdio_device =3D {
=A0=A0=A0 .name=A0=A0=A0 =A0=A0=A0 =3D "davinci_mdio",
=A0=A0=A0 .id=A0=A0=A0 =A0=A0=A0 =3D 0,
=A0=A0=A0 .num_resources=A0=A0=A0 =3D ARRAY_SIZE(tam3517_mdio_resources=
),
=A0=A0=A0 .resource=A0=A0=A0 =3D tam3517_mdio_resources,
=A0=A0=A0 .dev.platform_data =3D &tam3517_mdio_pdata,
};

static struct emac_platform_data tam3517_emac_pdata =3D {
=A0=A0=A0 .rmii_en=A0=A0=A0 =3D 1,
};

static struct resource tam3517_emac_resources[] =3D {
=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 .start=A0 =3D AM35XX_IPSS_EMAC_BASE,
=A0=A0=A0 =A0=A0=A0 .end=A0=A0=A0 =3D AM35XX_IPSS_EMAC_BASE + 0x2FFFF,
=A0=A0=A0 =A0=A0=A0 .flags=A0 =3D IORESOURCE_MEM,
=A0=A0=A0 }, {
=A0=A0=A0 =A0=A0=A0 .start=A0 =3D INT_35XX_EMAC_C0_RXTHRESH_IRQ,
=A0=A0=A0 =A0=A0=A0 .end=A0=A0=A0 =3D INT_35XX_EMAC_C0_RXTHRESH_IRQ,
=A0=A0=A0 =A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
=A0=A0=A0 }, {
=A0=A0=A0 =A0=A0=A0 .start=A0 =3D INT_35XX_EMAC_C0_RX_PULSE_IRQ,
=A0=A0=A0 =A0=A0=A0 .end=A0=A0=A0 =3D INT_35XX_EMAC_C0_RX_PULSE_IRQ,
=A0=A0=A0 =A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
=A0=A0=A0 }, {
=A0=A0=A0 =A0=A0=A0 .start=A0 =3D INT_35XX_EMAC_C0_TX_PULSE_IRQ,
=A0=A0=A0 =A0=A0=A0 .end=A0=A0=A0 =3D INT_35XX_EMAC_C0_TX_PULSE_IRQ,
=A0=A0=A0 =A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
=A0=A0=A0 }, {
=A0=A0=A0 =A0=A0=A0 .start=A0 =3D INT_35XX_EMAC_C0_MISC_PULSE_IRQ,
=A0=A0=A0 =A0=A0=A0 .end=A0=A0=A0 =3D INT_35XX_EMAC_C0_MISC_PULSE_IRQ,
=A0=A0=A0 =A0=A0=A0 .flags=A0 =3D IORESOURCE_IRQ,
=A0=A0=A0 },
};

static struct platform_device tam3517_emac_device =3D {
=A0=A0=A0 .name=A0=A0=A0 =A0=A0=A0 =3D "davinci_emac",
=A0=A0=A0 .id=A0=A0=A0 =A0=A0=A0 =3D -1,
=A0=A0=A0 .num_resources=A0=A0=A0 =3D ARRAY_SIZE(tam3517_emac_resources=
),
=A0=A0=A0 .resource=A0=A0=A0 =3D tam3517_emac_resources,
};

static void tam3517_enable_emac_int(void)
{
=A0=A0=A0 u32 regval;

=A0=A0=A0 regval =3D omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
=A0=A0=A0 regval =3D (regval | AM35XX_CPGMAC_C0_RX_PULSE_CLR |
=A0=A0=A0 =A0=A0=A0 AM35XX_CPGMAC_C0_TX_PULSE_CLR |
=A0=A0=A0 =A0=A0=A0 AM35XX_CPGMAC_C0_MISC_PULSE_CLR |
=A0=A0=A0 =A0=A0=A0 AM35XX_CPGMAC_C0_RX_THRESH_CLR);
=A0=A0=A0 omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
=A0=A0=A0 regval =3D omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
}

static void tam3517_disable_emac_int(void)
{
=A0=A0=A0 u32 regval;

=A0=A0=A0 regval =3D omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
=A0=A0=A0 regval =3D (regval | AM35XX_CPGMAC_C0_RX_PULSE_CLR |
=A0=A0=A0 =A0=A0=A0 AM35XX_CPGMAC_C0_TX_PULSE_CLR);
=A0=A0=A0 omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
=A0=A0=A0 regval =3D omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
}

static void tam3517_emac_ethernet_init(void) {
=A0=A0=A0 u32 regval, mac_lo, mac_hi;

=A0=A0=A0 mac_lo =3D omap_ctrl_readl(AM35XX_CONTROL_FUSE_EMAC_LSB);
=A0=A0=A0 mac_hi =3D omap_ctrl_readl(AM35XX_CONTROL_FUSE_EMAC_MSB);

=A0=A0=A0 tam3517_emac_pdata.mac_addr[0] =3D (u_int8_t)((mac_hi & 0xFF0=
000) >> 16);
=A0=A0=A0 tam3517_emac_pdata.mac_addr[1] =3D (u_int8_t)((mac_hi & 0xFF0=
0) >> 8);
=A0=A0=A0 tam3517_emac_pdata.mac_addr[2] =3D (u_int8_t)((mac_hi & 0xFF)=
 >> 0);
=A0=A0=A0 tam3517_emac_pdata.mac_addr[3] =3D (u_int8_t)((mac_lo & 0xFF0=
000) >> 16);
=A0=A0=A0 tam3517_emac_pdata.mac_addr[4] =3D (u_int8_t)((mac_lo & 0xFF0=
0) >> 8);
=A0=A0=A0 tam3517_emac_pdata.mac_addr[5] =3D (u_int8_t)((mac_lo & 0xFF)=
 >> 0);

=A0=A0=A0 tam3517_emac_pdata.ctrl_reg_offset=A0=A0=A0 =A0=A0=A0 =3D AM3=
5XX_EMAC_CNTRL_OFFSET;
=A0=A0=A0 tam3517_emac_pdata.ctrl_mod_reg_offset=A0=A0=A0 =A0=A0=A0 =3D=
 AM35XX_EMAC_CNTRL_MOD_OFFSET;
=A0=A0=A0 tam3517_emac_pdata.ctrl_ram_offset=A0=A0=A0 =A0=A0=A0 =3D AM3=
5XX_EMAC_CNTRL_RAM_OFFSET;
=A0=A0=A0 tam3517_emac_pdata.ctrl_ram_size=A0=A0=A0 =A0=A0=A0 =3D AM35X=
X_EMAC_CNTRL_RAM_SIZE;
=A0=A0=A0 tam3517_emac_pdata.version=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =3D E=
MAC_VERSION_2;
=A0=A0=A0 tam3517_emac_pdata.hw_ram_addr=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =3D=
 AM35XX_EMAC_HW_RAM_ADDR;
=A0=A0=A0 tam3517_emac_pdata.interrupt_enable=A0=A0=A0 =A0=A0=A0 =3D ta=
m3517_enable_emac_int;
=A0=A0=A0 tam3517_emac_pdata.interrupt_disable=A0=A0=A0 =A0=A0=A0 =3D t=
am3517_disable_emac_int;
=A0=A0=A0 tam3517_emac_device.dev.platform_data=A0=A0=A0 =A0=A0=A0 =3D =
&tam3517_emac_pdata;
/* taken care of with platform_add_devices() below
=A0=A0=A0 platform_device_register(&tam3517_emac_device);
=A0=A0=A0 platform_device_register(&tam3517_mdio_device);
*/
=A0=A0=A0 clk_add_alias(NULL, dev_name(&tam3517_mdio_device.dev),
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0 NULL, &tam3517_emac_device.dev);

=A0=A0=A0 regval =3D omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
=A0=A0=A0 regval =3D regval & (~(AM35XX_CPGMACSS_SW_RST));
=A0=A0=A0 omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
=A0=A0=A0 regval =3D omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
}

#endif=A0 // USE_ALT__EMAC_ETH
#endif=A0 // ENABLE_EMAC_ETH

{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
{{{{{{{{{{{{{{{{{{{{{{{{{{{=A0=A0=A0 SNIP=A0=A0 }}}}}}}}}}}}}}}}}}}}}}}=
}}}}}}}}}
{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}

/* --------------------------------------------------------- */

static struct omap_board_config_kernel tam3517_config[] =3D {};

/* --------------------------------------------------------- */
static struct platform_device *tam3517_devices[] __initdata =3D {
#if ENABLE_SMSC_ETH && !(USE_ALT__SMSC_ETH) && ( defined(CONFIG_SMSC911=
X) || defined(CONFIG_SMSC911X_MODULE) )
=A0=A0=A0 &tam3517_smsc911x_device,
#endif
#if 0 && ( defined(CONFIG_CAN_TI_HECC) || defined(CONFIG_CAN_TI_HECC_MO=
DULE) )
=A0=A0=A0 &tam3517_hecc_device,
#endif
=A0=A0=A0 &tam3517_dss_device,
#if ENABLE_EMAC_ETH && !(USE_ALT__EMAC_ETH)
=A0=A0=A0 &tam3517_mdio_device,
=A0=A0=A0 &tam3517_emac_device,
#endif
#if 0 && ( defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPI=
O_MODULE) )
=A0=A0=A0 &tam3517_keys_gpio,
#endif
};

/* ------------------------------------------------------------------- =
*/

static void __init tam3517_init(void) {
=A0=A0=A0 platform_add_devices(tam3517_devices, ARRAY_SIZE(tam3517_devi=
ces));
=A0=A0=A0 omap_board_config =3D tam3517_config;
=A0=A0=A0 omap_board_config_size =3D ARRAY_SIZE(tam3517_config);
=A0=A0=A0 omap3_mux_init(tam3517_mux, OMAP_PACKAGE_CBC);
=A0=A0=A0 omap_serial_init();
=A0=A0=A0 tam3517_i2c_init();
=A0=A0=A0=A0=A0=A0=A0=20
=A0=A0=A0 omap2_hsmmc_init(mmc);
=A0=A0=A0=A0=A0=A0=A0=20
=A0=A0=A0 tam3517_usb_init();=A0=A0=A0=A0=A0=A0=A0=20
=A0=A0=A0 tam3517_nand_init();

=A0=A0=A0 /*Ethernet:=A0 SMSC911x */
#if ENABLE_SMSC_ETH
=A0=A0=A0 tam3517_init_smsc911x();
#endif

=A0=A0=A0 /*Ethernet:=A0 DaVinci EMAC */
#if ENABLE_EMAC_ETH
#if USE_ALT__EMAC_ETH
=A0=A0=A0 am35xx_ethernet_init(AM35XX_EVM_MDIO_FREQUENCY, 1);
#else
=A0=A0=A0 tam3517_emac_ethernet_init();
#endif=A0 // USE_ALT__EMAC_ETH
#endif=A0 // ENABLE_EMAC_ETH
=A0=A0=A0=20
}

MACHINE_START(TAM3517, "Technexion TAM3517")
=A0=A0=A0 .atag_offset=A0=A0=A0 =3D 0x100,
=A0=A0=A0 .reserve=A0=A0=A0 =3D omap_reserve,
=A0=A0=A0 .map_io=A0=A0=A0 =A0=A0=A0 =3D omap3_map_io,
=A0=A0=A0 .init_early=A0=A0=A0 =3D am35xx_init_early,
=A0=A0=A0 .init_irq=A0=A0=A0 =3D omap3_init_irq,
=A0=A0=A0 .handle_irq=A0=A0=A0 =3D omap3_intc_handle_irq,
=A0=A0=A0 .init_machine=A0=A0=A0 =3D tam3517_init,
=A0=A0=A0 .timer=A0=A0=A0 =A0=A0=A0 =3D &omap3_timer,
MACHINE_END

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
