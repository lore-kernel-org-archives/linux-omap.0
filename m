From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 11/11] ARM: DT: Add support to system control module
 for OMAP4
Date: Wed, 30 May 2012 10:38:55 +0200
Message-ID: <4FC5DC9F.7080104@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-12-git-send-email-eduardo.valentin@ti.com> <4FC49BA5.5050008@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53959 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279Ab2E3Ikr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 May 2012 04:40:47 -0400
In-Reply-To: <4FC49BA5.5050008@dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

On 5/29/2012 11:49 AM, Konstantin Baydarov wrote:
>    Hi, Eduardo.
>
> On 05/25/2012 12:26 PM, Eduardo Valentin wrote:
>> This patch add device tree entries on OMAP4 based boards
>> for System Control Module (SCM).
>>
>> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
>> ---
>>   arch/arm/boot/dts/omap4.dtsi |   13 +++++++++++++
>>   1 files changed, 13 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 359c497..d2cb392 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -272,5 +272,18 @@
>>   			ti,hwmods = "mmc5";
>>   			ti,needs-special-reset;
>>   		};
>> +
>> +		ctrl_module_core: ctrl_module_core@4a002000 {
>> +			compatible = "ti,omap4-control";
>> +			ti,hwmods = "ctrl_module_core";
>> +			bandgap {
>> +				compatible = "ti,omap4460-bandgap";
>> +				interrupts =<0 126 4>; /* talert */
>> +				ti,tshut-gpio =<86>; /* tshut */
>> +			};
> I believe that CPU-specific bandgap definition should be moved to bard specific dts.

Mmm, why, since it is CPU specific and not board specific. I has to be 
in the SoC file.

Regards,
Benoit
