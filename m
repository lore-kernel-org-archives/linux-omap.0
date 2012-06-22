From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Problems in the DaVinci EMAC driver & AM35xx?
Date: Fri, 22 Jun 2012 13:22:53 -0700 (PDT)
Message-ID: <1340396573.68079.YahooMailNeo@web125202.mail.ne1.yahoo.com>
References: <1339627132.52592.YahooMailNeo@web125204.mail.ne1.yahoo.com> <1339788533.89799.YahooMailNeo@web125202.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm20.bullet.mail.ne1.yahoo.com ([98.138.90.83]:25911 "HELO
	nm20.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753804Ab2FVUWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 16:22:55 -0400
In-Reply-To: <1339788533.89799.YahooMailNeo@web125202.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "mgreer@animalcreek.com" <mgreer@animalcreek.com>, "afzal@ti.com" <afzal@ti.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "tony@atomide.com" <tony@atomide.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, "khilman@ti.com" <khilman@ti.com>

All,

Sorry to spam this out to so many folks, but we are REALLY getting stym=
ied by this bug at the moment and cannot believe we're the only ones se=
eing it.=A0 Googles for this particular crash ONLY show this thread, an=
d so far, no one has responded.=A0 The folks CC'd on here have been kin=
d enough to take a look at the other issues and/or seem to be the exper=
ts on the DaVinci EMAC from other threads.=A0 *Can anyone please help??=
?*

As previously discussed, we're having some stability issues with the AM=
3517.=A0 We initially thought they may be separate issues, hence the se=
parate threads here, but now we're suspecting they could all be the sam=
e error or at least related.=A0 We're presently testing with Technexion=
 TAM3517s.=A0 These processor boards can sometimes run under load for d=
ays, but will suddenly produce a crash of some sort.=A0 Sometimes it ha=
ngs the kernel completely, sometimes not.=A0 These issues have been *ve=
ry* hard to track, but we believe we're starting to see a rough commona=
lity in the errors, and they seem more prevalent now that we're enablin=
g and using the EMAC heavily.=A0 All are memory management errors, and =
now some are directly blaming the EMAC.=A0 As noted previously, our EMA=
C performance has *always* been questionable, especially when connectin=
g EMAC to EMAC.=A0 So maybe we're onto something?

Our current tests are running on a Linux-omap build straight off the ma=
ster that's a few days old now.=A0 It's a 3.5-rc2, and we're running SL=
UB now rather than SLAB as we try to get more information on this mm is=
sue.

Things did seem to get a bit worse after enabling the EMAC interface in=
side of u-boot, but I suspect that could just be coincidence.=A0 Could =
that make a difference to Linux somehow?=A0 I'll happily provide anythi=
ng u-boot, or otherwise, related if that would be helpful.=A0 We are do=
ing _nothing_ special. We are configuring the EMAC just about=20
like everyone else, including the CM-T3517, AM3517EVM, and=20
AM3517-crane.=A0 For now here is our Linux config:

CONFIG_SMSC911X=3Dy
# CONFIG_SMSC911X_ARCH_HOOKS is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_TI=3Dy
CONFIG_TI_DAVINCI_EMAC=3Dy
CONFIG_TI_DAVINCI_MDIO=3Dy
CONFIG_TI_DAVINCI_CPDMA=3Dy
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_PHYLIB=3Dy

In our board file we just do:


--------board file ----------------------------------------------------=
---------------------------------------------------

#include <linux/davinci_emac.h>
#include "am35xx-emac.h"


=2E..

am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);

=2E..

-----------------------------------------------------------------------=
------------------------------------------------------

The *ONLY* tweak to the current "linux/arch/arm/mach-omap2/am35xx-emac.=
c" is a little patch to use the fused MAC address in the AM3517:


--------small patch to "linux/arch/arm/mach-omap2/am35xx-emac.c"-------=
---------------------

