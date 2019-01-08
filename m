From: JeffyChen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] mfd: syscon: Fix syscon name for device tree
Date: Tue, 08 Jan 2019 11:16:59 +0800
Message-ID: <5C34162B.200@rock-chips.com>
References: <20190108000558.54914-1-tony@atomide.com> <20190108001543.GJ5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108001543.GJ5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 01/08/2019 08:15 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [190108 00:06]:
>> I'm now seeing the following error on omap5 during boot:
>>
>> (NULL device *): Failed to create dummy-scm_conf@0 debugfs directory
This log means failed to init regmap debugfs with device(NULL) and 
name("scm_conf@0"), which likely to be called from of_syscon_register() 
with np fullname("scm_conf@0").

So my guess would be there're more than one syscon dts nodes named 
"scm_conf@0".


For omap5 and scm_conf@0, should be these 2:
https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/omap5.dtsi#L167
				scm_conf: scm_conf@0 {
					compatible = "syscon";

https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/omap5.dtsi#L313
				scm_wkup_pad_conf: scm_conf@0 {
					compatible = "syscon", "simple-bus";

Maybe try to rename one of them(for example, rename the second one to 
"scm_wkup_pad_conf@0").
