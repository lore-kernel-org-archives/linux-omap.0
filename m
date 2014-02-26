From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM: dts: OMAP4: Add IOMMU nodes
Date: Wed, 26 Feb 2014 16:06:50 -0600
Message-ID: <530E657A.4080600@ti.com>
References: <1392315776-33197-1-git-send-email-s-anna@ti.com>
	<1392315776-33197-4-git-send-email-s-anna@ti.com>
	<5025565.C2g8cq3k2V@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5025565.C2g8cq3k2V@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On 02/26/2014 03:05 PM, Laurent Pinchart wrote:
> Hi Suman,
>
> Thank you for the patch.
>
> On Thursday 13 February 2014 12:22:55 Suman Anna wrote:
>> From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
>>
>> Add the IOMMU nodes for the DSP and IPU subsystems. The external
>> address space for DSP starts at 0x20000000 in OMAP4 compared to
>> 0x11000000 in OMAP3, and the addresses beyond 0xE0000000 are
>> private address space for the Cortex-M3 cores in the IPU subsystem.
>> The MMU within the IPU sub-system also supports a bus error back
>> capability, not available on the DSP MMU.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
>> [s-anna-l0cyMroinI0@public.gmane.org: dma-window updates and bus error back addition]
>> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/omap4.dtsi | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index d3f8a6e..1885f90 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -461,6 +461,23 @@
>>   			dma-names = "tx", "rx";
>>   		};
>>
>> +		mmu_dsp: mmu@4a066000 {
>> +			compatible = "ti,omap4-iommu";
>> +			reg = <0x4a066000 0xff>;
>> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>> +			ti,hwmods = "mmu_dsp";
>> +			dma-window = <0x20000000 0xdffff000>;
>> +		};
>> +
>> +		mmu_ipu: mmu@55082000 {
>> +			compatible = "ti,omap4-iommu";
>> +			reg = <0x55082000 0xff>;
>> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
>> +			ti,hwmods = "mmu_ipu";
>> +			dma-window = <0 0xdffff000>;
>
> I'm not too familiar with the M3 MPU in the OMAP4, but doesn't its memory map
> also include other reserved regions, such as 0x55040000- 0x5505ffff to access
> the ISS ?

The MMU integration into the M3 MPU subsystem is actually slightly 
different to that seen on DSP in OMAP3. The M3 MPU subsystem actually 
has one additional type of MMU, called the Attribute MMU/Unicache MMU 
immediately after the M3 processor. It is programmed completely from the 
M3, and is used mainly for setting the cache attributes and valid 
address ranges and translations for accessing address ranges like the 
ISS space. The L2 MMU interprets the remaining addresses, so yes, there 
are certain other address ranges that never go through the L2MMU. The 
dma-window values are used by omap-iovmm, but OMAP4 does not make use of 
omap-iovmm.

regards
Suman

>
>> +			ti,iommu-bus-err-back;
>> +		};
>> +
>>   		wdt2: wdt@4a314000 {
>>   			compatible = "ti,omap4-wdt", "ti,omap3-wdt";
>>   			reg = <0x4a314000 0x80>;
>
