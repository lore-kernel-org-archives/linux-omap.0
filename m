From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 15/15] ARM: dts: dra7: Add high speed modes capability
 to MMC1/MMC2 dt node
Date: Wed, 7 Feb 2018 14:51:57 +0530
Message-ID: <b411cf11-61e9-e688-6f04-e624fe52ac66@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
 <20180206125806.19350-16-kishon@ti.com>
 <210939ed-67fc-fa37-b4f2-c1faefcc4642@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <210939ed-67fc-fa37-b4f2-c1faefcc4642@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 07 February 2018 02:41 PM, Sekhar Nori wrote:
> Kishon,
> 
> On Tuesday 06 February 2018 06:28 PM, Kishon Vijay Abraham I wrote:
>> Add UHS/HS200/DDR speed mode capability to MMC1 and MMC2 dt nodes.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Along with this, dont we need to have
> 
> 	/delete-property/ mmc-hs200-1_8v;
> 
> for eMMC on Beagle x15 which does not support HS200?
> 
> Or are you planning to depend on lack of pinctrl entries for HS200 to
> take care of that?

right now it relies on lack of pinctrl entries but I think adding delete
property is appropriate. Actually I missed porting the patch that adds
/delete-property/.

Thanks
Kishon

> 
> Thanks,
> Sekhar
> 
> 
>> ---
>>  arch/arm/boot/dts/dra7.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 7bf33d522b14..feb496e7c5ef 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -1073,7 +1073,13 @@
>>  			status = "disabled";
>>  			pbias-supply = <&pbias_mmc_reg>;
>>  			max-frequency = <192000000>;
>> +			sd-uhs-sdr104;
>> +			sd-uhs-sdr50;
>> +			sd-uhs-ddr50;
>> +			sd-uhs-sdr25;
>> +			sd-uhs-sdr12;
>>  			cap-sd-highspeed;
>> +			mmc-ddr-1_8v;
>>  			cap-mmc-highspeed;
>>  		};
>>  
>> @@ -1092,6 +1098,10 @@
>>  			status = "disabled";
>>  			max-frequency = <192000000>;
>>  			cap-sd-highspeed;
>> +			sd-uhs-sdr25;
>> +			sd-uhs-sdr12;
>> +			mmc-hs200-1_8v;
>> +			mmc-ddr-1_8v;
>>  			cap-mmc-highspeed;
>>  		};
>>  
>> -- 
>> 2.11.0
>>
> 
