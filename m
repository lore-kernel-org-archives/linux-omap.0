From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v3] ARM:dts:omap4-panda:Update the LED support for the
 panda DTS
Date: Wed, 15 May 2013 06:56:26 -0500
Message-ID: <519377EA.8070105@ti.com>
References: <1368541076-6854-1-git-send-email-dmurphy@ti.com> <20130515052916.GA15607@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130515052916.GA15607@kahuna>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

NM
On 05/15/2013 12:29 AM, Nishanth Menon wrote:
> $subject - add a space?
> s/ARM:dts:omap4-panda:Update/ARM: dts: omap4-panda: Update/ ?
Will fix.
> On 09:17-20130514, Dan Murphy wrote:
>> The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-panda-es
>> are different.
>>
>> A1-A3 = gpio_wk7
> Thanks for fixing this - this is a key fix else, GPIO_7 which controls
> VSEL for VDD_MPU on PandaBoard-ES will create all kind of ruckus (change
> voltage on heartbeat)!
>> ES = gpio_110
>>
>> There is no change to LED D2
>>
>> Abstract away the pinmux and the LED definitions for the two boards into
>> the respective DTS files.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
> [...]
>> diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
>> index f1d8c21..8d1ba03 100644
>> --- a/arch/arm/boot/dts/omap4-panda-es.dts
>> +++ b/arch/arm/boot/dts/omap4-panda-es.dts
>> @@ -34,3 +34,43 @@
>>  		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
>>  		>;
>>  };
>> +
>> +&leds {
>> +	compatible = "gpio-leds";
>> +	heartbeat {
>> +		label = "pandaboard::status1";
>> +		gpios = <&gpio4 14 0>;
>> +		linux,default-trigger = "heartbeat";
>> +	};
>> +	mmc {
>> +		label = "pandaboard::status2";
>> +		gpios = <&gpio1 8 0>;
>> +		linux,default-trigger = "gpio";
> mmc0?
Good point why would I call it mmc and then set the trigger to gpio.

Will fix it.
>> +	};
>> +};
>> +
> Other that that,
> Tested-by: Nishanth Menon <nm@ti.com>


-- 
------------------
Dan Murphy
