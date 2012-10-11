From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: Renaming elpida_ecb240abacn.dtsi as lpddr2_data.dtsi
Date: Thu, 11 Oct 2012 11:46:45 +0530
Message-ID: <5076644D.5050703@ti.com>
References: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com> <1349870716-25511-2-git-send-email-lokeshvutla@ti.com> <50758AA0.5080307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47691 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756926Ab2JKGQ6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 02:16:58 -0400
In-Reply-To: <50758AA0.5080307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, devicetree-discuss@lists.ozlabs.org

+ devicetree-discuss

Hi Benoit,

On Wednesday 10 October 2012 08:18 PM, Benoit Cousson wrote:
> Hi Lokesh,
>
> On 10/10/2012 02:05 PM, Lokesh Vutla wrote:
>> Renaming elpida_ecb240abacn.dtsi file generic, so that the
>> same file can be reused for other parts from different vendors.
>
> Could you elaborate a little bit?
> Are these settings purely reflecting lpddr2 spec timings?

The basic idea is to group data for all the lpddr2 devices in a single 
file instead of creating separate file for each lpddr2 device.

Right now the file elpida_ecb240abacn.dtsi contains only data for 
lpddr2-s4 2G parts from Elpida.
I wanted to add data for lpddr2-s4 4G parts from Samsung.
So I renamed the file elpida_ecb240abacn.dtsi as lpddr2_data.dtsi.

Please let me know if more clarification is needed.

Thanks,
Lokesh
>
> Regards,
> Benoit
>
>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>   arch/arm/boot/dts/{elpida_ecb240abacn.dtsi => lpddr2_data.dtsi} |    0
>>   arch/arm/boot/dts/omap4-panda.dts                               |    2 +-
>>   arch/arm/boot/dts/omap4-sdp.dts                                 |    2 +-
>>   3 files changed, 2 insertions(+), 2 deletions(-)
>>   rename arch/arm/boot/dts/{elpida_ecb240abacn.dtsi => lpddr2_data.dtsi} (100%)
>>
>> diff --git a/arch/arm/boot/dts/elpida_ecb240abacn.dtsi b/arch/arm/boot/dts/lpddr2_data.dtsi
>> similarity index 100%
>> rename from arch/arm/boot/dts/elpida_ecb240abacn.dtsi
>> rename to arch/arm/boot/dts/lpddr2_data.dtsi
>> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
>> index 20b966e..09d3a32 100644
>> --- a/arch/arm/boot/dts/omap4-panda.dts
>> +++ b/arch/arm/boot/dts/omap4-panda.dts
>> @@ -8,7 +8,7 @@
>>   /dts-v1/;
>>
>>   /include/ "omap4.dtsi"
>> -/include/ "elpida_ecb240abacn.dtsi"
>> +/include/ "lpddr2_data.dtsi"
>>
>>   / {
>>   	model = "TI OMAP4 PandaBoard";
>> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
>> index 94a23b3..dd749fc 100644
>> --- a/arch/arm/boot/dts/omap4-sdp.dts
>> +++ b/arch/arm/boot/dts/omap4-sdp.dts
>> @@ -8,7 +8,7 @@
>>   /dts-v1/;
>>
>>   /include/ "omap4.dtsi"
>> -/include/ "elpida_ecb240abacn.dtsi"
>> +/include/ "lpddr2_data.dtsi"
>>
>>   / {
>>   	model = "TI OMAP4 SDP board";
>>
>

