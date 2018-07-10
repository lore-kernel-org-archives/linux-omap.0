From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v5 4/6] bus: ti-sysc: Add support for software reset
Date: Tue, 10 Jul 2018 18:50:14 +0530
Message-ID: <0ece4ef9-1306-d36a-acff-6ee4b98337c8@ti.com>
References: <20180709164841.14182-1-faiz_abbas@ti.com>
 <20180709164841.14182-5-faiz_abbas@ti.com>
 <20180710114248.GI99251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710114248.GI99251@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, paul@pwsan.com, t-kristo@ti.com, mark.rutland@arm.com, sboyd@kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tuesday 10 July 2018 05:12 PM, Tony Lindgren wrote:
> Hi,
> 
> * Faiz Abbas <faiz_abbas@ti.com> [180709 16:50]:
>> Add support for the software reset of a target interconnect
>> module using its sysconfig and sysstatus registers.
> ...
>> --- a/drivers/bus/ti-sysc.c
>> +++ b/drivers/bus/ti-sysc.c
> ...
>> +static int sysc_reset(struct sysc *ddata)
>> +{
>> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
>> +	int val = sysc_read(ddata, offset);
> 
> Testing with omap4 sysc dts data I noticed we already
> have modules where there is only rev register and no
> SYSC_SYSCONFIG. So not using legacy mode. The
> above offset with -ENODEV value will not work :)
> 
> I added some more checks and moved them to the reset
> function.

Great. Thanks for the fix.

Thanks,
Faiz
