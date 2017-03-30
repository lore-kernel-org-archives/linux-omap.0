From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 3/8] ARM: OMAP5: Thermal: Add slope and offset values
Date: Thu, 30 Mar 2017 08:57:59 +0530
Message-ID: <b8437eb3-4a96-2da6-65d8-f0baf4e0c29c@ti.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
 <1489046762-11288-4-git-send-email-j-keerthy@ti.com>
 <20170329043302.GA1596@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170329043302.GA1596@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 29 March 2017 10:03 AM, Eduardo Valentin wrote:
> On Thu, Mar 09, 2017 at 01:35:57PM +0530, Keerthy wrote:
>> Currently the slope and offset values for calculating the
>> hot spot temperature of a particular thermal zone is part
>> of driver data. Pass them here instead and obtain the values
>> while of node parsing.
> 
> 
> The patch is fine.. but
> 
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  arch/arm/boot/dts/omap5.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index 222155c..eaff2a5 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -1127,6 +1127,15 @@
>>  
>>  &cpu_thermal {
>>  	polling-delay = <500>; /* milliseconds */
>> +	coefficients = <65 (-1791)>;
> 
> I suppose you tried this change with this patch:
> https://patchwork.kernel.org/patch/9619577/
> ?
> 
> Otherwise, I do not see how your coeff would work, right?

IIRC i did not have that patch.

But No issues there. I did try deliberately with negative values and i
retrieved the negative values in driver nicely.

Fox ex: -20 unsigned when retrieved in driver as an int coeff will give
me -20. I checked with multiple negative co-efficients and i retrieved
the passed negative co-efficients in driver from DT.

Regards,
Keerthy


> 
>>  };
>>  
>>  /include/ "omap54xx-clocks.dtsi"
>> +
>> +&gpu_thermal {
>> +	coefficients = <117 (-2992)>;
>> +};
>> +
>> +&core_thermal {
>> +	coefficients = <0 2000>;
>> +};
>> -- 
>> 1.9.1
>>
