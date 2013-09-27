From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv2 2/9] hwspinlock/omap: add support for dt nodes
Date: Fri, 27 Sep 2013 11:21:10 -0500
Message-ID: <5245B076.1090008@ti.com>
References: <cover.1379445653.git.s-anna@ti.com> <0fd6a11880894260d627a50b1e35f363625e9b1d.1379445653.git.s-anna@ti.com> <AE597DCC-83D7-4BCD-8990-3D63540F32EA@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AE597DCC-83D7-4BCD-8990-3D63540F32EA@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/27/2013 11:06 AM, Kumar Gala wrote:
> 
> On Sep 17, 2013, at 2:30 PM, Suman Anna wrote:
> 
>> HwSpinlock IP is present only on OMAP4 and other newer SoCs,
>> which are all device-tree boot only. This patch adds the
>> base support for parsing the DT nodes, and removes the code
>> dealing with the traditional platform device instantiation.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> .../devicetree/bindings/hwlock/omap-hwspinlock.txt | 31 +++++++++++
>> arch/arm/mach-omap2/Makefile                       |  3 --
>> arch/arm/mach-omap2/hwspinlock.c                   | 60 ----------------------
>> drivers/hwspinlock/omap_hwspinlock.c               | 23 +++++++--
>> 4 files changed, 50 insertions(+), 67 deletions(-)
>> create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
>> delete mode 100644 arch/arm/mach-omap2/hwspinlock.c
>>
>> diff --git a/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
>> new file mode 100644
>> index 0000000..235b7c5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
>> @@ -0,0 +1,31 @@
>> +OMAP4+ HwSpinlock Driver
>> +========================
>> +
>> +Required properties:
>> +- compatible:		Currently supports only "ti,omap4-hwspinlock" for
>> +				OMAP44xx, OMAP54xx, AM33xx, AM43xx, DRA7xx SoCs
>> +- reg:			Contains the hwspinlock register address range (base
>> +			address and length)
>> +- ti,hwmods:		Name of the hwmod associated with the hwspinlock device
>> +
>> +Common hwlock properties:
>> +The following describes the usage of the common hwlock properties (defined in
>> +Documentation/devicetree/bindings/hwlock/hwlock.txt) on OMAP.
>> +
>> +- hwlock-base-id:	There are currently no OMAP SoCs with multiple
>> +			hwspinlock devices. The OMAP driver uses a default
>> +			base id value of 0 for the locks present within the
>> +			single hwspinlock device on all SoCs.
>> +- hwlock-num-locks:	This property is not required on OMAP SoCs, since the
>> +			number of locks present within a device can be deduced
>> +			from the SPINLOCK_SYSSTATUS device register.
> 
> If you are going to be explicit about this properties, you should probably be a bit more clear about them NOT being in the OMAP dts because of the reasons you specify.

You mean on the hwlock-base-id? I wanted to document how these
properties (do not) apply for OMAP, I will revise the text to be a bit
more explicit. Thanks for the review.

regards
Suman
