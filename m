From: =?UTF-8?Q?Andr=c3=a9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCH] ARM: dts: Add omap3-echo
Date: Wed, 25 Dec 2019 13:05:17 +0100
Message-ID: <a8f64408-f581-e57d-0f5d-db42ff0a4288@dawncrow.de>
References: <20191224161005.28083-1-nerv@dawncrow.de>
 <20191224184503.GK35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191224184503.GK35479@atomide.com>
Content-Language: de-LU
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Am 24.12.19 um 19:45 schrieb Tony Lindgren:
> * André Hentschel <nerv@dawncrow.de> [191224 16:11]:
>> This is the first generation Amazon Echo from 2016.
>> Audio support is not yet implemented.
> 
> OK looks good to me, just worried about one part:
> 
>> +&sgx_module {
>> +	status = "disabled";
>> +};
> 
> We should have a separate am3703.dtsi or whatever the SoC model
> disabling sgx if not there on the SoC. That way board specific
> dts files can just include it without having to debug this issue
> over and over.

Thanks for the quick review in that time of the year!
The sgx issue came up in newer kernels and I had to bisect it to 3b72fc895a2e57f70276b46f386f35d752adf555
The device just wasn't booting without a message, so yes, we should make it easier for others to figure it out.
SoC is DM3725 and only DM3730 has sgx support. And it's hard to say if the base is am37xx or omap36xx.
But I see the reasons you picked am3703, so I would move everything from omap36xx.dtsi to am3703.dtsi except sgx?
And then include am3703.dtsi in omap36xx.dtsi before sgx support?
Or would it be better to have sgx support in a separate dtsi?
