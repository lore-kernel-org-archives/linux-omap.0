From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: ARM: dts: omap3: NAND support - how?
Date: Fri, 19 Apr 2013 00:48:02 +0200
Message-ID: <1366325282.4232.6.camel@lovely>
References: <1366311829.4085.90.camel@mars>  <51704C05.4030200@ti.com>
	 <1366316595.4085.113.camel@mars>  <5170738F.8050305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:50428 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966948Ab3DRWsI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 18:48:08 -0400
Received: by mail-bk0-f47.google.com with SMTP id ik5so1455208bkc.20
        for <linux-omap@vger.kernel.org>; Thu, 18 Apr 2013 15:48:07 -0700 (PDT)
In-Reply-To: <5170738F.8050305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <daniel@zonque.org>, linux-omap@vger.kernel.org

On Thu, 2013-04-18 at 17:28 -0500, Jon Hunter wrote:
> On 04/18/2013 03:23 PM, Christoph Fritz wrote:


> > OMAP3_EVM # md 0x6E000060 7
> > 6e000060: 00001800 00141400 00141400 0f010f01    ................
> > 6e000070: 010c1414 1f0f0a80 00000870             ........p...

> 
> I don't see any other errors in the log. So I am wondering if the
> chip-select mapping is setup correctly. Can you share a dump of the gpmc
> registers from u-boot?

I already did, please see the "md 0x6E000060 7" from above. Below is my
work-sheet how I configured the values:

---

To get the values right for dt-GPMC-NAND-Config, here are the GPMC
config registers for chip-select 0, they are taken from u-boot
by doing "md 0x6E000060 7" on the u-boot shell:

	GPMC_CONFIG1: 0x6e000060: 0x00001800
	GPMC_CONFIG2: 0x6e000064: 0x00141400
	GPMC_CONFIG3: 0x6e000068: 0x00141400
	GPMC_CONFIG4: 0x6e00006c: 0x0F010F01
	GPMC_CONFIG5: 0x6e000070: 0x010C1414
	GPMC_CONFIG6: 0x6e000074: 0x1F0F0A80
	GPMC_CONFIG7: 0x6e000078: 0x00000870

and analyzed by datasheet (TRM page 2210):

GPMC_CONFIG7 0x00000870:
		|11|10| 9| 8| 7| 6| 5| 4| 3| 2| 1| 0|
		| 1| 0| 0| 0| 0| 1| 1| 1| 0| 0| 0| 0|

	5:0  BASEADDR: 0x4 (reg addr: 0x30000000)
	dT: not supported
		CSi base address
	6    CSVALID: 1
	dT: not supported
		CS enable
	11:8 MASKADDRESS: 0x1000: Chip-select size of 128 Mbytes
	dT: not supported
		CS mask address

GPMC_CONFIG6 0x1F0F0A80:
		|31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|
		| 0| 0| 0| 1| 1| 1| 1| 1| 0| 0| 0| 0| 1| 1| 1| 1|

		|15|14|13|12|11|10| 9| 8| 7| 6| 5| 4| 3| 2| 1| 0|
		| 0| 0| 0| 0| 1| 0| 1| 0| 1| 0| 0| 0| 0| 0| 0| 0|

	28:24 WRACCESSTIME: 0x1F: 31 GPMC_FCLK cycles
	dT: "gpmc,wr-access-ns = <0x1F>;" (0x0 to 0x1F)
		used by the attached memory for the first data capture

	19:16 WRDATAONADMUXBUS: 0xF
	dT: "gpmc,wr-data-mux-bus-ns = <0xF>;" (0x0 to 0xF)
		Specifies on which GPMC_FCLK rising edge the first data is
		driven in the add/data mux bus

	11:8  CYCLE2CYCLEDELAY: 0xA GPMC_FCLK cycles
	dT: "gpmc,cycle2cycle-delay-ns = <0xA>;" (0x0 to 0xF)
		Chip-select high pulse delay between successive accesses

	7     CYCLE2CYCLESAMECSEN: 0x1: Add CYCLE2CYCLEDELAY
	dT: "gpmc,cycle2cycle-samecsen = <0x1>;" (bool)
		Add CYCLE2CYCLEDELAY between successive accesses
		to the same CS (any access type)

	6     CYCLE2CYCLEDIFFCSEN: 0x0: No delay between the two accesses
	dT: "gpmc,cycle2cycle-diffcsen = <0x0>;" (bool)
		Add CYCLE2CYCLEDELAY between successive accesses
		to a different CS (any access type)

	3:0   BUSTURNAROUND: 0x0: 0 GPMC_FCLK cycle
	dT: "gpmc,bus-turnaround-ns = <0x0>;" (0x0 to 0xF)
		Bus turn around latency between successive accesses to
		the same CS (read to write) or to a different CS (read to
		read and read to write)

