From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Wed, 6 Jan 2016 10:55:51 +0200
Message-ID: <568CD697.9060800@gmail.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
 <568AC0F9.2010304@gmail.com> <20160105041356.GE12777@atomide.com>
 <20160105084947.GG22661@pali> <20160105224929.GF12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160105224929.GF12777@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org



On  6.01.2016 00:49, Tony Lindgren wrote:
>
> Suggested fix below, please test and reply with your Tested-by's if
> it solves the problem so we may still be able to get this into v4.4.
>
> Regards,
>
> Tony
>
> 8< ---------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 5 Jan 2016 12:04:20 -0800
> Subject: [PATCH] ARM: OMAP2+: Fix onenand rate detection to avoid filesystem
>   corruption
>
> Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug")
> unified the GPMC debug for the SoCs with GPMC. The commit also left
> out the option for HWMOD_INIT_NO_RESET as we now require proper timings
> for GPMC to be able to remap GPMC devices out of address 0.
>
> Unfortunately on 900, onenand now only partially works with the device
> tree provided timings. It works enough to get detected but the clock
> rate supported by the onenand chip gets misdetected. This in turn causes
> the GPMC timings to be miscalculated and this leads into file system
> corruption on n900.
>
> Looks like onenand needs CS_CONFIG1 bit 27 WRITETYPE set for for sync
> write. This is needed also for async timings when we write to onenand
> with omap2_onenand_set_async_mode(). Without sync write bit set, the
> async read for the onenand ONENAND_REG_VERSION_ID will return 0xfff.
>
> Let's exit with an error if onenand rate is not detected. And let's
> remove the extra call to omap2_onenand_set_async_mode() as we only
> need to do this once at the end of omap2_onenand_setup_async().
>
> Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> --- a/arch/arm/mach-omap2/gpmc-onenand.c
> +++ b/arch/arm/mach-omap2/gpmc-onenand.c

Bellow is gpmc dmesg output with that fix. I also disabled 
CONFIG_OMAP_GPMC_DEBUG and am still able to boot to maemo with no 
obvious problems.

So, seems that fixes the problem, feel free to  add:

Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>


Jan  6 10:34:15 Nokia-N900 kernel: [    1.373229] omap-gpmc 
6e000000.gpmc: GPMC revision 5.0
Jan  6 10:34:15 Nokia-N900 kernel: [    1.379425] GPMC CS0: cs_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.387481] GPMC CS0: cs_rd_off 
      :  14 ticks,  84 ns (was  16 ticks)  84 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.395507] GPMC CS0: cs_wr_off 
      :  19 ticks, 114 ns (was  16 ticks) 114 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.403472] GPMC CS0: adv_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.411407] GPMC CS0: adv_rd_off 
      :   3 ticks,  18 ns (was   2 ticks)  18 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.419342] GPMC CS0: adv_wr_off 
      :   3 ticks,  18 ns (was   2 ticks)  18 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.427276] GPMC CS0: oe_on 
      :   5 ticks,  30 ns (was   2 ticks)  30 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.435211] GPMC CS0: oe_off 
      :  14 ticks,  84 ns (was  16 ticks)  84 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.443115] GPMC CS0: we_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.451110] GPMC CS0: we_off 
      :  14 ticks,  84 ns (was  16 ticks)  84 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.459045] GPMC CS0: rd_cycle 
      :  18 ticks, 108 ns (was  19 ticks) 108 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.467041] GPMC CS0: wr_cycle 
      :  17 ticks, 102 ns (was  19 ticks) 102 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.474975] GPMC CS0: access 
      :  13 ticks,  78 ns (was  15 ticks)  78 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.482879] GPMC CS0: 
page_burst_access:   0 ticks,   0 ns (was   2 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.490814] GPMC CS0: 
bus_turnaround   :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.498748] GPMC CS0: 
cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.506683] GPMC CS0: 
wr_data_mux_bus  :   5 ticks,  30 ns (was   5 ticks)  30 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.514617] GPMC CS0: wr_access 
      :  13 ticks,  78 ns (was  15 ticks)  78 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.522583] GPMC CS0: 
