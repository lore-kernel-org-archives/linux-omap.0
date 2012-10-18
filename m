From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP: Add counter-32k nodes
Date: Thu, 18 Oct 2012 09:27:30 -0500
Message-ID: <508011D2.30806@ti.com>
References: <1350498803-22150-1-git-send-email-jon-hunter@ti.com>
 <1350498803-22150-2-git-send-email-jon-hunter@ti.com>
 <508010E1.6010102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <508010E1.6010102-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 10/18/2012 09:23 AM, Benoit Cousson wrote:
> Hi Jon,
> 
> This looks good to me, I just have a minor nit comment.
> 
> On 10/17/2012 08:33 PM, Jon Hunter wrote:
>> Adds the counter-32k timers nodes present in OMAP2/3/4 devices and
>> device-tree binding documentation for OMAP counter-32k.
>>
>> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
>> ---
>>  .../devicetree/bindings/arm/omap/counter32k.txt    |   15 +++++++++++++++
>>  arch/arm/boot/dts/omap2420.dtsi                    |    6 ++++++
>>  arch/arm/boot/dts/omap2430.dtsi                    |    6 ++++++
>>  arch/arm/boot/dts/omap3.dtsi                       |    6 ++++++
>>  arch/arm/boot/dts/omap4.dtsi                       |    6 ++++++
>>  5 files changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/omap/counter32k.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/counter32k.txt b/Documentation/devicetree/bindings/arm/omap/counter32k.txt
>> new file mode 100644
>> index 0000000..1983fae
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/omap/counter32k.txt
>> @@ -0,0 +1,15 @@
>> +OMAP Counter-32K bindings
>> +
>> +Required properties:
>> +- compatible:	Must be "ti,omap-counter32k" for OMAP controllers
>> +- reg:		Contains timer register address range (base address and length)
>> +- ti,hwmods:	Name of the hwmod associated to the counter, which is typically
>> +		"counter_32k"
>> +
>> +Example:
>> +
>> +counter32k: counter32k@4a304000 {
>> +	compatible = "ti,omap-counter32k";
>> +	reg = <0x4a304000 0x001f>;
>> +	ti,hwmods = "counter_32k";
>> +};
>> diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
>> index 5f68a70..082193f 100644
>> --- a/arch/arm/boot/dts/omap2420.dtsi
>> +++ b/arch/arm/boot/dts/omap2420.dtsi
>> @@ -14,6 +14,12 @@
>>  	compatible = "ti,omap2420", "ti,omap2";
>>  
>>  	ocp {
>> +		counter32k: counter32k@48004000 {
> 
> I'd rather use "counter" as generic type to be consistent with the timer
> type we are already using.
> 
> +		counter32k: counter@48004000 {

Sounds good. Will update.

Cheers
Jon
