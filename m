From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/2] hwspinlock/omap: add support for dt nodes
Date: Wed, 4 Sep 2013 11:30:22 -0500
Message-ID: <5227601E.7070007@ti.com>
References: <1378230767-54931-1-git-send-email-s-anna@ti.com> <5226EAD5.8070400@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5226EAD5.8070400@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/04/2013 03:09 AM, Stanimir Varbanov wrote:
> Hi Suman,
> 
> Thanks for the patch.
> 
> On 09/03/2013 08:52 PM, Suman Anna wrote:
>> HwSpinlock IP is present only on OMAP4 and other newer SoCs,
>> which are all device-tree boot only. This patch adds the
>> base support for parsing the DT nodes, and removes the code
>> dealing with the traditional platform device instantiation.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  .../devicetree/bindings/hwlock/omap-hwspinlock.txt | 28 ++++++++++
>>  arch/arm/mach-omap2/Makefile                       |  3 --
>>  arch/arm/mach-omap2/hwspinlock.c                   | 60 ----------------------
>>  drivers/hwspinlock/omap_hwspinlock.c               | 21 ++++++--
>>  4 files changed, 45 insertions(+), 67 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
>>  delete mode 100644 arch/arm/mach-omap2/hwspinlock.c
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
> 
> Could you rename base_id to base-id. The property name convention is to
> use dashes in DT world.

Yep, will change to use dashes.

Thanks
Suman