void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
{
=A0=A0=A0 u32 v;
=A0=A0=A0 int err;

#if 1
=A0=A0=A0 /* use the TI-provided MAC address fused in the AM35xx */
=A0=A0=A0 u32 regval, mac_lo, mac_hi;

=A0=A0=A0 mac_lo =3D omap_ctrl_readl(AM35XX_CONTROL_FUSE_EMAC_LSB);
=A0=A0=A0 mac_hi =3D omap_ctrl_readl(AM35XX_CONTROL_FUSE_EMAC_MSB);

=A0=A0=A0 am35xx_emac_pdata.mac_addr[0] =3D (u_int8_t)((mac_hi & 0xFF00=
00) >> 16);
=A0=A0=A0 am35xx_emac_pdata.mac_addr[1] =3D (u_int8_t)((mac_hi & 0xFF00=
) >> 8);
=A0=A0=A0 am35xx_emac_pdata.mac_addr[2] =3D (u_int8_t)((mac_hi & 0xFF) =
>> 0);
=A0=A0=A0 am35xx_emac_pdata.mac_addr[3] =3D (u_int8_t)((mac_lo & 0xFF00=
00) >> 16);
=A0=A0=A0 am35xx_emac_pdata.mac_addr[4] =3D (u_int8_t)((mac_lo & 0xFF00=
) >> 8);
=A0=A0=A0 am35xx_emac_pdata.mac_addr[5] =3D (u_int8_t)((mac_lo & 0xFF) =
>> 0);
#endif


=2E..

-----------------------------------------------------------------------=
------------------------------------------------------

There are *NO* changes to "linux/drivers/net/ethernet/ti/..." files at =
all.

The test I ran was simple:=A0 I kicked off a "ping -s 8000 <IP> &" to a=
 common laptop on several TAM-3517 platforms.=A0 Then I also ran the 's=
tress' utility (http://weather.ou.edu/~apw/projects/stress/) to put ver=
y light, *non-Ethernet* load on the platform.=A0 A day or so later, 2 o=
f the 3 processors are running.=A0 The 3rd crashed with the error below=
=2E=A0 This is an identical error to one mentioned in the top post of t=
his thread (http://article.gmane.org/gmane.linux.ports.arm.omap/78647):

[312631.542877] ------------[ cut here ]------------
[312631.547851] WARNING: at drivers/net/ethernet/ti/davinci_emac.c:997 =
emac_rx_alloc+0x5c/0x64()
[312631.556854] Modules linked in:
[312631.560211] [<c0013d60>] (unwind_backtrace+0x0/0x104) from [<c0394f=
34>] (dump_stack+0x20/0x24)
[312631.569396] [<c0394f34>] (dump_stack+0x20/0x24) from [<c002efa8>] (=
warn_slowpath_common+0x5c/0x)
[312631.578948] [<c002efa8>] (warn_slowpath_common+0x5c/0x74) from [<c0=
02efec>] (warn_slowpath_null)
[312631.589233] [<c002efec>] (warn_slowpath_null+0x2c/0x34) from [<c029=
8bc4>] (emac_rx_alloc+0x5c/0)
[312631.598846] [<c0298bc4>] (emac_rx_alloc+0x5c/0x64) from [<c0299a90>=
] (emac_rx_handler+0x74/0x11)
[312631.608306] [<c0299a90>] (emac_rx_handler+0x74/0x11c) from [<c029ad=
88>] (__cpdma_chan_free+0xc8)
[312631.618103] [<c029ad88>] (__cpdma_chan_free+0xc8/0xe0) from [<c029a=
e6c>] (__cpdma_chan_process+)
[312631.628356] [<c029ae6c>] (__cpdma_chan_process+0xcc/0x104) from [<c=
029ba00>] (cpdma_chan_proces)
[312631.638732] [<c029ba00>] (cpdma_chan_process+0x4c/0x64) from [<c029=
9f64>] (emac_poll+0x9c/0x208)
[312631.648101] [<c0299f64>] (emac_poll+0x9c/0x208) from [<c030b228>] (=
net_rx_action+0xb0/0x1a8)
[312631.657073] [<c030b228>] (net_rx_action+0xb0/0x1a8) from [<c0035c0c=
>] (__do_softirq+0xb0/0x1d8)
[312631.666351] [<c0035c0c>] (__do_softirq+0xb0/0x1d8) from [<c0036110>=
] (irq_exit+0x8c/0x94)
[312631.675048] [<c0036110>] (irq_exit+0x8c/0x94) from [<c000f010>] (ha=
ndle_IRQ+0x44/0x94)
[312631.683502] [<c000f010>] (handle_IRQ+0x44/0x94) from [<c00085b4>] (=
omap3_intc_handle_irq+0x68/0)
[312631.693145] [<c00085b4>] (omap3_intc_handle_irq+0x68/0x78) from [<c=
000e480>] (__irq_usr+0x40/0x)
[312631.702667] Exception stack(0xce029fb0 to 0xce029ff8)
[312631.708068] 9fa0:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00000000 0000=
0000 b6e64020 b6e63458
[312631.716796] 9fc0: 00000000 00000001 b6e64020 0000e530 00000011 0000=
e478 00000001 00000000
[312631.725494] 9fe0: b6e63198 bef7ab68 b6d6c4f4 b6d6c504 20000010 ffff=
ffff
[312631.732543] ---[ end trace bf1e7d78367d02a3 ]---
[312631.737579] stress: page allocation failure: order:0, mode:0x120
[312631.743988] [<c0013d60>] (unwind_backtrace+0x0/0x104) from [<c0394f=
34>] (dump_stack+0x20/0x24)
[312631.753173] [<c0394f34>] (dump_stack+0x20/0x24) from [<c009cec4>] (=
warn_alloc_failed+0xd8/0x11c)
[312631.762481] [<c009cec4>] (warn_alloc_failed+0xd8/0x11c) from [<c009=
f4d8>] (__alloc_pages_nodema)
[312631.773101] [<c009f4d8>] (__alloc_pages_nodemask+0x508/0x678) from =
[<c030031c>] (netdev_alloc_f)
[312631.783630] [<c030031c>] (netdev_alloc_frag+0xa4/0xdc) from [<c0301=
2ec>] (__netdev_alloc_skb+0x)
[312631.793609] [<c03012ec>] (__netdev_alloc_skb+0x78/0xd0) from [<c029=
8b90>] (emac_rx_alloc+0x28/0)
[312631.803192] [<c0298b90>] (emac_rx_alloc+0x28/0x64) from [<c0299a90>=
] (emac_rx_handler+0x74/0x11)
[312631.812622] [<c0299a90>] (emac_rx_handler+0x74/0x11c) from [<c029ad=
88>] (__cpdma_chan_free+0xc8)
[312631.822387] [<c029ad88>] (__cpdma_chan_free+0xc8/0xe0) from [<c029a=
e6c>] (__cpdma_chan_process+)
[312631.832641] [<c029ae6c>] (__cpdma_chan_process+0xcc/0x104) from [<c=
029ba00>] (cpdma_chan_proces)
[312631.842987] [<c029ba00>] (cpdma_chan_process+0x4c/0x64) from [<c029=
9f64>] (emac_poll+0x9c/0x208)
[312631.852294] [<c0299f64>] (emac_poll+0x9c/0x208) from [<c030b228>] (=
net_rx_action+0xb0/0x1a8)
[312631.861267] [<c030b228>] (net_rx_action+0xb0/0x1a8) from [<c0035c0c=
>] (__do_softirq+0xb0/0x1d8)
[312631.870483] [<c0035c0c>] (__do_softirq+0xb0/0x1d8) from [<c0036110>=
] (irq_exit+0x8c/0x94)
[312631.879180] [<c0036110>] (irq_exit+0x8c/0x94) from [<c000f010>] (ha=
ndle_IRQ+0x44/0x94)
[312631.887603] [<c000f010>] (handle_IRQ+0x44/0x94) from [<c00085b4>] (=
omap3_intc_handle_irq+0x68/0)
[312631.897186] [<c00085b4>] (omap3_intc_handle_irq+0x68/0x78) from [<c=
000e480>] (__irq_usr+0x40/0x)
[312631.906707] Exception stack(0xce029fb0 to 0xce029ff8)
[312631.912078] 9fa0:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00000000 0000=
0000 b6e64020 b6e63458
[312631.920776] 9fc0: 00000000 00000001 b6e64020 0000e530 00000011 0000=
e478 00000001 00000000
[312631.929473] 9fe0: b6e63198 bef7ab68 b6d6c4f4 b6d6c504 20000010 ffff=
ffff
[312631.936492] Mem-info:
[312631.938964] Normal per-cpu:
[312631.941986] CPU=A0=A0=A0 0: hi:=A0=A0 90, btch:=A0 15 usd:=A0 13
[312631.947113] active_anon:41797 inactive_anon:30 isolated_anon:0
[312631.947113]=A0 active_file:2215 inactive_file:12995 isolated_file:0
[312631.947113]=A0 unevictable:0 dirty:11034 writeback:1 unstable:0
[312631.947113]=A0 free:2352 slab_reclaimable:583 slab_unreclaimable:10=
14
[312631.947113]=A0 mapped:982 shmem:83 pagetables:606 bounce:0
[312631.978271] Normal free:9408kB min:2028kB low:2532kB high:3040kB ac=
tive_anon:167188kB inactive_o
[312632.019989] lowmem_reserve[]: 0 0 0
[312632.023742] Normal: 1488*4kB 432*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0=
*256kB 0*512kB 0*1024kB 0*20B
[312632.034973] 15295 total pagecache pages
[312632.049987] 65536 pages of RAM
[312632.053283] 2944 free pages
[312632.056304] 2306 reserved pages
[312632.059692] 1333 slab pages
[312632.062713] 3869 pages shared
[312632.065917] 0 pages swap cached


Any ideas what could be causing this?=A0 It has now happened with both =
SLAB and SLUB and with both heavy and relatively light Ethernet loads o=
n the EMAC.=A0 Can anyone please help?

Thanks in advance!

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
