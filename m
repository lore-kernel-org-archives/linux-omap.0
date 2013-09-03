From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/2] hwspinlock/omap: add support for dt nodes
Date: Tue, 3 Sep 2013 14:10:11 -0500
Message-ID: <52263413.1050108@ti.com>
References: <1378230767-54931-1-git-send-email-s-anna@ti.com> <43798031-2D57-44F0-A19C-FD80DB9E9794@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <43798031-2D57-44F0-A19C-FD80DB9E9794@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Kumar,

On 09/03/2013 01:50 PM, Kumar Gala wrote:
> 
> On Sep 3, 2013, at 12:52 PM, Suman Anna wrote:
> 
>> HwSpinlock IP is present only on OMAP4 and other newer SoCs,
>> which are all device-tree boot only. This patch adds the
>> base support for parsing the DT nodes, and removes the code
>> dealing with the traditional platform device instantiation.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> .../devicetree/bindings/hwlock/omap-hwspinlock.txt | 28 ++++++++++
>> arch/arm/mach-omap2/Makefile                       |  3 --
>> arch/arm/mach-omap2/hwspinlock.c                   | 60 ----------------------
>> drivers/hwspinlock/omap_hwspinlock.c               | 21 ++++++--
>> 4 files changed, 45 insertions(+), 67 deletions(-)
>> create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
>> delete mode 100644 arch/arm/mach-omap2/hwspinlock.c
>>
>> diff --git a/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
>> new file mode 100644
>> index 0000000..adfb8ad
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
>> @@ -0,0 +1,28 @@
>> +OMAP4+ HwSpinlock Driver
>> +
>> +Required properties:
>> +- compatible:		Currently supports only "ti,omap4-hwspinlock" for
>> +				OMAP44xx, OMAP54xx, AM33xx, AM43xx, DRA7xx SoCs
>> +- reg:			Contains the hwspinlock register address range (base
>> +			address and length)
>> +- ti,hwmods:		Name of the hwmod associated with the hwspinlock device
>> +
>> +Optional properties:
>> +- base_id:		Base Id for the locks for a particular hwspinlock
>> +			device. If not mentioned, a default value of 0 is used.
>> +			This property is mandatory ONLY if a SoC has several
>> +			hwspinlock devices. There are currently no such OMAP
>> +			SoCs.
> 
> Should this be ti,base_id ? [ I know its kinda generic in its intent for any SoC w/multiple blocks ]

I didn't add the "ti," prefix exactly for the same reason - it is
generic w.r.t the hwspinlock core irrespective of the SoC family, and
there is nothing ti or OMAP specific about it. I have added it to keep
the DT node definition in sync with the driver code. If it is too
generic a name, it can always be renamed as hwlock_base_id. This will be
SoC agnostic property for the hwspinlock driver. What do you think?

regards
Suman

> 
>> +
>> +			See documentation on struct hwspinlock_pdata in
>> +			linux/hwspinlock.h for more details.
>> +
>> +
>> +Example:
>> +
>> +/* OMAP4 */
>> +hwspinlock: spinlock@4a0f6000 {
>> +	compatible = "ti,omap4-hwspinlock";
>> +	reg = <0x4a0f6000 0x1000>;
>> +	ti,hwmods = "spinlock";
>> +};
> 
> [ snip ]
> 
> - k
> 
