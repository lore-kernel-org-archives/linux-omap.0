From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
Date: Thu, 31 May 2018 16:56:46 +0530
Message-ID: <be0fd711-c44b-dbe2-648f-08aa88c7aec4@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
 <20180531040638.GA26751@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180531040638.GA26751@rob-hp-laptop>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, paul@pwsan.com, tony@atomide.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 31 May 2018 09:36 AM, Rob Herring wrote:
> On Wed, May 30, 2018 at 07:41:32PM +0530, Faiz Abbas wrote:
>> The ti-sysc driver provides support for manipulating the idlemodes
>> and interconnect level resets.
>>
>> Add the generic interconnect target module node for MCAN to support
>> the same.
>>
>> CC: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  arch/arm/boot/dts/dra76x.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
>> index bfc82636999c..57b8dc0fe719 100644
>> --- a/arch/arm/boot/dts/dra76x.dtsi
>> +++ b/arch/arm/boot/dts/dra76x.dtsi
>> @@ -11,6 +11,25 @@
>>  / {
>>  	compatible = "ti,dra762", "ti,dra7";
>>  
>> +	ocp {
>> +
>> +		target-module@0x42c00000 {
> 
> Build your dtb with W=1 and fix warnings you add (drop '0x').

Sure, Will fix this.
> 
> This is a CAN bus controller? If so, then use 'can' for node name.

Yes but I am using m_can along the lines of dcan in other boards (For
example, see arch/arm/boot/dts/am33xx.dtsi:1046). Are you saying all CAN
controllers should only be called can?

Thanks,
Faiz
