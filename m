From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 0/8] DRA7xx core support
Date: Sun, 4 Aug 2013 21:44:26 +0530
Message-ID: <51FE7DE2.8010205@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <51FC327F.9020805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51FC327F.9020805@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, tony@atomide.com, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Saturday 03 August 2013 03:58 AM, Santosh Shilimkar wrote:
> On Tuesday 30 July 2013 07:25 AM, Rajendra Nayak wrote:
>> Changes in v2:
>> -1- Fixed minor changelog details
>> -2- Dropped the SRAM support patch since we need to move to drivers/misc/sram.c
>> -3- Added DTS update patches to this series which were earlier posted as
>> part of the data series (Since they don't have much objections as against the
>> other in-kernel data files)
>> -4- Updated the EVM dts file with pin config details for uart/mcspi and i2c
>>
>> DRA7xx based SoCs' are high-performance, infotainment application devices,
>> based on enhanced OMAP architecture integrated on a 28nm
>> technology.
>>
>> The DRA7xx family is composed of DRA75x and DRA74x devices.
>> The current device for which the patches add support is the
>> DRA752 SoC.
>>
>> Most of the core IPs are similar to those found on the OMAP5
>> devices, including the dual cortex-A15 based MPU subsystem,
>> which has helped quite some reuse from existing OMAP5 support.
>>
>> This series contains only core support patches and none of
>> the PRCM and hwmod data needed for the device to boot.
>>
>> The bootloader support for the platform is already available
>> in mainline u-boot.
>>
>> The patches posted in this series are available at:
>> git://github.com/rrnayak/linux.git for-3.12/dra-core-v2
>>
>> The patches (including the ones for in-kernel data) which boot
>> on dra7xx evm are available at:
>> t://github.com/rrnayak/linux.git out-of-tree/dra-integrated-v2
>>
>> R Sricharan (7):
>>   ARM: DRA7: id: Add cpu detection support for DRA7xx based SoCs'
>>   ARM: DRA7: Reuse all of PRCM and MPUSS SMP infra
>>   ARM: DRA7: Reuse io tables and add a new .init_early
>>   ARM: DRA7: Resue the clocksource, clockevent support
>>   ARM: DRA7: board-generic: Add basic DT support
>>   ARM: DRA7: Kconfig: Make ARCH_NR_GPIO default to 512
>>   ARM: DRA7: dts: Add the dts files for dra7 SoC and dra7-evm board
>>
>> Rajendra Nayak (1):
>>   ARM: DRA7: hwmod: Reuse the soc_ops used for OMAP4/5
>>
> I quickly scanned the series and largely it looks good to me.
> The suggestion on dts and soc_id seems to be the valid ones and good
> to address them. Feel free to add my ack when you respin the series
> with those couple of issues addressed.

Thanks, will do.

> 
> Regards,
> Santosh
> 
> 
> 
