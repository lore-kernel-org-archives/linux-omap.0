From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 7/8 v2] ARM OMAP2+ GPMC: calculate GPMCFCLKDIVIDER based
 on WAITMONITORINGTIME
Date: Wed, 25 Feb 2015 19:20:40 +0200
Message-ID: <54EE0468.3090000@ti.com>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-7-git-send-email-rabel@cit-ec.uni-bielefeld.de> <54EDF969.1070902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EDF969.1070902@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Robert,

On 25/02/15 18:33, Roger Quadros wrote:
> On 24/02/15 22:05, Robert ABEL wrote:
>> The WAITMONITORINGTIME is expressed as a number of GPMC_CLK clock cy=
cles,
>> even though the access is defined as asynchronous, and no GPMC_CLK c=
lock
>> is provided to the external device. Still, GPMCFCLKDIVIDER is used a=
s a divider
>> for the GPMC clock, so it must be programmed to define the
>> correct WAITMONITORINGTIME delay.
>>
>> Calculate GPMCFCLKDIVIDER independent of gpmc,sync-clk-ps in DT for
>> truly asynchronous accesses, i.e. both read and write asynchronous.
>>
>> Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
>> ---
>>  arch/arm/mach-omap2/gpmc-nand.c    | 17 ++++-----
>>  arch/arm/mach-omap2/gpmc-onenand.c |  4 +--
>>  drivers/memory/omap-gpmc.c         | 74 +++++++++++++++++++++++++++=
+++++++----
>>  include/linux/omap-gpmc.h          |  2 +-
>>  4 files changed, 80 insertions(+), 17 deletions(-)

Need to patch mach-omap2/usb-tusb6010.c as well. else we get

arch/arm/mach-omap2/usb-tusb6010.c: In function =91tusb_set_async_mode=92=
:
arch/arm/mach-omap2/usb-tusb6010.c:74:2: error: too few arguments to fu=
nction =91gpmc_cs_set_timings=92
In file included from arch/arm/mach-omap2/gpmc.h:14:0,
                 from arch/arm/mach-omap2/usb-tusb6010.c:23:
include/linux/omap-gpmc.h:166:12: note: declared here
arch/arm/mach-omap2/usb-tusb6010.c: In function =91tusb_set_sync_mode=92=
:
arch/arm/mach-omap2/usb-tusb6010.c:101:2: error: too few arguments to f=
unction =91gpmc_cs_set_timings=92
In file included from arch/arm/mach-omap2/gpmc.h:14:0,
                 from arch/arm/mach-omap2/usb-tusb6010.c:23:
include/linux/omap-gpmc.h:166:12: note: declared here

cheers,
-roger