GPMC_CONFIG5 0x010C1414:
		|31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|
		| 0| 0| 0| 0| 0| 0| 0| 1| 0| 0| 0| 0| 1| 1| 0| 0|

		|15|14|13|12|11|10| 9| 8| 7| 6| 5| 4| 3| 2| 1| 0|
		| 0| 0| 0| 1| 0| 1| 0| 0| 0| 0| 0| 1| 0| 1| 0| 0|

	27:24 PAGEBURSTACCESSTIME: 0x1: 1 GPMC_FCLK cycle
	dT: "gpmc,page-burst-access-ns = <0x1>;" (0x0 to 0xF)
		Delay between successive words in a multiple access

	20:16 RDACCESSTIME: 0xC: 12 GPMC_FCLK cycles
	dT: "gpmc,access-ns = <0xC>;" (0x0 to 0x1F)
		Delay between start cycle time and first data valid

	12:8  WRCYCLETIME: 0x14: 20 GPMC_FCLK cycles
	dT: "gpmc,wr-cycle-ns = <0x14>;" (0x0 to 0x1F)
		Total write cycle time

	4:0   RDCYCLETIME: 0x14: 20 GPMC_FCLK cycles
	dT: "gpmc,rd-cycle-ns = <0x14>;" (0x0 to 0x1F)
		Total read cycle time

GPMC_CONFIG4 0x0F010F01:
		|31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|
		| 0| 0| 0| 0| 1| 1| 1| 1| 0| 0| 0| 0| 0| 0| 0| 1|

		|15|14|13|12|11|10| 9| 8| 7| 6| 5| 4| 3| 2| 1| 0|
		| 0| 0| 0| 0| 1| 1| 1| 1| 0| 0| 0| 0| 0| 0| 0| 1|

	28:24 WEOFFTIME: 0xF: 16 GPMC_FCLK cycle
	dT: "gpmc,we-off-ns = <0xF>;" (0x0 to 0x1F)
		nWE de-assertion time from start cycle time

	23    WEEXTRADELAY: 0x0: nWE Timing control signal is not delayed
	dT: "gpmc,we-extra-delay = <0>;" (bool)
		nWE Add Extra Half GPMC_FCLK cycle

	19:16 WEONTIME: 0x1: 1 GPMC_FCLK cycle
	dT: "gpmc,we-on-ns = <0x1>;" (0x0 to 0x1F)
		nWE assertion time from start cycle time

	12:8  OEOFFTIME: 0xF: 15 GPMC_FCLK cycles
	dT: "gpmc,oe-off-ns = <0xF>;" (0x0 to 0x1F)
		nOE de-assertion time from start cycle time

	7     OEEXTRADELAY: 0x0: nOE Timing control signal is not delayed
	dT: "gpmc,oe-extra-delay = <0>;" (bool)
		nOE Add Extra Half GPMC_FCLK cycle

	3:0   OEONTIME: 0x1: 1 GPMC_FCLK cycle
	dT: "gpmc,oe-on-ns = <0x1>;" (0x0 to 0x1F)
		nOE assertion time from start cycle time

GPMC_CONFIG3 0x00141400:
		|31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|
		| 0| 0| 0| 0| 0| 0| 0| 0| 0| 0| 0| 1| 0| 1| 0| 0|

		|15|14|13|12|11|10| 9| 8| 7| 6| 5| 4| 3| 2| 1| 0|
		| 0| 0| 0| 1| 0| 1| 0| 0| 0| 0| 0| 0| 0| 0| 0| 0|

	20:16 ADVWROFFTIME: 0x14: 20 GPMC_FCLK cycles
	dT: "gpmc,adv-wr-off-ns = <0x14>;" (0x0 to 0x1F)
		nADV de-assertion time from start cycle time for write accesses

	12:8  ADVRDOFFTIME: 0x14: 20 GPMC_FCLK cycles
	dT: "gpmc,adv-rd-off-ns = <0x14>;" (0x0 to 0x1F)
		nADV de-assertion time from start cycle time for read accesses

	7     ADVEXTRADELAY: 0x0: nADV Timing control signal is not delayed
	dT: "gpmc,adv-extra-delay = <0>;" (bool)
		nADV Add Extra Half GPMC_FCLK cycle

	3:0   ADVONTIME: 0x0: 0 GPMC_FCLK cycle
	dT: "gpmc,adv-on-ns = <0>;" (0x0 to 0xF)
		nADV assertion time from start cycle time

