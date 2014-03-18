From: Sathya Prakash <a0393677@ti.com>
Subject: Re: [PATCH 2/2] ARM: DTS: AM43x: Add sii9022 dt information
Date: Tue, 18 Mar 2014 16:27:16 +0530
Message-ID: <5328268C.1030306@ti.com>
References: <1395137278-5065-1-git-send-email-sathyap@ti.com> <1395137278-5065-3-git-send-email-sathyap@ti.com> <53282082.1000208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58584 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767AbaCRK53 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 06:57:29 -0400
In-Reply-To: <53282082.1000208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, pawel.moll@arm.com, paul@pwsan.com

On Tuesday 18 March 2014 04:01 PM, Tomi Valkeinen wrote:
> On 18/03/14 12:07, Sathya Prakash M R wrote:
>> AM43x-epos and AM437x-gp device use external sii9022
>> DPI to HDMI encoder.
>> Sii9022 use i2c for communication.
>> Sii9022 dt entries are added to corresponding dts.
>>
>> Signed-off-by: Sathya prakash M R <sathyap@ti.com>
>> ---
>>   arch/arm/boot/dts/am437x-gp-evm.dts  |   58 +++++++++++++++++++++++++++++++--
>>   arch/arm/boot/dts/am43x-epos-evm.dts |   59 ++++++++++++++++++++++++++++++++--
>>   2 files changed, 111 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
>> index a178e8d..c4225b1 100644
>> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
>> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
>> @@ -51,6 +51,41 @@
>>   			remote-endpoint = <&dpi_out>;
>>   		};
>>   	};
>> +
>> +	sii9022: encoder@0 {
>> +		compatible = "sii,sii9022";
> See Documentation/devicetree/bindings/vendor-prefixes.txt
>
> The vendor prefix is "sil".
My bad. that was typo.
>
>> +		reset-gpio = <&gpio5 8 GPIO_ACTIVE_LOW>;/* 'SelLCDorHDMI' Gpio, LOW to select HDMI */
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +
>> +				sii9022_in: endpoint@0 {
>> +					remote-endpoint = <&dpi_out>;
>> +				};
>> +			};
>> +
>> +			port@1 {
>> +				reg = <1>;
>> +
>> +				sii9022_out: endpoint@0 {
>> +					remote-endpoint = <&hdmi_connector_in>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	hdmi0: connector@0 {
>> +		compatible = "hdmi-connector";
>> +		label = "hdmi";
>> +
>> +		hdmi_connector_in: endpoint {
>> +			remote-endpoint = <&sil9022_out>;
>> +		};
>> +	};
>>   };
>>   
>>   &am43xx_pinmux {
>> @@ -119,6 +154,9 @@
>>           status = "okay";
>>           pinctrl-names = "default";
>>           pinctrl-0 = <&i2c1_pins>;
>> +	&sii9022 {
>> +		reg = <0x3b>;
>> +	}
> This looks very very odd... The whole sii9022 node should be here.
ok. i was also bit confused with this placement.

>
>>   };
>>   
>>   &epwmss0 {
>> @@ -141,8 +179,22 @@
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&dss_pinctrl>;
>>   
>> -	dpi_out: endpoint@0 {
>> -		remote-endpoint = <&lcd_in>;
>> -		data-lines = <24>;
>> +	ports {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		port@0 {
>> +			reg = <0>;
>> +			dpi_out: endpoint@0 {
>> +				remote-endpoint = <&lcd_in>;
>> +				data-lines = <24>;
>> +			};
>> +
>> +			dpi_out:endpoint@1 {
>> +				remote-endpoint = <&sii9022_in>;
>> +				data-lines = <24>;
>> +
>> +			};
> You add the same label, "dpi_out" to both endpoints. Does this even compile?
>
> As there's just one port, you can leave out the 'ports' node.
Will check. the ports was added as per documentation in video-interfaces.txt
Can you suggest how to add the 2 dpi_out endpoints?
Thanks

>
>   Tomi
>
Sathya

