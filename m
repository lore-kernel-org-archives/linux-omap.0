From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: dts: dra7-evm-common: Enable relevant IPU and
 DSP MMU nodes
Date: Wed, 11 Oct 2017 16:51:35 -0500
Message-ID: <11194594-f510-bbcd-831e-a9765b88bb1a@ti.com>
References: <20170821235158.4968-1-s-anna@ti.com>
 <20170821235158.4968-2-s-anna@ti.com> <20171011182246.GE4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171011182246.GE4394-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 10/11/2017 01:22 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [170821 16:52]:
>> The MMU nodes for the remote processors IPU1, IPU2, DSP1 and
>> DSP2 have all been enabled. All these nodes are relevant and
>> valid for both the DRA7 EVM and DRA76 EVM boards, so are added
>> in the dra7 common evm dtsi file.
>>
>> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/dra7-evm-common.dtsi | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
>> index 343e95f9a001..01a5d4e0b044 100644
>> --- a/arch/arm/boot/dts/dra7-evm-common.dtsi
>> +++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
>> @@ -256,3 +256,27 @@
>>  		status = "okay";
>>  	};
>>  };
>> +
>> +&mmu0_dsp1 {
>> +	status = "okay";
>> +};
>> +
>> +&mmu1_dsp1 {
>> +	status = "okay";
>> +};
>> +
>> +&mmu0_dsp2 {
>> +	status = "okay";
>> +};
>> +
>> +&mmu1_dsp2 {
>> +	status = "okay";
>> +};
>> +
>> +&mmu_ipu1 {
>> +	status = "okay";
>> +};
>> +
>> +&mmu_ipu2 {
>> +	status = "okay";
>> +};
> 
> This is getting quite silly.. The default is "okay" so just remove the useless
> "disabled" from the common file and all these patches are no longer needed.

Yeah, agreed. Original intention was that some of the other remoteproc
related nodes can be customized per board, but there's nothing of that
sort on iommu nodes. Will post a new series. Thanks for the review.

regards
Suman
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