GPMC_CONFIG2 0x00141400:
		|31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|
		| 0| 0| 0| 0| 0| 0| 0| 0| 0| 0| 0| 1| 0| 1| 0| 0|

		|15|14|13|12|11|10| 9| 8| 7| 6| 5| 4| 3| 2| 1| 0|
		| 0| 0| 0| 1| 0| 1| 0| 0| 0| 0| 0| 0| 0| 0| 0| 0|

	20:16 CSWROFFTIME: 0x14: 20 GPMC_FCLK cycles
	dT: "gpmc,cs-wr-off-ns = <0x14>;" (0x0 to 0x1F)
		CS i de-assertion time from start cycle time for write accesses

	12:8  CSRDOFFTIME: 0x14: 20 GPMC_FCLK cycles
	dT: "gpmc,cs-rd-off-ns = <0x14>;" (0x0 to 0x1F)
		CS i de-assertion time from start cycle time for read accesses

	7     CSEXTRADELAY: 0x0: CS i Timing control signal is not delayed
	dT: "gpmc,cs-extra-delay = <0>;" (bool)
		CS i Add Extra Half GPMC_FCLK cycle

	3:0   CSONTIME: 0x0: 0 GPMC_FCLK cycle
	dT: "gpmc,cs-on-ns = <0>;" (0x0 to 0xF)
		CS i assertion time from start cycle time

GPMC_CONFIG1 0x00001800:
		|12|11|10| 9| 8| 7| 6| 5| 4| 3| 2| 1| 0|
		| 1| 1| 0| 0| 0| 0| 0| 0| 0| 0| 0| 0| 0|

	31 WRAPBURST: 0x0: Synchronous wrapping burst not supported
	dT: "gpmc,burst-wrap = <0>;" (bool)
		Enables the wrapping burst capability. Must be set if the
		attached device is configured in wrapping burst

	30 READMULTIPLE: 0x0: Single access
	dT: "gpmc,burst-read = <0>;" (bool)
		Selects the read single or multiple access

	29 READTYPE: 0x0: Read Asynchronous
	dT: "gpmc,sync-read = <0>;" (bool)
		Selects the read mode operation

	28 WRITEMULTIPLE: 0x0: Single access
	dT: "gpmc,burst-write = <0>;" (bool)
		Selects the write single or multiple access

	27 WRITETYPE: 0x0: Write Asynchronous
	dT: "gpmc,sync-write = <0>;" (bool)
		Selects the write mode operation

	26:25 CLKACTIVATIONTIME: 0x0: First rising edge of GPMC_CLK at start
	                              access time
	dT: not supported
		Output GPMC_CLK activation time

	24:23 ATTACHEDDEVICEPAGE LENGTH: 0x0: 4 Words
	dT: "gpmc,burst-length= <4>;" (4, 8 or 16)
		Specifies the attached device page (burst) length

	22 WAITREADMONITORING: 0x0: Wait pin is not monitored for read accesses
	dT: "gpmc,wait-on-read = <0>;" (bool)
		Selects the Wait monitoring configuration for Read accesses
		(Reset value is BOOTWAITEN input pin sampled at IC reset)

	21 WAITWRITEMONITORING: 0x0: Wait pin is not monitored for write accesses
	dT: "gpmc,wait-on-write = <0>;" (bool)
		Selects the Wait monitoring configuration for Write accesses

	19:18 WAITMONITORINGTIME: 0x0: Wait pin is monitored with valid data
	dT: not supported
		Selects input pin Wait monitoring time

	17:16 WAITPINSELECT: 0x0: Wait input pin is WAIT0
	dT: "gpmc,wait-pin = <0>;" (0 to 3)
		Selects the input WAIT pin for this chip-select (Reset value
		is BOOTWAITSELECT input pin sampled at IC reset for
		CS0 and 0 for CS1-7)

	13:12 DEVICESIZE: 0x1: 16 bit
	dT: "gpmc,device-width = <2>;" (1 or 2)
		Selects the device size attached (Reset value is
		BOOTDEVICESIZE input pin sampled at IC reset for CS0
		and 0x1 for CS1 to CS7)

	11:10 DEVICETYPE: 0x2: NAND Flash like devices, stream mode
	dT: "gpmc,device-nand = <1>;" (bool)
		Selects the attached device type

	9 MUXADDDATA: 0x0: Non Multiplexed attached device
	dT: "gpmc,mux-add-data = <0>;" (0 or 1 or 2)
		Enables the Address and data multiplexed protocol (Reset
		value is CS0MUXDEVICE input pin sampled at IC reset for
		CS0 and 0 for CS1-7)

	4 TIMEPARAGRANULARITY: 0x0: x1 latencies
	dT: "gpmc,time-para-granularity = <0>;" (bool)
		Signals timing latencies scalar factor (Rd/WrCycleTime,
		Rd/WrAccessTime, PageBurstAccessTime, CSOnTime,
		CSRd/WrOffTime, ADVOnTime, ADVRd/WrOffTime,
		OEOnTime, OEOffTime, WEOnTime, WEOffTime,
		Cycle2CycleDelay, BusTurnAround, TimeOutStartValue)

	1:0 GPMCFCLKDIVIDER: 0x0: GPMC_CLK frequency = GPMC_FCLK frequency
	dT: not supported
		Divides the GPMC_FCLK clock





