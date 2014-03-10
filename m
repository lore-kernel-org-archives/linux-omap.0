From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 1/8] ARM: dts: dra7: Initialize USB_DPLL
Date: Mon, 10 Mar 2014 15:32:13 +0200
Message-ID: <531DBEDD.9050400@ti.com>
References: <1394197751-28984-2-git-send-email-rogerq@ti.com>
 <1394455761-19226-1-git-send-email-rogerq@ti.com> <531DBE03.2070603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <531DBE03.2070603@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, tony@atomide.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, Mike Turquette <mturquette@linaro.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/10/2014 03:28 PM, Tero Kristo wrote:
> On 03/10/2014 02:49 PM, Roger Quadros wrote:
>> USB_DPLL must be initialized and locked at boot so that
>> USB modules can work.
>>
>> Program USB_DLL_M2 output to half rate as well.
>>
>> Patch depends on
>> https://www.mail-archive.com/linux-omap@vger.kernel.org/msg101300.html
>>
>> CC: Mike Turquette <mturquette@linaro.org>
>> CC: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   arch/arm/boot/dts/dra7.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 597979b..f376923 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -815,3 +815,11 @@
>>   };
>>
>>   /include/ "dra7xx-clocks.dtsi"
>> +
>> +&dpll_usb_ck {
>> +        default-rate = <960000000>;
>> +};
>> +
>> +&dpll_usb_m2_ck {
>> +    default-rate = <480000000>;
>> +};
>>
> 
> You can add these directly under the dra7xx-clocks.dtsi file as well, as I don't think anybody needs to modify these. And the properties can be added directly under the nodes themselves.
> 
> However, this patch can't be acked yet as we have no feedback from Mike for the default-rate proposal.

OK. I'll wait for the "default-rate" patch to be approved first and then revise this patch based on your
suggestion. Thanks for the review.

cheers,
-roger