wait_monitoring  :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.530548] GPMC CS0: 
clk_activation   :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.538543] GPMC CS0 CLK period is 
6 ns (div 1)
Jan  6 10:34:15 Nokia-N900 kernel: [    1.543334] gpmc cs0 after 
gpmc_cs_set_timings:
Jan  6 10:34:15 Nokia-N900 kernel: [    1.548126] cs0 GPMC_CS_CONFIG1: 
0xd9001200
Jan  6 10:34:15 Nokia-N900 kernel: [    1.552581] cs0 GPMC_CS_CONFIG2: 
0x00130e00
Jan  6 10:34:15 Nokia-N900 kernel: [    1.558837] cs0 GPMC_CS_CONFIG3: 
0x00030300
Jan  6 10:34:15 Nokia-N900 kernel: [    1.563323] cs0 GPMC_CS_CONFIG4: 
0x0e000e05
Jan  6 10:34:15 Nokia-N900 kernel: [    1.567901] cs0 GPMC_CS_CONFIG5: 
0x000d1112
Jan  6 10:34:15 Nokia-N900 kernel: [    1.572357] cs0 GPMC_CS_CONFIG6: 
0x8d050000
Jan  6 10:34:15 Nokia-N900 kernel: [    1.576812] gpmc cs0 access 
configuration:
Jan  6 10:34:15 Nokia-N900 kernel: [    1.581146] gpmc,mux-add-data = <2>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.584899] gpmc,device-width = <1>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.588592] gpmc,wait-pin = <0>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.591949] gpmc,burst-length = <16>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.595794] gpmc,sync-write = <1>
Jan  6 10:34:15 Nokia-N900 cellular: csd[1017]: Succesfully loaded 
plugin <sms>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.599273] gpmc,burst-write = <1>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.602905] gpmc,burst-read = <1>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.606445] gpmc,burst-wrap = <1>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.609954] gpmc cs0 timings 
configuration:
Jan  6 10:34:15 Nokia-N900 kernel: [    1.614440] gpmc,cs-on-ns = <0> /* 
0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.620269] gpmc,cs-rd-off-ns = 
<84> /* 79 ns - 84 ns; 14 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.626861] gpmc,cs-wr-off-ns = 
<114> /* 109 ns - 114 ns; 19 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.633728] gpmc,adv-on-ns = <0> 
/* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.639617] gpmc,adv-rd-off-ns = 
<18> /* 13 ns - 18 ns; 3 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.646209] gpmc,adv-wr-off-ns = 
<18> /* 13 ns - 18 ns; 3 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.652770] gpmc,oe-on-ns = <30> 
/* 25 ns - 30 ns; 5 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.658935] gpmc,oe-off-ns = <84> 
/* 79 ns - 84 ns; 14 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.665252] gpmc,we-on-ns = <0> /* 
0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.671081] gpmc,we-off-ns = <84> 
/* 79 ns - 84 ns; 14 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.677398] gpmc,rd-cycle-ns = 
<108> /* 103 ns - 108 ns; 18 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.684112] gpmc,wr-cycle-ns = 
<102> /* 97 ns - 102 ns; 17 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.690765] gpmc,access-ns = <78> 
/* 73 ns - 78 ns; 13 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.697082] 
gpmc,page-burst-access-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.704010] gpmc,bus-turnaround-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.710662] 
gpmc,cycle2cycle-delay-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.717620] 
gpmc,wait-monitoring-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.724395] gpmc,clk-activation-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.731048] 
gpmc,wr-data-mux-bus-ns = <30> /* 25 ns - 30 ns; 5 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.738098] gpmc,wr-access-ns = 
<78> /* 73 ns - 78 ns; 13 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.744781] GPMC CS0: cs_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.752685] GPMC CS0: cs_rd_off 
      :  16 ticks,  96 ns (was  14 ticks)  96 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.760681] GPMC CS0: cs_wr_off 
      :  16 ticks,  96 ns (was  19 ticks)  96 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.768646] GPMC CS0: adv_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.776641] GPMC CS0: adv_rd_off 
      :   2 ticks,  12 ns (was   3 ticks)  12 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.784576] GPMC CS0: adv_wr_off 
      :   2 ticks,  12 ns (was   3 ticks)  12 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.792541] GPMC CS0: oe_on 
      :   3 ticks,  18 ns (was   5 ticks)  18 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.800476] GPMC CS0: oe_off 
      :  16 ticks,  96 ns (was  14 ticks)  96 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.808410] GPMC CS0: we_on 
      :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.816345] GPMC CS0: we_off 
      :  16 ticks,  96 ns (was  14 ticks)  96 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.824279] GPMC CS0: rd_cycle 
      :  19 ticks, 114 ns (was  18 ticks) 114 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.832183] GPMC CS0: wr_cycle 
      :  19 ticks, 114 ns (was  17 ticks) 114 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.840087] GPMC CS0: access 
      :  15 ticks,  90 ns (was  13 ticks)  90 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.848083] GPMC CS0: 
page_burst_access:   2 ticks,  12 ns (was   0 ticks)  12 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.856018] GPMC CS0: 
bus_turnaround   :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.864013] GPMC CS0: 
cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.871917] GPMC CS0: 
wr_data_mux_bus  :   5 ticks,  30 ns (was   5 ticks)  30 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.879821] GPMC CS0: wr_access 
      :  15 ticks,  90 ns (was  13 ticks)  90 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.887817] GPMC CS0: 
wait_monitoring  :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.895812] GPMC CS0: 
clk_activation   :   1 ticks,   6 ns (was   0 ticks)   6 ns
Jan  6 10:34:15 Nokia-N900 kernel: [    1.903747] GPMC CS0 CLK period is 
12 ns (div 2)
Jan  6 10:34:15 Nokia-N900 kernel: [    1.908599] gpmc cs0 after 
gpmc_cs_set_timings:
Jan  6 10:34:15 Nokia-N900 kernel: [    1.913421] cs0 GPMC_CS_CONFIG1: 
0xfb001201
Jan  6 10:34:15 Nokia-N900 cellular: csd[1017]: Succesfully loaded 
plugin <ss>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.917907] cs0 GPMC_CS_CONFIG2: 
0x00101000
Jan  6 10:34:15 Nokia-N900 kernel: [    1.922332] cs0 GPMC_CS_CONFIG3: 
0x00020200
Jan  6 10:34:15 Nokia-N900 kernel: [    1.926788] cs0 GPMC_CS_CONFIG4: 
0x10001003
Jan  6 10:34:15 Nokia-N900 kernel: [    1.931243] cs0 GPMC_CS_CONFIG5: 
0x020f1313
Jan  6 10:34:15 Nokia-N900 kernel: [    1.935729] cs0 GPMC_CS_CONFIG6: 
0x8f050000
Jan  6 10:34:15 Nokia-N900 kernel: [    1.940124] gpmc cs0 access 
configuration:
Jan  6 10:34:15 Nokia-N900 kernel: [    1.944519] gpmc,mux-add-data = <2>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.948211] gpmc,device-width = <1>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.951934] gpmc,wait-pin = <0>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.955291] gpmc,burst-length = <16>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.959106] gpmc,sync-write = <1>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.962646] gpmc,burst-write = <1>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.966278] gpmc,gpmc,sync-read = <1>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.970184] gpmc,burst-read = <1>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.973724] gpmc,burst-wrap = <1>
Jan  6 10:34:15 Nokia-N900 kernel: [    1.977233] gpmc cs0 timings 
configuration:
Jan  6 10:34:15 Nokia-N900 kernel: [    1.981658] gpmc,cs-on-ns = <0> /* 
0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.987518] gpmc,cs-rd-off-ns = 
<96> /* 91 ns - 96 ns; 16 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    1.994049] gpmc,cs-wr-off-ns = 
<96> /* 91 ns - 96 ns; 16 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.000610] gpmc,adv-on-ns = <0> 
/* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.006591] gpmc,adv-rd-off-ns = 
<12> /* 7 ns - 12 ns; 2 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.013000] gpmc,adv-wr-off-ns = 
<12> /* 7 ns - 12 ns; 2 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.019500] gpmc,oe-on-ns = <18> 
/* 13 ns - 18 ns; 3 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.025634] gpmc,oe-off-ns = <96> 
/* 91 ns - 96 ns; 16 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.031921] gpmc,we-on-ns = <0> /* 
0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.037780] gpmc,we-off-ns = <96> 
/* 91 ns - 96 ns; 16 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.044067] gpmc,rd-cycle-ns = 
<114> /* 109 ns - 114 ns; 19 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.050811] gpmc,wr-cycle-ns = 
<114> /* 109 ns - 114 ns; 19 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.057586] gpmc,access-ns = <90> 
/* 85 ns - 90 ns; 15 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.063903] 
gpmc,page-burst-access-ns = <12> /* 7 ns - 12 ns; 2 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.071014] gpmc,bus-turnaround-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.077697] 
gpmc,cycle2cycle-delay-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.084625] 
gpmc,wait-monitoring-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.091339] gpmc,clk-activation-ns 
= <6> /* 1 ns - 6 ns; 1 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.098022] 
gpmc,wr-data-mux-bus-ns = <30> /* 25 ns - 30 ns; 5 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.105072] gpmc,wr-access-ns = 
<90> /* 85 ns - 90 ns; 15 ticks */
Jan  6 10:34:15 Nokia-N900 kernel: [    2.111602] omap2-onenand 
omap2-onenand: initializing on CS0, phys base 0x01000000, virtual base 
d0940000, freq 83 MHz
Jan  6 10:34:15 Nokia-N900 kernel: [    2.123016] OneNAND Manufacturer: 
Numonyx (0x20)
Jan  6 10:34:15 Nokia-N900 gconfd (root-1080): starting (version 
2.16.0), pid 1080 user 'root'
Jan  6 10:34:16 Nokia-N900 kernel: [    2.123016] Muxed OneNAND 256MB 
1.8V 16-bit (0x40)
Jan  6 10:34:16 Nokia-N900 waitx[1085]: trying to get X display
Jan  6 10:34:16 Nokia-N900 kernel: [    2.128112] OneNAND version = 0x0031
Jan  6 10:34:16 Nokia-N900 kernel: [    2.131896] Chip support all block 
unlock
Jan  6 10:34:16 Nokia-N900 kernel: [    2.131896] Chip has 2 plane
Jan  6 10:34:16 Nokia-N900 kernel: [    2.133483] Scanning device for 
bad blocks
Jan  6 10:34:16 Nokia-N900 kernel: [    2.232177] 6 ofpart partitions 
found on MTD device (null)
Jan  6 10:34:16 Nokia-N900 kernel: [    2.238098] Creating 6 MTD 
partitions on "(null)":
Jan  6 10:34:16 Nokia-N900 kernel: [    2.243164] 
0x000000000000-0x000000020000 : "bootloader"
Jan  6 10:34:16 Nokia-N900 kernel: [    2.249725] 
0x000000020000-0x000000080000 : "config"
Jan  6 10:34:16 Nokia-N900 kernel: [    2.255767] 
0x000000080000-0x0000000c0000 : "log"
Jan  6 10:34:16 Nokia-N900 kernel: [    2.263793] mtdoops: ready 34, 
959521136 (no erase)
Jan  6 10:34:16 Nokia-N900 kernel: [    2.263793] mtdoops: Attached to 
MTD device 2
Jan  6 10:34:16 Nokia-N900 kernel: [    2.268432] 
0x0000000c0000-0x0000002c0000 : "kernel"
Jan  6 10:34:16 Nokia-N900 kernel: [    2.274444] 
0x0000002c0000-0x0000004c0000 : "initfs"
Jan  6 10:34:16 Nokia-N900 kernel: [    2.280364] 
0x0000004c0000-0x000010000000 : "rootfs"
Jan  6 10:34:16 Nokia-N900 kernel: [    2.287963] gpmc cs1 before 
gpmc_cs_program_settings:
Jan  6 10:34:16 Nokia-N900 kernel: [    2.293304] cs1 GPMC_CS_CONFIG1: 
0x00001000
Jan  6 10:34:16 Nokia-N900 kernel: [    2.297790] cs1 GPMC_CS_CONFIG2: 
0x00101001
Jan  6 10:34:16 Nokia-N900 kernel: [    2.302246] cs1 GPMC_CS_CONFIG3: 
0x00020201
Jan  6 10:34:16 Nokia-N900 kernel: [    2.306732] cs1 GPMC_CS_CONFIG4: 
0x10031003
Jan  6 10:34:16 Nokia-N900 kernel: [    2.311126] cs1 GPMC_CS_CONFIG5: 
0x010f1111
Jan  6 10:34:16 Nokia-N900 kernel: [    2.315612] cs1 GPMC_CS_CONFIG6: 
0x8f030000
Jan  6 10:34:16 Nokia-N900 kernel: [    2.320007] gpmc cs1 access 
configuration:
Jan  6 10:34:16 Nokia-N900 kernel: [    2.324401] gpmc,mux-add-data = <0>
Jan  6 10:34:16 Nokia-N900 kernel: [    2.328124] gpmc,device-width = <1>
Jan  6 10:34:16 Nokia-N900 kernel: [    2.331817] gpmc,wait-pin = <0>
Jan  6 10:34:16 Nokia-N900 kernel: [    2.335205] gpmc,burst-length = <4>
Jan  6 10:34:16 Nokia-N900 kernel: [    2.338928] gpmc cs1 timings 
configuration:
Jan  6 10:34:16 Nokia-N900 kernel: [    2.343353] gpmc,cs-on-ns = <6> /* 
1 ns - 6 ns; 1 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.349212] gpmc,cs-rd-off-ns = 
<96> /* 91 ns - 96 ns; 16 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.355773] gpmc,cs-wr-off-ns = 
<96> /* 91 ns - 96 ns; 16 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.362274] gpmc,adv-on-ns = <6> 
/* 1 ns - 6 ns; 1 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.368225] gpmc,adv-rd-off-ns = 
<12> /* 7 ns - 12 ns; 2 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.374664] gpmc,adv-wr-off-ns = 
<12> /* 7 ns - 12 ns; 2 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.381103] gpmc,oe-on-ns = <18> 
/* 13 ns - 18 ns; 3 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.387237] gpmc,oe-off-ns = <96> 
/* 91 ns - 96 ns; 16 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.393463] gpmc,we-on-ns = <18> 
/* 13 ns - 18 ns; 3 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.399597] gpmc,we-off-ns = <96> 
/* 91 ns - 96 ns; 16 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.405914] gpmc,rd-cycle-ns = 
<102> /* 97 ns - 102 ns; 17 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.412536] gpmc,wr-cycle-ns = 
<102> /* 97 ns - 102 ns; 17 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.419219] gpmc,access-ns = <90> 
/* 85 ns - 90 ns; 15 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.425476] 
gpmc,page-burst-access-ns = <6> /* 1 ns - 6 ns; 1 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.432403] gpmc,bus-turnaround-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.439086] 
gpmc,cycle2cycle-delay-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.446044] 
gpmc,wait-monitoring-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.452728] gpmc,clk-activation-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.459442] 
gpmc,wr-data-mux-bus-ns = <18> /* 13 ns - 18 ns; 3 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.466491] gpmc,wr-access-ns = 
<90> /* 85 ns - 90 ns; 15 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.473052] GPMC CS1: cs_on 
      :   0 ticks,   0 ns (was   1 ticks)   0 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.481048] GPMC CS1: cs_rd_off 
      :   8 ticks,  48 ns (was  16 ticks)  48 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.489044] GPMC CS1: cs_wr_off 
      :   4 ticks,  24 ns (was  16 ticks)  24 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.496978] GPMC CS1: adv_on 
      :   0 ticks,   0 ns (was   1 ticks)   0 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.504943] GPMC CS1: adv_rd_off 
      :   0 ticks,   0 ns (was   2 ticks)   0 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.512878] GPMC CS1: adv_wr_off 
      :   0 ticks,   0 ns (was   2 ticks)   0 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.520843] GPMC CS1: oe_on 
      :   2 ticks,  12 ns (was   3 ticks)  12 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.528839] GPMC CS1: oe_off 
      :   8 ticks,  48 ns (was  16 ticks)  48 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.536773] GPMC CS1: we_on 
      :   2 ticks,  12 ns (was   3 ticks)  12 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.544708] GPMC CS1: we_off 
      :   3 ticks,  18 ns (was  16 ticks)  18 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.552612] GPMC CS1: rd_cycle 
      :  30 ticks, 180 ns (was  17 ticks) 180 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.560607] GPMC CS1: wr_cycle 
      :  30 ticks, 180 ns (was  17 ticks) 180 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.568542] GPMC CS1: access 
      :   7 ticks,  42 ns (was  15 ticks)  42 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.576477] GPMC CS1: 
page_burst_access:   0 ticks,   0 ns (was   1 ticks)   0 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.584472] GPMC CS1: 
bus_turnaround   :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.592346] GPMC CS1: 
cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.600341] GPMC CS1: 
wr_data_mux_bus  :   2 ticks,  12 ns (was   3 ticks)  12 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.608276] GPMC CS1: wr_access 
      :   0 ticks,   0 ns (was  15 ticks)   0 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.616271] GPMC CS1: 
wait_monitoring  :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.624267] GPMC CS1: 
clk_activation   :   0 ticks,   0 ns (was   0 ticks)   0 ns
Jan  6 10:34:16 Nokia-N900 kernel: [    2.632171] GPMC CS1 CLK period is 
6 ns (div 1)
Jan  6 10:34:16 Nokia-N900 kernel: [    2.637023] gpmc cs1 after 
gpmc_cs_set_timings:
Jan  6 10:34:16 Nokia-N900 kernel: [    2.641815] cs1 GPMC_CS_CONFIG1: 
0x00001000
Jan  6 10:34:16 Nokia-N900 kernel: [    2.646301] cs1 GPMC_CS_CONFIG2: 
0x00040800
Jan  6 10:34:16 Nokia-N900 kernel: [    2.650726] cs1 GPMC_CS_CONFIG3: 
0x00000000
Jan  6 10:34:16 Nokia-N900 kernel: [    2.655212] cs1 GPMC_CS_CONFIG4: 
0x03020802
Jan  6 10:34:16 Nokia-N900 kernel: [    2.659606] cs1 GPMC_CS_CONFIG5: 
0x00071e1e
Jan  6 10:34:16 Nokia-N900 kernel: [    2.664093] cs1 GPMC_CS_CONFIG6: 
0x80020000
Jan  6 10:34:16 Nokia-N900 kernel: [    2.668548] gpmc cs1 access 
configuration:
Jan  6 10:34:16 Nokia-N900 kernel: [    2.672882] gpmc,mux-add-data = <0>
Jan  6 10:34:16 Nokia-N900 kernel: [    2.676635] gpmc,device-width = <1>
Jan  6 10:34:16 Nokia-N900 kernel: [    2.680328] gpmc,wait-pin = <0>
Jan  6 10:34:16 Nokia-N900 kernel: [    2.683685] gpmc,burst-length = <4>
Jan  6 10:34:16 Nokia-N900 kernel: [    2.687408] gpmc cs1 timings 
configuration:
Jan  6 10:34:16 Nokia-N900 kernel: [    2.691833] gpmc,cs-on-ns = <0> /* 
0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.697692] gpmc,cs-rd-off-ns = 
<48> /* 43 ns - 48 ns; 8 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.704132] gpmc,cs-wr-off-ns = 
<24> /* 19 ns - 24 ns; 4 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.710601] gpmc,adv-on-ns = <0> 
/* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.716552] gpmc,adv-rd-off-ns = 
<0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.722808] gpmc,adv-wr-off-ns = 
<0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.729125] gpmc,oe-on-ns = <12> 
/* 7 ns - 12 ns; 2 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.735137] gpmc,oe-off-ns = <48> 
/* 43 ns - 48 ns; 8 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.741333] gpmc,we-on-ns = <12> 
/* 7 ns - 12 ns; 2 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.747375] gpmc,we-off-ns = <18> 
/* 13 ns - 18 ns; 3 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.753509] gpmc,rd-cycle-ns = 
<180> /* 175 ns - 180 ns; 30 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.760284] gpmc,wr-cycle-ns = 
<180> /* 175 ns - 180 ns; 30 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.767059] gpmc,access-ns = <42> 
/* 37 ns - 42 ns; 7 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.773254] 
gpmc,page-burst-access-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.780212] gpmc,bus-turnaround-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.786895] 
gpmc,cycle2cycle-delay-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.793853] 
gpmc,wait-monitoring-ns = <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.800628] gpmc,clk-activation-ns 
= <0> /* 0 ns - 0 ns; 0 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.807312] 
gpmc,wr-data-mux-bus-ns = <12> /* 7 ns - 12 ns; 2 ticks */
Jan  6 10:34:16 Nokia-N900 kernel: [    2.814270] gpmc,wr-access-ns = 
<0> /* 0 ns - 0 ns; 0 ticks */
