From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 02/10] arm/dts: OMAP4: Add a main ocp entry bound
	to l3-noc driver
Date: Fri, 9 Sep 2011 02:10:08 +0200
Message-ID: <4E695960.8010905@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-3-git-send-email-b-cousson@ti.com>
	<20110908180300.GB2967@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110908180300.GB2967@ponder.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Shilimkar,
	Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 9/8/2011 8:03 PM, Grant Likely wrote:
> On Wed, Aug 24, 2011 at 03:09:08PM +0200, Benoit Cousson wrote:
>> Used the main OCP node to add bindings with the l3_noc driver.
>> Remove l3_noc static device creation if CONFIG_OF is defined.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Tony Lindgren<tony@atomide.com>
>> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> ---
>>   arch/arm/boot/dts/omap4.dtsi  |    3 ++-
>>   arch/arm/mach-omap2/devices.c |    2 ++
>>   2 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 97a3ea7..928a74c 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -64,10 +64,11 @@
>>   	 * hierarchy.
>>   	 */
>>   	ocp {
>> -		compatible = "simple-bus";
>> +		compatible = "ti,l3-noc", "arteris,noc", "simple-bus";
>>   		#address-cells =<1>;
>>   		#size-cells =<1>;
>>   		ranges;
>> +		hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
>>
>>   		gic: interrupt-controller@48241000 {
>>   			compatible = "ti,omap4-gic", "arm,gic";
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
>> index 2d4a199..5964650 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -70,6 +70,7 @@ static int __init omap3_l3_init(void)
>>   }
>>   postcore_initcall(omap3_l3_init);
>>
>> +#ifndef CONFIG_OF
>>   static int __init omap4_l3_init(void)
>>   {
>>   	int l, i;
>> @@ -100,6 +101,7 @@ static int __init omap4_l3_init(void)
>>   	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
>>   }
>>   postcore_initcall(omap4_l3_init);
>> +#endif
>
> Don't do this.  Turning on CONFIG_OF must not break non-DT booting.
> Instead, check at runtime if a DT is available, and if it does then
> don't run the hook.

Do you want to check only the availability of the DT or the availability 
of that specific node inside the DT?

Benoit
