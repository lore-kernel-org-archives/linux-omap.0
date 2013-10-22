From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH V7 0/8] ARM: OMAP3+: support cpufreq-cpu0 for device tree
 boot
Date: Tue, 22 Oct 2013 17:49:10 +0200
Message-ID: <52669E76.2010702@baylibre.com>
References: <1381937948-27057-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:45767 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab3JVPtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Oct 2013 11:49:15 -0400
Received: by mail-wi0-f175.google.com with SMTP id hm4so5917536wib.14
        for <linux-omap@vger.kernel.org>; Tue, 22 Oct 2013 08:49:14 -0700 (PDT)
In-Reply-To: <1381937948-27057-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Nishanth,

On 16/10/2013 17:39, Nishanth Menon wrote:
> Hi,
>
> This series enables the use of cpufreq-cpu0 generic driver for all
> OMAP and related derivatives. Only patch#8 in the series, which
> introduces CPU clock nodes, depends on Tero's V8 patch series for clo=
ck
> nodes[1]
>
> I will stop copy pasting the series complete history and point at [2]=
=2E
>
> Main changes since V6[3]:
> - squashed patches for a minimal set
> - i have organized the series such that 1 to 7 can immediately be mer=
ged
>    if desired:
> 	- patches 1,2,3 can go to Tony's omap-for-v3.13/quirk [4]
> 	- patches 4-7 can go to Benoit's for_3.13/dts [5]

I've just applied them in my DTS tree.

Thanks,
Benoit

> 	- patch 8 needs to depend on [1] and should eventually go to [5]
>
> NOTES: obviously without clock nodes cpufreq will not function.
>
> Test Script: http://pastebin.com/VvJPjsne
>
> Test-log:
> BeagleBoard-XM (OMAP36xx): http://pastebin.com/XZDNaHPf
> PandaBoard-ES (OMAP4460): http://pastebin.com/qQCmA2ng
> BeagleBone-Black(AM335x): http://pastebin.com/98FX4uYW
> OMAP5uEVM (OMAP5432): http://pastebin.com/NXj3L636
> DRA7-EVM (DRA7xx): http://pastebin.com/0kKT3TXy
>
> J Keerthy (3):
>    ARM: dts: dra7-evm: add smps123 supply for CPU
>    ARM: dts: OMAP5: Add CPU OPP table
>    ARM: dts: DRA7: Add CPU OPP table
>
> Nishanth Menon (5):
>    ARM: OMAP3+: do not register non-dt OPP tables for device tree boo=
t
>    ARM: OMAP2+: add missing lateinit hook for calling pm late init
>    ARM: OMAP3+: use cpu0-cpufreq driver in device tree supported boot
>    ARM: dts: omap5-uevm: add smps123 supply for CPU
>    ARM: dts: OMAP3: add clock nodes for CPU
>
> [1] http://marc.info/?t=3D138133284200006&r=3D1&w=3D2
> [2] http://marc.info/?l=3Dlinux-arm-kernel&m=3D136804009618594&w=3D2
> [3] http://marc.info/?l=3Ddevicetree&m=3D138135419203492&w=3D2
> [4] https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.gi=
t/log/?h=3Domap-for-v3.13/quirk
>
>   arch/arm/boot/dts/am33xx.dtsi       |    4 ++++
>   arch/arm/boot/dts/dra7-evm.dts      |    4 ++++
>   arch/arm/boot/dts/dra7.dtsi         |   13 ++++++++++++-
>   arch/arm/boot/dts/omap3.dtsi        |    5 +++++
>   arch/arm/boot/dts/omap4.dtsi        |    5 +++++
>   arch/arm/boot/dts/omap5-uevm.dts    |    4 ++++
>   arch/arm/boot/dts/omap5.dtsi        |   15 ++++++++++++++-
>   arch/arm/mach-omap2/board-generic.c |    4 ++++
>   arch/arm/mach-omap2/common.h        |    4 ++++
>   arch/arm/mach-omap2/io.c            |   20 ++++++++++++++++++++
>   arch/arm/mach-omap2/opp.c           |    4 ++++
>   arch/arm/mach-omap2/pm.c            |   12 +++++++++---
>   12 files changed, 89 insertions(+), 5 deletions(-)
>
> Regards,
> Nishanth Menon
>


--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
