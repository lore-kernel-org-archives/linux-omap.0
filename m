From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH] ARM: dts: duovero-parlor: Add HDMI output
Date: Wed, 21 May 2014 08:41:10 +0200
Message-ID: <537C4A86.1010507@epfl.ch>
References: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch> <20140520143932.GA27830@atomide.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:42791 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbaEUGlQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 02:41:16 -0400
In-Reply-To: <20140520143932.GA27830@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org


On 05/20/2014 04:39 PM, Tony Lindgren wrote:
> * Florian Vaussard <florian.vaussard@epfl.ch> [140520 07:26]:
>> @@ -77,6 +94,15 @@
>>  			0x30 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48: amdix enabled */
>>  		>;
>>  	};
>> +
>> +	dss_hdmi_pins: pinmux_dss_hdmi_pins {
>> +		pinctrl-single,pins = <
>> +			0x58 (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_hpd.hdmi_hpd */
>> +			0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
>> +			0x5c (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_scl.hdmi_ddc_scl */
>> +			0x5e (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_sda.hdmi_ddc_sda */
>> +		>;
>> +	};
>>  };
>>  
>>  &i2c2 {
> 
> This seems to apply with fuzz against omap-for-v3.16/dt-v2, but
> should be updated against omap-for-v3.16/dt-v2 to use OMAP4_IOPAD
> as omap4-duovero-parlor.dts is now using it. That makes checking
> the muxing easier against the TRM. See commit 5efa994b0d49 for
> the script Joachim used.
> 

It is based on Tomi's for-next, which is based on 3.15-rc4, so the fuzz
is not surprising. I will update against omap-for-v3.16/dt-v2.

Regards,
Florian
